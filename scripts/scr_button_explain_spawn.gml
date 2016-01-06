#define scr_button_explain_spawn
///scr_button_explain_spawn(type, index)

var type = argument0;
var index = argument1;

explain_font = fnt_menu_bn_15_black; //maybe smaller font?
draw_set_font(explain_font)
explain_text = scr_button_explain_get_text(type,index) 
explain_h = string_height("H")*1.2;
explain_x = GAME_MID_X;
explain_y = sp_end_y - sp_size/2  + explain_h*scr_button_explain_get_row(type)//take top of sprites
explain_dur = 3*room_speed;
scr_popup_text_field_static(explain_x, explain_y, explain_text, COLORS[0], 
                            explain_font, true, explain_dur, 0)



#define scr_button_explain_get_text
///scr_button_explain_get_text(type, index)

var type, index, str;
type = argument0;
index = argument1;
str = scr_unlock_get_name_long(type, index) +" selected";
str += scr_button_explain_get_text_long(type,index);

return str;

#define scr_button_explain_get_text_long
///scr_button_explain_get_text_long(type, index)

var type, index, str;
type = argument0;
index = argument1;
str = "";



switch (type)
{
    case 0: 
        str += ": "+convert_index_to_val_string(type,index)+" "+scr_settings_get_explain(type)
    break;
    
    case 1: 
    
    break;
    
    case 2: 
        str += ": "+convert_index_to_val_string(type,index)+" "+scr_settings_get_explain(type)
    
    break;
    
    case 3: 
    
    break;
    
}



return str;
 










#define scr_button_explain_get_row
///scr_button_explain_get_row(type)

var type = argument0;
var val = -.5;

//rigors -3.5, grids -2.5, theme, -1.5, mode -.5
switch argument0{

case 0:
    val = -3.0;
break;


case 1:
    val = -1.0;
break;


case 2:
    val = -4.0;
break;


case 3:
    val = -2.0;
break;

}

return val; 