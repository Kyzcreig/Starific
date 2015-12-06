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

    // Draw Category Title
    draw_set_valign(fa_middle);
    switch text_align {
    case -1: 
        draw_set_halign(fa_left);
        cat_text_x = GAME_W/2 - inner_width;
    break;
    case 0: 
        draw_set_halign(fa_center);
        cat_text_x = GAME_W/2;
    break;
    case 1: 
        draw_set_halign(fa_right);
        cat_text_x = GAME_W/2 + inner_width;
            //We use GAME_W/2 instead of GAME_MID_X because we're on a scroll surface
    break;
    }    
    draw_set_font(subArray[3]);
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
        def_list = subArray[1];
        def_wrap = subArray[2];
        
        def_w = 60 * RU;
        def_h = def_w;
        def_upscale = 1 //6/4; 
        def_w_gap = 2*(inner_width - def_w/2) / (5 - 1);
        def_h_gap = def_w_gap * 1.1; //
        def_x_start = GAME_MID_X - inner_width// + def_w/2;
        
        //Iterate Through List
        for (var k = 0, o = ds_list_size(def_list); k < o; k++){
            def_data = def_list[| k];
            //Set Object Type and Sprite
            def_type = scr_deflector_set_draw_type(def_data);
            def_spr = scr_codex_get_sprite(def_type);
            //Get Lock Status
            def_discovered = def_data[11];
            
            // Set Symbol
            if def_discovered != 0{
                def_symbol = def_data[4];
            } else {
                def_symbol = spr_power_locked//padlock
            }
            def_draw_sym = sprite_exists(def_symbol);
            // Get Colors
            def_col = power_type_colors(def_type,0);
            def_col_sym = power_type_colors(def_type,1);
            // Get Scale
            def_scale = def_upscale * ease;
            def_scale_sym = ease;
            
            // Get Coordinates
            def_x = def_x_start + def_w/2 + def_w_gap * (k mod def_wrap);
            def_y = cat_text_y + def_h/2 + def_h_gap * (k div def_wrap);
            
            //Draw Deflector
            draw_sprite_ext(def_spr, 0, def_x, def_y, def_scale, def_scale, 0, def_col, 1); 
    
            //Draw Symbol
            if def_draw_sym {
                draw_sprite_ext(def_symbol, 0, def_x, def_y, def_scale_sym, def_scale_sym, 0, def_col_sym, 1); 
            }
            
            // Draw "NEW!"
            if abs(def_discovered) == 1 {
                // Draw NewMark in Top Right
                nm_scl = def_scale * .5;
                nm_spr = spr_button_basic_game;
                nm_spr_h = sprite_get_height(nm_spr) * nm_scl;
                nm_x = def_x + def_w / 2 * def_scale; 
                nm_y = def_y - def_h / 2 * def_scale; // + nm_spr_h / 2;
                // Draw Note Sprite
                draw_sprite_ext(nm_spr, 0, nm_x, nm_y, nm_scl, nm_scl, 0, COLORS[0], 1);
                
                // Draw New Text
                draw_set_halign(fa_center);
                draw_set_font(fnt_gui_counts3);
                nm_txt = "new!";
                nm_txt_y = nm_y //- .1 * string_height(nm_txt) * nm_scl;
                nm_col = COLORS[scr_flashing_color_index(10)];
                draw_text_ext_transformed_colour(nm_x, nm_txt_y, nm_txt, -1, -1, 
                                nm_scl, nm_scl, 0, nm_col,nm_col,nm_col,nm_col, 1);
                                
                //Check if New Codex Has Never Been Seen
                if def_discovered == 1 {
                    
                    // Check if Deflector is Visible on Screen
                    if !TweenExists(mainTween) and 
                        def_y >= 0 and 
                        def_y <= ScrollDisplayH 
                    {
                        // Decrement New Count
                        unlockCounts[@ 2]--;
                        
                        // Mark Deflector as Seen
                        def_data[@ 11] = -1;
                    }
                    
                }
                
            }
            
            
            //Draw Deflector Text
            draw_set_halign(fa_center);
            draw_set_font(fnt_gui_counts3);
            def_txt = def_data[5];
            if def_discovered == 0 {
                def_txt = scr_cypher_text("abcdefghijklmnopqrstuvwxyz-+$1234567890","?",def_txt);
            } 
            def_txt_scale = ease;
            def_txt_h = string_height(def_txt) * def_txt_scale;
            def_txt_x = def_x;
            def_txt_y = def_y + def_h/2 + def_txt_h * .6;
            def_txt_col = COLORS[0];
            draw_text_ext_transformed_colour(def_txt_x, def_txt_y, def_txt, 
                                    -1,-1,def_txt_scale,def_txt_scale,0,
                                    def_txt_col,def_txt_col,def_txt_col,def_txt_col,1)

        }
        
        // Increment Y Coordinate
        cat_text_y = def_txt_y + def_txt_h/2;

    
    }
}


return cat_text_y;











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

var key, def_data, def_list, tmp, subArray;

//Iterate through each first dimension
for (var i = 0, n = array_length_1d(mainArray); i < n; i++){
    subArray = mainArray[i];
    //Recurse through sub arrays
    if is_array(subArray[1]){
        scr_codex_get_counts(subArray[1], counts);
    }
    //Interate through Lists
    else if ds_exists(subArray[1], ds_type_list) {
        def_list = subArray[1];
        for (var j = 0, m = ds_list_size(def_list); j < m; j++){
            def_data = def_list[| j];
            //Increment Total
            counts[@ 0] += 1;
            //Increment Unlocked
            if def_data[11] > 0 {
                counts[@ 1] += 1;
                //Increment New
                if def_data[11] == 1 {
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