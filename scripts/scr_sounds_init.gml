#define scr_sounds_init
///scr_sounds_init
//This script is called in the obj_control_game Game Start event.
//It initializes all the sound caps and the lists of sounds which are used
//to manipulate volume among other things.

//Initialize global variables
globalvar sfx_sound, music_sound, sfx_list, music_list;
globalvar CURRENT_SONG_TIME, managed_sounds,sound_caps, CURRENT_SONG, CURRENT_SONG_GAIN;
globalvar MUSIC_STATE,musicStopper, musicEaser, MUSIC_ACTIVE;

MUSIC_ACTIVE = false;

//Pull sound data
ini_open("scores.ini")
    //show_message(string(program_directory))
    sfx_sound[0] = ini_read_real("settings", "sfx_volume", .5);
    sfx_sound[1] = ini_read_real("settings", "sfx_enabled", 1);
    sfx_sound[2] = false;
    music_sound[0] = ini_read_real("settings", "music_volume", .5);
    music_sound[1] = ini_read_real("settings", "music_enabled", 1);
    music_sound[2] = false;
    // index 0 = volume, index 1 = enabled, index 2 = volume pressed
ini_close();

//Detect operating system and set audio channel max
switch (os_browser){
    case browser_not_a_browser:
        switch (os_type){
            // Desktop Platforms
            case os_windows:
            case os_macosx:
               audio_channel_num(200);
               capfactor = 12 
               break;
            // Mobile Platforms
            default:
               audio_channel_num(64);
               capfactor = 4
               break;
        }
        break;
    // HTML5 Platforms
    default:
        audio_channel_num(16);
        capfactor = 1
        break;
}
    

//Add adjusted sound caps to sound cap map and list.
//*new sound effects must be added to this list, if in doubt use 1*capfactor.
managed_sounds = ds_map_create();
sound_caps = ds_map_create();
//Init sfx list and add each of the above sound effects.
//*new sound effects must be added here also.
audio_group_load(AG_SFX);

sfx_list = ds_list_create()

scr_add_sound_management_and_sfx_list(sd_collide_basic,5*capfactor) 
scr_add_sound_management_and_sfx_list(sd_collide_ballpower,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_collide_bomb,5*capfactor) //1
scr_add_sound_management_and_sfx_list(sd_collide_powerup,1*capfactor)   
scr_add_sound_management_and_sfx_list(sd_turn_begin,1*capfactor)  
scr_add_sound_management_and_sfx_list(sd_turn_end,1*capfactor)    
scr_add_sound_management_and_sfx_list(sd_difficulty_increases,1*capfactor)  
scr_add_sound_management_and_sfx_list(sd_screenshake,1*capfactor) 
scr_add_sound_management_and_sfx_list(sd_collide_with_paddle,1*capfactor)   
scr_add_sound_management_and_sfx_list(sd_catch_power_1up,1*capfactor)  
scr_add_sound_management_and_sfx_list(sd_catch_power_generic,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_catch_power_freeze,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_collide_trigger_powerup,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_catch_cash,16*capfactor) //This is high for the jackpot prizes
scr_add_sound_management_and_sfx_list(sd_not_enough_cash,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_resurrect,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_catch_power_good,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_catch_power_bad,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_catch_power_neutral,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_catch_power_boardclear,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_combo,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_menu_click,2*capfactor)
scr_add_sound_management_and_sfx_list(sd_gameover,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_menu_swoosh,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_menu_unswoosh,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_menu_wrongclick,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_gameover_unlock,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_cash_register,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_prize_wheel_flap,4*capfactor) 
scr_add_sound_management_and_sfx_list(sd_bad_prize,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_clock_tick,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_clock_tock,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_near_miss,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_resume_step_beep,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_resume_final_beep,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_tp_place,1*capfactor)
scr_add_sound_management_and_sfx_list(sd_coin_bag,1*capfactor)

                         
//Initialize music list
//these need not be added to the above lists.
//Looping and shuffling is handled automatically
music_list = ds_list_create() 
MUSIC_STATE = 0;
musicStopper = noone
musicEaser = noone;

audio_group_load(AG_MusicAll);
ds_list_add(music_list,sd_music_cheatcodes)//arcade
ds_list_add(music_list,sd_music_turbopenguin)//arcade
ds_list_add(music_list,sd_music_badpitched) //arcade
ds_list_add(music_list,sd_music_dancetoit) //time
ds_list_add(music_list,sd_music_sugarrush) //arcade


//Extra Music
if os_browser == browser_not_a_browser{
    
    audio_group_load(AG_MusicMobile); //NB: No Longer Needed
    
    ds_list_add(music_list,sd_music_ftwletsbefriends) //arcade
    ds_list_add(music_list,sd_music_badboy) //arcade
    ds_list_add(music_list,sd_music_newgame)//arcade
    ds_list_add(music_list,sd_music_hotpursuit) //MOVES_LEFT
    
    ds_list_add(music_list,sd_music_flight) //MOVES_LEFT
    ds_list_add(music_list,sd_music_atlantic) //time
    ds_list_add(music_list,sd_music_supernova) //MOVES_LEFT
    ds_list_add(music_list,sd_music_overworkmyhouse) //time
    
    ds_list_add(music_list,sd_music_topoftheworld) //time
    ds_list_add(music_list,sd_music_rocktronic) //MOVES_LEFT
    ds_list_add(music_list,sd_music_virtualriot)//
    ds_list_add(music_list,sd_music_eclipse) //arcade
    
    ds_list_add(music_list,sd_music_onlyforyou) //time
    ds_list_add(music_list,sd_music_trythis) //arcade
    ds_list_add(music_list,sd_music_coffins) //time
    ds_list_add(music_list,sd_music_whoiam) //time
    
    
    
    
    /*
    //We ordered this by preference to include in future updates
    ds_list_add(music_list,sd_music_reasons) //time
    ds_list_add(music_list,sd_music_ecstacy) //time
    ds_list_add(music_list,sd_music_timebomb) //time
    ds_list_add(music_list,sd_music_armorlock) //time
    ds_list_add(music_list,sd_music_swag) //time
    ds_list_add(music_list,sd_music_ecstacy) //time
    ds_list_add(music_list,sd_music_snakeeyes) //time
    ds_list_add(music_list,sd_music_disconnected) //arcade
    ds_list_add(music_list,sd_music_emergency) //arcade
    ds_list_add(music_list,sd_music_fainbreeze) //time
    ds_list_add(music_list,sd_music_labyrinth) //time
    ds_list_add(music_list,sd_music_errorcode) //MOVES_LEFT
    ds_list_add(music_list,sd_music_tothestars) //MOVES_LEFT
    ds_list_add(music_list,sd_music_throttle)//
    ds_list_add(music_list,sd_music_razorsharp) //time
    ds_list_add(music_list,sd_music_pressurecooker) //time
    
    
    ds_list_add(music_list,sd_music_followme) //time
    ds_list_add(music_list,sd_music_oneminute) //time
    
    ds_list_add(music_list,sd_music_thisisnottheend) //time //heavy vocals
    ds_list_add(music_list,sd_music_dropthatchild) //time
    
    ds_list_add(music_list,sd_music_selfdestruct) //MOVES_LEFT
    
    ds_list_add(music_list,sd_music_adventuretime)//MOVES_LEFT
    ds_list_add(music_list,sd_music_tillitsover)//
    ds_list_add(music_list,sd_music_backandforth)//
    ds_list_add(music_list,sd_music_sweet)//
    ds_list_add(music_list,sd_music_letsbefriends)//MOVES_LEFT
    
    
    */
}



//show_message('agmusic='+string(audio_group_load_progress(AG_Music))+
//'agmusicextra='+string(audio_group_load_progress(AG_MusicExtra)))

 
CURRENT_SONG = noone;
CURRENT_SONG_GAIN = 0;
CURRENT_SONG_TIME = 0;

#define scr_sounds_dealloc
///scr_sounds_dealloc()

ds_map_destroy(managed_sounds);
ds_map_destroy(sound_caps);

ds_list_destroy(sfx_list);
ds_list_destroy(music_list);