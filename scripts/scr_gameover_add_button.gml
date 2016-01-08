#define scr_gameover_add_button
///scr_gameover_add_button( button_index)

ds_list_add(go_sp_buttons, scr_gameover_create_button(argument0));

#define scr_gameover_create_button
///scr_gameover_create_button(button_type)



/*

    newButtonData[0] = //sprite
    newButtonData[1] = //subtext
    newButtonData[2] = //function_id
    newButtonData[3] = //meta functionality (button state):
                        -4 flag for removal
                        -3 means transparent, non-functioning, and ease out
                        -2 means transparency and non-functioning
                        -1 means transparency
                        0 means normal
                        1 means flashing
*/


var newButtonData = noone;


// Starting X/y Coordinates for easing
newButtonData[2] = argument0; //function/button_id
newButtonData[3] = 0; //meta functionality
newButtonData[4] = GAME_MID_X; //x coordinate (for easing)
newButtonData[5] = GAME_Y+GAME_H*1.05; //y coordinate (for easing)
        //y coordinate is slightly larger to keep button off screen
newButtonData[6] = 0 //count indicator
newButtonData[7] = 0 //extra data

switch argument0 {



case 4:
    newButtonData[0] = s_v_facebook; //spr
    //newButtonData[1] = "earn#+"+CASH_STR; //subtext
    newButtonData[1] = "share#+"+CASH_STR; //subtext
break;

case 5:
    newButtonData[0] = s_v_twitter; //spr
    //newButtonData[1] = "earn#+"+CASH_STR; //subtext
    newButtonData[1] = "share#+"+CASH_STR; //subtext
break;

case 6:
    newButtonData[0] = s_v_rate; //spr
    //newButtonData[1] = "rate#+"+CASH_STR+CASH_STR+CASH_STR; //subtext
        //NB: Rewarding rating is against policy
    newButtonData[1] = "rate"; //subtext
break;

case 7:
    var bSpr;
    if ADVERTISING == 1 { bSpr  = s_v_noads }
    else { bSpr = s_v_deluxe }
    newButtonData[0] = bSpr; //spr
    newButtonData[1] = "get it"; //app"; //subtext

break;

// Mobile Share
case 8:
    newButtonData[0] = spr_share_send///s_v_share; //spr
    //newButtonData[1] = "earn#+"+CASH_STR; //subtext
    newButtonData[1] = "share#+"+CASH_STR; //subtext
break;

case 9:
    newButtonData[0] = s_v_app//s_v_get; //spr
    newButtonData[1] = "mobile"//"the#app"; //subtext
break;

case 10:     
    newButtonData[0] = s_v_themeswitcher; //spr
    newButtonData[1] = "new#theme"; //subtext
break;

//gridswitcher
case 11:    
    newButtonData[0] = asset_get_index("s_v_gridswitcher_"+string(GRID));
    newButtonData[1] = "new#grid"; //subtext
break;

//rigor switcher
case 12:
    newButtonData[0] = asset_get_index("s_v_rigorswitcher_"+string(RIGOR));
    newButtonData[1] = "new#rigor"; //subtext

break;

// Quest Reward Button
case 13:     
    newButtonData[0] = s_v_prize //spr
    newButtonData[1] = "new#reward"; //subtext
    // Add Notification Bubble
    newButtonData[6] = 1 //count indicator
break;

// Gift Reward Button
case 14:     
    newButtonData[0] = s_v_gift; //spr
    newButtonData[1] = "new#gift"; //subtext
    // Add Notification Bubble
    newButtonData[6] = 1 //count indicator
break;


// Prize wheel Button
case 15:     
    newButtonData[0] = s_v_wheel //spr
    newButtonData[1] = "win#prize"; //subtext
    // Add Notification Bubble
    newButtonData[6] = 1 //count indicator
break;

// Video Reward Button
case 16:     
    newButtonData[0] = s_v_video //spr
    newButtonData[1] = "earn#+"+CASH_STR+CASH_STR+CASH_STR; //subtext
    newButtonData[6] = 1 //count indicator
break;

// Quest Cancel Button
case 17:
    newButtonData[0] = s_v_cancel; //spr
    //newButtonData[1] = "earn#+"+CASH_STR; //subtext
    newButtonData[1] = "cancel#quest"; //subtext
break;


//mode switcher
case 18:
    newButtonData[0] = asset_get_index("s_v_modeswitcher_"+string(MODE));
    newButtonData[1] = "new#mode"; //subtext

break;


// Interstitial Reward Button
case 19:     
    newButtonData[0] = s_v_interstitial //spr
    newButtonData[1] = "earn#+"+CASH_STR; //subtext
    newButtonData[6] = 1 //count indicator
break;

// PLM Promote Reward Button
case 20:     
    newButtonData[0] = s_v_gift //spr
    newButtonData[1] = "new#games"//#+"+CASH_STR+CASH_STR+CASH_STR; //subtext
break;

// Everyplay Button
case 21:     
    var share_reward = sh_doShare;//scr_great_game_check();
    var subtext = scr_button_everyplay_set_text(share_reward);
    newButtonData[0] = spr_ep_prompt //spr
    newButtonData[1] = subtext//#+"+CASH_STR+CASH_STR+CASH_STR; //subtext
    newButtonData[3] = everyplay_is_recording(); //meta functionality 
    newButtonData[7] = share_reward; //extra data (share reward)
break;

}

return newButtonData;

#define scr_go_is_button
///scr_go_is_button(button_id)
var _len = ds_list_size(go_sp_buttons)
for (var b = 0; b < _len; b++) {
    var _button = go_sp_buttons[| b];
    if _button[2] == argument0{
        return b;
    }
}

return -1;
#define scr_go_replace_button
///scr_go_replace_button(old_id, new_id)
var oldID_Pos = scr_go_is_button(argument0);
var newID_Obj = scr_gameover_create_button(argument1);


ds_list_replace(go_sp_buttons, oldID_Pos, newID_Obj);
#define scr_go_queue_button
///scr_go_queue_button(data);

var data, type, dur, dur_index, buttonID, buttonArray, arrayCursor, inc_notif;
data = argument[0];
type = data[0];
dur = .2 * room_speed;




switch type {

// Grid
case 0:
    dur = 1*dur;
    //ind_to_val_func = convert_index_to_grid;
    buttonID = 11;
    buttonArray = unlock_grids;
    arrayCursor = unlock_grids_cursor;
    inc_notif = data[2] <= 0; 
        //NB: Only makes a difference when we're debugging with all unlocks
            // and we've played on a settings we unlocked

break; 

// Mode
case 1:
    dur = 2*dur;
    //ind_to_val_func = convert_index_to_grid;
    buttonID = 18;
    buttonArray = unlock_modes;
    arrayCursor = unlock_modes_cursor;
    inc_notif = data[2] <= 0; 
        //NB: Only makes a difference when we're debugging with all unlocks
            // and we've played on a settings we unlocked
    
    //exit; //Use this if we want to disable mode button on unlock...

break; 

//Rigor
case 2:
    dur = 3*dur;
    buttonID = 12;
    buttonArray = unlock_rigors;
    arrayCursor = unlock_rigors_cursor;
    inc_notif = data[2] <= 0; 
        //NB: Only makes a difference when we're debugging with all unlocks
            // and we've played on a settings we unlocked

break; 

// Theme
case 3:
    dur = 4*dur;
    //ind_to_val_func = convert_index_to_theme;
    buttonID = 10;
    buttonArray = unlock_skins;
    arrayCursor = unlock_skins_cursor;
    inc_notif = data[2] <= 0; 
        //NB: Only makes a difference when we're debugging with all unlocks
            // and we've played on a settings we unlocked

break; 

// Misc
case 4:

    exit;
break; 


case 5:
    exit;
break; 

}

// Add or Update Button With New Data
scr_go_queue_button_helper( data, buttonID, buttonArray, arrayCursor, dur, inc_notif)

#define scr_go_queue_button_helper
///scr_go_queue_button_helper(data, button_id, button_array, arrayCursor, duration, increment_notification)

var i = -1;
var data = argument[++i];
var buttonID = argument[++i];
var buttonArray = argument[++i];
var buttonArrayCursor = argument[++i];
var dur = argument[++i];
var inc_notif = argument[++i];


// Add unlock index to button's array list
var newArrayIndex = array_length_1d( buttonArray );// get last array pos
// If We're not Cheating with Unlock Everything Mode
if buttonArray[0] != data[7]{
    buttonArray[@ newArrayIndex] = data[7] //place unlock index in last pos
}

//check if button is already in list
if scr_go_is_button(buttonID) == -1{
    //add switcher button        
    scr_gameover_add_button(  buttonID);
    // set current index to one before new index
    buttonArrayCursor[@ 0] = newArrayIndex-1;
    // change current index to next one (new one)
    //go_selected[1] = false
    //ScheduleScript(id,false,dur,scr_delayed_selection,go_selected,buttonID)
    array_set_index_1d(delayed_button_calls, buttonID, dur) //delayed button press
    
}

//Increment Button Notification Count
if inc_notif {
    buttonIndex = scr_go_is_button(buttonID);
    buttonData = go_sp_buttons[| buttonIndex];
    buttonData[@ 6] += 1;
}
#define scr_go_button_get_data
///scr_go_button_get_data(id)


var buttonIndex = scr_go_is_button(argument0);
var buttonData = go_sp_buttons[| buttonIndex]; 


return buttonData;
#define scr_go_remove_button
///scr_go_remove_button(button_id)
var buttonPos = scr_go_is_button(argument0);

ds_list_delete(go_sp_buttons, buttonPos);