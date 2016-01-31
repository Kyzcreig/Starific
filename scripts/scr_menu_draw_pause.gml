#define scr_menu_draw_pause
///scr_menu_draw_pause()


// Draw Screenshot in Background
scr_draw_background_screenshot(p_FadeBackTween[0]);

// Draw Mask over Background
scr_draw_background_mask(p_FadeTween[0], 0)



// Draw Resume Countdown Timer
if resumeCD[0] > 0 {
    draw_set_font(fnt_menu_bn_60_bold);
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);
    draw_text_outline_ext_transformed_color(centerfieldx, centerfieldy, string(resumeCD[0]),-1,-1,
    resumeCD_scale[0],resumeCD_scale[0], 0, COLORS[0],COLORS[0],COLORS[0],COLORS[0],1, 4, COLORS[6], 4);
}



//Draw PAUSE screen slide up
rect_x = GAME_X
rect_y = GAME_MID_Y +1400*(1-p_SlideTween1[0])
///var xScale = GAME_W/sprite_get_width(s_v_background_solid);
//var yScale = rect_h/sprite_get_height(s_v_background_solid);
draw_sprite_stretched_ext(s_v_background_solid_menu,0,rect_x,rect_y - rect_h/2,rect_w,rect_h,COLORS[7],1)
//draw_rectangle_color(rect_x,rect_y - rect_h,
//                     rect_x+rect_w,rect_y+rect_h,
//                     COLORS[6],COLORS[6],COLORS[6],COLORS[6],false);

      

// Draw Title
scr_draw_title(rect_y-rect_h/2, p_SlideTween2[0]);
// Draw Title Underline
scr_draw_title_underline(start_y + title_from_top * 2, p_SlideTween2[0], 0);



//Draw Pause Menu Choices
var choices_x, choices_y, choices_start_y, choices_gap_y;
choices_start_y = line_y+100;
choices_gap_y = 95;
for(var i = 0; i < array_length_1d(menu);i++)
{
    //Alternate sign/direction of tween
    draw_set_font(fnt_menu_bn_40_bold);
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);
    var tweenSign = (i mod 2);
    if tweenSign == 0 {tweenSign = -1}
    
    
    // Get Data
    data = menu[i];
    text_text = data[0];
    text_function = data[1];
    
    
    //Sets Coords for Text
    choices_x = centerfieldx  -tweenSign*600*(1-p_SlideTween2[0]);
    choices_y  = choices_start_y  + choices_gap_y*(i) //probably use percentages here for varying resolutions
    //Nah I actually just stretch the screen instead :)
    
    //Else i>1; check if Text Hovered Over
    choice_w = (GAME_W*11/32)
    choice_h = string_height("H")/2
    text_w = string_width(text_text);
    text_h = string_height(text_text)
    text_scale = 1;
    
    text_color = COLORS[i+1];
    text_color_accent = merge_color(COLORS[6],text_color,.5);
    bold_line = false;
    
    text_hover = point_in_rectangle(mouse_x,mouse_y,choices_x-choice_w,choices_y-choice_h,choices_x+choice_w,choices_y+choice_h) ;
    
    if text_hover and p_selected[0] == noone and 
    (!touchPad or mouse_check_button(mb_left)) and !TweenExists(p_TweenSlide3)
    {
        //Set Scale
        text_scale *= 1.2
        text_color = text_color_accent
        bold_line = true;
        

        //On Select of Menu Choice
        if mouse_check_button_pressed(mb_left) and p_selected[1] == true 
            ///NB: We could replace this with swipe_tap for our frameskipper workaround
        {
            //Call Switch Code for this menu choice
            p_selected[1] = false
            ScheduleScript(id,1,.25 ,scr_delayed_selection,p_selected,text_function)
            scr_sound(sd_menu_click,1,false);
            
        }
        
    }
    
    // Draw Choice Text
    draw_text_ext_transformed_colour(choices_x, choices_y, text_text, 
    -1, -1, text_scale, text_scale, 0, text_color, text_color, text_color, text_color,1);
 
    
    // Draw Line Behind Text
    line_w = choice_w * text_scale * p_SlideTween3[0]
    hideline_w = text_w/2 * text_scale * 1.2 //or arbitrary pixel length
    scr_draw_menu_choice_backline(choices_x, choices_y+10, line_w, hideline_w, text_color,text_color_accent, 1, 0,bold_line)

   
    
} 

//Shortcut key 'p' for resume
if keyboard_check_released(ord('P')){
            p_selected[1] = false
            ScheduleScript(id,1,.25 ,scr_delayed_selection,p_selected,1)
            scr_sound(sd_menu_click,1,false);
}

//Shortcut key 'vk_backspace' for return to menu
if keyboard_check_released(vk_backspace){
            p_selected[1] = false
            ScheduleScript(id,1,.25 ,scr_delayed_selection,p_selected,3)
            scr_sound(sd_menu_click,1,false);
}


//I probably want to draw the info button here too
var btn_x, btn_y, btn_scale, btn_width, btn_height, btn_hover;
var n = array_length_1d(btn_items);
var btn_size = 60 //sprite_get_height([0,0]);
var btn_gap_whole = (GAME_W*11/32)*2  - btn_size;//NB: I don't use line_w so position is fixed and not easing
var btn_gap = btn_gap_whole / ( max(1,n-1) );
//var btn_gap = max(btn_size * 1.1, min(btn_gap_whole / (n) * (n-1), btn_gap_whole / (max(1,n-1))))
//btn_start_x = centerfieldx - (GAME_W*11/32) + btn_size/2;
for(var i = 0; i < n;i++)
{
    //Get Data
    btn_data = btn_items[i];
    btn_txt = btn_data[0];
    btn_spr = btn_data[1];
    
    //Check if Sprite is Volume Array
    if is_array(btn_spr) {
        //Set Sprite based on Sound Muta Data
        sound_data = btn_data[3];
        btn_spr = btn_spr[sound_data[1]];
    }
    //btn_x = btn_start_x + btn_gap * i;
    btn_x = GAME_MID_X + btn_gap * (i - (n-1)/2) 
    btn_y = GAME_Y+ .85 * GAME_H;
    
    // Set Alpha
    if btn_data[4] == 0 {
        // Normal
        btn_alpha = 1; 
    } 
    else if btn_data[4] == 1{
        // Flashing
        btn_alpha = lerp(.2,.8, FULL_SECOND_SINE);//FULL_SECOND_LERP); //EVALUATE ME
    }
    else if btn_data[3] < 0 {
        // Inactive
        btn_alpha = .6;
    }
    // Ease Up Alpha
    btn_alpha *= p_SlideTween3[0]; 
    // Set Color
    btn_col = COLORS[8];
    

    
    
    btn_width = sprite_get_width(btn_spr);
    btn_height = sprite_get_height(btn_spr);
    btn_scale = btn_size / btn_height;
    btn_scalar = 1;
    
    btn_hover = point_in_rectangle(mouse_x,mouse_y,
                btn_x-btn_width/2*1.25,btn_y-btn_height/2*1.25,
                btn_x+btn_height/2*1.25,btn_y+btn_height/2*1.25) 
    
    //Check if mouse over icon
    if btn_hover and p_selected[0] == noone 
    and (!touchPad or mouse_check_button(mb_left)) 
    and !TweenExists(p_TweenSlide3)
    {
        //Disable increase scale when hovered/clicked
        btn_scalar *= 1.25;
        
        
    
        //On Icon Press
        //if mouse_check_button_ released(mb_left)
        if mouse_check_button_pressed(mb_left) and p_selected[1] == true and btn_data[4] >= 0
        {
            //Call Switch Code for this menu choice
            p_selected[1] = false
            ScheduleScript(id,1,.25,scr_delayed_selection,p_selected,btn_data[2])
            scr_sound(sd_menu_click,1,false);
            //p_selected = i+4;
            //event_user(0);
        }
       
    }
    
    //Draw Sound Icons from Sprite Array
    draw_sprite_ext(btn_spr, 0,btn_x,btn_y,btn_scale*btn_scalar,
                    btn_scale*btn_scalar,0,btn_col,btn_alpha);
    // Draw Button Label
    draw_set_font(fnt_menu_bn_15_black);
    draw_set_valign(fa_top);
    draw_set_halign(fa_center);
    btn_txt_scale = btn_scalar;
    btn_txt_x = btn_x;
    btn_txt_y = btn_y + btn_size / 2 * btn_scalar + 10;
    draw_text_ext_transformed_colour(btn_txt_x, btn_txt_y, btn_txt, -1, -1, 
    btn_txt_scale, btn_txt_scale, 0, btn_col, btn_col, btn_col, btn_col, btn_alpha);
                                             
}


//Draw Difficulty/Skill Text
draw_set_font(fnt_menu_bn_20_black);
draw_set_valign(fa_top);
draw_set_halign(fa_right);
info_x = GAME_X + GAME_W - 10;
info_y = GAME_Y + 10;
draw_text_ext_colour(info_x, info_y, info_txt, -1, GAME_W/2,
COLORS[0], COLORS[0], COLORS[0], COLORS[0],p_SlideTween3[0]);


// Draw Song Ticker
if MUSIC_STATE == 1 {
    draw_set_font(fnt_menu_calibri_24_bold);
    draw_set_valign(fa_bottom);
    draw_set_halign(fa_left);
    
    // Process Ticker
    for (var i = 0; i < 2; i ++){
        // Draw Tickers
        draw_text_ext_colour(np_x[i], np_y, np_text, -1, -1,
        COLORS[0], COLORS[0], COLORS[0], COLORS[0], p_SlideTween3[0]);
        // Move Ticker by NP Velocity
        if p_SlideTween3[0] == 1 {
            np_x[i] -= np_vel;
        }
        // If Ticker Off Screen
        if np_x[i] + np_w < GAME_X {
            // Get Other Ticker Index
            var tmp;
            switch i {
                case 0:
                    tmp = 1;
                    break;
                case 1:
                    tmp = 0;
                    break;
            }
            // Reset Location Behind Other Ticker
            np_x[i] = np_x[tmp] + np_w + GAME_W/2;
        } 
    }
    
    

}




#define scr_menu_pause_make_background
///scr_menu_pause_make_background()

///Create Background Sprite

// Adjust Colors if changed
if mColorsChanger > 0 {
    scr_reset_aesthetics();
}
mColorsChanger = 0;

//Delete any old Screenshots
if sprite_exists(spr_temp){sprite_delete(spr_temp);}

//Take Screenshot
spr_temp = scr_screenshot(1, 0, 1);

// Deactivate Everything Else
scr_deactivate_everything_else();

// Draw Sprite to Surface to Prevent Flicker
//scr_draw_still_screen(spr_temp, p_FadeBackTween[0]);