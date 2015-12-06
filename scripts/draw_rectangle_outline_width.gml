#define draw_rectangle_outline_width
///draw_rectangle_outline_width(x1,y1,x2,y2,width)
var x1, x2, y1, y2, width;
x1 = argument0
y1 = argument1
x2 = argument2
y2 = argument3
width = argument4

draw_line_width(x1,y1,x2,y1,width)
draw_line_width(x1,y2,x2,y2,width)
draw_line_width(x1,y1,x1,y2,width)
draw_line_width(x2,y1,x2,y2,width)

#define draw_rectangle_outline_width_colour
///draw_rectangle_outline_width_colour(x1,y1,x2,y2,width, color)
var x1, x2, y1, y2, width, color, oldColor;
x1 = argument0
y1 = argument1
x2 = argument2
y2 = argument3
width = argument4
color = argument5;
oldColor = draw_get_colour()

draw_set_colour(color); 

draw_line_width(x1,y1,x2,y1,width)
draw_line_width(x1,y2,x2,y2,width)
draw_line_width(x1,y1,x1,y2,width)
draw_line_width(x2,y1,x2,y2,width)

draw_set_colour(oldColor); 