/// ScheduleGetTime(schedule)

if (argument0)
{
    var _schedule = global.SGMS_MAP_SCHEDULES[? argument0];
    return _schedule[SGMS_SCHEDULE.TIME];
}