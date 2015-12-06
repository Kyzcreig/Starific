///scr_button_themeswitcher()


analytics_button_counter("themeSwitcher");

//Increment Cursor Position
CURSKIN = scr_inc_button_array_cursor(unlock_skins,unlock_skins_cursor);

//Save Skin Change
mColorsChanger = true;
ini_open("scores.ini")
    ini_write_real("settings", "CURSKIN", CURSKIN);
    //Mark theme as seen
    scr_button_update_indicator(scr_unlock_get_data(3,CURSKIN), 10)
ini_close()


//Color Easer
scr_color_easer(.5)


// Spawn Explainer Text for Button
scr_button_explain_spawn(3, CURSKIN);
