#define scr_draw_settings_arrows
///scr_draw_settings_arrows(data_type, function_id, current_index, counts_array, name, ease, arrow_ease)


var data_type = argument0;
var function_id = argument1;
var current_index = argument2;
var counts_array = argument3;
var name = argument4;
var ease = argument5;
var arrow_ease = argument6;
var use_cypher = false;

// If Data Type is Grid/Rigor
if data_type >= 0 {
    // Get Data
    var data = scr_unlock_get_data(data_type,current_index);
    
    //Draw Category Unlocks Progress
    scr_draw_settings_progress(counts_array, ease)
    
    // Draw Descripion and Flashing "NEW"
    scr_draw_settings_description(data_type, data, ease);
    
    // If 0 Views on Unlock
    if data[1] == 0 {
        use_cypher = true;
    }
     
    
} 
// If Data Type is Control STyle
else if data_type == -2 {
    // Draw Descripion 
    scr_draw_settings_description(data_type, TP_SENSE[1], ease);
}

// Draw name
scr_draw_settings_name(name, ease);

//Draw Inner Text
scr_draw_settings_inner_text(data_type, current_index, use_cypher, ease);  

    
//Draw Inner Explain Text
scr_draw_settings_explain(data_type, ease); 


            

// Draw Arrows
scr_draw_settings_arrows_helper(function_id, ease, arrow_ease);

#define scr_draw_settings_description
///scr_draw_settings_description(type, data, ease)


var type = argument0;;
var data = argument1;
var ease = argument2;
var desc_text = ""
var col_index = 0;

// Set Font

switch type {

// Control Style
case -2:
    desc_text = scr_control_style_description(TP_SENSE[1]);

break;

// Unlockable Setting
case 0:
case 1: 
case 2:
case 3: 
case 4:
case 5: 
    // If Locked
    if data[1] <= 0{
        // If Locked Draw Description
        desc_text = data[8]
    } else {//if data[2] >= 0 {
        // If New
        if scr_unlock_is_new(data) { 
            col_index = scr_flashing_color_index(10)
            desc_text = "new!#"
        }else {
            desc_text += "games: "+string(data[9]);
        }
    }
break;

}


//Draw Description and/or Games Played
if desc_text != "" {//data[1] == 0{
    draw_set_font(DescriptionFont);
    draw_set_valign(fa_top);
    draw_text_ext_transformed_colour(desc_x, desc_y,//-7 
        desc_text, -1, desc_w, 1, 1, 0, 
        COLORS[col_index], COLORS[col_index], COLORS[col_index], 
        COLORS[col_index], ease);
}

#define scr_draw_settings_progress
///scr_draw_settings_progress(counts_array, ease)

var counts_array = argument0;
var ease = argument1;

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(CountsFont);
counts_text = string(counts_array[1])+"/"+string(counts_array[0]);
// Add "x new text"
if counts_array[2] > 0 {
    counts_text += " +"+string(counts_array[2])//+" new";
}
draw_text_ext_transformed_colour(desc_x, counts_y,
    counts_text, -1, desc_w*1.2, 1, 1, 0, 
    COLORS[0], COLORS[0], COLORS[0], 
    COLORS[0], ease);







#define scr_draw_settings_inner_text
///scr_draw_settings_inner_text(type, index, ease)

var type = argument0;
var index = argument1;
var cypher = argument2;
var ease = argument3;
var inner_text = convert_index_to_val_string(type,index);


//Obfuscated inner text
if cypher { //data[1] == 0{
    inner_text =  scr_cypher_text("0123456789","?",inner_text);  //we'll see if single ? mark works 
}
// Draw Inner Text
draw_set_font(fnt_menu_bn_40_bold);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_ext_transformed_colour(inner_x, inner_y,
    inner_text, -1, -1, 1, 1, 0, 
    COLORS[0], COLORS[0], COLORS[0], 
    COLORS[0], ease);

    














#define scr_draw_settings_new
///scr_draw_settings_new(data, ease)

var data = argument0;
var ease = argument1;

// Check if Never Biewed Before (Note: This Will Mark it As New Even After Seeing it before, until you see it on gameover first.
if scr_unlock_is_new(data) { 
    var text = "new!"
    draw_set_font(DescriptionFont);
    col_index = scr_flashing_color_index(10)
    draw_text_ext_transformed_colour(desc_x, desc_y, //arrows_y -category_h/4,//-7 
        text, -1, desc_w, 1, 1, 0, 
        COLORS[col_index], COLORS[col_index], COLORS[col_index], 
        COLORS[col_index], ease);

}





#define scr_draw_settings_name
///scr_draw_settings_name(name, ease)

var name = argument0;
var ease = argument1;

//Draw Name
draw_set_font(NameFont);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text_ext_transformed_colour(name_x, name_y, 
    name, -1, -1, 1, 1, 0, 
    COLORS[0], COLORS[0], COLORS[0], 
    COLORS[0], ease);

#define scr_settings_update_counts
///scr_settings_update_counts(data,count_array)

var data = argument0;
var count_array = argument1;

// If Never Seen Before
if data[2] == 0{
    // Mark as seen
    data[@ 2] = -1;
    // Decrement New Count
    count_array[@ 2] -=1;
    
    /*
    var key = scr_unlock_get_key(data[0],data[7]);
    var true_views = ini_read_real("UNLOCKS_DATA",key+"-views",0);
    if true_views == 0{
        count_array[@ 2] -=1;
    }*/
}

#define scr_draw_settings_explain
///scr_draw_settings_explain(type,ease)


var type = argument0
var ease = argument1;
var explain_text = scr_settings_get_explain(type);

draw_set_font(DescriptionFont);
draw_set_valign(fa_top);

draw_text_ext_transformed_colour(explain_x, explain_y,
    explain_text, -1, -1, 1, 1, 0, 
    COLORS[0], COLORS[0], COLORS[0], 
    COLORS[0], ease);






#define scr_settings_get_explain
///scr_settings_get_explain(type)

var str = "";
switch argument0 {

case -3:
    str = "particles" 
break
case -2:
    str = "touch style" 
break
case -1:
    str = "performance" //"frames per second"
break

case 0:
    str = "deflectors"
break;
case 2:
    str = "points & cash"
break;



}

return str;

#define scr_draw_settings_arrows_helper
///scr_draw_settings_arrows_helper(function_id, ease, arrow_ease)

var function_id = argument0;
var ease = argument1;
var arrow_ease = argument2;

//Draw < Arrows >
for (j=-1;j<2;j+=2)
{
    
    // Set Each Arrow's Coordinates
    arrow_scale = 1;
        //Offset the X plus or minus
    arrow_x = arrows_x + (arrows_inner_w + arrow_w/2) * j +(600)*(1-ease); 
    arrow_y = arrows_y;
    arrow_hover = point_in_rectangle(mouse_x,mouse_y,
                    arrow_x-arrow_w,arrow_y-arrow_h,
                    arrow_x+arrow_w,arrow_y+arrow_h)
    //Draw < Arrows >
    if j == -1{
        arrow_spr = s_v_leftarrow 
    }
    else if j == 1{
        arrow_spr = s_v_rightarrow
    }

    //Scale Up ON HOVER AND SELCTION
    if arrow_hover and selected[0] == noone and
    (!touchPad or mouse_check_button(mb_left)) and 
    (!TweenExists(mainTween))
    {

        arrow_scale *= 1.25//
        
        //On Select of Menu Choice
        if mouse_check_button_pressed(mb_left) and selected[1] == true
        {
            //Call Switch Code for this menu choice
            if j == -1{
                ADJUST = -1; 
            }
            else if j == 1{
                ADJUST = 1
            }
            selected[1] = false;
            ScheduleScript(id,1,.20 ,scr_delayed_selection,selected,function_id)
            scr_sound(sd_menu_click,1,false);
            
        }
        
    }   
    //Draw < Arrows >
    draw_sprite_ext(arrow_spr, 0,arrow_x,arrow_y,
    arrow_scale,arrow_scale,0,COLORS[0],arrow_ease);
        
}
#define scr_draw_settings_arrows_coordinates
///scr_draw_settings_arrows_coordinates()


//Get Center of Arrow Section
//arrows_x =(GAME_W - marginX - arrows_w/2); //+GAME_X
arrows_x = GAME_MID_X + line_w - arrows_w/2 - arrow_w/2  +(600)*(1-subEase[i+2]); 
//arrows_y = category_y + category_h/2 + settings_h/2 ;// +5;
arrows_y = category_y + category_h/2 + arrow_h * 1.6 //settings_h/2 ;// +5;
// Set Misc Coordinates
name_x = arrows_x;
name_y = category_y + category_h * 1 //- name_h/2;
counts_x = category_x + category_h * .1;
counts_y = category_y + category_h * 1;
desc_x = counts_x;
desc_y = counts_y + counts_h * 1.2;///arrows_y -category_h * 5//.25;
inner_x = arrows_x;
inner_y = arrows_y - 7*RU;
explain_x = inner_x;
explain_y = inner_y + category_h * .7;