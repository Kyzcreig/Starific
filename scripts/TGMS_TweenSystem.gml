#define TGMS_TweenSystem
/// TweenSystem()

/*
    Scripts for setting global tweening system functionality
    and getting global system information.
*/

#define TweenSystemDeltaTime
/// TweenSystemDeltaTime(scaled)
/*
    @scaled = return delta time affected by system time scale?
    
    RETURN:
        real
        
    INFO:
        Returns the internal delta time updated by obj_SharedTweener.
        
    EXAMPLE:
        // Increase 'x' by 16 every second
        x += 16*TweenSystemDeltaTime(false);
*/

if (argument0)
{
    return SharedTweener().deltaTime * SharedTweener().timeScale;
}

return SharedTweener().deltaTime;

#define TweenSystemGetEnabled
/// TweenSystemGetEnabled()
/*
    RETURN:
        bool
        
    INFO:
        Returns true if tweening system is enabled
*/

return SharedTweener().isEnabled;

#define TweenSystemSetEnabled
/// TweenSystemSetEnabled(enable)
/*
    @enable = enable tweening system?
    
    RETURN:
        na
        
    INFO:
        Used to enable/disable the tweening system
*/

(SharedTweener()).isEnabled = argument0;
global.TGMS_IsEnabled = argument0;

#define TweenSystemGetTimeScale
/// TweenSystemGetTimeScale()
/*
    RETURN:
        real
        
    INFO:
        Returns the tweening engine's system-wide time scale
*/

return SharedTweener().timeScale;

#define TweenSystemSetTimeScale
/// TweenSystemSetTimeScale(scale)
/*
    @scale = time scale
    
    RETURN:
        na
        
    INFO:
        Sets the tweening engine's system-wide time scale.
        This will affect the time scale of all active tweens,
        independent of their own time scale.
*/

(SharedTweener()).timeScale = argument0;
global.TGMS_TimeScale = argument0;

#define TweenSystemGetUpdateInterval
/// TweenSystemGetUpdateInterval()

return SharedTweener().updateInterval;

#define TweenSystemSetUpdateInterval
/// TweenSystemSetUpdateInterval(steps)

(SharedTweener()).updateInterval = argument0;
global.TGMS_UpdateInterval = argument0;

#define TweenSystemCount
/// TweenSystemCount(TWEEN_COUNT_****)
/*
    RETURN:
        real
    
    INFO:
        Returns total number of tweens in system, excluding those in inactive persistent rooms
*/

return ds_list_size(SharedTweener().tweens);

#define TweenSystemCountPlaying
/// TweenSystemCountPlaying()
/*
    RETURN:
        real
    
    INFO:
        Returns total number of tweens playing in system, excluding those in inactive persistent rooms
*/

var _tweens = SharedTweener().tweens;
var _total = 0;
var _index = -1;

repeat(ds_list_size(_tweens))
{
    var _tween = _tweens[| ++_index];
    _total += _tween[TWEEN.STATE] >= 0;
}

return _total;

#define TweenSystemCountStopped
/// TweenSystemCountStopped()
/*
    RETURN:
        real
    
    INFO:
        Returns total number of tweens stopped in system, excluding those in inactive persistent rooms
*/

var _tweens = SharedTweener().tweens; 
var _total = 0;
var _index = -1;   

repeat(ds_list_size(_tweens))
{
    var _tween = _tweens[| ++_index];
    _total += _tween[TWEEN.STATE] == TWEEN_STATE.STOPPED;
}

return _total;

#define TweenSystemCountPaused
/// TweenSystemCountPaused()
/*
    RETURN:
        real
    
    INFO:
        Returns total number of tweens paused in system, excluding those in inactive persistent rooms
*/

var _tweens = SharedTweener().tweens;
var _total = 0;
var _index = -1;

repeat(ds_list_size(_tweens))
{
    var _tween = _tweens[| ++_index];
    _total += _tween[TWEEN.STATE] == TWEEN_STATE.PAUSED;
}

return _total;

#define TweenSystemSetMinDeltaFPS
/// TweenSystemSetMinDeltaFPS(fps)
/*
    @fps = frame rate
    
    RETURN:
        na
        
    INFO:
        Sets the minimum frame rate allowed before delta timing begins to lag behind.
        It is advised to keep this number as default, unless you know what you're doing.
        DEFAULT: 10
*/

with(SharedTweener())
{
    global.TGMS_MinDeltaFPS = argument0;
    minDeltaFPS = argument0;
    maxDelta = 1/minDeltaFPS;
}

#define TweenSystemSetAutoCleanIterations
/// TweenSystemSetAutoCleanIterations(num)
/*
    @num = number of tweens to check each step
    
    RETURN:
        na
        
    INFO:
        Sets the number of tweens to be passively checked
        each step for automatic garbage collection.
        DEFAULT: 10
*/

with(SharedTweener())
{
    global.TGMS_AutoCleanIterations = argument0;
    autoCleanIterations = argument0;
}
#define TweenSystemFlushDestroyed
/// TweenSystemFlushDestroyed()
/*
    RETURN:
        na
        
    INFO:
        Overrides passive memory manager by immediately removing
        all destroyed tweens from the system
*/

with(SharedTweener())
{
    // Make sure auto clean index is reset after flushing system
    autoCleanIndex = 0;
    
    var _tweens = tweens;
    var _index = ds_list_size(_tweens);
    
    repeat(ds_list_size(_tweens))
    {   
        var _t = _tweens[| --_index];
        var _target = _t[TWEEN.TARGET];
        
        // Check to see if target no longer exists -- Proceed with attempting to destroy tween if so
        if (instance_exists(_target) == false)
        { 
            // Attempt to reactivate instance if it has simply been deactivated
            instance_activate_object(_target);
            
            // IF instance still exists, put target back in deactivated state 
            // ELSE proceed with destroying tween
            if (instance_exists(_target))
            {
                instance_deactivate_object(_target);
            }
            else
            {
                // Delete simple tween data
                ds_map_delete(simpleTweens, _t[TWEEN.SIMPLE_KEY]); 
                // Invalidate tween handle
                ds_map_delete(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]);
                // Remove tween from tweens list 
                ds_list_delete(_tweens, _index);
                
                // Destroy tween events if events map exists
                if (_t[TWEEN.EVENTS] != -1)
                {
                    // Cache events
                    var _events = _t[TWEEN.EVENTS];
                    // Find key to first event
                    var _key = ds_map_find_first(_events);
                    
                    // Cycle through and destroy all events
                    repeat(ds_map_size(_events))
                    {
                        // Cache event
                        var _event = _events[? _key];
                        
                        // Cycle through all event callbacks...
                        var _cbIndex = 0;
                        repeat(ds_list_size(_event)-1)
                        {
                            // Invalidate callback handle
                            var _cb = _event[| ++_cbIndex];
                            ds_map_delete(global.TGMS_MAP_CALLBACK, _cb[2]);
                        }
                        
                        // Destroy event
                        ds_list_destroy(_event);
                        // Find key for next event
                        _key = ds_map_find_next(_events, _key);
                    } 
                    
                    // Destroy events map
                    ds_map_destroy(_events);
                }
            }
        }
    }
}

#define TweenSystemClearRoom
/// TweenSystemClearRoom(room)
/*
    @room = persistent room
    
    RETURN:
        na

    INFO:
        Clears persistent room's stored tween data
*/

TGMS_ClearRoom(argument0);

#define TweenSystemClearAllRooms
/// TweenSystemClearAllRooms()
/*
    RETURN:
        na
        
    INFO:
        Clears stored tween data from all persistent rooms  
*/

TGMS_ClearAllRooms();