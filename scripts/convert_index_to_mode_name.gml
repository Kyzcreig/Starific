#define convert_index_to_mode_name
///convert_index_to_mode_name(MODE)

//NB: It might be cleaner to use the unlocks data here.

var name = scr_unlock_get_name(1, argument0);

return string_cap_first_letter(name); 

/*
var gm_str;
switch argument0{
    case 0:
         gm_str = "Arcade";
         break;   
    case 1:
         gm_str = "Moves";
         break;   
    case 2:
         gm_str = "Time";
         break;  
    case 3:
         gm_str = "Sandbox";
         break;   
}

return gm_str;

#define convert_index_to_grid_name
///convert_index_to_grid_name(GRID)


var name = scr_unlock_get_name(0, argument0);

return string_cap_first_letter(name); 
/*
var gm_str;
switch argument0{
    case 0:
         gm_str = "Small";
         break;   
    case 1:
         gm_str = "Medium";
         break;   
    case 2:
         gm_str = "Large";
         break;  
    case 3:
         gm_str = "Giant";
         break;   
}

return gm_str;

#define convert_index_to_rigor_name
///convert_index_to_rigor_name(RIGOR)


var name = scr_unlock_get_name(2, argument0);

return string_cap_first_letter(name); 

#define convert_settings_to_name
///convert_index_to_setting_name(type, index)

var type = argument0;
var index = argument1;
var str = "";

switch type {

case 0:
    str = convert_index_to_grid_name(index)
    break; 

case 1:
    str = convert_index_to_mode_name(index)
    break; 

case 2:
    str = convert_index_to_rigor_name(index)
    break;
case 3:
//TO DO
    //str = convert_index_to_theme_name(index)
    break; 
} 

return str;

#define string_cap_first_letter
///string_cap_first_letter(str)


var str = argument0;


// Capitalize first letter
var first_letter = string_char_at(str,1);
if first_letter == "" {
    return str;
}

return string_replace(str, first_letter, string_upper(first_letter));
#define convert_index_to_control_name
///convert_index_to_control_name(TP_SENSE[1])



var gm_str;
switch argument0{
    case 0:
         gm_str = "fluid";
         break;   
    case 1:
         gm_str = "fixed";
         break;   
    case 2:
         gm_str = "linear";
         break;  
}

return gm_str;

#define scr_control_style_description
///scr_control_style_description(TP_SENSE[1])




var gm_str;
switch argument0{
    case 0:
         gm_str = "drag in circles, use leash to recenter";
         break;   
    case 1:
         gm_str = "drag in circles, tap & hold to recenter";
         break;   
    case 2:
         gm_str = "drag in lines, tap & hold to recenter";
         break;  
}

return gm_str;