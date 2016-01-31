#define scr_button_noAds
///scr_button_noAds()

// Create Dilemma Buttons
var promptButtons = noone;
promptButtons[0] = Array(spr_button_basic, "themes", 0, 
                    power_type_color_index(4, 0), power_type_color_index(4, 1),
                    noone, noone, scr_options_goto,Array(obj_settings_themes, false)) 
promptButtons[1] = Array(spr_button_basic, "shop", 1, 
                    power_type_color_index(3, 0), power_type_color_index(3, 1),
                    noone, noone, scr_options_goto,Array(obj_settings_shop, false)) 
// Create Dilemma Prompt       
var promptText = "Aren't ads annoying?#Get rid of ads forever when you buy ANY theme or shop item!";
var prompt = scr_prompt_dilemma_create("no ads", "remove ads?", promptText, promptButtons);


// Schedule No-Ads Button Validation
ScheduleScript(id, false, 5, scr_refresh_noAds_button);

#define scr_options_goto
///scr_options_goto(params)

/* params = [ settings_controller, room_reset ] 


*/



//Spawn Quick Settings Room Changer
var quick_page = instance_create(x,y, obj_settings_quick_select)
with (quick_page) {
    var params = argument0;
    // Set to Shop Page
    quick_page_goto[0] = params[0];
    reset_room = params[1];
}

return quick_page;



#define scr_refresh_noAds_button
///scr_refresh_noAds_button()

// Get Button Data
var buttonIndex = scr_go_is_button(7);
var buttonData = go_sp_buttons[| buttonIndex]; 
// Update Button to indicate Used
if ADS_FORCED != 0 {
    // If they Didn't Buy Anything
    buttonData[@ 6] = 0; 
} else {
    // If They Bought Something
    buttonData[@ 3] = -3;//Removes Button
    buttonData[@ 6] = 0; 
}