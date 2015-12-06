/// ScheduleScript(target,delta,dur,script,arg0,arg1,...);

// Reference default schedule -- create new schedule on write
var _schedule = global.SGMS_DefaultSchedule;

// Set script callback arguments
var _cbArgCount = argument_count-4;
var _argIndex = argument_count;
var _schedIndex = SGMS_SCHEDULE.ARGS + _cbArgCount;

repeat(_cbArgCount)
{
    _schedule[--_schedIndex] = argument[--_argIndex];
}

// Set schedule properties
_schedule[SGMS_SCHEDULE.TARGET] = argument[0];
_schedule[SGMS_SCHEDULE.DELTA] = argument[1];
_schedule[SGMS_SCHEDULE.DURATION] = argument[2];
_schedule[SGMS_SCHEDULE.TIME] = argument[2];
_schedule[SGMS_SCHEDULE.SCRIPT_EVENT] = argument[3];
_schedule[SGMS_SCHEDULE.TYPE] = SGMS_SCHEDULE_TYPE.SCRIPT;
_schedule[SGMS_SCHEDULE.ID] = ++global.SGMS_INDEX_SCHEDULE;

// Assign schedule index to schedule map
global.SGMS_MAP_SCHEDULES[? global.SGMS_INDEX_SCHEDULE] = _schedule;
// Add new schedule to scheduler list
ds_list_add(SharedScheduler().schedules, _schedule);
// Return schedule ID
return global.SGMS_INDEX_SCHEDULE;