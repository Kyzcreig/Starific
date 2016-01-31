#define ScheduleScript
///ScheduleScript(target, delta, dur, script[, arg0, arg1, ...])

var _s = noone; //schedule
var _d = noone; //data
var _c = noone; //callback

for (var i = argument_count - 1; i >= 0; i--){
    _d[i] = argument[i];
}

_s = TweenFire(_d[0], "", EaseLinear, TWEEN_MODE_ONCE, _d[1], 0, _d[2], 0, 1); //obj_control_main
// Play Schedule Tween
//TweenDestroyWhenDone(_s, true);
//TweenPlay(_s); 
// Schedule Callback
_c = ScheduleAddCallback(_s, _d);

return _s;


#define ScheduleAddCallback
///ScheduleAddCallback(schedule, data)

var _s = argument0;
var _d = argument1;
var _c = noone;

var argLen = array_length_1d(_d) - 4;

switch argLen {

case 0:
    _c = TweenAddCallback(_s, TWEEN_EV_FINISH, _d[0], _d[3]);
    break;
case 1:
    _c = TweenAddCallback(_s, TWEEN_EV_FINISH, _d[0], _d[3], _d[4]);
    break;
case 2:
    _c = TweenAddCallback(_s, TWEEN_EV_FINISH, _d[0], _d[3], _d[4], _d[5]);
    break;
case 3:
    _c = TweenAddCallback(_s, TWEEN_EV_FINISH, _d[0], _d[3], _d[4], _d[5], _d[6]);
    break;
case 4:
    _c = TweenAddCallback(_s, TWEEN_EV_FINISH, _d[0], _d[3], _d[4], _d[5], _d[6], _d[7]);
    break;
case 5:
    _c = TweenAddCallback(_s, TWEEN_EV_FINISH, _d[0], _d[3], _d[4], _d[5], _d[6], _d[7], _d[8]);
    break;
case 6:
    _c = TweenAddCallback(_s, TWEEN_EV_FINISH, _d[0], _d[3], _d[4], _d[5], _d[6], _d[7], _d[8], _d[9]);
    break;
case 7:
    _c = TweenAddCallback(_s, TWEEN_EV_FINISH, _d[0], _d[3], _d[4], _d[5], _d[6], _d[7], _d[8], _d[9], _d[10]);
    break;
case 8:
    _c = TweenAddCallback(_s, TWEEN_EV_FINISH, _d[0], _d[3], _d[4], _d[5], _d[6], _d[7], _d[8], _d[9], _d[10], _d[11]);
    break;
case 9:
    _c = TweenAddCallback(_s, TWEEN_EV_FINISH, _d[0], _d[3], _d[4], _d[5], _d[6], _d[7], _d[8], _d[9], _d[10], _d[11], _d[12]);
    break;
case 10:
    _c = TweenAddCallback(_s, TWEEN_EV_FINISH, _d[0], _d[3], _d[4], _d[5], _d[6], _d[7], _d[8], _d[9], _d[10], _d[11], _d[12], _d[13]);
    break;
case 11:
    _c = TweenAddCallback(_s, TWEEN_EV_FINISH, _d[0], _d[3], _d[4], _d[5], _d[6], _d[7], _d[8], _d[9], _d[10], _d[11], _d[12], _d[13], _d[14]);
    break;
case 12:
    _c = TweenAddCallback(_s, TWEEN_EV_FINISH, _d[0], _d[3], _d[4], _d[5], _d[6], _d[7], _d[8], _d[9], _d[10], _d[11], _d[12], _d[13], _d[14], _d[15]);
    break;

}

return _c;









#define ScheduleExists
///ScheduleExists(Schedule)

var _s = argument0;

return TweenExists(_s);

#define ScheduleCancel
///ScheduleCancel(Schedule)

var _s = argument0;

TweenEventClear(_s, TWEEN_EV_FINISH);
TweenDestroy(_s);


#define ScheduleFinish
///ScheduleFinish(schedule)

var _s = argument0;

TweenFinish(_s, true);

#define script497
///ScheduleCreateExt(target, mode, delta, delay, dur, script[, arg0, arg1, ...])

//TO DO, later if we want