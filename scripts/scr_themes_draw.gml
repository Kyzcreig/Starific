#define scr_themes_draw
///scr_themes_draw(inner_width, draw_start_y, ease)



var inner_width = argument0;
var start_y = argument1;
var ease = argument2;
theme_y = start_y +50; 
mouse_on_themes = ScrollStartY < mouse_y and ScrollEndY > mouse_y;

/*
if FULL_SECOND_INTERVAL == 1 {
    if IAP_ENABLED {
        iap_store_state = iap_status();
    } else {
        iap_store_state = iap_status_unavailable;
    }
}
*/


// For Each Type
var data;
// For Each Theme
for (var index = 0; index < UNLOCKS_DATA_SIZES[3]; index++ ){
    // Get Theme Data
    data = scr_unlock_get_data(3,index);
    
    //Cache Unlock Bool
    theme_unlocked = data[1] > 0;
    theme_available = data[1] != 0;
    
    
    //Draw Rectangle 
    rect_scale = ease; //ease scaling
    rect_w = inner_width * 2 * rect_scale;
    rect_h = 100 * rect_scale; //arbitrary choice for 100
    rect_x = GAME_MID_X - inner_width * rect_scale// + rect_ease;
    rect_y = theme_y;
    rect_spr = s_v_background_solid_menu;
    rect_alpha = 1 //* (ease > 0)
    rect_col = mColors[6, index];
    draw_sprite_stretched_ext(rect_spr, 0, rect_x, rect_y, rect_w, rect_h, rect_col, rect_alpha)


    
    //Draw Name
    draw_set_font(fnt_menu_bn_26_black)
    draw_set_halign(fa_right);
    draw_set_valign(fa_top);
    name_text = data[5];
    name_scale = rect_scale;
    name_w = string_width(name_text)
    name_h = string_height(name_text)
    name_margin = name_h * name_scale * .1;
    name_x = rect_x + rect_w - name_margin*2;
    name_y = rect_y + name_margin;
    name_col = mColors[0, index];
    name_alpha = rect_alpha;
    draw_text_ext_transformed_colour(name_x, name_y, name_text, 
                            -1,-1,name_scale,name_scale,0,
                            name_col,name_col,name_col,name_col,name_alpha) 

                            
    // Draw Deflectors (Or Buy Button Or PadLock)
    def_scale = rect_scale;
    def_margin = 6 * def_scale;
    def_size = 40 * def_scale;
    def_gap = (rect_h - (def_size+def_margin) * 2);
    def_x = rect_x + def_margin;
    def_y = rect_y + def_margin;
    scr_themes_draw_deflectors(def_x,def_y, theme_available, index, def_size, def_gap, def_scale);
    
    //Set Description Stuff
    draw_set_font(fnt_menu_bn_15_black ) ///try other fonts  fnt_game_bn_20_black
    draw_set_halign(fa_right);
    draw_set_valign(fa_top);
    
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
            new_col = mColors[scr_flashing_color_index(10), index];
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
    if SWIPE_TAP and !TweenExists(mainTween) and mouse_on_themes
    {
        // Check If Mouse is Over Current Theme
        rect_hover =  point_in_rectangle(mouse_x,mouse_y,
                    rect_x, rect_y, rect_x + rect_w, rect_y + rect_h);
            //scroll_convert_x_to_sx(mouse_x, GAME_X), //no longer needed
            //scroll_convert_y_to_sy(mouse_y, ScrollStartY),  //no longer needed
        // Check if Mouse Coordinates are Valud
        if rect_hover
        {
            //Track Analytics
            analytics_button_counter("Options-ThemeChosen");
            
            //Change current theme
            CURSKIN = index;
            
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
    if CURSKIN == index{
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
///scr_themes_draw_deflectors(def_x,def_y, unlocked, theme_index, def_size, gap_size, def_scale)


var def_x = argument0;
var def_y = argument1;
var unlocked = argument2;
var theme_index = argument3;
var def_size = argument4;
var def_gap = argument5;
var def_scale = argument6;

    
        

// If Locked
if !unlocked {

    //Set Sprite Parameters (Centered)
    btn_h = def_size * 2 + def_gap;
    btn_h *= .9; //further downscaling
    btn_scale = btn_h / 100; //we assume sprite is 100px tall
    btn_y = def_y + (def_size * 1 + def_gap/2) ;
    btn_col = mColors[0,theme_index];
    
    // If Theme IAPs Enabled
    if IAP_ENABLED {
        // Set Sprite to Buy Button 
        btn_spr = sp_button_buy;//s_v_buy_theme_099;
        btn_alpha = 1;//.65;
        btn_w = sprite_get_width(btn_spr)*btn_scale;
        btn_x = def_x + btn_w*.5 + def_gap;
        
        //If Page Tapped (and not scrolling)
        if SWIPE_TAP and !TweenExists(mainTween) and mouse_on_themes
        {
            // Check If Mouse is Over Buy Button
            btn_hover =  point_in_rectangle(mouse_x,mouse_y,
                            btn_x-btn_w/2, btn_y-btn_h/2, 
                            btn_x+btn_w/2, btn_y+btn_h/2);
            // Check if Mouse Coordinates are Valid
            if btn_hover
            {
                //Track Analytics
                analytics_button_counter("Options-ThemeBuyClick", "theme_index,"+string(theme_index));
                
                //Process IAP
                //var store_status = iap_status();
                var acquire_status = false//scr_iap_acquire("theme_"+string(theme_index), iap_store_state);
                show_debug_message("Theme Buy Button Tapped: "
                                +str_debug("theme_index",theme_index)
                                +str_debug("acquire_status",acquire_status)
                                +str_debug("SWIPE_TAP",SWIPE_TAP)
                                +str_debug("mouse_on_themes",mouse_on_themes)
                                +str_debug("def_x",def_x)
                                +str_debug("def_y",def_y)
                                +str_debug("id",id) //ARE TWO THEME UI CONTROLLERS BEING SPAWNED?
                                );
                //if !store_available {} 
                // Theme Not Equipped on Buy Button Click
                //SWIPE_TAP = false;
                //mouse_clear(mb_left)
                mouse_on_themes = false; // Flag to prevent theme being equipped
                //Click Sound
                scr_sound(sd_menu_click);
                    
            }
        }
            
        // Draw Buy Button  
        draw_sprite_ext(btn_spr,0,btn_x,btn_y,
                    btn_scale,btn_scale,0,btn_col,btn_alpha)
        // Draw Cart Icon
        cart_spr = sp_store_cart_40;
        cart_scale = 1 * def_scale
        cart_w = sprite_get_width(cart_spr) * cart_scale;
        cart_x = btn_x - btn_w * .5 +cart_w *.5 + def_gap;
        cart_y = btn_y;
        cart_col = mColors[6,theme_index];
        draw_sprite_ext(cart_spr,0,cart_x,cart_y,
                    btn_scale,btn_scale,0,cart_col,1)
        
        // Draw Price Text
        draw_set_font(fnt_menu_bn_20_black);
        draw_set_valign(fa_middle);
        draw_set_halign(fa_right);
        price_text = scr_iap_get_price("theme_"+string(theme_index), "$.99");
        price_w = string_width(price_text) * def_scale;
        price_h = string_height("H") * def_scale;
        price_x = btn_x + btn_w * .5 - def_gap*1.5;
        price_y = btn_y - price_h * .15;
        price_yscale = 1 * def_scale;
        price_w_max = btn_w - cart_w - def_gap*2.5;
        if price_w > price_w_max {
            // Squeeze Width to Fit
            price_xscale = price_w_max / price_w;
        } else {
            // Use Normal Width
            price_xscale = price_yscale;
        }
        draw_text_transformed_colour(price_x, price_y, price_text, 
            price_xscale,price_yscale, 0, cart_col, cart_col, cart_col, cart_col, 1);
    }
    // Else If No IAPs 
    else {
        // Set Pad Lock Sprite Parameters
        btn_spr = s_v_padbtn_100;
        btn_w = btn_h;
        btn_x = def_x + (def_size * 1.5 + def_gap) ;
        btn_alpha = .5;
        // Draw Lock Pad  
        draw_sprite_ext(btn_spr,0,btn_x,btn_y,
                        btn_scale,btn_scale,0,btn_col,btn_alpha)
    }
    


} else {
    
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
#define scr_themes_init
///scr_themes_init()

title_txt = "themes";


// Get Theme Locked Counts
ini_open("scores.ini")
    unlockCounts[0] = 0; //total
    unlockCounts[1] = 0; //progress
    unlockCounts[2] = 0; //new
    unlockCounts = scr_unlock_get_type_counts("3");
    // [0] = total; [1] = unlocked; [2] = new;
    
    // Set Unlocks Criteria Text
    scr_unlock_set_description("3");
ini_close();


