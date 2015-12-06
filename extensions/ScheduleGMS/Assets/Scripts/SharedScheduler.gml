#define SharedScheduler
/// SharedScheduler()

if (instance_exists(global.SGMS_SharedScheduler))
{
    return global.SGMS_SharedScheduler;
}
else
{
    instance_activate_object(global.SGMS_SharedScheduler);
    
    if (instance_exists(global.SGMS_SharedScheduler))
    {
        return global.SGMS_SharedScheduler;
    }
    else
    {
        global.SGMS_SharedScheduler = instance_create(-1000000, -1000000, obj_SharedScheduler);
        return global.SGMS_SharedScheduler;
    }
}
#define SharedScheduler_Create
/// SharedScheduler_Create()

// Set default global settings IF first time creating shared scheduler
if (global.SGMS_FirstLoad)
{   
    global.SGMS_FirstLoad = false; // Prevent future default setup calls
    global.SGMS_IsEnabled = true; // System's active state boolean
    global.SGMS_TimeScale = 1.0; // Effects overall speed of how fast system plays
    global.SGMS_MinDeltaFPS = 10; // The lowest framerate before delta schedules will begin to lag behind (Ideally, 10-15)
    global.SGMS_UpdateInterval = 1.0; // Sets how often (in steps) system will update (1 = default, 2 = half speed, 0.5 = double speed) DO NOT set as 0 or below!
}

// Assign global values to instance variables
isEnabled = global.SGMS_IsEnabled;
timeScale = global.SGMS_TimeScale;
minDeltaFPS = global.SGMS_MinDeltaFPS;
updateInterval = global.SGMS_UpdateInterval;

// System maintenance variables
tick = 0; // System update timer
keepPersistent = false; // Becomes true if used in persistent room
maxDelta = 1/minDeltaFPS; // Cache delta cap
deltaTime = delta_time/1000000; // Let's make delta time more practical to work with, shall we?
deltaRestored = false; // Used to help maintain predictable delta timing
timeScales[0] = timeScale;
timeScales[1] = timeScale*deltaTime;

// Data structures
schedules = ds_list_create();
pRoomSchedules = ds_map_create();

#define SharedScheduler_Destroy
/// SharedScheduler_Destroy()

//-------------------------------------------------
// Destroy Schedules for Persistent Rooms
//-------------------------------------------------
ScheduleSystemClearAllRooms();

//---------------------------------------------
// Destroy remaining schedules
//---------------------------------------------
// Cache schedules
var _schedules = schedules;
// Cache schedules index map
var _mapSchedules = global.SGMS_MAP_SCHEDULES;
// Set index for schedule iteration
var _index = ds_list_size(_schedules);

repeat(_index)
{   
    // Cache schedule
    var _schedule = _schedules[| --_index]; 
    // Invalidate schedule index handle id
    ds_map_delete(_mapSchedules, _schedule[9]);
}

//---------------------------------------
// Remove self as shared singleton
//---------------------------------------
global.SGMS_SharedScheduler = noone;

//---------------------------------------
// Destroy Data Structures
//---------------------------------------
ds_list_destroy(schedules);
ds_map_destroy(pRoomSchedules);

#define SharedScheduler_BeginStep
/// SharedScheduler_BeginStep()

//--------------------------
//  Manage Delta Timing
//--------------------------
// Store previous usable delta time format
var _prevDeltaTime = deltaTime;
// Update usable delta time format
deltaTime = delta_time/1000000;

// Let's prevent delta time from exhibiting sporadic behaviour, shall we?
if (deltaTime > maxDelta)
{
    if (deltaRestored)
    { 
        deltaTime = maxDelta
    }
    else 
    {
        deltaRestored = true;
        deltaTime = _prevDeltaTime;
    }
}
else
{
    deltaRestored = false;
}

//---------------------------------
// Update/Cache Time Scales
//---------------------------------
timeScales[0] = timeScale;
timeScales[1] = timeScale*deltaTime;
var _systemTimeScales = timeScales;

//---------------------------------
// Process Main Update Loop
//---------------------------------
if (isEnabled)
{      
    // Cache schedules list
    var _schedules = schedules;  
    // Increment system tick
    tick++;
    
    // While system tick is greater than the update interval
    while(tick >= updateInterval)
    {   
        // Decrement system tick by update interval value
        tick -= updateInterval;
        
        // IF system timescale isn't "paused"
        if (timeScale != 0)
        {
            //--------------------------------------------------
            // Process Schedules
            //--------------------------------------------------
            // Set temporary index for schedules iteration
            var _index = -1; 
            
            // Iterate through all schedules
            repeat(ds_list_size(_schedules))
            {
                // Increment index and cache schedule
                _schedule = _schedules[| ++_index];
                
                // Process schedule if instance active or schedule timer is forced
                if (instance_exists(_schedule[SGMS_SCHEDULE.TARGET]) || _schedule[SGMS_SCHEDULE.FORCE_TIMER])
                {
                    // IF schedule is active
                    if (_schedule[SGMS_SCHEDULE.STATE])
                    {
                        // Update schdules's time -- [use_seconds] boolean selects STEP/delta time scale
                        _schedule[@ SGMS_SCHEDULE.TIME] -= _schedule[SGMS_SCHEDULE.TIME_SCALE]*_systemTimeScales[_schedule[SGMS_SCHEDULE.DELTA]];
                        
                        // Check is schedule has expired
                        if (_schedule[SGMS_SCHEDULE.TIME] <= 0)
                        {
                            // Execute callback
                            SGMS_ExecuteCallback(_schedule[SGMS_SCHEDULE.ID]);
                            
                            // Decrement repeat counter and check if not zero
                            if (_schedule[SGMS_SCHEDULE.REPEAT_COUNT] != 0)
                            {
                                // Clamp repeat counter
                                _schedule[@ SGMS_SCHEDULE.REPEAT_COUNT] = max(-1, _schedule[SGMS_SCHEDULE.REPEAT_COUNT] - 1);
                                // Adjust timer for potential time overflow (maintains delta time sync)
                                _schedule[@ SGMS_SCHEDULE.TIME] = _schedule[SGMS_SCHEDULE.DURATION] + _schedule[SGMS_SCHEDULE.TIME];
                            }
                            else
                            {   
                                // Remove schedule from schedules list
                                ds_list_delete(_schedules, _index--);
                                // Invalidate schedule index handle
                                ds_map_delete(global.SGMS_MAP_SCHEDULES, _schedule[SGMS_SCHEDULE.ID]);
                                // Clear target instance
                                _schedule[@ SGMS_SCHEDULE.TARGET] = noone;
                                // Mark schedule as destroyed 
                                _schedule[@ SGMS_SCHEDULE.STATE] = -1;
                                // Nullify self referenced handle
                                _schedule[@ SGMS_SCHEDULE.ID] = 0;
                            }
                        }
                    }
                }
                else
                {
                    // Attempt to activate instance for checking if it actually exists
                    instance_activate_object(_schedule[SGMS_SCHEDULE.TARGET]);
                    
                    // If it now exists...
                    if (instance_exists(_schedule[SGMS_SCHEDULE.TARGET]))
                    {
                        // Put it back to deactivated state... 
                        instance_deactivate_object(_schedule[SGMS_SCHEDULE.TARGET]);
                    }
                    else
                    {
                        // Remove schedule from schedules list
                        ds_list_delete(_schedules, _index--);
                        // Invalidate schedule index handle
                        ds_map_delete(global.SGMS_MAP_SCHEDULES, _schedule[SGMS_SCHEDULE.ID]);
                        // Clear target instance
                        _schedule[@ SGMS_SCHEDULE.TARGET] = noone;
                        // Mark schedule as destroyed 
                        _schedule[@ SGMS_SCHEDULE.STATE] = -1;
                        // Nullify self referenced handle
                        _schedule[@ SGMS_SCHEDULE.ID] = 0;
                    }
                }
            }
        }
    }
}

#define SharedScheduler_RoomStart
/// SharedScheduler_RoomStart()

// Restore schedules for persistent rooms
if (room_persistent)
{
    // Tell shared scheduler to remain persistent
    keepPersistent = true;
    // Cache room name for map key
    var _key = room;
    
    // IF the persistent room has stored schedules
    if (ds_map_exists(pRoomSchedules, _key))
    {
        // Cache queue of room's schedules
        var _queuedSchedules = pRoomSchedules[? _key];
        // Cache schedules list
        var _schedules = schedules; 
        
        // Add stored tweens back to main schedules list
        repeat(ds_queue_size(_queuedSchedules))
        {
            ds_list_add(_schedules, ds_queue_dequeue(_queuedSchedules));
        }
    }
}

#define SharedScheduler_RoomEnd
/// SharedScheduler_RoomEnd()

var _schedules = schedules;
var _tempPersistent = false;

//------------------------------------------
// Handle Schedules for Persistent Room
//------------------------------------------
if (room_persistent)
{
    // Use room index as map key for storing schedules
    var _key = room;
    // Tell shared scheduler to remain persistent -- tell it who's boss!
    keepPersistent = true;
    // Create persistent queue for room if it doesn't exist
    if (ds_map_exists(pRoomSchedules, _key) == false) { ds_map_replace(pRoomSchedules, _key, ds_queue_create()); }
    // Cache room's schedule queue
    var _pRoomQueue = pRoomSchedules[? _key]; 
        
    // Add schedules to persistent room data 
    var _index = ds_list_size(_schedules); // Start index checking at schedule list size
    repeat(_index)
    {  
        // Cache schedule
        var _schedule = _schedules[| --_index];
        // Cache target
        var _target = _schedule[SGMS_SCHEDULE.TARGET];
        
        // IF target exists and is not persistent...
        if (instance_exists(_target))
        {
            if (_target.persistent == false)
            {
                // Remove from main schedule list
                ds_list_delete(_schedules, _index);
                // Add schedule to persistent room queue
                ds_queue_enqueue(_pRoomQueue, _schedule);
            }
        }
        else
        {
            // Attempt to activate instance
            instance_activate_object(_target);
            
            // IF the instance now exists
            if (instance_exists(_target))
            {
                // IF instance is not persistent
                if (_target.persistent == false)
                {
                    // Remove from main schedule list
                    ds_list_delete(_schedules, _index);
                    // Add schedule to persistent room queue
                    ds_queue_enqueue(_pRoomQueue, _schedule);
                }
                
                // Put instance back to deactivated state
                instance_deactivate_object(_target);
            }
        }
    }
}
else
{ 
    //------------------------------------------------
    // Handle Schedules for Non-Persistent Room
    //------------------------------------------------ 
    var _index = ds_list_size(_schedules);
    repeat(_index)
    {  
        // Cache schedule
        var _schedule = _schedules[| --_index];
        
        // IF target exists and is persistent, signal system to be persistent
        if (instance_exists(_schedule[SGMS_SCHEDULE.TARGET]) && _schedule[SGMS_SCHEDULE.TARGET].persistent)
        {
            _tempPersistent = true;
        }
        else
        {
            // Remove schedule from schedules list
            ds_list_delete(_schedules, _index);
            // Clear schedule handle
            ds_map_delete(global.SGMS_MAP_SCHEDULES, _schedule[9]);
        }
    }
}

//-----------------------------------------------------
// Destroy Shared Scheduler if not set as persistent
//-----------------------------------------------------
if (keepPersistent || _tempPersistent) 
{
    persistent = true;
}
else 
{
    instance_destroy();
}

#define SharedSchedulerActivate
/// SharedSchedulerActivate()

instance_activate_object(obj_SharedScheduler);

#define SharedSchedulerDestroy
/// SharedSchedulerDestroy()

with(obj_SharedScheduler) instance_destroy();