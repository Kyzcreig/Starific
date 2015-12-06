///scr_shake_add(duration, power)

var dur = argument0
var pwr = argument1;


SHAKE_TIME = max(dur,SHAKE_TIME);
SHAKE_POWER = max(pwr, SHAKE_POWER);

//NB: We can't accurately do different shake power strengths
//without some kind of ds_map or ds_list system but I think this will work for now.
// Luckily using a script for all shake adding will make refactoring that much simpler.
