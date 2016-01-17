#define scr_sound_toggle_music
//scr_sound_toggle_music()


music_sound[@ 1] = round(!music_sound[@ 1]);  //NB: Round was required for HTML5

//Remember Mute Settings
ini_open("scores.ini") //NB: Eventually I 'd like to switch this to the savedata.ini file
  ini_write_real("settings", "music_enabled", music_sound[1]);
ini_close();


// If Song Exists
if audio_exists(CURRENT_SONG) {
    audio_sound_gain(CURRENT_SONG, music_sound[0]*music_sound[1], 0);
}

#define scr_sound_toggle_sfx
//scr_sound_toggle_sfx()

sfx_sound[@ 1] = round(!sfx_sound[@ 1]);  //NB: Round was required for HTML5
     
//Remember Mute Settings
ini_open("scores.ini") //NB: Eventually I 'd like to switch this to the savedata.ini file
  ini_write_real('settings', "sfx_enabled", sfx_sound[1]);
ini_close();

// If SFX enabled
if sfx_sound[1] {
    // For Each SFX
    for (var i = 0; i < ds_list_size(sfx_list); i++){  
        // Set Volume
       audio_sound_gain(sfx_list[| i], sfx_sound[0], 0);
    }

} else {
    // For Each SFX
    for (var i = 0; i < ds_list_size(sfx_list); i++){
        // Mute
       audio_sound_gain(sfx_list[| i], 0, 0);
    }

}