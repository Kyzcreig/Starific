///draw_arc(degree size, STEP size, radius, start degree, width, x, y)

arc_size = argument0 // size of curve (in degrees)
step_size = argument1 // STEP size
radius = argument2 // distance of edge of curve from origin
start_deg = argument3 // direction of first point of curve (in degrees)
arc_width = argument4/2 // width of arc
oX = argument5 // x origin
oY = argument6 // y origin



var i; var xx; var yy;
draw_primitive_begin(pr_trianglestrip)

for (i=0; i<=arc_size; i+=step_size)
{
    //Draw inside
    xx=lengthdir_x(radius-arc_width,start_deg+i)
    yy=lengthdir_y(radius-arc_width,start_deg+i)
    draw_vertex(oX+xx,oY+yy)
    
    //Draw Outside
    xx=lengthdir_x(radius+arc_width,start_deg+i)
    yy=lengthdir_y(radius+arc_width,start_deg+i)
    draw_vertex(oX+xx,oY+yy)
}

draw_primitive_end()
