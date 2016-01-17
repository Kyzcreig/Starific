#define audio_add_managed_sound
///audio_add_managed_sound(sound,number)
//I lazily assumed that you setup sound caps only at the beginning, not changing it anywhere later
//if it's different, feel free to change that script to reflect that; don't forget not to create too many ds_lists
var sound = argument[0]
var number = argument[1]
ds_map_add(MANAGED_SOUNDS, sound, ds_list_create());
ds_map_add(MANAGED_SOUND_CAPS, sound, number);

#define scr_add_sound_management_and_sfx_list
///scr_add_sound_management_and_sfx_list(sound,cap)

// add cap to cap map
audio_add_managed_sound(argument0,argument1)
// add to sfx list
ds_list_add(sfx_list,argument0)