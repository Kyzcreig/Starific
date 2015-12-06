/// ScheduleSystemClearAllRooms()
// Clears schedule data from all persistent rooms

var _pRoomSchedules = SharedScheduler().pRoomSchedules;

// Clear and destroy schedules
repeat(ds_map_size(_pRoomSchedules))
{
    var _key = ds_map_find_first(_pRoomSchedules);
    var _queue = ds_map_find_value(_pRoomSchedules, _key);
    
    repeat(ds_queue_size(_queue))
    {
        var _schedule = ds_queue_dequeue(_queue);
        {   
            // Invalidate schedule handle
            ds_map_delete(global.SGMS_MAP_SCHEDULES, _schedule[9]);
        }
    }
    
    ds_queue_destroy(_queue);
    ds_map_delete(_pRoomSchedules, _key);
}