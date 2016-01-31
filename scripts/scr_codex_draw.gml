#define scr_codex_draw
///scr_codex_draw(array, inner_width, y_start, text_align, ease)
/// 0 = center; -1 = left; 1 = right



var mainArray = argument0;
var inner_width = argument1;
var y_start = argument2;
var text_align = argument3;
var ease = argument4;
cat_text_y = y_start;


//NB: I may need to take into consideration the recursion for the total scroll size

//Iterate through each first dimension
for (var i = 0, n = array_length_1d(mainArray); i < n; i++){
    // Get Data
    var subArray = mainArray[i];
    var subFont = subArray[3];

    // Draw Category Title
    draw_set_font(subFont);
    draw_set_valign(fa_middle);
    switch text_align {
    case -1: 
        draw_set_halign(fa_left);
        cat_text_x = GAME_MID_X - inner_width;
    break;
    case 0: 
        draw_set_halign(fa_center);
        cat_text_x = GAME_MID_X;
    break;
    case 1: 
        draw_set_halign(fa_right);
        cat_text_x = GAME_MID_X + inner_width;
            //We use GAME_W/2 instead of GAME_MID_X because we're on a scroll surface
    break;
    }    
    cat_text = subArray[0];
    cat_text_scale = ease;
    cat_text_h = string_height("S") * cat_text_scale
    cat_text_y_adj = cat_text_h * 1.2 ;
    cat_text_y += cat_text_y_adj;
    cat_text_col = COLORS[0];
    draw_text_ext_transformed_colour(cat_text_x, cat_text_y, cat_text, 
                            -1,-1,cat_text_scale,cat_text_scale,0,
                            cat_text_col,cat_text_col,cat_text_col,cat_text_col,1) 

    // Increment Y Coordinate
        // Add Some space under category text
    cat_text_y += cat_text_y_adj * .2;
    
    //Recurse through sub categories
    if is_array(subArray[1]){
        scr_codex_draw(subArray[1], inner_width, cat_text_y, -1, ease);
    }
    // Draw Sprites, wrapped
    else if ds_exists(subArray[1], ds_type_list) {
        cat_text_y += cat_text_h;
        item_list = subArray[1];
        item_wrap = subArray[2];
        item_list_type = subArray[4];
        
        item_w = 60 * RU;
        item_h = item_w;
        item_upscale = 1 //6/4; 
        item_w_gap = 2*(inner_width - item_w/2) / (5 - 1);
        item_h_gap = item_w_gap * 1.1; //
        item_x_start = GAME_MID_X - inner_width// + item_w/2;
        
        //Iterate Through List
        for (var k = 0, o = ds_list_size(item_list); k < o; k++){
            item_data = item_list[| k];
            // If Deflector 
            if item_list_type == 0 {
                //Set Object Type and Sprites  
                item_type = scr_deflector_set_draw_type(item_data); 
                item_spr = scr_codex_get_sprite(item_type); 
                item_symbol = item_data[4]; 
                // Get Colors
                item_col = power_type_colors(item_type,0); 
                item_col_sym = power_type_colors(item_type,1); 
                // Icon Text
                item_txt = item_data[5];
            }
            // If Gamemod 
            else if item_list_type == 1 {
                //Set Object Type and Sprites
                item_type = item_data[1] ; 
                item_spr = s_v_deflector_rounder_60; 
                item_symbol = item_data[5]; 
                // Get Colors
                item_col = power_type_colors(item_type+1, 0);   //+9
                item_col_sym = power_type_colors(item_type+1, 1); //+9
                // Icon Text
                item_txt = item_data[6];
            }
            //Get Lock Status
            item_discovered = item_data[11]; 
                    //NB: 0 == locked, 1 == new, 2 == seen
            
            // If Never Discovered
            if item_discovered == 0 {
                //Lock Sprite
                item_symbol = spr_power_locked//padlock
            }
            item_draw_sym = sprite_exists(item_symbol);
            
            // Get Scale
            item_scale = item_upscale * ease;
            item_scale_sym = ease;
            
            // Get Coordinates
            item_x = item_x_start + item_w/2 + item_w_gap * (k mod item_wrap);
            item_y = cat_text_y + item_h/2 + item_h_gap * (k div item_wrap);
            
            //Draw item sprite
            draw_sprite_ext(item_spr, 0, item_x, item_y, item_scale, item_scale, 0, item_col, 1); 
    
            //Draw Symbol
            if item_draw_sym {
                draw_sprite_ext(item_symbol, 0, item_x, item_y, item_scale_sym, item_scale_sym, 0, item_col_sym, 1); 
            }
            
            // Draw "NEW!"
            if abs(item_discovered) == 1 {
                // Draw NewMark in Top Right
                nm_scl = item_scale * .2//.5;
                nm_spr = spr_button_basic_double_game;
                nm_spr_h = sprite_get_height(nm_spr) * nm_scl;
                nm_x = item_x + item_w / 2 * item_scale; 
                nm_y = item_y - item_h / 2 * item_scale; // + nm_spr_h / 2;
                // Draw Note Sprite
                draw_sprite_ext(nm_spr, 0, nm_x, nm_y, nm_scl, nm_scl, 0, COLORS[0], 1);
                
                // Draw New Text
                draw_set_font(fnt_game_bn_15_black);
                draw_set_valign(fa_middle);
                draw_set_halign(fa_center);
                nm_txt = "new!";
                nm_txt_scl = item_scale * .5;
                nm_txt_y = nm_y - .15 * string_height(nm_txt) * nm_txt_scl;
                nm_col = COLORS[scr_flashing_color_index(10)];
                draw_text_ext_transformed_colour(nm_x, nm_txt_y, nm_txt, -1, -1, 
                                nm_txt_scl, nm_txt_scl, 0, nm_col,nm_col,nm_col,nm_col, 1);
                                
                //Check if New Codex Has Never Been Seen
                if item_discovered == 1 {
                    
                    // Check if Deflector is Visible on Screen
                    if !TweenExists(mainTween) and 
                        item_y >= 0 and 
                        item_y <= ScrollDisplayH 
                    {
                        // Decrement New Count
                        unlockCounts[@ 2]--;
                        
                        // Mark Deflector as Seen
                        item_data[@ 11] = -1;
                    }
                    
                }
                
            }
            
            
            //Draw Deflector Text
            draw_set_font(fnt_game_bn_15_black);
            draw_set_valign(fa_middle);
            draw_set_halign(fa_center);
            if item_discovered == 0 {
                item_txt = scr_cypher_text("abcdefghijklmnopqrstuvwxyz-+$1234567890"+CASH_STR,"?",item_txt);
            } 
            item_txt_scale = ease;
            item_txt_h = string_height(item_txt) * item_txt_scale;
            item_txt_x = item_x;
            item_txt_y = item_y + item_h/2 + item_txt_h * .6;
            item_txt_col = COLORS[0];
            draw_text_ext_transformed_colour(item_txt_x, item_txt_y, item_txt, 
                                    -1,-1,item_txt_scale,item_txt_scale,0,
                                    item_txt_col,item_txt_col,item_txt_col,item_txt_col,1)

        }
        
        // Increment Y Coordinate
        cat_text_y = item_txt_y + item_txt_h/2;

    
    }
}


return cat_text_y;











#define scr_codex_init
///scr_codex_init()

///Codex Page

//Overwrite fonts to be used to be game fonts, not menu fonts
        //NB: We use game texture page here for all the game icon symbols.
title_txt = "codex";
title_font = fnt_game_title_95; 
counts_font = fnt_game_bn_40_bold;


codex_categories = noone;
codex_sub_simple = noone;
codex_sub_uppers = noone;
codex_sub_downers = noone;
//codex_sub_rounders = noone;
codex_sub_mods = noone;



// Set Up Data to Draw  
                    //label, array/list of deflectors, wrap_width, font
codex_sub_simple[0] = Array("basic",scr_deflector_get_list("0","0", true),4,fnt_game_bn_26_black, 0);
codex_sub_simple[1] = Array("bombs",scr_deflector_get_list("4","0", true),4,fnt_game_bn_26_black, 0);
codex_categories[0] =  Array("simple",codex_sub_simple,5,fnt_game_bn_40_bold, 0);


codex_sub_uppers[0] = Array("duration",scr_deflector_get_list("1","1", true),5,fnt_game_bn_26_black, 0);
codex_sub_uppers[1] = Array("tappers",scr_deflector_get_list("1","3", true),5,fnt_game_bn_26_black, 0);
codex_sub_uppers[2] = Array("instant",scr_deflector_get_list("1","0", true),5,fnt_game_bn_26_black, 0);
codex_categories[1] =  Array("uppers",codex_sub_uppers,5,fnt_game_bn_40_bold, 0);

codex_sub_downers[0] = Array("duration",scr_deflector_get_list("2","1", true),5,fnt_game_bn_26_black, 0);
codex_sub_downers[1] = Array("turn modifiers",scr_deflector_get_list("2","2", true),3,fnt_game_bn_26_black, 0);
codex_sub_downers[2] = Array("tappers",scr_deflector_get_list("2","3", true),3,fnt_game_bn_26_black, 0);
codex_sub_downers[3] = Array("instant",scr_deflector_get_list("2","0", true),5,fnt_game_bn_26_black, 0);
codex_categories[2] =  Array("downers",codex_sub_downers,5,fnt_game_bn_40_bold, 0);

codex_categories[3] =  Array("rounders",scr_deflector_get_list("3","0,1,2,3,4", 1),4,fnt_game_bn_40_bold, 0);

codex_sub_mods[0] = Array("buffs",scr_gamemod_get_list("0","0", true),5,fnt_game_bn_26_black, 1);
codex_sub_mods[1] = Array("debuffs",scr_gamemod_get_list("1","0", true),5,fnt_game_bn_26_black, 1);
codex_categories[4] =  Array("mods",codex_sub_mods,5,fnt_game_bn_40_bold, 1);


// Set if Deflector is Locked or Not
ini_open("scores.ini")
    unlockCounts[0] = 0; //total
    unlockCounts[1] = 0; //discovered
    unlockCounts[2] = 0; //new 
    unlockCounts = scr_codex_get_counts(codex_categories, unlockCounts); 
ini_close();





#define scr_codex_clean
///scr_codex_clean(array)

var mainArray = argument0;
var subArray;
//Iterate through each first dimension
for (var i = 0, n = array_length_1d(mainArray); i < n; i++){
    subArray = mainArray[i];
    //Recurse through sub arrays
    if is_array(subArray[1]){
        scr_codex_clean(subArray[1]);
    }
    //Cleanup Lists
    else if ds_exists(subArray[1], ds_type_list) {
        ds_list_destroy(subArray[1]);
    }
}


#define scr_codex_set_locks
///scr_codex_set_locks(array, count_array)

var mainArray = argument0;
var counts = argument1;

var key, def_data, def_list, tmp, subArray;

//Iterate through each first dimension
for (var i = 0, n = array_length_1d(mainArray); i < n; i++){
    subArray = mainArray[i];
    //Recurse through sub arrays
    if is_array(subArray[1]){
        scr_codex_set_locks(subArray[1], counts);
    }
    //Interate through Lists
    else if ds_exists(subArray[1], ds_type_list) {
        //ds_list_destroy(mainArray[i]);
        def_list = subArray[1];
        for (var j = 0, m = ds_list_size(def_list); j < m; j++){
            def_data = def_list[| j];
            def_type = scr_deflector_set_draw_type(def_data);
            def_key = scr_deflector_get_key(def_data[0]);
            // Determine If Projectile Deflector Or Not
            if !scr_deflector_type_is_projectile(def_type){
                //Or Not:  Look up deaths
                 tmp = ini_read_real_MS_total("0,1,2,3", "0,1,2,3", false, "careerDeaths-"+def_key, 0)          
            } else {
                //Projectile:  Look up catches
                 tmp = ini_read_real_MS_total("0,1,2,3", "0,1,2,3", false, "careerCatches-"+def_key, 0)
            }
            // Set Lock Status
            def_data[@ 11] = tmp > 0;
            //Increment Total
            counts[@ 0] += 1;
            //Increment Unlocked
            counts[@ 1] += def_data[11]
        
        }  
    }
}

return counts;



#define scr_codex_get_counts
///scr_codex_get_counts(codex_array, count_array)

var mainArray = argument0;
var counts = argument1;

var key, item_data, item_list, tmp, subArray;

//Iterate through each first dimension
for (var i = 0, n = array_length_1d(mainArray); i < n; i++){
    subArray = mainArray[i];
    //Recurse through sub arrays
    if is_array(subArray[1]){
        scr_codex_get_counts(subArray[1], counts);
    }
    //Interate through Lists
    else if ds_exists(subArray[1], ds_type_list) {
        item_list = subArray[1];
        for (var j = 0, m = ds_list_size(item_list); j < m; j++){
            item_data = item_list[| j];
            //Increment Total
            counts[@ 0] += 1;
            //Increment Unlocked
            if item_data[11] > 0 {
                counts[@ 1] += 1;
                //Increment New
                if item_data[11] == 1 {
                    counts[@ 2] += 1;
                }
            }
        
        }  
    }
}

return counts;



#define scr_deflector_type_is_projectile
///scr_deflector_type_is_projectile(type)


switch argument0{

case 1:
case 2:
case 3:
    return true;
break;

case 0:
case 4:
default:
    return false;
break;


}

#define scr_codex_get_sprite
///scr_codex_get_sprite(type)


switch argument0 {

case -1:
    return s_v_star_white;
break;


case 0:
    return s_v_deflector_basic_60;
break;


case 1:
    return s_v_deflector_upper_60;
break;


case 2:
    return s_v_deflector_downer_60;
break;


case 3:
    return s_v_deflector_rounder_60;
break;

case 4:
    return s_v_deflector_bomb_60;
break;

case 5:
    return s_v_deflector_basic_60;
break;

//Buffs
case 6:
//Debuffs
case 7:
    return s_v_game_mod_60;
break;

default:
    show_message("error get codex sprite")
break;

}

#define scr_deflector_is_discovered
///scr_deflector_is_discovered(data)

var data = argument0;
var tmp;
// If Is Not A projectile
if !scr_deflector_type_is_projectile(data[1]){
    //Look up deaths
     tmp = data[7] > 0;      
} 
// Else Is A Projectile
else {
    //Look up catches
     tmp = data[9] > 0;
}

return tmp;