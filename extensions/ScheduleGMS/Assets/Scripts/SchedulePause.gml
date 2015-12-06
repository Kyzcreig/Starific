/// SchedulePause(schedule)

if (argument0)
{
    var _schedule = global.SGMS_MAP_SCHEDULES[? argument0];

    if (_schedule[SGMS_SCHEDULE.STATE] == 1)
    {
        _schedule[@ SGMS_SCHEDULE.STATE] = 0;
    }
}