#define SharedTweener
/// SharedTweener()
/*
    Creates and/or Returns Shared Tweener Singleton
*/

// Return shared tweener if it already exists
if (instance_exists(global.TGMS_SharedTweener))
{
    return global.TGMS_SharedTweener;
}
else
{
    // Attempt to activate shared tweener
    instance_activate_object(global.TGMS_SharedTweener);
    
    // Return shared tweener if it now exists
    if (instance_exists(global.TGMS_SharedTweener))
    {
        return global.TGMS_SharedTweener;
    }
    else
    {
        // Create new shared tweener if it doesn't exist
        global.TGMS_SharedTweener = instance_create(-1000000, -1000000, obj_SharedTweener);
        return global.TGMS_SharedTweener;
    }
}

// S.A.L.

#define TGMS_Tweener_Create
/// TGMS_Tweener_Create()

// Global system-wide settings
isEnabled = global.TGMS_IsEnabled;                     // System's active state flag
timeScale = global.TGMS_TimeScale;                     // Global time scale of tweening engine
minDeltaFPS = global.TGMS_MinDeltaFPS;                 // Minimum frame rate before delta time will lag behind
updateInterval = global.TGMS_UpdateInterval;           // Step interval to update system (default = 1)
autoCleanIterations = global.TGMS_AutoCleanIterations; // Number of tweens to check each step for auto-cleaning

// System maintenance variables
tick = 0;                            // System update timer
autoCleanIndex = 0;                  // Used to track index when processing passive memory manager
keepPersistent = false;              // Becomes true if tweening used in persistent room
maxDelta = 1/minDeltaFPS;            // Cache delta cap
deltaTime = delta_time/1000000;      // Let's make delta time more practical to work with, shall we?
prevDeltaTime = deltaTime;           // Holds delta time from previous step
deltaRestored = false;               // Used to help maintain predictable delta timing
addDelta = 0.0;                      // Amount to add to delta time if update interval not reached
timeScales[0] = timeScale;           // Store time scale in time scales array for step/delta selection
timeScales[1] = timeScale*deltaTime; // Store delta time scale in time scales array for step/delta selection
flushDestroyed = false;              // Flag to indicate if destroyed tweens should be immediately cleared
isDestroyed = false;                 // Flag to ensure Destroy/Room_End events only called when appropriate
tweensProcessNumber = 0;             // Number of tweens to be actively processed in update loop
delaysProcessNumber = 0;             // Number of delays to be actively processed in update loop

// Required data structures
tweens = ds_list_create();           // Stores automated step tweens
delayedTweens = ds_list_create();    // Stores tween delay data
simpleTweens = ds_map_create();      // Used for simple tweens
pRoomTweens = ds_map_create();       // Associates persistent rooms with stored tween lists
pRoomDelays = ds_map_create();       // Associates persistent rooms with stored tween delay lists
eventCleaner = ds_priority_create(); // Used to clean callbacks from events

#define TGMS_Tweener_Destroy
/// TGMS_Tweener_Destroy()

// Return early if Destroy Event already called
// Else mark tweener as being destroyed
if (isDestroyed) { return 0; }
else             { isDestroyed = true; }

//-------------------------------------------------
// Destroy Tweens and Delays for Persistent Rooms
//-------------------------------------------------
TGMS_ClearAllRooms();

//---------------------------------------------
// Destroy remaining tweens
//---------------------------------------------
var _tweens = tweens;
var _tIndex = -1;
repeat(ds_list_size(_tweens))
{   
    var _t = _tweens[| ++_tIndex];             // Get tween and decrement iterator
    _t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set state as destroyed
    _t[@ TWEEN.ID] = undefined;                // Nullify self reference
    
    // Destroy tween events if events map exists
    if (_t[TWEEN.EVENTS] != -1)
    {
        var _events = _t[TWEEN.EVENTS]; // Cache events
        
        // Iterate through events
        repeat(ds_map_size(_events))
        {
            ds_list_destroy(_events[? ds_map_find_first(_events)]); // Destroy event list
            ds_map_delete(_events, ds_map_find_first(_events));     // Delete event key   
        }
        
        // Destroy events map
        ds_map_destroy(_events);
    }
}

//-----------------------------------------
// Remove self as shared tweener singleton
//-----------------------------------------
global.TGMS_SharedTweener = noone;

//---------------------------------------
// Destroy Data Structures
//---------------------------------------
ds_list_destroy(tweens);
ds_list_destroy(delayedTweens);
ds_map_destroy(simpleTweens);
ds_map_destroy(pRoomTweens);
ds_map_destroy(pRoomDelays);
ds_priority_destroy(eventCleaner);

//---------------------------------------
// Clear id reference maps
//---------------------------------------
ds_map_clear(global.TGMS_MAP_TWEEN);
ds_map_clear(global.TGMS_MAP_CALLBACK);

#define TGMS_Tweener_Step
/// TGMS_Tweener_Step()

//--------------------------
// Manage Delta Timing
//--------------------------
prevDeltaTime = deltaTime;      // Store previous usable delta time format
deltaTime = delta_time/1000000; // Update usable delta time format

// Let's prevent delta time from exhibiting sporadic behaviour, shall we?
// IF the delta time is greater than the set max duration
if (deltaTime > maxDelta)
{
    // IF delta time was already restored
    if (deltaRestored)
    { 
        deltaTime = maxDelta; // Set delta time to max delta value
    }
    else
    { 
        deltaTime = prevDeltaTime; // Restore delta time to value from previous step
        deltaRestored = true;      // Flag delta time as being restored
    }
}
else
{
    deltaRestored = false; // Clear restored flag
}

deltaTime += addDelta; // Adjust for update interval difference

// Assign time scales to array for optimisation purposes
timeScales[0] = timeScale;           // Assign step time scale
timeScales[1] = timeScale*deltaTime; // Assign delta time scale
var _systemTimeScales = timeScales;  // Cache time scales array

//---------------------------------
// Process Main Update Loop
//---------------------------------

// Initiate local variables for iteration
var _tIndex, _tweens = tweens, _delayedTweens = delayedTweens;

// IF the system is active
if (isEnabled)
{     
    tick++; // Increment step tick
    
    // Make adjustment for delta time if update interval not achieved
    if (tick < updateInterval) { addDelta += deltaTime; }
    else                       { addDelta = 0.0; }
    
    // WHILE the system tick is greater than the set step update interval -- NEED TO UPDATE FOR DELTA TIMING
    while (tick >= updateInterval)
    {   
        tick -= updateInterval; // Decrement step tick by update interval value
        
        // IF system timescale isn't "paused"
        if (timeScale != 0)
        {   
            //--------------------------------------------------
            // Process Tweens
            //--------------------------------------------------
            _tIndex = -1; 
            repeat(tweensProcessNumber)
            {
                var _t = _tweens[| ++_tIndex]; // Get tween and increment index
                
                // Process tween if target/state exists/active
                if (instance_number(_t[TWEEN.STATE]))
                {
                    // Get updated tween time -- DELTA boolean selects between step/delta time scales
                    var _time = _t[TWEEN.TIME] + _t[TWEEN.TIME_SCALE] * _systemTimeScales[_t[TWEEN.DELTA]];
                    var _duration = _t[TWEEN.DURATION]; // Cache duration
                    var _property = _t[TWEEN.PROPERTY]; // Cache property
                    
                    // IF tween is within start/destination
                    if (_time > 0 && _time < _duration)
                    {
                        // Assign updated time
                        _t[@ TWEEN.TIME] = _time;
                        // Update tweened property with eased value
                        if (_property != null__) script_execute(_property, script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET]); 
                    }
                    else // Tween has reached start or destination
                    if (_t[TWEEN.TIME_SCALE] != 0) // Make sure time scale isn't "paused"
                    {
                        // Update tween based on its play mode -- Could put overflow wait time in here????
                        switch(_t[TWEEN.MODE])
                        {
                        case TWEEN_MODE_ONCE:
                            _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;  // Set tween's state as STOPPED
                            _t[@ TWEEN.TIME] = _duration*(_time > 0); // Update tween's time
                            
                            // Update property
                            if (_property != null__) { script_execute(_property, _t[TWEEN.START] + _t[TWEEN.CHANGE]*(_time > 0), _t[TWEEN.DATA], _t[TWEEN.TARGET]); }
                            
                            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH); // Execute FINISH event
                            if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }          // Destroy tween if temporary
                        break;
                        
                        case TWEEN_MODE_BOUNCE:
                            if (_time > 0)
                            {
                                _time = 2*_duration - _time;        // Update raw time with epsilon compensation
                                _t[@ TWEEN.TIME] = _time;           // Assign raw time to tween
                                _time = clamp(_time, 0, _duration); // Clamp raw time used for tween calculation
                                
                                // Update property
                                if (_property != null__) script_execute(_property, script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET]);
                                
                                _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];           // Reverse direction 
                                _t[@ TWEEN.TIME_SCALE] = -_t[TWEEN.TIME_SCALE];         // Reverse time scale
                                TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE); // Execute CONTINUE event
                            }
                            else
                            {
                                // Update tween's time
                                _t[@ TWEEN.TIME] = 0;
                                
                                // Update property
                                if (_property != null__) { script_execute(_property, _t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET]); }
                                
                                _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;              // Set tween state as STOPPED
                                TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH); // Execute FINISH event
                                if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }          // Destroy tween if temporary
                            }
                        break;
                        
                        case TWEEN_MODE_PATROL:
                            // Update raw time with epsilon compensation
                            if (_time > 0) { _time = 2*_duration - _time; }
                            else           { _time = -_time; }
                        
                            _t[@ TWEEN.TIME] = _time;           // Assign raw time to tween
                            _time = clamp(_time, 0, _duration); // Clamp raw time used for tween calculation
                            
                            // Update property
                            if (_property != null__) script_execute(_property, script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET]);
                            
                            _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];           // Reverse tween's direction
                            _t[@ TWEEN.TIME_SCALE] = -_t[TWEEN.TIME_SCALE];         // Reverse tween's time scale
                            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE); // Execute CONTINUE event
                        break;
                        
                        case TWEEN_MODE_LOOP:
                            // Update tween's time depending on side of loop
                            if (_time > 0) { _time = _time - _duration; }
                            else           { _time = _time + _duration; }
                            
                           _t[@ TWEEN.TIME] = _time;           // Assign raw time to tween
                           _time = clamp(_time, 0, _duration); // Clamp raw time used for tween calculation
                            
                            // Update property
                            if (_property != null__) { script_execute(_property, script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET]); }
                            
                            // Execute LOOP event
                            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE);
                        break;
                        
                        case TWEEN_MODE_REPEAT:
                            // Update tween's time and starting location based on side of loop
                            if (_time > 0)
                            {
                                _time = _time - _duration; // Update raw time with epsilon compensation
                                _t[@ TWEEN.START] = _t[TWEEN.START] + _t[TWEEN.CHANGE]; // Update start
                            }
                            else
                            {
                                _time = _time + _duration; // Update raw time with epsilon compensation
                                _t[@ TWEEN.START] = _t[TWEEN.START] - _t[TWEEN.CHANGE]; // Update start
                            }
                            
                            _t[@ TWEEN.TIME] = _time;          // Assign raw time to tween
                           _time = clamp(_time, 0, _duration); // Clamp raw time used for tween calculation
                            
                            // Update property
                            if (_property != null__) { script_execute(_property, script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _duration), _t[TWEEN.DATA], _t[TWEEN.TARGET]); }
                            
                            // Execute LOOP event
                            TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE);
                        break;
                        
                        default:
                            show_error("Invalid Tween Mode! --> Reverting to TWEEN_MODE_ONCE", false);
                            _t[@ TWEEN.MODE] = TWEEN_MODE_ONCE;
                        }
                    }
                }
            }
            
            //----------------------------------------
            // Process Delays
            //----------------------------------------
            _tIndex = -1;
            repeat(delaysProcessNumber)
            {
                var _t = _delayedTweens[| ++_tIndex]; // Get next tween from delayed tweens list
    
                // IF tween instance exists AND delay is NOT destroyed
                if (_t[TWEEN.STATE] == TWEEN_STATE.DELAYED && instance_number(_t[TWEEN.TARGET]))
                { 
                    // Decrement delay timer
                    _t[@ TWEEN.DELAY] -= abs(_t[TWEEN.TIME_SCALE]) * _systemTimeScales[_t[TWEEN.DELTA]];
                    
                    // IF the delay timer has expired
                    if (_t[TWEEN.DELAY] <= 0)
                    {
                        ds_list_delete(_delayedTweens, _tIndex--);                  // Remove tween from delay list
                        _t[@ TWEEN.DELAY] = -10;                                    // Indicate that delay has been removed from delay list
                        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH_DELAY); // Execute FINISH DELAY event
                        _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];                       // Set tween as active    
                        // Update property with start value                 
                        script_execute(_t[TWEEN.PROPERTY], _t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET]);
                        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PLAY); // Execute PLAY event callbacks
                    }
                }
                else // If delay is marked for removal or tween is destroyed
                if (_t[TWEEN.DELAY] == -1 || _t[TWEEN.STATE] == TWEEN_STATE.DESTROYED)
                {
                    ds_list_delete(_delayedTweens, _tIndex--); // Remove tween from delay list
                    _t[@ TWEEN.DELAY] = -10;                   // Indicate that delay has been removed from delay list
                }
            }
        }
    }
}

//--------------------------------------------------
// Event Cleaner
//--------------------------------------------------
if (ds_priority_size(eventCleaner))
{
    var _event = ds_priority_delete_min(eventCleaner); // Get event to check for cleaning

    // Cycle through all callbacks, except the new one -- make sure not to check event status index event[0]
    var _cbIndex = ds_list_size(_event);
    repeat(_cbIndex-1)
    {
        var _cb = _event[| --_cbIndex];           // Get next callback and decrement iterator
        var _target = _cb[TWEEN_CALLBACK.TARGET]; // Cache callback's target instance
        
        // If the tween's target instance doesn't exist...
        if (instance_exists(_target) == false)
        {
            // Attempt to activate target instance
            instance_activate_object(_target);
            
            // If the target instance now exists...
            if (instance_exists(_target))
            {
                instance_deactivate_object(_target); // Put target instance back to deactivated state
            }
            else // Proceed to delete callback
            {
                ds_map_delete(global.TGMS_MAP_CALLBACK, _cb[TWEEN_CALLBACK.ID]); // Invalidate global callback handle
                ds_list_delete(_event, _cbIndex);                                // Delete callback from event list
            }
        }
    }
}

//--------------------------------------------------
// Passive Tween Cleaner
//--------------------------------------------------
// Check to see if system is being flushed
// Else clamp number of cleaning iterations
var _cleanIterations;
if (flushDestroyed)
{
    flushDestroyed = false;                   // Clear "flush" flag
    autoCleanIndex = ds_list_size(_tweens);   // Set starting clean index to list size
    _cleanIterations = ds_list_size(_tweens); // Set number of iterations to list size 
}
else
{
    _cleanIterations = min(autoCleanIterations, autoCleanIndex, ds_list_size(_tweens)); // CLAMP!
}

// Start the cleaning!
repeat(_cleanIterations)
{   
    // Cache tween
    var _t = _tweens[| --autoCleanIndex];
    
    // IF tween target does not exist...
    if (instance_exists(_t[TWEEN.TARGET]) == false)
    {
        // IF tween is set for destruction...
        if (_t[TWEEN.TARGET] == noone)
        {
            // Remove tween from tweens list
            ds_list_delete(_tweens, autoCleanIndex);
            
            // IF tween events are valid...
            if (_t[TWEEN.EVENTS] != -1)
            {
                var _events = _t[TWEEN.EVENTS];        // Cache tween's events map
                var _key = ds_map_find_first(_events); // Get first key in data map
                
                // For each tween event...
                repeat(ds_map_size(_events))
                {
                    ds_list_destroy(_events[? _key]);       // Destroy event's list data
                    _key = ds_map_find_next(_events, _key); // Get key for next event
                }
                
                // Destroy tween's events map
                ds_map_destroy(_events);
            }
        }
        else
        {
            // Attempt to activate target instance
            instance_activate_object(_t[TWEEN.TARGET]);
            
            // IF instance now exists, put it back to deactivated state
            if (instance_exists(_t[TWEEN.TARGET]))
            {
                instance_deactivate_object(_t[TWEEN.TARGET]);
            }
            else // Handle tween destruction...
            {
                ds_list_delete(_tweens, autoCleanIndex);            // Remove tween from tweens list
                ds_map_delete(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]); // Invalidate tween handle
                ds_map_delete(simpleTweens, _t[TWEEN.SIMPLE_KEY]);  // Delete simple tween data
                _t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED;          // Set tween state as destroyed
                
                // Destroy tween events if events map exists
                if (_t[TWEEN.EVENTS] != -1)
                {
                    var _events = _t[TWEEN.EVENTS];        // Cache events
                    var _key = ds_map_find_first(_events); // Find key to first event
                    
                    // Cycle through and destroy all events
                    repeat(ds_map_size(_events))
                    {
                        var _event = _events[? _key]; // Cache event
                        
                        // Invalidate callback handles
                        var _cbIndex = 0;
                        repeat(ds_list_size(_event)-1)
                        {
                            var _cb = _event[| ++_cbIndex];
                            ds_map_delete(global.TGMS_MAP_CALLBACK, _cb[TWEEN_CALLBACK.ID]);
                        }
                        
                        ds_list_destroy(_event);                // Destroy event list
                        _key = ds_map_find_next(_events, _key); // Find key for next event
                    }
                    
                    ds_map_destroy(_events); // Destroy events map
                }
            }
        }
    }
}

// Place auto clean index to size of tweens list if below or equal to 0
if (autoCleanIndex <= 0) { autoCleanIndex = ds_list_size(_tweens); }


#define TGMS_Tweener_RoomStart
/// TGMS_Tweener_RoomStart()

// Return early if tweener already marked as being destroyed
if (isDestroyed) { return 0; }

// Reset auto-cleaner index
autoCleanIndex = 0;

// IF the entered room is persistent
if (room_persistent)
{   
    var _tweens = tweens;               // Cache tweens list
    var _delayedTweens = delayedTweens; // Cache delayed tweens
    var _key = room;                    // Cache room name for map key
    keepPersistent = true;              // Tell obj_SharedTweener to remain persistent
    
    // IF stored tween data exists for persistent room
    if (ds_map_exists(pRoomTweens, _key))
    {
        // Cache queue of room's tweens
        var _queuedTweens = pRoomTweens[? _key];
        // Iterate through queue, adding stored tweens back to main tween list
        repeat(ds_queue_size(_queuedTweens)) { ds_list_add(_tweens, ds_queue_dequeue(_queuedTweens)); }
    }
    
    // IF stored tween delay data exists for persistent room
    if (ds_map_exists(pRoomDelays, _key))
    {
        // Cache queue of room's delayed tweens
        var _queuedDelays = pRoomDelays[? _key];
        // Iterate through queue, adding stored tween delays back to main tween delay list
        repeat(ds_queue_size(_queuedDelays)) { ds_list_add(_delayedTweens, ds_queue_dequeue(_queuedDelays)); }
    }

    // Update process counts
    tweensProcessNumber = ds_list_size(tweens);
    delaysProcessNumber = ds_list_size(delayedTweens);
}


#define TGMS_Tweener_RoomEnd
/// TGMS_Tweener_RoomEnd()

// Return early if tweener already marked as being destroyed
if (isDestroyed) { return 0; }

var _tweens = tweens;
var _simpleTweens = simpleTweens;
var _delayedTweens = delayedTweens;
var _tempPersistent = false;

//------------------------------------------
// Handle Persistent Room
//------------------------------------------
if (room_persistent)
{
    var _key = room;       // Set map key as room id
    keepPersistent = true; // Tell shared tweener to remain persistent -- tell it who's boss!
    
    // Create persistent queue for room if it doesn't exist
    if (ds_map_exists(pRoomTweens, _key) == false) { ds_map_replace(pRoomTweens, _key, ds_queue_create()); }
    
    // Cache room's tween queue
    var _pRoomQueue = pRoomTweens[? _key];
        
    // Add tweens to persistent room data 
    var _index = ds_list_size(_tweens);
    repeat(_index)
    {  
        var _t = _tweens[| --_index];   // Get tween and decrement iterator
        var _target = _t[TWEEN.TARGET]; // Cache tween's target
        
        if (instance_exists(_target))
        {
            if (_target.persistent == false)
            {
                ds_queue_enqueue(_pRoomQueue, _t); // Add tween to persistent room queue
                ds_list_delete(_tweens, _index);   // Remove from main tween list
            }
        }
        else
        {
            instance_activate_object(_target); // Attempt to activate target
            
            // IF the tween's target now exists
            if (instance_exists(_target))
            {
                // IF the target instance isn't persistent
                if (_target.persistent == false)
                {
                    ds_queue_enqueue(_pRoomQueue, _t); // Add tween to persistent room queue
                    ds_list_delete(_tweens, _index);   // Remove from main tween list
                }
                
                instance_deactivate_object(_target); // Put target back to deactivated state
            }
            else
            {
                _t[@ TWEEN.DESTROY] = 1; // Do this to prevent attempt to destroy target instance
                TweenDestroy(_t);        // Destroy tween
            }
        }
    }
    
    //----------------------
    //  Handle delays
    //----------------------
    // Create persistent delays queue for room if it doesn't exist
    if (ds_map_exists(pRoomDelays, _key) == false) { ds_map_replace(pRoomDelays, _key, ds_queue_create()); }
    
    // Cache room's delayed tweens queue
    var _pRoomDelays = pRoomDelays[? _key];
    
    // Iterate through all delayed tweens backwards
    var _index = ds_list_size(delayedTweens);
    repeat(_index)
    {
        var _t = delayedTweens[| --_index]; // Get tween and decrement iterator
        var _target = _t[TWEEN.TARGET];     // Cache tween's target
        
        // IF target exists
        if (instance_exists(_target))
        {
            // IF target is not persistent
            if (_target.persistent == false)
            {
                ds_list_delete(delayedTweens, _index); // Remove delay from main delay list
                ds_queue_enqueue(_pRoomDelays, _t);    // Add delay to persistent room queue
            }
        }
        else
        {
            // Attempt to activate target
            instance_activate_object(_target);
            
            // IF target now exists
            if (instance_exists(_target))
            {
                // IF target is not persistent
                if (_target.persistent == false)
                {
                    ds_list_delete(delayedTweens, _index); // Remove delay from main delay list
                    ds_queue_enqueue(_pRoomDelays, _t);    // Add delay to persistent room queue
                }
                
                instance_deactivate_object(_target); // Put target back to deactivated state  
            }
        }
    }             
}
else
{ 
    //------------------------------------------------
    // Handle Non-Persistent Room
    //------------------------------------------------ 
    var _index = ds_list_size(_tweens);
    repeat(_index)
    {  
        var _t = _tweens[| --_index];   // Get tween and increment iterator
        var _target = _t[TWEEN.TARGET]; // Cahce tween's target instance
        
        // IF target exists and is persistent, signal tweening system to be persistent
        if (instance_exists(_target))
        {
            // IF target is persistent
            if (_target.persistent)
            {
                _tempPersistent = true; // Signal system to remain persistent
            }
            else
            {
                _t[@ TWEEN.DESTROY] = 1; // Do this to prevent any attempt to destroy target
                TweenDestroy(_t);        // Destroy tween
            }
        }
        else
        {
            // Attempt to activate instance
            instance_activate_object(_target);
            
            // IF target now exists
            if (instance_exists(_target))
            {
                // IF target is persistent
                if (_target.persistent)
                {
                    _tempPersistent = true; // Signal system to remain persistent
                }
                else
                {
                    _t[@ TWEEN.DESTROY] = 1; // Do this to prevent any attempt to destroy target
                    TweenDestroy(_t);        // Destroy tween
                }
                
                instance_deactivate_object(_target); // Put target back to deactive state
            }
            else
            {
                _t[@ TWEEN.DESTROY] = 1; // Do this to prevent any attempt to destroy target
                TweenDestroy(_t);        // Destroy tween
            }
        }
    }
}

// Update process counts
tweensProcessNumber = ds_list_size(tweens);
delaysProcessNumber = ds_list_size(delayedTweens);

//-----------------------------------------------------
// Destroy Shared Tweener if not set as persistent
//-----------------------------------------------------
if (keepPersistent || _tempPersistent)  { persistent = true; }
else                                    { instance_destroy(); }
