/// ScheduleFinish(schedule)

if (argument0)
{
    // Cache schedule data
    var _schedule = global.SGMS_MAP_SCHEDULES[? argument0];
    // Execute callback
    SGMS_ExecuteCallback(argument0);
    // Invalidate schedule handle
    ds_map_delete(global.SGMS_MAP_SCHEDULES, _schedule[SGMS_SCHEDULE.ID]);
    // Clear target instance
    _schedule[@ SGMS_SCHEDULE.TARGET] = noone;
    // Mark schedule as destroyed 
    _schedule[@ SGMS_SCHEDULE.STATE] = -1;
    // Nullify self reference handle
    _schedule[@ SGMS_SCHEDULE.ID] = 0;
}