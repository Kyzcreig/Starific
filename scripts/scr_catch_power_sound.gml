///scr_catch_power_sound(objIndex,objType)
//This script is called when a power up is caught by the paddle.
//It takes an integer as the parameter and plays the according sound.


var _whichObject = argument[0];
var _whichType = argument[1];

if _whichType == 1{scr_sound(sd_catch_power_good, 1, false);}//
else if _whichType == 2{scr_sound(sd_catch_power_bad, 1, false);}
else if object_is_ancestor(_whichObject,obj_powerup_parent_cash) {scr_sound(sd_catch_cash, 1, false);}
else if _whichType == 3{scr_sound(sd_catch_power_neutral, 1, false);}
//else if _whichType == 4{scr_sound(sd_catch_power_bomb, 1, false);}
