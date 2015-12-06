///scr_menu_draw_main()



// SubEasers
if true {//TweenExists(mainTween){// and TweenIsPlaying(mainTween) {
    subEase[0] = EaseOutBack(clamp(mainEase[0],0,1), 0, 1, 1)
    subEase[1] = EaseInBack(clamp(mainEase[0]-0.5,0,1), 0, 1, 1);
    subEase[2] = clamp(mainEase[0]-1.0,0,1);
    //subEase[0] = clamp(mainEase[0],0,1)
    //subEase[1] = clamp(mainEase[0]-1.0,0,1)
}



// Draw Title
scr_draw_title(GAME_Y, subEase[0]);
// Draw Title Underline
scr_draw_title_underline(start_y + title_from_top * 2, subEase[1], 0);





//Draw Menu Choices
var choices_x, choices_y,choices_start_y, choices_gap_y, choices_h, choices_w;
choices_start_y = line_y//title_endY + title_h/2 + 10 //* + title_h/2
choices_gap_y = 165 //140
//Check for Mouse Hover; 
for(var i = 1; i < array_length_1d(menu);i++)
{
    draw_set_font(fnt_menu_buttons);
    draw_set_halign(fa_center)
    draw_set_valign(fa_middle)
    //Alternate sign/direction of tween
    var tweenSign = (i mod 2)*-1;
    if tweenSign == 0 {tweenSign = 1}
    
    //Sets Coords for Text
    choices_x = GAME_MID_X  -tweenSign*600*(1-subEase[0]);
    choices_y  = choices_start_y  + (i)*choices_gap_y
    
    choices_w = (GAME_W*11/32)//(GAME_W/2*19/32)
    choices_h = string_height(menu[i])
    
    text_text = menu[i];
    mode_data = scr_unlock_get_data(1,i-1);
    // If mode locked, change text
    text_locked = false;
    if mode_data[1] == 0 {
        //text_text = scr_cypher_text("abcdefghijklmnopqrstuvwxyz","?",text_text)//"locked"
        //text_text = "locked"
        text_text = "     ";
        text_locked = true;
    }
    //If mode new flag new
    text_new = false;
    if scr_unlock_is_new(mode_data) {
        text_new = true;
        //Flag Mode as Seen
        mode_data[@ 2] = -1;
    }
    
    text_w = string_width(text_text);
    text_scale = 1;
    text_color = COLORS[i];
    text_color_accent = merge_color(COLORS[6],text_color,.5);
    bold_line = false
    
    
    
    text_hover = point_in_rectangle(mouse_x,mouse_y,
                            choices_x-choices_w,choices_y-choices_h,
                            choices_x+choices_w,choices_y+choices_h) ;
                       
    if text_hover and selected[0] == noone and (!touchPad or mouse_check_button(mb_left))
    and !instance_exists(obj_prompt_parent)
    {
    
        //Set Scale
        text_scale = 1.2
        text_color = text_color_accent
        bold_line = true;
        
        //On Select of Menu Choice
        //if mouse_check_button _released(mb_left)
        if mouse_check_button_pressed(mb_left) and selected[1] == true
        {
            //Call Switch Code for this menu choice
            selected[1] = false
            ScheduleScript(id,1,.25,scr_delayed_selection,selected,i)
            //pass along coordinates for possible text dialogues
            u_txt_x = choices_x;
            u_txt_y = choices_y+choices_h;
            scr_sound(sd_menu_click,1,false);
            //selected = i;
            //event_user(0);
            
        }
        
    }
    
    

    // Draw Mode Text
    if !text_locked {
        draw_text_ext_transformed_colour(choices_x, choices_y, 
        text_text, -1, -1, text_scale, text_scale, 0, 
        text_color, text_color, text_color, text_color,1);
             
        // Draw New Text and Mark as Viewed
        if text_new {
        
            // Set Text
            sub_text = "new!"
            // Place Tiny New Text
            sub_text_x = choices_x - text_w * text_scale * .5;
            sub_text_y = choices_y - choices_h * text_scale * .5//.65;
            
            sub_text_col = COLORS[scr_flashing_color_index(10)];
            //Draw rating text
            draw_set_font(fnt_gui_options7)
            draw_set_halign(fa_left)
            draw_text_ext_transformed_colour(sub_text_x, sub_text_y, sub_text, 
            -1, -1, text_scale, text_scale, 0, sub_text_col,sub_text_col,sub_text_col,sub_text_col,subEase[1]);
        
        }
    
    } 
    // Else Draw Pad Lock Icon
    else {
        sp_spr = s_v_padlock_100;
        sp_size = 75; 
        sp_scale = sp_size / sprite_get_height(s_v_padlock_100) * text_scale;
        sp_x = choices_x  + menu_jiggle[i,1];
        sp_y = choices_y + menu_jiggle[i,2];
        sp_alpha = .5;
        draw_sprite_ext(sp_spr, 0,sp_x,sp_y ,sp_scale,sp_scale,0,text_color,sp_alpha)  //COLORS[8], 
        
    }
    
    
    
    // Draw Line Behind Text
    line_w = choices_w * text_scale * subEase[2]
    hideline_w = text_w/2 * text_scale * 1.2 //or arbitrary pixel length
    scr_draw_menu_choice_backline(choices_x, choices_y+10, line_w, hideline_w, text_color,text_color_accent, 1, 0, bold_line)


    
} 

//Shortcut key 'vk_backspace' for exit application
if keyboard_check_released(vk_backspace){
            selected[1] = false
            ScheduleScript(id,1,.25 ,scr_delayed_selection,selected,12)
            scr_sound(sd_menu_click,1,false);
}



//Draw Sprite Buttons
var n = array_height_2d(menu_button);
var sp_width = sprite_get_width(menu_button[0,0]);
var sp_size = 60;
var sp_gap_whole = (GAME_W*11/32)*2 - sp_size; //NB: I don't use line_w so position is fixed and not easing
//var sp_gap = ( sp_gap_whole / ( n-1 );
var sp_gap = max(sp_size * 1.1, min(sp_gap_whole / (n) * (n-1), sp_gap_whole / (max(1,n-1))))
//var sprite_start_x = line_x-line_w;
//var sp_start_x = GAME_MID_X - GAME_W*11/32 +sp_size/2 ;
for(var i = 0; i < n; i++)
{
    //Sprite Coordinates
    //sp_x = sp_start_x + sp_gap*i + menu_jiggle[menu_button[i,1],1];
    //sp_y = choices_start_y + (5)*choices_gap_y +30/*GAME_Y +GAME_H  - sp_width/2 -40*/ + menu_jiggle[menu_button[i,1],2];
    sp_x = GAME_MID_X + sp_gap * (i - (n-1)/2) 
    sp_y = choices_start_y + (5)*choices_gap_y +30
    sp_x += + menu_jiggle[menu_button[i,1],1];
    sp_y += + menu_jiggle[menu_button[i,1],2];
    //Maybe we should tween these buttons in, that might be cool.
    //well we'll evaluate how it looks.
    //alpha tween might just be fine.
    
    //Draw and Trigger Sound Toggle
    var sp_scale =  1;
    var sp_resize = sp_size / sprite_get_width(menu_button[i,0]);
    //Check if mouse over icon
    if point_in_rectangle(mouse_x,mouse_y,sp_x-sp_width/2*1.25,sp_y-sp_width/2*1.25,
                          sp_x+sp_width/2*1.25,sp_y+sp_width/2*1.25) 
                          and selected[0] == noone and (!touchPad or mouse_check_button(mb_left)) 
                          and !TweenExists(mainTween) 
    {
        //Disable increase scale when hovered/clicked
        sp_scale *= 1.25;
        //On Icon Press
        if mouse_check_button_pressed(mb_left) and selected[1] == true
        {
            //Call Switch Code for this menu choice
            selected[1] = false
            ScheduleScript(id,1,.25 ,scr_delayed_selection,selected,menu_button[i,1])
            
            u_txt_x = choices_x;
            u_txt_y = sp_y+sp_size/2;
            scr_sound(sd_menu_click,1,false);
        }
       
    }
    
    //Draw Sprite Icons from Sprite Array
    draw_sprite_ext(menu_button[i,0], 0,sp_x,sp_y,sp_scale*sp_resize,sp_scale*sp_resize,0,COLORS[5],subEase[2])  //COLORS[8], 
    
    // Draw Notification Circle
    if menu_button[i,2] > 0 {
        sp_note_text = string(menu_button[i,2])
        sp_note_size = sp_size * .5; // make notificaiton circle 4 smaller
        sp_resize = sp_note_size / sprite_get_width(s_v_solid_circle_60); // maybe tweak this size
        sp_x = sp_x + sp_scale * (sp_size / 2) // - sp_note_size / 2 
        sp_y = sp_y - sp_scale * (sp_size / 2) //+ sp_note_size / 2
        // Draw Circle
        draw_sprite_ext(s_v_solid_circle_60, 0,sp_x,sp_y,sp_resize,sp_resize,0,COLORS[0],subEase[2])  //COLORS[8], 
        // Draw Notifcation Count
        //draw_set_font(fnt_gui_options9);
        draw_set_font(fnt_gui_options7);
        draw_set_valign(fa_middle);
        draw_set_halign(fa_center);
        var note_height_adj = string_height("0") * .15;
        draw_text_colour(sp_x, sp_y - note_height_adj, sp_note_text, COLORS[6],COLORS[6],COLORS[6],COLORS[6],subEase[2])
    }
}



//Decrement GUI jigglers
var jiggle_strength = 4;
for (var i=0, n=array_height_2d(menu_jiggle); i < n; i++){
    if menu_jiggle[i,0] > 0{
        menu_jiggle[i,0] -= 1
        menu_jiggle[i,1] = random_range(-1,1)*jiggle_strength;
        menu_jiggle[i,2] = random_range(-1,1)*jiggle_strength;
    }
    else if menu_jiggle[i,0] >= 0{
        menu_jiggle[i,0] = -2
        menu_jiggle[i,1] = 0;
        menu_jiggle[i,2] = 0;
    
    }
}
