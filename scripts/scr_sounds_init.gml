#define scr_sounds_init
///scr_sounds_init
//This script is called in the obj_control_game Game Start event.
//It initializes all the sound caps and the lists of sounds which are used
//to manipulate volume among other things.

//Initialize global variables
globalvar sfx_sound, music_sound, sfx_list, MUSIC_INDEXES;
globalvar 
    MANAGED_SOUNDS,MANAGED_SOUND_CAPS, NEXT_SONG_INDEX,
    CURRENT_SONG, CURRENT_SONG_GAIN, CURRENT_SONG_STREAM,
    CURRENT_SONG_INDEX;
globalvar MUSIC_STATE,MUSIC_SCHEDULE, MUSIC_TWEEN, 
    MUSIC_ACTIVE, MUSIC_DATA, MUSIC_DLC;

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
MANAGED_SOUNDS = ds_map_create();
MANAGED_SOUND_CAPS = ds_map_create();
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
scr_add_sound_management_and_sfx_list(sd_woosh,1*capfactor)
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
//music_list = ds_list_create() 
MUSIC_STATE = 0;
MUSIC_SCHEDULE = noone
MUSIC_TWEEN = noone;
MUSIC_DATA = noone;
MUSIC_INDEXES = ds_list_create();
MUSIC_DLC = noone;
 
NEXT_SONG_INDEX = noone;

CURRENT_SONG = noone;
CURRENT_SONG_GAIN = 0;
CURRENT_SONG_INDEX = noone;
CURRENT_SONG_STREAM = noone;



if CONFIG == CONFIG_TYPE.HTML {
    // Load Music Data
    audio_group_load(AG_MusicHTML);
    scr_music_data_init(true); 
             
    // Add Available Music to Music Index List
    for (var i = 0, n = array_length_1d(MUSIC_DATA); i < n; i++){
        ds_list_add(MUSIC_INDEXES, i);
    }

}
else {      
    // Load Music Data
    scr_music_data_init(false);    
                             
    // Add Available Music to Music Index List
    for (var i = 0, n = array_length_1d(MUSIC_DATA); i < n; i++){
        var fname = "Music/track"+string(i)+".ogg";
        // If Songfile Exists
        if file_exists(fname) {
            // Add Index
            ds_list_add(MUSIC_INDEXES, i);
            show_debug_message("Loaded Song: "+fname);
        }
    }
}
// Select Next Song Index
scr_music_select_next();



#define scr_music_step
///scr_music_step()



//Enable music on star launch or mixer select
if (MUSIC_STATE == 0 or MUSIC_STATE == 2) and MUSIC_ACTIVE and
    room == rm_game and !TUTORIAL_ENABLED and !GAMEOVER
{
    scr_ResumeMusic(3*room_speed);
}
//Music State == Playing
else if MUSIC_STATE == 1  
{
    if (!audio_exists(CURRENT_SONG) or 
       !audio_is_playing(CURRENT_SONG) or
       ScheduleExists(MUSIC_SCHEDULE)) and
       !GAME_PAUSE  //game not paused
    {
        // If Music Scheduled to Stop
        if ScheduleExists(MUSIC_SCHEDULE) {
            // Immediately stop music
            ScheduleFinish(MUSIC_SCHEDULE)
        }
        
        // Case HTML
        if (CONFIG == CONFIG_TYPE.HTML and 
            audio_group_is_loaded(AG_MusicHTML))
        {
            
            // Get Next Song Data
            var _md = MUSIC_DATA[NEXT_SONG_INDEX];
            var next_song = _md[4];
            // Set Gain and Play Song
            CURRENT_SONG = scr_sound(next_song, 100);
            CURRENT_SONG_GAIN = 1;
            
            // Select Next Music Index
            NEXT_SONG_INDEX = scr_music_select_next();
        
        }
        // Case Other
        else {
            // Check if Next Song is Available
            if !scr_music_file_exists(NEXT_SONG_INDEX) {
                // If Not, Select Next Song From Available Indexes
                var pos = irandom(ds_list_size(MUSIC_INDEXES)-1);
                NEXT_SONG_INDEX = MUSIC_INDEXES[| pos];
            }
            
            // Destroy Previous Song Stream
            if CURRENT_SONG_STREAM != noone {
                audio_destroy_stream(CURRENT_SONG_STREAM);
                CURRENT_SONG_STREAM = noone;
            }
            
            // Get Next Song FName
            var fname = "Music/track"+string(NEXT_SONG_INDEX)+".ogg";
            // Create Song Stream
            CURRENT_SONG_STREAM = audio_create_stream(fname);
            
            // Set Gain and Play Song
            CURRENT_SONG = scr_sound(CURRENT_SONG_STREAM, 100);
            CURRENT_SONG_GAIN = 1;
            
            // Select Next Music Index
            NEXT_SONG_INDEX = scr_music_select_next();
        }
    }
}


#define scr_music_select_next
///scr_music_select_next()


// Cache Previous Index
CURRENT_SONG_INDEX = NEXT_SONG_INDEX;

// Select Next Song Index
NEXT_SONG_INDEX = irandom(array_length_1d(MUSIC_DATA)-1);

// If Song File Does Not Exist
if !scr_music_file_exists(NEXT_SONG_INDEX) {
    var _md, dlc_url, dlc_fname;
    // Get Music Data
    _md = MUSIC_DATA[NEXT_SONG_INDEX];
    
    // Download Song
    dlc_url = "http://starificgame.com/music/"+_md[0];
    dlc_fname = "Music/track"+string(NEXT_SONG_INDEX)+".ogg";
    MUSIC_DLC = http_get_file(dlc_url, dlc_fname);
    
    show_debug_message("selected music index: "+string(NEXT_SONG_INDEX));
}


return NEXT_SONG_INDEX;

#define scr_music_dlc
///scr_music_dlc()



if ds_map_find_value(async_load, "id") == MUSIC_DLC {
    var status, http_status, dlc_path, dlc_prog, dlc_size;
    
    // Get Status
    status = ds_map_find_value(async_load, "status");
    
    // Error Handling
    if status < 0 {
        http_status = ds_map_find_value(async_load, "http_status");
        show_debug_message("error: "+string(http_status));
    }
    // Update Progress
    if status == 1 and false { //DISABLED
        dlc_size = ds_map_find_value(async_load, "contentLength");
        dlc_prog = ds_map_find_value(async_load, "sizeDownloaded");
        show_debug_message("dlc_size: "+string(dlc_size));
        show_debug_message("dlc_prog: "+string(dlc_prog));
    }
    // Download Complete
    if status == 0 
    {         
        // This Path is Useless on Android
        dlc_path = ds_map_find_value(async_load, "result");
        show_debug_message("DLC Path: "+dlc_path);
        
        // Get Music Index
        var ogg_pos = string_pos(".ogg",dlc_path);
        var music_index = real(string_digits(string_copy(
                                dlc_path,ogg_pos - 5, 5)));
        // Add the music index to the music index list
        ds_list_add(MUSIC_INDEXES, music_index);
        
        show_debug_message("added music index: "+string(music_index));
        
    }
}



#define scr_music_data_init
///scr_music_data_init(is_HTML)

if argument0 {
    // Set Music Data
    var i = -1;
    // URL, SongName, ChanceWeight(unused), Available, SoundAsset(if extant)
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Nitro_Fun_Cheat_Codes.ogg",
                        "Nitro Fun - Cheat Codes",
                        1, true, sd_music_cheatcodes);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Sound_Remedy_and_Nitro_Fun_Turbo_Penguin.ogg",
                        "Sound Remedy & Nitro Fun - Turbo Penguin",
                        1, true, sd_music_turbopenguin);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Insan3Lik3_Bad_Pitched_Original_Mix_.ogg",
                        "Insan3Lik3 - Bad Pitched",
                        1, true, sd_music_badpitched);
    MUSIC_DATA[++i] = scr_create_array(
                        "110BPM_Tut_Tut_Child_Dance_To_It.ogg",
                        "Tut Tut Child - Dance To It",
                        1, true, sd_music_dancetoit);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_PIXL_Sugar_Rush.ogg",
                        "PIXL - Sugar Rush",
                        1, true, sd_music_sugarrush);
} else {
    
    // Set Music Data
    var i = -1;
    // URL, SongName, ChanceWeight(unused), Available, SoundAsset(if extant)
    MUSIC_DATA[++i] = scr_create_array(
                        "110BPM_Haywyre_Back_and_Forth.ogg",
                        "Haywyre - Back and Forth",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "110BPM_Pegboard_Nerds_and_Tristam_Razor_Sharp.ogg",
                        "Pegboard Nerds and Tristam - Razor Sharp",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "110BPM_Razihel_Bad_Boy.ogg",
                        "Razihel - Bad Boy",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "110BPM_Tut_Tut_Child_Dance_To_It.ogg",
                        "Tut Tut Child - Dance To It",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Alex_Ferro_Armor_Lock_Nitro_Fun_Remix_Audiophile_Live.ogg",
                        "Alex Ferro - Armor Lock (Nitro Fun Remix)",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "DnB_Feint_Boyinaband_feat_Veela_Time_Bomb.ogg",
                        "Feint & Boyinaband feat. Veela - Time Bomb",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "DnB_Feint_Snake_Eyes_feat_CoMa.ogg",
                        "Feint feat. CoMa - Snake Eyes ",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Drumstep_Braken_To_The_Stars.ogg",
                        "Braken - To The Stars",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Drumstep_Krewella_One_Minute.ogg",
                        "Krewella - One Minute (DotEXE Remix)",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Drumstep_Pegboard_Nerds_Pressure_Cooker.ogg",
                        "Pegboard Nerds - Pressure Cooker",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Drumstep_Pegboard_Nerds_Try_This.ogg",
                        "Pegboard Nerds - Try This",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Drumstep_Tristam_and_Braken_Flight.ogg",
                        "Tristam and Braken - Flight",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Dubstep_Droptek_and_Tut_Tut_Child_Drop_That_Child.ogg",
                        "Droptek and Tut Tut Child - Drop That Child",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Dubstep_Krewella_and_Pegboard_Nerds_This_Is_Not_The_End.ogg",
                        "Krewella And Pegboard Nerds - This Is Not The End",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Dubstep_Tristam_Follow_Me.ogg",
                        "Tristam - Follow Me",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Case_and_Point_Error_Code.ogg",
                        "Case And Point - Error Code",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Insan3Lik3_Bad_Pitched_Original_Mix_.ogg",
                        "Insan3Lik3 - Bad Pitched",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_I_Y_F_F_E_Au5_and_Auratic_Sweet.ogg",
                        "I.Y.F.F.E, Au5 & Auratic - Sweet",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Laszlo_Supernova.ogg",
                        "Laszlo - Supernova",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Lets_Be_Friends_FTW.ogg",
                        "Lets Be Friends - FTW",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Nitro_Fun_Cheat_Codes.ogg",
                        "Nitro Fun - Cheat Codes",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Nitro_Fun_New_Game.ogg",
                        "Nitro Fun - New Game",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Nitro_Fun_Rob_Gasser_Ecstasy.ogg",
                        "Nitro Fun & Rob Gasser - Ecstasy",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Noisestorm_Eclipse.ogg",
                        "Noisestorm - Eclipse",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_OVERWERK_House_feat_Nick_Nikon_.ogg",
                        "OVERWERK - House (feat. Nick Nikon)",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Pegboard_Nerds_Disconnected.ogg",
                        "Pegboard Nerds - Disconnected",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Pegboard_Nerds_Emergency.ogg",
                        "Pegboard Nerds - Emergency",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Pegboard_Nerds_Rocktronik.ogg",
                        "Pegboard Nerds - Rocktronik",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_PIXL_Sugar_Rush.ogg",
                        "PIXL - Sugar Rush",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Rogue_Adventure_Time.ogg",
                        "Rogue - Adventure Time",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Rogue_Atlantic.ogg",
                        "Rogue - Atlantic",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Sound_Remedy_and_Nitro_Fun_Turbo_Penguin.ogg",
                        "Sound Remedy & Nitro Fun - Turbo Penguin",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Stephen_Walking_Top_of_the_World.ogg",
                        "Stephen Walking - Top of the World",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Electro_Tut_Tut_Child_Hot_Pursuit.ogg",
                        "Tut Tut Child - Hot Pursuit",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Glitch_Hop_110BPM_Pegboard_Nerds_FrainBreeze.ogg",
                        "Pegboard Nerds - FrainBreeze",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Glitch_Hop_or_110BPM_Lets_Be_Friends_Manslaughter.ogg",
                        "Lets Be Friends - Manslaughter",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Glitch_Hop_or_110BPM_Tristam_Till_It's_Over.ogg",
                        "Tristam - Till It's Over",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Mat_Zo_feat_Rachel_K_Collier_Only_For_You_Maor_Levi_Remix.ogg",
                        "Mat Zo feat. Rachel K Collier - Only For You",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Nitro_Fun_SWAG_Original_Mix_Audiophile_Live.ogg",
                        "Nitro Fun - \#SWAG",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Nitro_Fun_Who_I_Am_Original_Mix.ogg",
                        "Nitro Fun – Who I Am",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Progressive_House_Project_46_Reasons_feat_Andrew_Allen.ogg",
                        "Project 46 - Reasons (feat. Andrew Allen)");
    MUSIC_DATA[++i] = scr_create_array(
                        "Reaktion_Labyrinth_Nitro_Fun_Remix.ogg",
                        "Reaktion - Labyrinth",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Throttle_Inspire.ogg",
                        "Throttle - Inspire",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Trap_Pegboard_Nerds_x_MisterWives_Coffins.ogg",
                        "Pegboard Nerds and Misterwives - Coffins",
                        1, true);
    MUSIC_DATA[++i] = scr_create_array(
                        "Virtual_Riot_Energy_Drink_DUBSTEP.ogg",
                        "Virtual Riot - Energy Drink",
                        1, true);  
}










#define scr_sounds_dealloc
///scr_sounds_dealloc()

ds_map_destroy(MANAGED_SOUNDS);
ds_map_destroy(MANAGED_SOUND_CAPS);

ds_list_destroy(sfx_list);
//ds_list_destroy(music_list);

ds_list_destroy(MUSIC_INDEXES);
//ds_map_destroy(MUSIC_DATA);

#define scr_music_file_exists
///scr_music_file_exists(music_index)

return ds_list_find_index(MUSIC_INDEXES,argument0) != -1