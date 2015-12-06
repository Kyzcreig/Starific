/// ScheduleSetRepeat(schedule,count)

if (argument0)
{
    var _schedule = global.SGMS_MAP_SCHEDULES[? argument0];
    _schedule[@ SGMS_SCHEDULE.REPEAT_COUNT] = max(-1, floor(argument1));
}