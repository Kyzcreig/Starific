/// ScheduleSystemClearRoom(room)
// Clears persistent room's schedule data

// Cache persisent room schedules map
var _pRoomSchedules = SharedScheduler().pRoomSchedules;
// Cache schedules index map
var _mapSchedules = global.SGMS_MAP_SCHEDULES;
// Set key as room index
var _key = argument0;

// Destroy schedules for persistent room
if (ds_map_exists(_pRoomSchedules, _key))
{
    // Get persisent room's queue of stored schedules
    var _queue = ds_map_find_value(_pRoomSchedules, _key);
    
    // Invalidate schedule handles
    repeat(ds_queue_size(_queue))
    {   
        var _schedule = ds_queue_dequeue(_queue);
        ds_map_delete(_mapSchedules, _schedule[9]);
    }
    
    // Destroy queue holding persistent room schedules
    ds_queue_destroy(_queue);
    // Delete key from persistent room schedules map
    ds_map_delete(_pRoomSchedules, _key);
}