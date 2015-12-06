/// ScheduleSetMuteAll(mute,deactivated)

var _schedules = SharedScheduler().schedules;  
var _index = -1;

if (argument1)
{
    repeat(ds_list_size(_schedules))
    {
        var _schedule = _schedules[| ++_index];
        ScheduleSetMute(_schedule[SGMS_SCHEDULE.ID], argument0);
    }
}
else
{
    repeat(ds_list_size(_schedules))
    {
        var _schedule = _schedules[| ++_index];
        
        if (instance_exists(_schedule[SGMS_SCHEDULE.TARGET]))
        {
            ScheduleSetMute(_schedule[SGMS_SCHEDULE.ID], argument0);
        }
    }
}