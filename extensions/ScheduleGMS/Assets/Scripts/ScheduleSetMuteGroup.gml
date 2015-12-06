/// ScheduleSetMuteGroup(group,mute,deactivated)

var _schedules = SharedScheduler().schedules;  
var _index = -1;

if (argument2)
{
    repeat(ds_list_size(_schedules))
    {
        if (_schedule[SGMS_SCHEDULE.GROUP] == argument0)
        {
            var _schedule = _schedules[| ++_index];
            ScheduleSetMute(_schedule[SGMS_SCHEDULE.ID], argument1);
        }
    }
}
else
{
    repeat(ds_list_size(_schedules))
    {
        var _schedule = _schedules[| ++_index];
        
        if (_schedule[SGMS_SCHEDULE.GROUP] == argument0 && instance_exists(_schedule[SGMS_SCHEDULE.TARGET]))
        {
            ScheduleSetMute(_schedule[SGMS_SCHEDULE.ID], argument1);
        }
    }
}