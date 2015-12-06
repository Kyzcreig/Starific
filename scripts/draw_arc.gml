///draw_arc(degree size, STEP size, radius, start degree, x, y)
/*
argument0 = size of curve (in degrees)
argument1 = STEP size
argument2 = distance of edge of curve from origin
argument3 = direction of first point of curve (in degrees)
argument4 = x origin
argument5 = y origin
*/


var i; var xx; var yy;
draw_primitive_begin(pr_linelist)
for (i=0; i<=argument0; i+=argument1)
{
xx=lengthdir_x(argument2,argument3+i)
yy=lengthdir_y(argument2,argument3+i)
draw_vertex(argument4+xx,argument5+yy)
}
draw_primitive_end()
