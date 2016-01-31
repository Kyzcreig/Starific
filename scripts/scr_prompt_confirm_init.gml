#define scr_prompt_confirm_init
///scr_prompt_confirm_init()

title_txt = "";
promptHeader = "";//main header
promptText = ""; 
rect_h = round(.50 * GAME_H);//.55

//Sprite Button Arrays
                                          //sprite, text, id, spr color, text color
prompt_buttons[0] = Array(spr_button_basic, "no", 0,
                                    power_type_color_index(2,0), 
                                    power_type_color_index(2,1)); 
prompt_buttons[1] = Array(spr_button_basic, "yes!",1,
                                    power_type_color_index(1,0), 
                                    power_type_color_index(1,1)); 


prompt_choice = noone;
prompt_script = noone;
prompt_params = noone;


prompt_jiggletime = 1.0*room_speed
for ( i = 0; i < array_length_1d(prompt_button); i++ ){
    for (j=0;j<3;j++){
        prompt_jiggle[i,j] = 0;
    }
}




#define scr_prompt_confirm_step
///scr_prompt_confirm_step()



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
var n = array_length_1d(prompt_buttons);
var sp_scale_start = 3 / (n+1) 
var sp_width = sprite_get_width(spr_button_basic) * sp_scale_start;
var sp_height = sprite_get_height(spr_button_basic) * sp_scale_start;
var sp_size = sp_width;
var sp_gap_whole = line_w*1.9 - sp_size;
var sp_gap = sp_gap_whole / ( max(1,n-1) );
for(var i = 0; i < n; i++)
{

    // Button Data
    data = prompt_buttons[i];
    
    sp_spr = data[0];
    sp_text = data[1];
    
    //Sprite Coordinates
    sp_x = GAME_MID_X + sp_gap * (i - (n-1)/2) 
    sp_y = promptTextY +promptTextH/2 + sp_height/sp_scale_start * 1.5//1;
    sp_x += prompt_jiggle[data[2],1];
    sp_y += prompt_jiggle[data[2],2];

    var sp_scale =  1;
    //Check if mouse over icon
    if point_in_rectangle(mouse_x,mouse_y,sp_x-sp_width/2,sp_y-sp_height/2,
                          sp_x+sp_width/2,sp_y+sp_height/2) 
                          and (!touchPad or mouse_check_button(mb_left)) 
                          and !TweenExists(mainTween) 
    {
        //Disable increase scale when hovered/clicked
        sp_scale *= 1.2;
        //On Button Press
        if mouse_check_button_pressed(mb_left)
        {
            //Don't Exit
            if data[2] == 0 {
                prompt_choice = 0;
            }
            //Do Exit
            else if data[2] == 1 {
                prompt_choice = 1;
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
    draw_sprite_ext(sp_spr, 0,sp_x,sp_y,sp_scale_start*sp_scale,sp_scale_start*sp_scale,0,COLORS[data[3]],subEase[3]) 
    
    
    // Draw Button Text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_menu_bn_26_black);
    sp_msg_h_adj = string_height("S") * .15;
    sp_text_col = COLORS[data[4]];
    draw_text_ext_transformed_colour(sp_x, sp_y - sp_msg_h_adj , sp_text, 
                            -1,-1,sp_scale*sp_scale_start,sp_scale*sp_scale_start,0,
                            sp_text_col,sp_text_col,sp_text_col,sp_text_col,subEase[3])
    

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


#define scr_prompt_confirm_destroy
///scr_prompt_confirm_destroy()

switch prompt_choice {

case 1:
    if script_exists(prompt_script) {
        if is_array(prompt_params) {
            ScheduleScript(obj_control_main, false, 2, prompt_script, prompt_params);
        } else {
            ScheduleScript(obj_control_main, false, 2, prompt_script);
        }
    }
    break;

case 0:
    // Do Nothing
    break;
    
case noone:
    // Do Nothing
    break;

}

#define scr_prompt_confirm_draw
///scr_prompt_confirm_draw()


// Prompt Head
//scr_prompt_step_head_no_title();
scr_prompt_step_head();

// Prompt Body
scr_prompt_confirm_step();

// Prompt Foot
scr_prompt_step_foot()