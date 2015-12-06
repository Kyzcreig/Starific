/// ScheduleSetDelta(schedule,bool)

if (argument0)
{
    var _schedule = global.SGMS_MAP_SCHEDULES[? argument0];
    _schedule[@ SGMS_SCHEDULE.DELTA] = argument1;
}