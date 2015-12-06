/// ScheduleSetTarget(schedule,instance)

if (argument0)
{
    var _schedule = global.SGMS_MAP_SCHEDULES[? argument0];
    _schedule[@ SGMS_SCHEDULE.TARGET] = argument1;
}