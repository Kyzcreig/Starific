///scr_gamemod_make_prompt_description(mod_data)

var mod_data = argument0;
var name = mod_data[7];
var dur = time_decode_opt_custom(false, true, true, mod_data[3], 60);

return name+" for the next "+dur
