/// ScheduleGMS_Init()
/*
    Extension Init Function
    -- DO NOT CALL THIS --
*/

global.SGMS_SharedScheduler = noone;
global.SGMS_FirstLoad = true;
global.SGMS_MAP_SCHEDULES = ds_map_create();
global.SGMS_INDEX_SCHEDULE = 0;

var _null;
_null[0] = noone;

global.SGMS_MAP_SCHEDULES[? 0] = _null;

enum SGMS_SCHEDULE{
TARGET=0,
STATE,
TYPE,
REPEAT_COUNT,
TIME_SCALE,
DELTA,
GROUP,
DURATION,
TIME,
ID,
FORCE_TIMER,
SCRIPT_EVENT,
ARGS,
};

enum SGMS_SCHEDULE_TYPE{
SCRIPT=1,
EVENT,
EVENT_USER,
EVENT_OBJECT,
SOUND,SOUND_AT,
SOUND_ON,
TIME_LINE,
PATH,
ALARM
};

global.SGMS_DefaultSchedule[SGMS_SCHEDULE.TARGET] = noone;
global.SGMS_DefaultSchedule[SGMS_SCHEDULE.SCRIPT_EVENT] = 0;
global.SGMS_DefaultSchedule[SGMS_SCHEDULE.TYPE] = 1;
global.SGMS_DefaultSchedule[SGMS_SCHEDULE.STATE] = 1;
global.SGMS_DefaultSchedule[SGMS_SCHEDULE.REPEAT_COUNT] = 0;
global.SGMS_DefaultSchedule[SGMS_SCHEDULE.TIME_SCALE] = 1.0;
global.SGMS_DefaultSchedule[SGMS_SCHEDULE.DELTA] = false;
global.SGMS_DefaultSchedule[SGMS_SCHEDULE.GROUP] = 0;
global.SGMS_DefaultSchedule[SGMS_SCHEDULE.DURATION] = 0;
global.SGMS_DefaultSchedule[SGMS_SCHEDULE.TIME] = 0;
global.SGMS_DefaultSchedule[SGMS_SCHEDULE.ID] = -1;
global.SGMS_DefaultSchedule[SGMS_SCHEDULE.FORCE_TIMER] = false;
