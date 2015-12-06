/// ScheduleFinishGroup(group,deactivated)

var _schedules = SharedScheduler().schedules;  
var _index = -1;

if (argument1)
{
    repeat(ds_list_size(_schedules))
    {
        var _schedule = _schedules[| ++_index];

        if (_schedule[SGMS_SCHEDULE.GROUP] == argument0)
        {
            ScheduleFinish(_schedule[SGMS_SCHEDULE.ID]);
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
            ScheduleFinish(_schedule[SGMS_SCHEDULE.ID]);
        }
    }
}