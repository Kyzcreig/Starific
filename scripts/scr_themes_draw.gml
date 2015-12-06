#define scr_themes_draw
///scr_themes_draw(inner_width, draw_start_y, ease)



var inner_width = argument0;
var start_y = argument1;
var ease = argument2;
theme_y = start_y +50; 
mouse_on_themes = ScrollStartY < mouse_y and ScrollEndY > mouse_y;




// For Each Type
var data;
// For Each Theme
for (var i = 0; i < UNLOCKS_DATA_SIZES[3]; i++ ){
    // Get Theme Data
    data = scr_unlock_get_data(3,i);
    
    //Cache Unlock Bool
    theme_unlocked = data[1] > 0;
    theme_available = data[1] != 0;
    
    
    //Draw Rectangle 
    rect_scale = ease; //ease scaling
    rect_w = inner_width * 2 * rect_scale;
    rect_h = 100 * RU * rect_scale; //arbitrary choice for 100
    rect_x = GAME_W/2 - inner_width * rect_scale// + rect_ease;
    rect_y = theme_y;
    rect_spr = s_v_background_solid_menu;
    rect_alpha = 1 //* (ease > 0)
    rect_col = mColors[6, i];
    draw_sprite_stretched_ext(rect_spr, 0, rect_x, rect_y, rect_w, rect_h, rect_col, rect_alpha)


    
    //Draw Name
    draw_set_font(fnt_gui_options8)
    draw_set_halign(fa_right);
    draw_set_valign(fa_top);
    name_text = data[5];
    name_scale = rect_scale;
    name_w = string_width(name_text)
    name_h = string_height(name_text)
    name_margin = name_h * name_scale * .1;
    name_x = rect_x + rect_w - name_margin*2;
    name_y = rect_y + name_margin;
    name_col = mColors[0, i];
    name_alpha = rect_alpha;
    draw_text_ext_transformed_colour(name_x, name_y, name_text, 
                            -1,-1,name_scale,name_scale,0,
                            name_col,name_col,name_col,name_col,name_alpha) 

                            
    // Draw Deflectors
    def_scale = rect_scale;
    def_margin = 6 * RU * def_scale;
    def_size = 40 * RU * def_scale;
    def_gap = (rect_h - (def_size+def_margin) * 2) ;
    def_x = rect_x + def_margin;
    def_y = rect_y + def_margin;
    scr_themes_draw_deflectors(def_x,def_y, theme_available, i, def_size, def_gap, def_scale)
    
    //Set Description Stuff
    draw_set_font(fnt_gui_options7 ) ///try other fonts  fnt_gui_counts1
    draw_set_halign(fa_right);
    
    // If Unlocked
    if theme_unlocked {
        //Get Played Games Description
        sub_text = "games: "+string(data[9]);
        
        
        //If New Draw "NEW!" Text
        if scr_unlock_is_new(data){ 
        
            //Draw New Text  
            draw_set_valign(fa_middle);
            new_text = "new!"
            new_x = name_x - name_w - name_margin*2;
            new_y = name_y + name_h * .5;
            new_col = mColors[scr_flashing_color_index(10), i];
            draw_text_ext_transformed_colour(new_x, new_y, new_text, 
                                    -1,-1,name_scale,name_scale,0,
                                    new_col,new_col,new_col,new_col,name_alpha);
            
            //Check if New Theme Has Never Been Seen
            if data[2] == 0 {
                // Check if Theme is Visible on Screen
                if !TweenExists(mainTween) and 
                    theme_y >= 0 and 
                    theme_y <= ScrollDisplayH 
                {
                    
                    //Decrement New Count
                    unlockCounts[@ 2]--;
                    
                    //Update Views
                    data[@ 2] -= 1;
                }
            } 
        }
    
    }
    // Else if Locked
    else {
        sub_text = data[8];
    }
    
    // Draw Description
    draw_set_valign(fa_top);
    sub_x = name_x //- name_h*.1;
    sub_y = name_y + name_h*1;//rect_y + rect_h - name_margin;
    sub_w = rect_w * .5;
    draw_text_ext_transformed_colour(sub_x, sub_y, sub_text, 
                            -1,sub_w,name_scale,name_scale,0,
                            name_col,name_col,name_col,name_col,name_alpha) 
    
    
    
    //If Tapped (and not scrolling), Select Theme
    if SWIPE_TAP  and !TweenExists(mainTween) and mouse_on_themes
    {
        // Check If Mouse is Over Current Theme
        rect_hover =  point_in_rectangle(mouse_x,mouse_y,
            //scroll_convert_x_to_sx(mouse_x, GAME_X), //no longer needed
            //scroll_convert_y_to_sy(mouse_y, ScrollStartY),  //no longer needed
            rect_x, rect_y, rect_x + rect_w, rect_y + rect_h);
        // Check if Mouse Coordinates are Valud
        if rect_hover
        {
            //Track Analytics
            analytics_button_counter("Options-ThemeChosen");
            
            //Change current theme
            CURSKIN = i;
            
            //If Theme Available
            if theme_available{
                // If During Game Pause Flag Color Changer for Pause Screenshot
                if GAME_PAUSE {mColorsChanger = true;}
                
                //Save New Current Skin
                ini_open("scores.ini")
                    ini_write_real("settings", "CURSKIN", CURSKIN);
                    
                    //Increment File View Count
                    scr_unlock_update_views_file(data);
                ini_close()
                
                // Set Easing Flag
                SKIN_LOCKED_FLAG = false;
            }
            else{
                // Set Easing Flag
                SKIN_LOCKED_FLAG = true;
            }
    
            //Color Easer
            scr_color_easer(.5)
            
            //Click Sound
            scr_sound(sd_menu_click);
        }
    
    }
    
    //Get Selected Rectangle Coords
    if CURSKIN == i{
        selected_x1 = rect_x;
        selected_y1 = rect_y;
        selected_x2 = rect_x + rect_w;
        selected_y2 = rect_y + rect_h;
        
    }
    
    
    //Increment Theme Y
    theme_y += rect_h;
    
}

//Draw Selection Rectangle
if (ease > 0) {
    selected_w = 12 * ease;
    draw_rectangle_outline_width_ext(selected_x1, selected_y1, selected_x2, selected_y2, selected_w, COLORS[0], 1, 0);
}



return theme_y;



#define scr_themes_draw_deflectors
///scr_themes_draw_deflectors(x,y, unlocked, theme_index, def_size, gap_size, def_scale)


var def_x = argument0;
var def_y = argument1;
var unlocked = argument2;
var theme_index = argument3;
var def_size = argument4;
var def_gap = argument5;
var def_scale = argument6;


// If Locked
if !unlocked {
    //Draw Pad Lock Centered
    lock_h = def_size * 2 + def_gap;
    lock_h *= .9; //further downscaling
    lock_scale = lock_h / 100; //we assume sprite is 100px
    lock_x = def_x + (def_size * 1.5 + def_gap) ;
    lock_y = def_y + (def_size * 1 + def_gap/2) ;
    lock_col = mColors[0,theme_index];
    lock_alpha = .5;
    draw_sprite_ext(s_v_padlock_100,0,lock_x,lock_y,
                    lock_scale,lock_scale,0,lock_col,lock_alpha)


    exit;
}

// Get Coordinate Data
var spr_xy_data = scr_themes_get_deflector_xy(def_x, def_y, def_size, def_gap)
// Draw Sprites
var spr_x, spr_y;
for (var z = 0; z < 6; z++){
    // Get Draw Data
    spr = scr_themes_index_to_sprite(z);
    spr_xy = spr_xy_data[z];
    spr_size = def_size * scr_themes_get_sprite_size(z)
    spr_x = spr_xy[0] - spr_size/2;
    spr_y = spr_xy[1] - spr_size/2;
    // Get Color
    spr_col = mColors[scr_themes_index_to_color(z, unlocked), theme_index];

    // Draw Sprite
    draw_sprite_stretched_ext(spr, 0, spr_x, spr_y, spr_size, spr_size, spr_col, 1);
    
    /*
    // Draw Padlocks if Locked
    if !unlocked {
        lock_x = spr_xy[0];
        lock_y = spr_xy[1];
        lock_col = mColors[6,theme_index];
        lock_scale = def_scale * .70;
        draw_sprite_ext(spr_symbol_locked,0,lock_x,lock_y,
                        lock_scale,lock_scale,0,lock_col,1)
    }*/

}
 


#define scr_themes_index_to_sprite
///scr_themes_index_to_sprite(def_type)

var tmp;

switch argument0 {

case 0:
    tmp = s_v_star_menu//s_v_star_white//object_get_sprite(obj_star);
break;


case 1:
    tmp = s_v_deflector_basic_40//object_get_sprite(obj_reflector_parent_basic);
break;


case 2:
    tmp = s_v_deflector_bomb_40//object_get_sprite(obj_powerup_parent_bomb);
break;


case 3:
    tmp = s_v_deflector_upper_40//object_get_sprite(obj_powerup_parent_ups);
break;

case 4:
    tmp = s_v_deflector_rounder_40//object_get_sprite(obj_powerup_parent_neutral);
break;

case 5:
    tmp = s_v_deflector_downer_40//object_get_sprite(obj_powerup_parent_downs);
break;


}

return tmp;

#define scr_themes_index_to_color
///scr_themes_index_to_color(def_type, disoovered)

if !argument1{
    return 0;
}

var tmp;

switch argument0 {

case 0:
    tmp = 0
break;


case 1:
    tmp = 5
break;


case 2:
    tmp = 4
break;


case 3:
    tmp = 1
break;

case 4:
    tmp = 3
break;

case 5:
    tmp = 2
break;


}

return tmp;

#define scr_themes_get_deflector_xy
///scr_themes_get_deflector_xy(start_x, start_y, spr_size, gap_size)


var start_x = argument0;
var start_y = argument1;
var spr_size = argument2;
var gap_size = argument3;

var returnArray, column, row;

for (var k = 0; k < 6; k++){
    var subArray = noone;
    // Get Row and Column
    column = (k mod 3);
    row = (k div 3);
    // Add Appropriate Sprite Size and Gap Size for Each Row/Column
    subArray[0] = start_x + spr_size/2 * (1 + 2 * column) + gap_size * column;
    subArray[1] = start_y + spr_size/2 * (1 + 2 * row) + gap_size * row;    
    // Add to Return Array
    returnArray[k] = subArray;    
}



return returnArray;



#define scr_themes_get_sprite_size
///scr_themes_get_sprite_size(index)


var tmp;

switch argument0 {

// Star Sized Up
case 0:
    tmp = 1.2 //1 nb:I'd like to try size 1 and see how it looks.
break;
//Regular Deflectors
case 1:
case 2:
    tmp = 1
break;

//Bottom Row is Sized Down
case 3:
case 4:
case 5:
    tmp = .9
break;


}

return tmp;
#define scr_flashing_color_index
///scr_flashing_color_index(flashes_per_second)


var flashes_per_second = argument0;
var flash_interval = room_speed / flashes_per_second;
var col_index = (STEP div flash_interval) mod 6;

return col_index;