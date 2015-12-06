#define scr_button_update_indicator
///scr_button_update_indicator(data [, button_id])

var data = argument[0];

// If New Unlock
if scr_unlock_is_new(data){
    // Mark as Seen
    scr_unlock_increment_views(3,CURSKIN, 1, true);
    // Update Button Indicator
    if argument_count > 1 {
        var buttonIndex = scr_go_is_button(argument[1]);  
        var buttonData = go_sp_buttons[| buttonIndex]; 
        buttonData[@ 6] -= 1; //decrement notification count
    
    }
}


#define convert_theme_to_index
///convert_theme_to_index(theme_index);

return argument0;

#define convert_grid_to_index
///convert_grid_to_index(gridSize);

return (argument0 / 5) - 3;

#define convert_rigor_to_index
///convert_rigor_to_index(RIGOR);

return log2(argument0);

#define convert_index_to_theme
///convert_index_to_theme(uindex)

return argument0 - 12;

#define convert_index_to_grid
///convert_index_to_grid(index);

return (argument0 + 3) * 5;

#define convert_index_to_rigor
///convert_index_to_rigor(index);

return power(2, argument0)//+"00$";

#define convert_index_to_mode
///convert_index_to_mode(index);

return argument0;

#define convert_index_to_val
///convert_index_to_val(type,index)

var type = argument0;
var index = argument1;
var val = 0;
switch type{

// VFX Level
case -3:
    val = convert_index_to_vfx(index);
break

// Control Style
case -2:
    val = convert_index_to_control(index);
break
// FPS
case -1:
    val = convert_index_to_fps(index);
break

case 0:
    val = convert_index_to_grid(index); 
break;

case 1:
    val = convert_index_to_mode(index);
break;
case 2:
    val = convert_index_to_rigor(index);
break;

case 3:
break;
case 4:
break;
case 5:
break;



}


return val;

#define convert_mode_to_index
///convert_mode_to_index(MODE)


return argument0;

#define convert_val_to_index
///convert_val_to_index(type,val)

var type = argument0;
var val = argument1;
var index = 0;
switch type{

case 0:
    index = convert_grid_to_index(val); 
break;

case 1:
    index = convert_mode_to_index(val);
break;
case 2:
    index = convert_rigor_to_index(val);
break;

case 3:
    index = convert_theme_to_index(val);
break;
case 4:
break;
case 5:
break;



}


return index;

#define convert_index_to_val_string
///convert_index_to_val_string(type, index)


var type = argument0;
var index = argument1;
var val = convert_index_to_val(type,index); 
var str = "";

switch type{

// VFX
case -3:
    return string(val)+"%";
break;
// Control Style
case -2:
    return string(val);
break;
// FPS
case -1:
    return string(val);
break

case 0:
    str = string(val)+" x "+string(val);
break;

case 1:
break;

case 2:
    str = "+"+string(val)+"00%";
break;

case 3:
break;
case 4:
break;
case 5:
break;

}

return str;

#define convert_index_to_fps
////convert_index_to_fps(index)

return RMSPD_OPTIONS[argument0];
#define convert_index_to_control
////convert_index_to_control(index)


var str;

switch argument0{
case 0:
    str = "@";
    break;
case 1:
    str = "o";
    break;
case 2:
    str = "=";//"-";
    break;


}
return str;

#define convert_index_to_vfx
////convert_index_to_vfx(index)


var val;

switch argument0{
case 0:
    val = 50;
    break;
case 1:
    val = 100;
    break;


}
return val;