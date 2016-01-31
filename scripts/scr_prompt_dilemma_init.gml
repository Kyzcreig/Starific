#define scr_prompt_dilemma_init
///scr_prompt_dilemma_init()

title_txt = "";
promptHeader = "";//main header
promptText = ""; 
rect_h = round(.50 * GAME_H);//.55

//Sprite Button Arrays
prompt_buttons = noone;
prompt_choice = noone;

//prompt_script = noone;
//prompt_params = noone;
prompt_jiggletime = 1.0*room_speed
if is_array(prompt_buttons) {
    for ( i = 0; i < array_length_1d(prompt_buttons); i++ ){
        for (j=0;j<3;j++){
            prompt_jiggle[i,j] = 0;
        }
    }
}




#define scr_prompt_dilemma_step
///scr_prompt_dilemma_step()



// Prompt Body
draw_set_halign(fa_left);
//draw_set_halign(fa_middle);
draw_set_font(fnt_menu_bn_40_bold);
// Set Header Text
promptHeaderX = GAME_MID_X-line_w//GAME_X + 40;
promptHeaderY = line_y + 60 + 175*0;
promptHeaderH = string_height(promptHeader);
draw_text_color(promptHeaderX, promptHeaderY, promptHeader, 
COLORS[0], COLORS[0],COLORS[0],COLORS[0],subEase[1]);

// Draw Paragraph Text
draw_set_halign(fa_left);
draw_set_font(fnt_menu_calibri_22_bold); 
promptTextX = promptHeaderX+8;
promptTextW = line_w*1.9;
promptTextH = string_height_ext(promptText,-1,promptTextW);
promptTextY = promptHeaderY + promptHeaderH/2 *1.2 +promptTextH/2;
draw_text_ext_colour(promptTextX, promptTextY,promptText, 
-1, promptTextW, COLORS[0], COLORS[0],COLORS[0],COLORS[0],subEase[3]);




//Draw Sprite Buttons
if is_array(prompt_buttons) {
    var n = array_length_1d(prompt_buttons);
    var btn_scale_start = 3 / (n+1) 
    var btn_width = sprite_get_width(spr_button_basic) * btn_scale_start;
    var btn_height = sprite_get_height(spr_button_basic) * btn_scale_start;
    var btn_size = btn_width;
    var btn_gap_whole = line_w*1.9 - btn_size;
    var btn_gap = btn_gap_whole / ( max(1,n-1) );
    for(var i = 0; i < n; i++)
    {
    
        // Button Data
        btn_data = prompt_buttons[i];
        
        btn_spr = btn_data[0];
        btn_text = btn_data[1];
        btn_index = btn_data[2];
        
        //Sprite Coordinates
        btn_x = GAME_MID_X + btn_gap * (i - (n-1)/2) 
        btn_y = promptTextY +promptTextH/2 + btn_height/btn_scale_start * 1.5//1;
        btn_x += prompt_jiggle[btn_index,1];
        btn_y += prompt_jiggle[btn_index,2];
        
        btn_alpha = subEase[3];
        btn_col_index = btn_data[3];
        btn_col = COLORS[btn_col_index];
    
        btn_scalar =  1;
        btn_hover = point_in_rectangle(mouse_x,mouse_y,
                        btn_x-btn_width/2,btn_y-btn_height/2,
                        btn_x+btn_width/2,btn_y+btn_height/2) 
        //Check if mouse over icon
        if btn_hover and (!touchPad or mouse_check_button(mb_left)) and !TweenExists(mainTween) 
        {
            //Disable increase scale when hovered/clicked
            btn_scalar *= 1.2;
            //On Button Press
            if mouse_check_button_pressed(mb_left)
            {
                // Set Choice
                prompt_choice = btn_index;
                
                // Execute Press Script
                prompt_script = btn_data[5];
                prompt_params = btn_data[6];
                if script_exists(prompt_script) {
                    if is_array(prompt_params) {
                        script_execute(prompt_script, prompt_params);
                    } else {
                        script_execute(prompt_script);
                    }
                }
    
                
                // Exit Tween
                mainTween = TweenFire(id, mainEase,EaseLinear,
                                TWEEN_MODE_ONCE,false,3,.75*room_speed,mainEase[0],0); //NB: Don't use delta time here
                //Destroy Prompt On Tween Finish
                TweenAddCallback(mainTween, TWEEN_EV_FINISH, id, Destroy, id);
                
                
                
                //Click Sound
                scr_sound(sd_menu_click,1,false)
            }
           
        }
        
        //Draw Button Sprite 
        draw_sprite_ext(btn_spr, 0,btn_x,btn_y,btn_scale_start*btn_scalar,btn_scale_start*btn_scalar,0,btn_col,btn_alpha) 
        
        
        // Draw Button Text
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_font(fnt_menu_bn_26_black);
        btn_msg_h_adj = string_height("S") * .15;
        btn_text_col_index = btn_data[4];
        btn_text_col = COLORS[btn_text_col_index];
        draw_text_ext_transformed_colour(btn_x, btn_y - btn_msg_h_adj , btn_text, 
                                -1,-1,btn_scale_start*btn_scalar,btn_scale_start*btn_scalar,0,
                                btn_text_col,btn_text_col,btn_text_col,btn_text_col,subEase[3])
        
    
    }
}



//Decrement GUI jigglers
var jiggle_strength = 4;
for (var i=0, n=array_height_2d(prompt_jiggle); i < n; i++){
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


#define scr_prompt_dilemma_destroy
///scr_prompt_dilemma_destroy()



switch prompt_choice {

case 0:
case 1:
    // Execute Death Script
    btn_data = prompt_buttons[prompt_choice]
    if is_array(btn_data) {
        prompt_script = btn_data[7];
        prompt_params = btn_data[8];
        if script_exists(prompt_script) {
            if is_array(prompt_params) {
                ScheduleScript(obj_control_main, false, 2, prompt_script, prompt_params);
            } else {
                ScheduleScript(obj_control_main, false, 2, prompt_script);
            }
        }
    }
    break;
    
case noone:
    // Do Nothing
    break;

}

#define scr_prompt_dilemma_draw
///scr_prompt_dilemma_draw()


// Prompt Head
//scr_prompt_step_head_no_title();
scr_prompt_step_head();

// Prompt Body
scr_prompt_dilemma_step();

// Prompt Foot
scr_prompt_step_foot()

#define scr_prompt_dilemma_create
///scr_prompt_dilemma_create(title, header, text, buttons_data)
/* 
    buttons_data = [
                    sprite, 
                    name, 
                    id, 
                    spr_col_index, 
                    name_col_index, 
                    press_script, 
                    press_params = array or noone
                    death_script, 
                    death_params = array or noone
                 ] x2;  for two buttons
                 
    //NB: You could flesh this out with 2 sets of scripts/params, one for on death and one for on button press.



*/

var prompt = instance_create(0, 0, obj_prompt_dilemma);
with (prompt) {
    var i = -1;
    title_txt = argument[++i];
    promptHeader = argument[++i];
    promptText = argument[++i];
    prompt_buttons = argument[++i];
    
    // Set Jigglers
    if is_array(prompt_buttons) {
        for ( i = 0; i < array_length_1d(prompt_buttons); i++ ){
            for (j=0;j<3;j++){
                prompt_jiggle[i,j] = 0;
            }
        }
    }

}

return prompt;