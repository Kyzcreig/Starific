/// ScheduleFinishAll(deactivated)

var _schedules = SharedScheduler().schedules;  
var _index = -1;

if (argument0)
{
    repeat(ds_list_size(_schedules))
    {
        var _schedule = _schedules[| ++_index];
        ScheduleFinish(_schedule[SGMS_SCHEDULE.ID]);
    }
}
else
{
    repeat(ds_list_size(_schedules))
    {
        var _schedule = _schedules[| ++_index];
        
        if (instance_exists(_schedule[SGMS_SCHEDULE.TARGET]))
        {
            ScheduleFinish(_schedule[SGMS_SCHEDULE.ID]);
        }
    }
}