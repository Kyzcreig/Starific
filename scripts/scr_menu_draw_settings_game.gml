#define scr_menu_draw_settings_game
///scr_menu_draw_settings_game()




// SubEasers
scr_menu_draw_settinga_set_easers();

///Page Header
scr_settings_page_header(subEase[0], subEase[1]);




//Page Body

//Sets Coords for Text
scr_menu_draw_settings_baseline();

//Draw Page Settings
for(i = 0; i < array_length_1d(menu);i++)
{
    // Draw Settings Categories
    scr_menu_draw_settings_categories();
    
    
     // Arrow Style Settings
    if menu_data[1] == 1{ 
    
        // Set Coordinates for Arrows
        scr_draw_settings_arrows_coordinates();
        
        
        //Draw Gridsize stuff
        if menu_data[2] == 0 { //what is subtype
            var name = scr_unlock_get_name(menu_data[2],CUR_GRID);
            scr_draw_settings_arrows(menu_data[2], menu_data[3], CUR_GRID, COUNTS_GRID, name, subEase[i+2], subEase[i+3]);
            
        }
        //Draw Rigor stuff
        else if menu_data[2] == 2 { //what is subtype
            var name = scr_unlock_get_name(menu_data[2],CUR_RIGOR);
            scr_draw_settings_arrows(menu_data[2], menu_data[3], CUR_RIGOR, COUNTS_RIGOR, name, subEase[i+2], subEase[i+3]);
        }
        
        //Draw Control stuff
        else if menu_data[2] == -2 { //what is subtype
            var name = convert_index_to_control_name(TP_SENSE[1])
            scr_draw_settings_arrows(menu_data[2], menu_data[3], TP_SENSE[1], array_length_1d(tm_names), name, subEase[i+2], subEase[i+3]);
        }
        
        
       
    }
    
    //Draw Slider Bars
    if menu_data[1] == 2 and subEase[i+1] != 0 {
    
        // Set Coordinates
        scr_menu_draw_slider_coordinates();
    
        //Sensitivity Bar
        if menu_data[2] == 2
        {
            scr_draw_settings_slider(TP_SENSE, "", "settings", "TP_SENSE", 
                                        subEase[i+2], menu_data[2]);
            toggle_spr = tp_show_spr[TOUCH_PAD_SHOW];

            scr_draw_settings_slider_button(toggle_spr, menu_data[3], subEase[i+2]) 
            
        }
    }
    
    // Increment Y Coordinate
    scr_draw_settings_increment();
} 




//Page Footer
scr_settings_page_footer();

#define scr_menu_draw_settings_display
///scr_menu_draw_settings_display()





// SubEasers
scr_menu_draw_settinga_set_easers();


///Page Header
scr_settings_page_header(subEase[0], subEase[1]);




//Page Body

//Sets Coords for Text
scr_menu_draw_settings_baseline();

//Draw Page Settings
for(i = 0; i < array_length_1d(menu);i++)
{
    // Draw Settings Categories
    scr_menu_draw_settings_categories();
    
     // Arrow Style Settings
    if menu_data[1] == 1{ 
    
    
        // Set Coordinates for Arrows
        scr_draw_settings_arrows_coordinates();
  
        
        //Draw FPS stuff
        if menu_data[2] == -1 { //what is subtype
            var name = fps_names[RMSPD_OPT_INDEX];
            scr_draw_settings_arrows(menu_data[2], menu_data[3], RMSPD_OPT_INDEX, RMSPD_OPTIONS, name, subEase[i+2], subEase[i+3]);
            
        }
        // Draw VFX Stuff
        else if menu_data[2] == -3 { //what is subtype
            var name = vfx_names[VFX_LEVEL];
            scr_draw_settings_arrows(menu_data[2], menu_data[3], VFX_LEVEL, array_length_1d(vfx_names), name, subEase[i+2], subEase[i+3]);
            
        }
    }
    
    //Draw Sound Volume Bars
    if menu_data[1] == 2 and subEase[i+1] != 0 {
        // Set Coordinates
        scr_menu_draw_slider_coordinates();
        
        
        //Music Volume bar
        if menu_data[2] == 0
        {
            scr_draw_settings_slider(music_sound, music_list, "settings", "music_volume", 
                                    subEase[i+2], menu_data[2]);
            toggle_spr = music_spr[music_sound[1]];
            scr_draw_settings_slider_button(toggle_spr, menu_data[3], subEase[i+2]) 
        }
        //SFX Volume bar
        if menu_data[2] == 1
        {
            scr_draw_settings_slider(sfx_sound, sfx_list, "settings", "sfx_volume", 
                                        subEase[i+2], menu_data[2]);
            toggle_spr = sfx_spr[sfx_sound[1]];
            scr_draw_settings_slider_button(toggle_spr, menu_data[3], subEase[i+2]) 
        }
    }
    
    // Draw Togglers
    if menu_data[1] == 3 {
        // Set Coordinates
        scr_menu_draw_toggler_coordinates();
    
        // Everyplay Toggler
        if menu_data[2] == 0 {
            scr_draw_settings_toggler_button(EVERYPLAY_AUTO, 5, subEase[i+2]);
        }
    
    }
    
    // Increment Y Coordinate
    scr_draw_settings_increment();
    
    
} 



#define scr_draw_settings_slider_button
///scr_draw_settings_slider_button(toggle_spr, function_id, ease) 


var toggle_spr = argument0;
var function_id = argument1;
var ease = argument2;

// Skip Button
if toggle_spr == noone {
    exit;
    //continue
}

//Draw Sound Toggles
toggle_x = GAME_MID_X - line_w + toggleXOffset +(600)*(1-ease); ; //maybe add ease coords here
toggle_y = sliderMidY;

toggle_scale = 1;
toggle_hover = point_in_rectangle(mouse_x,mouse_y, 
              toggle_x-sprite_get_width(toggle_spr)/2*1.25,
              toggle_y-sprite_get_height(toggle_spr)/2*1.25,
              toggle_x+sprite_get_width(toggle_spr)/2*1.25,
              toggle_y+sprite_get_height(toggle_spr)/2*1.25);
//Check if mouse over icon
if toggle_hover and selected[0] == noone and 
   (!touchPad or mouse_check_button(mb_left)) 
    and !TweenExists(mainTween)
{
    //Disable increase scale when hovered/clicked
    toggle_scale *= 1.25;
    //On Icon Press
    if mouse_check_button_pressed(mb_left) and selected[1] == true
    {
        //Call Switch Code for this menu choice
        selected[1] = false
        ScheduleScript(id,1,.25 ,scr_delayed_selection,selected,function_id)
        scr_sound(sd_menu_click,1,false);
    }
   
}

//Draw Sound Icons from Sprite Array
draw_sprite_ext(toggle_spr, 0,toggle_x,toggle_y,toggle_scale,toggle_scale,0,COLORS[8],ease)

#define scr_menu_draw_settinga_set_easers
///scr_menu_draw_settinga_set_easers()

// SubEasers
if true {//TweenExists(mainTween) {// and TweenIsPlaying(mainTween) {
    subEase[0] = EaseOutBack(clamp(mainEase[0],0,1), 0, 1, 1)
    subEase[1] = clamp(mainEase[0]-0.5,0,1)
    //subEase[2] = EaseOutBack(clamp(mainEase[0]-1.0,0,1), 0, 1, 1);
    
    //Category Eases
    cat_len = array_length_1d(menu)+1;
    for(i = 0; i < cat_len;i++) {
        baseEase = ((mainEase[0] - 1) * cat_len) - (i)
        subEase[i+2] = clamp(baseEase,0,1)
    
    }

}
#define scr_menu_draw_settings_baseline
///scr_menu_draw_settings_baseline()

settings_h = 180;// * RU//170;  

draw_set_font(fnt_menu_bn_40_bold);
category_h = string_height("S");

arrows_w = string_width("55 x 55") + sprite_get_width(s_v_rightarrow)*2 * 1.25
arrows_inner_w = string_width("55 x 55") / 2 * 1.25; //1.8
arrow_w = sprite_get_width(s_v_leftarrow)*1;
arrow_h = sprite_get_height(s_v_leftarrow)*1;

draw_set_font(CountsFont);
counts_h = string_height("S");
    
desc_w = line_w*2 - arrows_w - category_h*1.0//25;
category_y = line_y + 50;// - settings_h//* RU + settings_h*(i);

#define scr_menu_draw_settings_categories
///scr_menu_draw_settings_categories()


//Settings Data 
menu_data = menu[i];    

// Draw Settings Category
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fnt_menu_bn_40_bold);
category_x = GAME_MID_X - line_w +(600)*(1-subEase[i+2]); 
category_text = menu_data[0];
draw_text_ext_transformed_colour(category_x, category_y, 
category_text, -1, -1, 1, 1, 0, COLORS[0], COLORS[0], COLORS[0], COLORS[0], 1);


#define scr_menu_draw_slider_coordinates
///scr_menu_draw_slider_coordinates


sliderH = 50;
toggleXOffset = 30;//sprite_get_xoffset(music_spr[0]);
toggleW = toggleXOffset * 3 * 1.25;
sliderW = (line_w*2 - toggleW);
sliderMidX = GAME_MID_X - line_w + toggleW + sliderW/2 +(600)*(1-subEase[i+1]) ; //GAME_X +
sliderMidY = category_y + settings_h/2+5;


#define scr_draw_settings_increment
///scr_draw_settings_increment()


category_y += settings_h * ( 1 - .15 * (menu_data[1] >= 2));

#define scr_menu_draw_toggler_coordinates
///scr_menu_draw_toggler_coordinates()


// Set Coordinates and Scale of Toggler
togglerSize = 50;//60;
togglerScale = togglerSize / sprite_get_height(spr_toggle_on) * subEase[i+1];

togglerH = togglerScale * sprite_get_height(spr_toggle_on);
togglerW = togglerScale * sprite_get_width(spr_toggle_on);
togglerX = GAME_MID_X + line_w - togglerW/2 +(600)*(1-subEase[i+1]);
togglerY = category_y + category_h * .6;







#define scr_draw_settings_toggler_button
///scr_draw_settings_toggler_button(toggle_state, function_id, ease) 


var toggle_state = argument0;
var function_id = argument1;
var ease = argument2;

// Set Toggle Sprite & Color
if toggle_state {
    toggle_spr = spr_toggle_on;
} else {
    toggle_spr = spr_toggle_off;
}


toggle_hover = point_in_rectangle(mouse_x,mouse_y, 
                  togglerX-togglerW/2,
                  togglerY-togglerH/2,
                  togglerX+togglerW/2,
                  togglerY+togglerH/2);
//Check if mouse over icon
if toggle_hover and selected[0] == noone and 
   (!touchPad or mouse_check_button(mb_left)) 
    and !TweenExists(mainTween)
{
    //On Icon Press
    if mouse_check_button_pressed(mb_left) and selected[1] == true
    {
        //Call Switch Code for this menu choice
        selected[1] = false
        ScheduleScript(id,1,.25 ,scr_delayed_selection,selected,function_id)
        scr_sound(sd_menu_click,1,false);
    }
   
}

//Draw Sound Icons from Sprite Array
draw_sprite_ext(toggle_spr, 0,togglerX,togglerY,togglerScale,togglerScale,0,COLORS[8],ease)