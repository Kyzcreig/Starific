#define scr_prompt_feedback_init
///scr_prompt_feedback_init(bool)

promptTextType = argument0;

// Set Prompt Title
if promptTextType == 0 or promptTextType == 2{
    title_txt = "feedback";
    cash_reward = 0;
}
else if promptTextType == 1 {
    title_txt = "unlocked";
    cash_reward = 1;
}

// Set Size of Prompt Window
rect_h = round(.675 * GAME_H);//.55

//rect_h = round(.55 * GAME_H);//.55
//NB: This should be refactored to use ths scr_create_array, it's a lot cleaner than 2d arrays


enum buttonType{
    message,
    play,
    rate,
    donate
}

//Sprite Button Arrays
var i, j, k;
i = -1; 
        
// Play Time Mode Button
if promptTextType == 1 {
    prompt_button[++i] = scr_create_array(spr_button_basic, "play", cash_reward, buttonType.play, 3, power_type_color_index(3,1));
} 
// Download Music Button
else if promptTextType == 0 {
    prompt_button[++i] = scr_create_array(spr_button_basic, "music", cash_reward, buttonType.donate, 3, power_type_color_index(3,1));
}
// Contact Button
                           //button sprite //button text  //button cash reward //button id //button color //button text color 
prompt_button[++i] = scr_create_array(spr_button_basic, "message", cash_reward, buttonType.message, 2, power_type_color_index(2,1));
// Rate or Get App Mobile Button
if touchPad != 0 {
    prompt_button[++i] = scr_create_array(spr_button_basic, "rate", cash_reward, buttonType.rate, 1, power_type_color_index(1,1));
}
else {
    prompt_button[++i] = scr_create_array(spr_button_basic, "get app", cash_reward, buttonType.rate,1, power_type_color_index(1,1));
}


prompt_jiggletime = 1.0*room_speed
for ( i = 0; i < array_length_1d(prompt_button); i++ ){
    for (j=0;j<3;j++){
        prompt_jiggle[i,j] = 0;
    }
}

#define scr_prompt_step_feedback
///scr_prompt_step_feedback()

// Prompt Body
draw_set_halign(fa_left);
draw_set_font(fnt_menu_bn_40_bold);
// Set Header Text
promptHeader = "enjoying starific?"
promptHeaderX = GAME_MID_X-line_w//GAME_X + 40;
promptHeaderY = line_y + 60 + 175*0;
promptHeaderH = string_height(promptHeader);
draw_text_color(promptHeaderX, promptHeaderY, promptHeader, 
COLORS[0], COLORS[0],COLORS[0],COLORS[0],subEase[3]);

// Draw Paragraph Text
draw_set_font(fnt_menu_calibri_22_bold); 
promptText = scr_prompt_feedback_text(promptTextType);
promptTextX = promptHeaderX+8;
promptTextW = line_w*1.9;
promptTextH = string_height_ext(promptText,-1,promptTextW);
promptTextY = promptHeaderY + promptHeaderH/2 *1.2 +promptTextH/2;
draw_text_ext_colour(promptTextX, promptTextY,promptText, 
-1, promptTextW, COLORS[0], COLORS[0],COLORS[0],COLORS[0],subEase[3]);


// Draw Buttons
//btn_w = sprite_get_width(spr_button_basic);
//btn_h = sprite_get_height(spr_button_basic);
//btn_y = promptTextY +promptTextH/2 + btn_h * .75
//btn_x = 



//Draw Sprite Buttons
var n = array_length_1d(prompt_button);
var sp_scale_start = 3 / (n+1) 
/*
if n == 2 {
    sp_gap_whole = line_w*1.6;
    sp_gap_start = sp_gap_whole/2;
    sp_scale_start = 1;
}
else if n == 3 {
    sp_gap_whole = line_w*1.9;
    sp_gap_start = sp_gap_whole/2;
    sp_scale_start = .75;
}*/
var sp_width = sprite_get_width(spr_button_basic) * sp_scale_start;
var sp_height = sprite_get_height(spr_button_basic) * sp_scale_start;
var sp_size = sp_width;
var sp_gap_whole = line_w*1.9 - sp_size;
var sp_gap = sp_gap_whole / ( max(1,n-1) );
//var sp_gap = max(sp_size * 1.1, min(sp_gap_whole / (n) * (n-1), sp_gap_whole / (max(1,n-1))))
//var sp_start_x = GAME_MID_X - sp_gap_start + sp_width/2 ;
for(var i = 0; i < n; i++)
{
    // Get Button Data
    var data = prompt_button[i];
    //Sprite Coordinates
    sp_x = GAME_MID_X + sp_gap * (i - (n-1)/2) 
    sp_y = promptTextY +promptTextH/2 + sp_height/sp_scale_start * 1.5//1;
    sp_x += prompt_jiggle[i,1];
    sp_y += prompt_jiggle[i,2];

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
            //Call Action
            
            // Contact
            if data[3] == buttonType.message {
                //var contact_email = "support@"+string_slice(LANDING_PAGE_URL,7,-1);
                //url_open_ext("mailto:"+contact_email, "_self")//"_blank")
                    //NB: For some reason email pages don't open from the app.
                var contact_page = COMPANY_URL+"contact/"
                url_open_ext(contact_page,URL_TARGET)//"_blank")
            }
            // Rate
            else if data[3] == buttonType.rate {
                scr_button_rate();
            }
            //Play
            else if data[3] == buttonType.play {
                // Exit Tween
                mainTween = TweenCreate(id, mainEase,EaseLinear,
                                TWEEN_MODE_ONCE,1,0,.75, mainEase[0],0);
                ScheduleScript(id, 0, 3, TweenPlay,mainTween); //delayed to allow cash prompt to happen first
            
                // Play Time Mode  On Tween Finish
                TweenAddCallback(mainTween, TWEEN_EV_FINISH,obj_control_main, 
                            ScheduleScript, obj_control_main, 0, 2, scr_select_menu_option, 3);  
                                    //NB: we use obj_control_main because it's persistent
                //Destroy Prompt On Tween Finish
                TweenAddCallback(mainTween,TWEEN_EV_FINISH, id, Destroy, id);
            } 
            // Donate
            else if data[3] == buttonType.donate {
                var donate_page = "http://bevelededge.itch.io/starific-endless-reactor-sountrack";// TO DO ITCH.IO
                url_open_ext(donate_page,URL_TARGET)//"_blank")
            }
            //Click Sound
            scr_sound(sd_menu_click,1,false)
            
            // If Cash Bonus For Button
            if data[2] == 1 {
    
                // Clear Cash Bonus for All Buttons
                for (var j = 0; j < n; j++) {
                    data[@ 2] = 0;
                }
                
                // Create Cash Reward Prompt
                ScheduleScript(id, 0, 2, scr_reward_set,.2, true); //NB: delayed so cash markings on the buttons disappear
            }
        }
       
    }
    
    //Draw Button Sprite 
    draw_sprite_ext(data[0], 0,sp_x,sp_y,sp_scale_start*sp_scale,sp_scale_start*sp_scale,0,COLORS[data[4]],subEase[3]) 
    
    
    // Draw Button Text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_menu_bn_26_black);
    sp_msg_h_adj = string_height("S") * .15;
    sp_text_col = COLORS[data[5]];
    draw_text_ext_transformed_colour(sp_x, sp_y - sp_msg_h_adj , string(data[1]), 
                            -1,-1,sp_scale*sp_scale_start,sp_scale*sp_scale_start,0,
                            sp_text_col,sp_text_col,sp_text_col,sp_text_col,subEase[3])
    
    // Draw Cash Reward
    if data[2] == 1 {
        draw_set_font(fnt_menu_bn_20_black);
        sp_note_text = "+"+CASH_STR//+string(data[2]);
        sp_note_size = string_width(sp_note_text)*1.5 //sp_size / 6; // make notificaiton circle 4 smaller
        sp_note_scale = sp_scale_start * sp_note_size / sprite_get_width(spr_button_note_cash); // maybe tweak this size
        sp_note_x = sp_x + sp_width/2 * sp_scale
        sp_note_y = sp_y - sp_height/2 * sp_scale 
        
        //draw_set_valign(fa_middle);
        //draw_set_halign(fa_center);
        // Draw Note Rectangle
        draw_sprite_ext(spr_button_note_cash, 0,sp_note_x,sp_note_y,sp_note_scale,sp_note_scale,0,COLORS[0],subEase[3])   //COLORS[8], 
        // Draw Note Text
        var note_height_adj = sp_scale_start * sp_scale * string_height("S") * .1;
        draw_text_ext_transformed_colour(sp_note_x, sp_note_y - note_height_adj, sp_note_text, -1, -1, 
        sp_scale_start, sp_scale_start, 0, COLORS[6],COLORS[6],COLORS[6],COLORS[6],subEase[3])
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


#define scr_prompt_step_head
///scr_prompt_step_head(enable_back_button, vertical_align)

//Enable Button Button
enable_back_button = true;
if argument_count > 0 {
    enable_back_button = argument[0];
}
//Enable Button Button
vertical_align = 0;
if argument_count > 1 {
    vertical_align = argument[1];
}
var rect_y_adj = 0;
switch vertical_align {
    // Center
    case 0:
        rect_y_adj = -rect_h/2;
    break;
    // Top
    case 1:
        rect_y_adj = GAME_Y-GAME_MID_Y;
    break;

}


/*
scr_assert_menuSurface_exists();
surface_set_target(global.menuSurface);
draw_clear_alpha(COLORS[7],0);  // 0 alpha makes drawing screenshots easier?
*/



// SubEases
subEase[0] = clamp(mainEase[0],0,1)
subEase[1] = clamp(mainEase[0]-1,0,1)
subEase[2] = clamp(mainEase[0]-2,0,1)
subEase[3] = clamp(mainEase[0]-3,0,1)

// Draw Screenshot in Background
scr_draw_background_screenshot(1);

// Draw Mask over Background
scr_draw_background_mask(subEase[0] * .75, 0);

// Draw Containing Rect
rect_y = GAME_MID_Y -1400*(1-subEase[1]) + rect_y_adj;
draw_sprite_stretched_ext(s_v_background_solid_menu,0,rect_x, rect_y, rect_w, rect_h,COLORS[7],1)

// Draw Title
scr_draw_title(rect_y, subEase[2]);
// Draw Title Underline
scr_draw_title_underline(start_y + title_from_top * 2, subEase[2], 0);


/*
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_font(title_font);
title_from_top = 75;
title_y = rect_y + title_from_top - 400*(1-subEase[2]);
draw_text_color(GAME_MID_X, title_y, title_txt, COLORS[0], COLORS[0],COLORS[0],COLORS[0], 1);

// Draw Title Underline
line_w = GAME_W*(14/32) * subEase[2] 
line_y = rect_y + title_from_top * 2 
line_c = merge_color(COLORS[6],COLORS[0],.5)
draw_line_width_color(GAME_MID_X - line_w, line_y, GAME_MID_X + line_w, line_y, 6, line_c, line_c);
draw_line_width_color(GAME_MID_X - line_w, line_y, GAME_MID_X + line_w, line_y, 3, COLORS[0], COLORS[0]);
*/



//Draw Back Button
if showBackButton  {
    backButtonSpr = scr_return_arrow_sprite(0,0);
    
    backButtonScale = 1;
    backButtonW = sprite_get_width(s_v_backarrow)*1.00;
    backButtonH = sprite_get_height(s_v_backarrow) *.75;
    backButtonX = GAME_X+70 - 300*(1-subEase[2]) - backButtonW/2;
    
    backButtonHover = point_in_rectangle(mouse_x,mouse_y,backButtonX-backButtonW,
                                    title_y+9-backButtonH,backButtonX+backButtonW,
                                    title_y+9+backButtonH);
    //Scale Back Button on Hover
    if ((backButtonHover and (!touchPad or mouse_check_button(mb_left)))
         or keyboard_check_pressed(vk_backspace))
    {
    
        backButtonScale = 1.25; 
        
        //On Select of Back Button
        if (mouse_check_button_pressed(mb_left) or keyboard_check_pressed(vk_backspace))
            and !TweenExists(mainTween) and enable_back_button
        {
            // Exit Tween
            mainTween = TweenFire(id, mainEase,EaseLinear,
                                    TWEEN_MODE_ONCE,1,0,.75,mainEase[0],0);
            //Destroy Prompt On Tween Finish
            TweenAddCallback(mainTween,TWEEN_EV_FINISH, id, Destroy, id);
            
            scr_sound(sd_menu_click,1,false);
        }
    }   
    //Draw Back Button
    draw_sprite_ext(backButtonSpr, 0,backButtonX,title_y+9,backButtonScale,backButtonScale,0,COLORS[0],1);   
}
    


#define scr_prompt_step_foot
///scr_prompt_step_foot(enable_exit)

enable_exit = true;
if argument_count > 0 {
    enable_exit = argument[0];
}

// If Click Outside Prompt: Exit
if ((!point_in_rectangle(mouse_x,mouse_y, rect_x,rect_y, rect_x+rect_w,rect_y+rect_h) 
    and mouse_check_button_pressed(mb_left)) or keyboard_check_pressed(vk_backspace))
    and !TweenExists(mainTween) and enable_exit
{
    // Exit Prompt
    scr_prompt_exit()
}


/*
//Reset surface draw
surface_reset_target();






#define scr_prompt_add_cash_to_buttons
///scr_prompt_add_cash_to_buttons(val)

if is_array(prompt_button) {
    for (var i = 0; i < array_height_2d(prompt_button); i++){
        prompt_button[i, 2] = argument0; // set cash to val
    }
}

#define scr_select_menu_option
///scr_select_menu_option(function_id)

with (obj_control_menu) {
    ScheduleScript(id,1,.25 ,scr_delayed_selection,selected,argument0)

}

#define scr_prompt_step_head_prize
////scr_prompt_step_head_prize()


/*
scr_assert_menuSurface_exists();
surface_set_target(global.menuSurface);
draw_clear_alpha(COLORS[7],0);  // 0 alpha makes text more legible
*/

// SubEases
subEase[0] = clamp(mainEase[0],0,1)
subEase[1] = clamp(mainEase[0]-1,0,1)
subEase[2] = clamp(mainEase[0]-2,0,1)
subEase[3] = clamp(mainEase[0]-3,0,1)

// Draw Screenshot in Background
scr_draw_background_screenshot(1);

// Draw Mask over Background
draw_sprite_stretched_ext(s_v_background_solid_menu,0,GAME_X,GAME_Y,GAME_W,GAME_H,COLORS[7],subEase[0] * .75)



/*
// Draw Containing Rect
rect_y = GAME_MID_Y -1400*(1-subEase[1]) - rect_h/2
draw_sprite_stretched_ext(s_v_background_solid,0,rect_x, rect_y, rect_w, rect_h,COLORS[7],1)


// Draw Prompt Title
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_font(title_font);
title_from_top = 75;
title_y = rect_y + title_from_top - 400*(1-subEase[2]);
draw_text_color(GAME_MID_X, title_y, title_txt, COLORS[0], COLORS[0],COLORS[0],COLORS[0], 1);

// Draw Title Underline
line_w = GAME_W*(14/32) * subEase[2] 
line_y = rect_y + title_from_top * 2 
line_c = merge_color(COLORS[6],COLORS[0],.5)
draw_line_width_color(GAME_MID_X - line_w, line_y, GAME_MID_X + line_w, line_y, 6, line_c, line_c);
draw_line_width_color(GAME_MID_X - line_w, line_y, GAME_MID_X + line_w, line_y, 3, COLORS[0], COLORS[0]);
*/

#define scr_draw_background_screenshot
///scr_draw_background_screenshot(alpha)


// Draw Screenshot in Background
draw_sprite_ext(spr_temp, 0, VIEW_X, VIEW_Y, 1, 1, 0, c_white, argument0);

#define scr_draw_background_mask
///scr_draw_background_mask(alpha, tex_page)



// Draw Mask Over Screen
draw_sprite_stretched_ext(scr_return_solid_sprite(argument1),0,VIEW_X,VIEW_Y,VIEW_W,VIEW_H,COLORS[7],argument0)
#define scr_prompt_exit
///scr_prompt_exit()


// Exit Tween
mainTween = TweenFire(id, mainEase,EaseLinear,
                 TWEEN_MODE_ONCE,1,0,.75,mainEase[0],0);
//Destroy Prompt On Tween Finish
TweenAddCallback(mainTween,TWEEN_EV_FINISH, id, Destroy, id);