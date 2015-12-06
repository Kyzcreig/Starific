///scr_button_gridswitcher()

analytics_button_counter("gridSwitcher");

//Increment Cursor Position
var newVal = scr_inc_button_array_cursor(unlock_grids,unlock_grids_cursor);
//newVal = convert_index_to_grid(newVal); // special case converts 0-1-2-3 index to gridsize which we inconveniently use

//Save Skin Change
ini_open("scores.ini")
    ini_write_real("settings", "GRID", newVal);
    //Mark As Seen
    scr_button_update_indicator(scr_unlock_get_data(0,newVal), 11)
ini_close()

//Find button object
var buttonData = go_sp_buttons[| scr_go_is_button(11)];
//Change sprite
buttonData[@ 0] = asset_get_index("s_v_gridswitcher_"+string(newVal));

// Spawn Explainer Text for Button
scr_button_explain_spawn(0, newVal);
