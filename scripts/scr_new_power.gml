///scr_new_power(array, list, dur, object_index, tap_txt, misc value, array_index)
var z;

z = -1;
var new_power = argument[++z];
var timer_list = argument[++z];
var timer_dur = argument[++z];
var obj_index = argument[++z];
var obj_data = scr_deflector_get_data(obj_index);
var power_type = obj_data[1];
var icon_symbol = obj_data[4];
var icon_txt = obj_data[5];
var tapper_txt = argument[++z];
var misc_val = argument[++z];
var array_index = argument[++z];

z = 0; //start at sub 1
new_power[@ ++z] = timer_list;
new_power[@ ++z] = timer_dur;
new_power[@ ++z] = power_type;
new_power[@ ++z] = icon_symbol;
new_power[@ ++z] = icon_txt;
new_power[@ ++z] = tapper_txt;
new_power[@ ++z] = misc_val; //misc data
new_power[@ ++z] = array_index; //position in POWER_ARRAY
new_power[@ ++z] = obj_index; //9



//Append power to power array
var power_index = array_length_1d(POWER_ARRAY);
POWER_ARRAY[(power_index)] = new_power;
