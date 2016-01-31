#define scr_subprompt_prize_init
///scr_subprompt_prize_init()

rect_x = 0
rect_y = 0;
rect_h = 0;
rect_w = 0;

prize_wheel_active = false;

enable_exit = true;
buttons_enabled = true;





// Default Data
prizeData = scr_prompt_prize_create_data(s_v_frown, 2, "try again!", "empty", 0, 0, 0, 0, "", noone);

#define scr_subprompt_prize_draw
///scr_subprompt_prize_draw()



// Prompt Head
scr_prompt_step_head_blank();

//Prompt Body
if dataLoaded {
    // Draw Prize Symbol
    prize_x = GAME_MID_X;
    prize_y = GAME_MID_Y - GAME_H*.05;
    prize_scale = subEase[3] //*2;
    prize_alpha = 1 //subEase[3]
    prize_col = COLORS[prizeData[1]]
    // Draw Flat Back Color
    draw_sprite_ext(s_v_solid_circle_x2, 0, prize_x, prize_y, 
    prize_scale, prize_scale, 0, COLORS[6], prize_alpha);
    // Draw Prize Symbol
    draw_sprite_ext(prizeData[0], 0, prize_x, prize_y, 
    prize_scale, prize_scale, 0, prize_col, prize_alpha);
    
    
    // Draw Winner or Try Again Text
    draw_set_valign(fa_middle)
    draw_set_halign(fa_center)
    draw_set_font(fnt_menu_bn_60_bold)
    top_text = prizeData[2]
    top_text_x = prize_x;
    top_text_y = prize_y - GAME_H * .25;
    top_text_scale = subEase[3];
    top_text_col = prize_col //COLORS[0];
    draw_text_outline_ext_transformed_color(top_text_x, top_text_y, top_text, -1, -1,
    top_text_scale, top_text_scale, 0, top_text_col,top_text_col,top_text_col,
    top_text_col,prize_alpha, 4, COLORS[6], 4);
    
    
    // Draw Prize Name
    if string_length(prizeData[3]) > 15 {
        draw_set_font(fnt_menu_bn_26_black);
    } else if string_length(prizeData[3]) > 6 {
        draw_set_font(fnt_menu_bn_40_bold);
    } else {
        draw_set_font(fnt_menu_bn_60_bold);
    }
    bottom_text_scale = subEase[3];
    bottom_text_h = string_height("H") * bottom_text_scale;
    bottom_text = prizeData[3];
    bottom_text_x = prize_x;
    bottom_text_y = prize_y + GAME_H * .25;
    bottom_text_col = prize_col //COLORS[0];
    draw_text_outline_ext_transformed_color(bottom_text_x, bottom_text_y,bottom_text, -1, -1,
    bottom_text_scale, bottom_text_scale, 0, bottom_text_col,bottom_text_col,bottom_text_col,
    bottom_text_col,prize_alpha, 4, COLORS[6], 4);
   
    // Draw Price Description
    if prizeData[8] != "" {
        draw_set_font(fnt_menu_bn_20_black)
        draw_set_valign(fa_top)
        desc_text = prizeData[8]; 
        desc_scale = subEase[3];
        desc_x = bottom_text_x
        desc_y = bottom_text_y + bottom_text_h*.75;
        desc_col = prize_col
        desc_alpha = prize_alpha
        
        // Draw Button Label
        draw_text_outline_ext_transformed_color(desc_x, desc_y, desc_text, -1, GAME_W*.80,
        desc_scale, desc_scale, 0, desc_col,desc_col,desc_col,desc_col, desc_alpha, 4, COLORS[6], 4);
    } 
    
    
    // If Button Data Valid
    if is_array(prizeData[9]) 
    {
        // Reset Enable Exit
        enable_exit = true;
        
        // Set Font
        draw_set_font(fnt_menu_bn_20_black);
        draw_set_valign(fa_middle)
        draw_set_halign(fa_center)
        // Get Button Matrix
        btn_matrix = prizeData[9];
        
        //Draw Buttons
        var n = array_length_1d(btn_matrix);
        btn_w_max = 180;
        btn_row_w = (GAME_W*14/32)*2 - btn_w_max; //NB: I don't use line_w so position is fixed and not easing
        btn_gap_w = max(btn_w_max * 1.2, 
                    min(btn_row_w / (max(1,n)) * (n-1), 
                        btn_row_w / (max(1,n-1))))
        btn_y_end = GAME_Y + GAME_H * .90;
        
        
        for (var i = 0; i < n; i++) 
        { 
            // Get Button Data
            btn_data = btn_matrix[i];
            btn_text = btn_data[0];
            btn_spr = btn_data[1];
            btn_id = btn_data[2];
        
            // Set Button Params
            btn_scale = subEase[3];
            btn_w = sprite_get_width(btn_spr) * btn_scale;
            btn_h = sprite_get_height(btn_spr) * btn_scale;
            btn_x = GAME_MID_X + btn_gap_w * (i-(n-1)/2);
            btn_y = btn_y_end
            btn_text_h = string_height(btn_text) * btn_scale;
            btn_text_x = btn_x;
            btn_text_y = btn_y - btn_text_h * .10;
            btn_col = prize_col; //COLORS[0];
            btn_text_col = COLORS[6];
            btn_alpha = prize_alpha;
            // Fade out disabled button
            if !buttons_enabled {
                btn_col = merge_colour(btn_col, COLORS[6], .5);
            }
            
            
            // Detect ShareButton Hovered
            btn_hover = point_in_rectangle(mouse_x, mouse_y, 
                        btn_x - btn_w/2, btn_y - btn_h/2, 
                        btn_x + btn_w/2, btn_y + btn_h/2)
            if btn_hover  {                    
                if !TweenExists(mainTween) {
                    // Colorize on Hover
                    if buttons_enabled {
                        btn_col = merge_colour(COLORS[6],btn_col,.5); 
                    }
                    //btn_scale *= 1.2; 
                    
                    
                    // If Pressed   
                    if mouse_check_button_pressed(mb_left) and buttons_enabled
                    {
                    
                        // Prevent Exit on Button Press
                        enable_exit = false;
                        mouse_clear(mb_left); // Clear to prevent this running during prompt screenshot
                        
                        // Share Button
                        if btn_id == 0 {
                            // Share Unlock
                            if (prizeData[5] == 2) or (prizeData[5] == 3) {
                                share_msg = "Just unlocked "+bottom_text+"!";
                            }
                            // Share Big Money 
                            else if prizeData[5] == 1 {
                                share_msg = "Jackpot "+bottom_text+"!";
                            }
                            //else { share_msg = extra param text}
                            
                            // Schedule Share
                            ScheduleScript(obj_control_main, false, 1, scr_share_mobile, true, false, share_msg);
                        } 
                        // Watch A Video
                        else if btn_id == 1 {
                            
                            // Create Dilemma Buttons
                            var promptButtons = noone;
                            promptButtons[0] = Array(spr_button_basic, "no", 0, 
                                                power_type_color_index(2, 0), power_type_color_index(2, 1),
                                                noone, noone, noone, noone) 
                            promptButtons[1] = Array(spr_button_basic, "yes", 1, 
                                                power_type_color_index(1, 0), power_type_color_index(1, 1),
                                                noone, noone,scr_subprompt_prize_button,
                                                    Array(id, btn_data, prizeData[6], true)) 
                            // Set Confirm Text
                            var promptText = "Would you like to watch a video to ";
                            promptText += btn_data[4];
                            
                                                
                            // Create Confirm Watch Ad Prompt
                            ScheduleScript(id, false, 2, scr_prompt_dilemma_create,
                                "confirm", "watch a video?",promptText,promptButtons)
                        
                            /*
                            // Execute Choice
                            ScheduleScript(id, false, 2, scr_subprompt_prize_button,
                                                Array(id, btn_data, prizeData[6], true));
                            */
                        
                        }
                        // Pay for Effect (50c)
                        else if btn_id == 2 {
                            // If Enough Cash
                            if STAR_CASH >= 50 {
                                // Take Cash
                                STAR_CASH -= 50;
                                // Save Cash
                                ini_open("scores.ini");
                                    ini_write_real("misc", "STAR_CASH", STAR_CASH);
                                ini_close();
                                
                                // Execute Choice
                                ScheduleScript(id, false, 2, scr_subprompt_prize_button,
                                                    Array(id, btn_data, prizeData[6], false));
                                
                            } else if IAP_ENABLED{
                                //Go to Shop Page
                                scr_options_goto(Array(obj_settings_shop, false));
                            } else {
                                // Not Enough Cash Sound/Jiggle
                                scr_sound(sd_not_enough_cash);
                            }
                        }
                    }
                }
            }
            
            //Draw Button
            draw_sprite_ext(btn_spr, 0, btn_x, btn_y, btn_scale, 
                            btn_scale, 0, btn_col, btn_alpha)
            
            // Draw Button Label
            draw_text_ext_transformed_colour(btn_text_x, btn_text_y, btn_text, -1, -1,
            btn_scale, btn_scale, 0, btn_text_col,btn_text_col,btn_text_col,
            btn_text_col, btn_alpha);
        
        }
    
    }
}


// Prompt Foot
scr_prompt_step_foot(enable_exit);


#define scr_confirm_prompt_create
///scr_confirm_prompt_create(title, header, text, script, params_array)

var promptTitle, promptHeader, promptText, deathScript, deathParams

// Create Dilemma Buttons
var promptButtons = noone;
promptButtons[0] = Array(spr_button_basic, "no", 0, 
                    power_type_color_index(2, 0), power_type_color_index(2, 1),
                    noone, noone, noone, noone) 
promptButtons[1] = Array(spr_button_basic, "yes", 1, 
                    power_type_color_index(1, 0), power_type_color_index(1, 1),
                    scr_quest_cancel, noone,noone,noone) 
// Create Dilemma Prompt       
var promptText = "Cancel current quest for "+CASH_STR+"25?  A new one will be selected next game.##" +
                 "You have "+CASH_STR+string(STAR_CASH)+".";
var prompt = scr_prompt_dilemma_create("confirm", "quest cancel", promptText, promptButtons);
        
        
var prompt = instance_create(x,y,obj_prompt_dilemma);
with (prompt) {
    var i = -1;
    title_txt = argument[++i];
    promptHeader = argument[++i];
    promptText = argument[++i];
    prompt_script = argument[++i]; //script to run on "yes"
    prompt_params = argument[++i]; // params_array or noone
}

return prompt;

#define scr_subprompt_prize_button
///scr_subprompt_prize_button(button_parameters)

var params = argument0;

with (params[0]) {
    // Get Data
    var params = argument0;
    var btn_data = params[1];
    var btn_type = btn_data[2];
    var btn_sub_type = btn_data[3];
    var reward_data = params[2];
    var watch_video = params[3];

    // Show Reward Video
    if ADS_REWARD_VIDEO_CACHED and watch_video {
        ads_show_reward_video(false);
    }
    
    // Disable Buttons
    buttons_enabled = false;
        
    //Declare Yay Prompt Params
    var yay_data, yay_sprite, yay_text, yay_name, 
        yay_col_index, yay_fanfare, yay_buttons;
    
    // If Respin Prompt
    if btn_sub_type == 0 {
        // Refund StarCash
        STAR_CASH += 100;
        // Save Cash
        ini_open("scores.ini");
            ini_write_real("misc", "STAR_CASH", STAR_CASH);
        ini_close();  
        
        // Create Yay Prompt
        yay_sprite = s_v_smile_x2;
        yay_text = "redo!";
        yay_name = "spin refunded";
        yay_col_index = 4;
        yay_fanfare = 2;
        yay_buttons = noone;
        //Make Yay Prompt Data
        yay_data = scr_prompt_prize_create_data(yay_sprite,yay_col_index, yay_text, yay_name, 
                        yay_fanfare, 6, reward_data, 0, "", yay_buttons);
    }
    // If Double It Prompt
    else if btn_sub_type == 1 {
    
        // Increment Count
        reward_data[@ 8] += 1; //just add one rather than *2, since that could stack
                
        // Get Mod Key
        var mod_key = scr_gamemod_get_key(reward_data[0]);
        // Save Mod Data
        ini_open("scores.ini");
            ini_write_real("GAMEMOD_DATA", mod_key+"-count", reward_data[8]);
            ini_write_real("GAMEMOD_DATA", mod_key+"-timer", reward_data[9]);
        ini_close();
        
        
        // Create Yay Prompt
        yay_sprite = s_v_double_x2;
        yay_text = "doubled!!!";
        yay_name = string_replace_all(reward_data[0], "_", " ")+" buff";
        yay_col_index = 1;
        yay_fanfare = 2;
        yay_buttons = noone;
        //Make Yay Prompt Data
        yay_data = scr_prompt_prize_create_data(yay_sprite,yay_col_index, yay_text, yay_name, 
                        yay_fanfare, 6, reward_data, 0, "", yay_buttons);
    }
    // If Remove It Prompt
    else if btn_sub_type == 2 {
        // Clear Count
        reward_data[@ 8] = 0;
        // Clear Time
        reward_data[@ 9] = 0;
    
        // Get Mod Key
        var mod_key = scr_gamemod_get_key(reward_data[0]);
        // Save Mod Data
        ini_open("scores.ini");
            ini_write_real("GAMEMOD_DATA", mod_key+"-count", reward_data[8]);
            ini_write_real("GAMEMOD_DATA", mod_key+"-timer", reward_data[9]);
        ini_close();
        
        
        
        // Create Yay Prompt
        yay_sprite = s_v_smile_x2;
        yay_text = "removed!";
        yay_name = string_replace_all(reward_data[0], "_", " ")+" debuff";
        yay_col_index = 2;
        yay_fanfare = 2;
        yay_buttons = noone;
        //Make Yay Prompt Data
        yay_data = scr_prompt_prize_create_data(yay_sprite,yay_col_index, yay_text, yay_name, 
                        yay_fanfare, 6, reward_data, 0, "", yay_buttons);
    
    }
    
        
    // Create Success Prompt
    ScheduleScript(id, true, .1, scr_prompt_prize_spawn, yay_data);
    
    //Schedule Exit
    ScheduleScript(id, true, .2, scr_prompt_exit);
    
   
}
