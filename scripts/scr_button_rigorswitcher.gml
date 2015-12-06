///scr_button_rigorswitcher()

analytics_button_counter("rigorSwitcher");


//Increment Cursor Position
var newVal = scr_inc_button_array_cursor(unlock_rigors,unlock_rigors_cursor);

//Save Skin Change
ini_open("scores.ini")
    ini_write_real("settings", "RIGOR", newVal);
    //Mark As Seen
    scr_button_update_indicator(scr_unlock_get_data(2,newVal), 12)
ini_close()

//Find button object
var buttonData = go_sp_buttons[| scr_go_is_button(12)];
//Change sprite
buttonData[@ 0] = asset_get_index("s_v_rigorswitcher_"+string(newVal));

// Spawn Explainer Text for Button
scr_button_explain_spawn(2, newVal);
