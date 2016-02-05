#define scr_set_game_info_text
///scr_set_game_info_text()

info_txt = "";
if QUEST_DATA[0] != -1{ 
    info_txt += "q "+scr_quest_text_format(QUEST_DATA[0],
                   min(QUEST_DATA[2] + scr_quest_progress(), 
                   QUEST_DATA[1]), QUEST_DATA[1]);
    info_txt += "#" //NB: This line should be in this block.
    
}
info_txt += "t "+time_decode_opt_custom(0,1,1,lastPlaytime,60);
info_txt += "#"
info_txt += "r "+convert_index_to_val_string(2,RIGOR) 
info_txt += "#"
info_txt += "g "+convert_index_to_val_string(0,GRID);
info_txt += "#"
info_txt += string(RMSPD_DEFAULT)+" fps";
//info_txt += "#"

return info_txt;

#define scr_set_pause_now_playing
///scr_set_pause_now_playing()

np_text = "";
np_vel = 1 * RMSPD_DELTA;
np_w = 0;

if MUSIC_STATE == 1 and audio_exists(CURRENT_SONG){
    draw_set_font(fnt_menu_calibri_24_bold);
    // Get Music Data
    var _md = MUSIC_DATA[CURRENT_SONG_INDEX];
    np_text = "Now Playing:    "+_md[1];
    if CONFIG == CONFIG_TYPE.HTML {
    } else {
        np_text = "Now Playing:    "+_md[1];
    }
    np_w = string_width(np_text);

}

np_x[0] = GAME_X + GAME_W*.1; // + 20 
np_x[1] = np_x[0] + np_w + GAME_W/2;
np_y = GAME_Y + GAME_H - 20;

return np_text;

#define scr_set_quest_cancel_button_status
///scr_set_quest_cancel_button_status()



if QUEST_DATA[0] == -1 {
    scr_pause_button_set_status(9,-1);
}




#define scr_pause_button_find_index
//scr_pause_button_find_index(id)



for (var i = 0, n = array_length_1d(btn_items); i < n; i++){
    var data = btn_items[i];
    
    //check if ID matches criteria
    if data[2] == argument0 {
        return i;
    }

}

return -1;

#define scr_pause_button_set_status
///scr_pause_button_set_status(id, status)

// find button index
var button_index = scr_pause_button_find_index(argument0);

// get button data
var button_data = btn_items[button_index];

// update Status
button_data[@ 4] = argument1;

#define scr_pause_resume_countdown
///scr_pause_resume_countdown(set_countdown)

// Set Resume Countdown Timer
if argument_count > 0 {
    resumeCD[@ 0] = argument[0] + 1;  //+1 because we decrement anyway
}

// Decrement Resume Countdown
resumeCD[@ 0] -= 1;
// Set Text Scale
resumeCD_scale[0] = 1;

if resumeCD[0] > 0 {
    // Ease Countdown Timer
    resumeCD_tween = TweenFire(id,resumeCD_scale,EaseInBack, 
                            TWEEN_MODE_ONCE,1, 0, 1, resumeCD_scale[0], 0);
    // Add Callback
    TweenAddCallback(resumeCD_tween,TWEEN_EV_FINISH,id,scr_pause_resume_countdown);
    // Play Beep Sound
    scr_sound(sd_resume_step_beep);

}
else {
    // Fade out Overlay
    TweenPlay(p_TweenFade);
        //NB: Game should unpause automatically on tween finish.

    //Play Special Final Beep
    scr_sound(sd_resume_final_beep);
}    

#define scr_set_everyplay_button_status
///scr_set_everyplay_button_status()



if everyplay_is_recording(){
    scr_pause_button_set_status(10,1);
} else {
    scr_pause_button_set_status(10,0);

}