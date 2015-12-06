///scr_draw_box_centered(width, height, padding, edge_color, background_color,tweenfactor,tweenx, tweeny);

var width = argument0 //width of box probably use view_wport*factor
var height = argument1;  // height of box
var padding = argument2;  // how much padding on perimeter
var edge_color = argument3 //color of padding
var bak_color = argument4;  // Color of the background
var tweenfactor = argument5; //how much to tween
var tweenx = argument6 //tween y direction -1 for from right, 1 for from left
var tweeny = argument7 //tween y direction -1 for from bottom, 1 for from top

var boxbounds;
boxbounds[0] = (GAME_MID_X - width/2) - 2*width*tweenfactor*tweenx//left
boxbounds[1] = (GAME_MID_Y - height/2) - 2*height*tweenfactor*tweeny//top
boxbounds[2] = (GAME_MID_X + width/2) - 2*width*tweenfactor*tweenx //right
boxbounds[3] = (GAME_MID_Y + height/2) - 2*height*tweenfactor*tweeny //bottom


draw_roundrect_color(boxbounds[0]-padding,boxbounds[1]-padding,boxbounds[2]+padding,boxbounds[3]+padding,edge_color,edge_color,0);
draw_rectangle_colour(boxbounds[0],boxbounds[1],boxbounds[2],boxbounds[3],bak_color,bak_color,bak_color,bak_color,0);

return boxbounds
