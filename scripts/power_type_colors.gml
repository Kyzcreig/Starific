#define power_type_colors
///power_type_colors(objType, colType)
/* Script returns symbol or solid colors for reflector type
   if -1 oType then colType = the color index returned
   else colType
       solid = 0;
       symbol = 1;
   
*/
var objType = argument0;
var colType = argument1;
var symIndex = 11; //starting index for symbol colors
var col;

switch objType {

//basic
case 0:
    if !colType{
        col = COLORS[5];   
    } else {
        col = COLORS[5+symIndex];  
    }
break;
//uppers
case 1:
//downers
case 2:
//rounders
case 3:
//bombs
case 4:
    if !colType{
        col = COLORS[objType];   
    } else {
        col = COLORS[objType+symIndex];  
    }
break;

//Direct Access Color Index
default:
   col = COLORS[colType];

break;
}


return col

#define power_type_color_index
///power_type_color_index(objType, colType)

/* Script returns symbol or solid colors for reflector type
   if -1 oType then colType = the color index returned
   else colType
       solid = 0;
       symbol = 1;
   
*/

var objType = argument0;
var colType = argument1;
var symIndex = 11; //starting index for symbol colors
var col;

switch objType {

//basic
case 0:
    if !colType{
        col = 5;   
    } else {
        col =  5+symIndex; 
    }
break;
//uppers
case 1:
//downers
case 2:
//rounders
case 3:
//bombs
case 4:
    if !colType{
        col = objType;   
    } else {
        col = objType+symIndex;  
    }
break;

//Direct Access Color Index
default:
    col = colType;   

break;
}


return col
#define power_paddle_color
///power_paddle_color(type)


return COLORS[9+argument0];