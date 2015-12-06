/// ScheduleSetMute(schedule,mute)

if (argument0)
{
    var _schedule = global.SGMS_MAP_SCHEDULES[? argument0];
    
    if (argument1)
    {
        _schedule[@ SGMS_SCHEDULE.TYPE] = -abs(_schedule[SGMS_SCHEDULE.TYPE]);
    }
    else
    {
        _schedule[@ SGMS_SCHEDULE.TYPE] = abs(_schedule[SGMS_SCHEDULE.TYPE]);
    }
}