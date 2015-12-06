#define scr_starcash_power_caught
///scr_starcash_power_caught(value)
//-1 = randomize

var cash_value = argument0;

// If Cash Doubler Power
if POWER_cashx2[0] > 0{
    cash_value *= 2;
}


// Prevent Cash Counting During Tutorial
if !TUTORIAL_ENABLED {
    // Increment Cash Value
    STAR_CASH += cash_value
    scr_starcash_power_caught_helper(cash_value);
} else {
    cash_value = 0;
}



return cash_value;

//NB: //Maybe signal how much the randomize was for somehow?

#define scr_starcash_power_caught_helper
///scr_starcash_power_caught_helper(cash_value)

with (obj_control_game){
    starCashCaught += argument0;
    //Jiggle and flash color
    //gui_jiggle[2,0] = 1*room_speed //NB: Jiggle disabled for now
    cashTimer = 1*room_speed;
}