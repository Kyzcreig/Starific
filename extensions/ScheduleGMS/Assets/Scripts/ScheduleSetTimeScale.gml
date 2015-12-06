/// ScheduleSetTimeScale(schedule,scale)

if (argument0)
{
    var _schedule = global.SGMS_MAP_SCHEDULES[? argument0];
    _schedule[@ SGMS_SCHEDULE.TIME_SCALE] = argument1;
}