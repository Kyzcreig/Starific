#define scr_main_set_room_speed
///scr_main_set_room_speed()


RMSPD_DEFAULT = RMSPD_OPTIONS[RMSPD_OPT_INDEX]
RMSPD_DELTA = 60/RMSPD_DEFAULT;
//RMSPD_DELTA_INV = RMSPD_DEFAULT / 60;
room_speed = RMSPD_DEFAULT;
// Reset Expected Delta Time
DELTA_TIME_EXPECTED = 1000000/room_speed;



#define scr_main_reset_room_speed
///scr_main_reset_room_speed()

// If Toggle Was Switched and No Active Game
if RMSPD_DEFAULT != RMSPD_OPTIONS[RMSPD_OPT_INDEX] and !GAME_ACTIVE
{
    // Set Room Speed Params
    scr_main_set_room_speed()
    //Set Part Type Settings
    scr_part_types_set()

}


#define convert_index_to_room_speed
///convert_index_to_room_speed(toggle_index)

var index = argument0;

if index == 1 { 
    return 30
}
else if index == 0 {
    return 60
}

#define scr_main_toggle_room_speed
///scr_main_toggle_room_speed()


RMSPD_OPT_INDEX = (RMSPD_OPT_INDEX+1) mod array_length_1d(RMSPD_OPTIONS);

ini_open("savedata.ini");
    ini_write_real("settings", "RMSPD_OPT_INDEX", RMSPD_OPT_INDEX);
ini_close();