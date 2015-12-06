/// ScheduleResumeAll(deactivated)
 
var _schedules = SharedScheduler().schedules;  
var _index = -1;

if (argument0)
{
    repeat(ds_list_size(_schedules))
    {
        var _schedule = _schedules[| ++_index];
        ScheduleResume(_schedule[SGMS_SCHEDULE.ID]);
    }
}
else
{
    repeat(ds_list_size(_schedules))
    {
        var _schedule = _schedules[| ++_index];
        
        if (instance_exists(_schedule[SGMS_SCHEDULE.TARGET]))
        {
            ScheduleResume(_schedule[SGMS_SCHEDULE.ID]);
        }
    }
}