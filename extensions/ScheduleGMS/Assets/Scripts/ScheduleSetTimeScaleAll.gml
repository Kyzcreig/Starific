/// ScheduleSetTimeScaleAll(scale,deactivated)

var _schedules = SharedScheduler().schedules;  
var _index = -1;

if (argument1)
{
    repeat(ds_list_size(_schedules))
    {
        var _schedule = _schedules[| ++_index];
        ScheduleSetTimeScale(_schedule[SGMS_SCHEDULE.ID], argument0);
    }
}
else
{
    repeat(ds_list_size(_schedules))
    {
        var _schedule = _schedules[| ++_index];
        
        if (instance_exists(_schedule[SGMS_SCHEDULE.TARGET]))
        {
            ScheduleSetTimeScale(_schedule[SGMS_SCHEDULE.ID], argument0);
        }
    }
}