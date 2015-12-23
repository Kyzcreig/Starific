#define scr_prompt_everyplay_init
///scr_prompt_everyplay_init()

enable_share_reward = false;
parent_button_data = 0;
ScheduleScript(id, false, 2, scr_prompt_everyplay_init_helper)

#define scr_prompt_everyplay_init_helper
///scr_prompt_everyplay_init_helper()


title_txt = "everyplay";


rect_h = round(.60 * GAME_H);//.50


//Toggle Arra
ep_toggle_array[0] = scr_create_array(spr_ep_start, spr_ep_break);
ep_toggle_array[1] = scr_create_array("start#record", "stop#record");

// Get is Recording
ep_recording = everyplay_is_recording();//
// Get Share Reward
ep_share_reward = enable_share_reward;
if ep_share_reward {
    ep_share_txt = "share#+"+CASH_STR;
} else {
    ep_share_txt = "share";
} 

//Sprite Button Arrays
                                   //sprite,    text,   id, sub_index,  flashing,  reward
prompt_button[0] = scr_create_array(ep_toggle_array[0], 
                                    ep_toggle_array[1], 0, ep_recording,
                                    ep_recording, false)//power_type_color_index(1,0), power_type_color_index(1,1)); 
prompt_button[1] = scr_create_array(spr_ep_playback,
                                    "watch#replay", 1, 0,
                                    false, false)//power_type_color_index(2,0), power_type_color_index(2,1)); 
prompt_button[2] = scr_create_array(spr_share_send,
                                    ep_share_txt, 2, 0,
                                    false, ep_share_reward)//power_type_color_index(3,0), power_type_color_index(3,1)); 
prompt_button[3] = scr_create_array(spr_ep_everyplay,
                                    "everyplay#videos", 3, 0, 
                                    false, false)//power_type_color_index(4,0), power_type_color_index(4,1)); 



/*
prompt_jiggletime = 1.0*room_speed;
for ( i = 0; i < array_length_1d(prompt_button); i++ ){
    for (j=0;j<3;j++){
        prompt_jiggle[i,j] = 0;
    }
}




#define scr_prompt_everyplay_step
///scr_prompt_everyplay_step()



// Prompt Body

//Draw Sprite Buttons
var n = array_length_1d(prompt_button);
var sp_scale_start = 1*subEase[2];//3 / (n+1) 
var sp_width = sprite_get_width(spr_ep_everyplay) * sp_scale_start;
var sp_height = sprite_get_height(spr_ep_everyplay) * sp_scale_start;
var sp_size = sp_width;
var row_size = 2;
var sp_upscale = 1.2;
var sp_gap_x = (line_w*1.6 - sp_size*sp_upscale) * .5;
var sp_gap_y = sp_size*sp_upscale;//(rect_h - (line_y+4 - rect_y))/2 
var sp_start_y = (line_y+4 + sp_size*sp_upscale);//*.75); /// 2 - sp_gap*.5//1.5//+ line_y - sp_gap;
for(var i = 0; i < n; i++)
{

    // Button Data
    data = prompt_button[i];
    
    // Data
    sp_id = data[2];
    
    // Get Sprite
    sp_spr = data[0];
    if is_array(sp_spr) {
        sp_spr = sp_spr[data[3]];
    } 
    // Get Text
    sp_text = data[1];
    if is_array(sp_text) {
        sp_text = sp_text[data[3]];
    } 
    
    //Get Coordinates
    col_index = (i mod row_size) * 2 - 1; //starts left of center (-1)
    row_index = (i div row_size) * 2;
    sp_x = GAME_MID_X + sp_gap_x * col_index ;
    sp_y = sp_start_y + sp_gap_y * row_index; //* .8
    
    // Sprite Styling
    sp_col = COLORS[0];
    // Set Alpha
    if data[4] == 0 {
        // Normal
        sp_alpha = 1;
    }
    else if data[4] == 1{
        // Flashing
        sp_alpha = lerp(.2,.8,FULL_SECOND_SINE);//FULL_SECOND_LERP);
    } else if data[4] < 0{
        // Dim
        sp_alpha = .6;
    }
    
    // Scale and Hover
    sp_scale =  sp_scale_start;
    sp_hover = point_in_rectangle(mouse_x,mouse_y,sp_x-sp_width/2,sp_y-sp_height/2,
                          sp_x+sp_width/2,sp_y+sp_height/2) 
    //Check if mouse over icon
    if sp_hover and (!touchPad or mouse_check_button(mb_left)) 
                          and !TweenExists(mainTween) 
    {
        //Disable increase scale when hovered/clicked
        sp_scale *= sp_upscale;
        //On Button Press
        if mouse_check_button_pressed(mb_left) and !ScheduleExists(mainSchedule)
        {
            
            // Execute Everyplay Function
            mainSchedule = ScheduleScript(id, false, 1, scr_everyplay_execute, sp_id, data);
            
            // If Reward 
            if data[5] {
                // Toggle Off Reward
                data[@ 5] = false;
                
                // Calculate Reward 
                rewardValue = scr_reward_set(.5, false);
                
                // Change Share Text and Spawn Cash Reward Prompt
                ScheduleScript(id, false, 2, scr_prompt_everyplay_reward_helper, data, rewardValue);
                
            }
            
            //Click Sound 
            scr_sound(sd_menu_click,1,false)
        }
       
    }
    
    //Draw Button Sprite 
    draw_sprite_ext(sp_spr, 0,sp_x,sp_y,sp_scale,sp_scale,0,sp_col,sp_alpha) 
    
    
    //Draw Button Text
    draw_set_valign(fa_top);
    //draw_set_font(fnt_gui_options7);
    draw_set_font(fnt_gui_options9);
    draw_text_ext_transformed_colour(sp_x, sp_y + sp_size/2 * sp_scale + 12,
                                sp_text, -1, -1, sp_scale, sp_scale, 0,
                                sp_col, sp_col, sp_col, sp_col, 1);     

}

/*

//Decrement GUI jigglers
var jiggle_strength = 4;
for (var i=0, n=array_length_1d(prompt_jiggle); i < n; i++){
    if prompt_jiggle[i,0] > 0{
        prompt_jiggle[i,0] -= 1
        prompt_jiggle[i,1] = random_range(-1,1)*jiggle_strength;
        prompt_jiggle[i,2] = random_range(-1,1)*jiggle_strength;
    }
    else if prompt_jiggle[i,0] >= -1{
        prompt_jiggle[i,0] = -2
        prompt_jiggle[i,1] = 0;
        prompt_jiggle[i,2] = 0;
    
    }
}



#define scr_prompt_everyplay_reward_helper
///scr_prompt_everyplay_reward_helper(button_data, rewardValue)

var data = argument0;
var rewardValue = argument1;

// Change Share Text to indicate Earnings
data[@ 1] = "earned#+"+CASH_STR+string(rewardValue);


// Create Cash Prompt
scr_prompt_cash_create(rewardValue);



// Mark Parent Button as Rewarded/Shared
if is_array(parent_button_data) {
    // Change Text to Plain - no +CASH_STR
    parent_button_data[@ 1] = scr_button_everyplay_set_text(false);
    // Toggle Reward Flag
    parent_button_data[@ 7] = false;
}

#define scr_everyplay_execute
///scr_everyplay_execute(button_id, button_data)

var button_id = argument[0];
//var button_data = argument1;

switch button_id {
    
    // Toggle Recording
    case 0:
        
        // Set Recording
        if everyplay_is_recording() { 
            // Set Meta Data and Stop Recording
            scr_everyplay_stop_recording();
        } else {
            everyplay_start_recording();
        }
        
    
    break;
    
    // Play Last Recording
    case 1:
        
        if everyplay_is_recording() {
            scr_everyplay_stop_recording();
        } 
        
        everyplay_play_last_recording();
        
        
    
    break;
    // Share Modal (and reward)
    case 2:
    
        if everyplay_is_recording() {
            scr_everyplay_stop_recording();
        } 
        
        everyplay_show_share_modal();
    
    break;
    
    // Everyplay Modal
    case 3:
        
        everyplay_show_everyplay();
    
    break;

}

// Set Recording State
ScheduleScript(id, true, .20, scr_prompt_everyplay_update_record_button, prompt_button[0]);
/* .20 second delay needed for everyplay_is_recording to change state

*/

#define scr_everyplay_stop_recording
///scr_everyplay_stop_recording()


// Set Meta Data
everyplay_set_metadata("game","Starific");
everyplay_set_metadata("score",string(score_p1));
everyplay_set_metadata("mode",convert_index_to_mode_name(MODE));
everyplay_set_metadata("grid",convert_index_to_grid_name(GRID));
everyplay_set_metadata("rigor",convert_index_to_rigor_name(RIGOR));

// Stop Recording
everyplay_stop_recording();

#define scr_button_everyplay_set_text
///scr_button_everyplay_set_text(give_reward)


var subtext = "video"//"everyplay"; //ep //replay //record
if argument0  {
    subtext += "#+"+CASH_STR;
}

return subtext;

#define scr_prompt_everyplay_update_record_button
///scr_prompt_everyplay_update_record_button(record_button_data)


// Get Record Button Data
var button_data = argument0;

// Reset Subindex
button_data[@ 3] = everyplay_is_recording();
//show_message("EP_is_recording="+string(everyplay_is_recording())) 
// Reset Flashing
button_data[@ 4] = button_data[3];