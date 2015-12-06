///scr_button_modeswitcher()

analytics_button_counter("modeSwitcher");

//Increment Cursor Position
var newVal = scr_inc_button_array_cursor(unlock_modes,unlock_modes_cursor);

//Save Skin Change
ini_open("scores.ini")
    ini_write_real("settings", "MODE", newVal); 
        //NB: we don't really use this saved value for anything, since we select mode via main menu
        //But I like the consistency between my functions...
    //Mark As Seen
    scr_button_update_indicator(scr_unlock_get_data(1,newVal), 18)
ini_close()

//Find button object
var buttonData = go_sp_buttons[| scr_go_is_button(18)];
//Change sprite
buttonData[@ 0] = asset_get_index("s_v_modeswitcher_"+string(newVal));


// Spawn Explainer Text for Button
scr_button_explain_spawn(1, newVal);
