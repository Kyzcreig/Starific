/// ScheduleSoundAt(target,delta,dur,sound,x,y,z,falloff_rest_dist,falloff_max_dist,falloff_factor,loops,priority)

// Reference default schedule -- create new schedule on write
var _schedule = global.SGMS_DefaultSchedule;

_schedule[SGMS_SCHEDULE.ARGS+7] = argument[11];

_schedule[SGMS_SCHEDULE.TARGET] = argument[0];
_schedule[SGMS_SCHEDULE.DELTA] = argument[1];
_schedule[SGMS_SCHEDULE.DURATION] = argument[2];
_schedule[SGMS_SCHEDULE.TIME] = argument[2];
_schedule[SGMS_SCHEDULE.SCRIPT_EVENT] = argument[3];
_schedule[SGMS_SCHEDULE.ARGS] = argument[4];
_schedule[SGMS_SCHEDULE.ARGS+1] = argument[5];
_schedule[SGMS_SCHEDULE.ARGS+2] = argument[6];
_schedule[SGMS_SCHEDULE.ARGS+3] = argument[7];
_schedule[SGMS_SCHEDULE.ARGS+4] = argument[8];
_schedule[SGMS_SCHEDULE.ARGS+5] = argument[9];
_schedule[SGMS_SCHEDULE.ARGS+6] = argument[10];
_schedule[SGMS_SCHEDULE.TYPE] = SGMS_SCHEDULE_TYPE.SOUND_AT;
_schedule[SGMS_SCHEDULE.ID] = ++global.SGMS_INDEX_SCHEDULE;

// Assign schedule index to schedule map
global.SGMS_MAP_SCHEDULES[? global.SGMS_INDEX_SCHEDULE] = _schedule;
// Add new schedule to scheduler list
ds_list_add(SharedScheduler().schedules, _schedule);
// Return schedule handle index
return global.SGMS_INDEX_SCHEDULE;