///draw_roundrect_texture(x1, y1, x2, y2, radius, texture, circle precision, repeat)

//Draws a textured rounded rectangle
//Does not work on HTML5
//Example: draw_roundrect_texture(60,160,160,300,40,bkg_sign,9,false);

var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var radius = argument4;
var tex = argument5;
var prec = argument6;
var rep = argument7;
//texture_set_repeat(rep);

var w,h;
w=(x2-x1)
h=(y2-y1)
var xscale, yscale;
xscale = 1//w/texture_get_width(tex);
yscale = 1//h/texture_get_height(tex);

var cx,cy,xx,yy,col,alph;
col = c_white;
alph = 1;


/*

draw_primitive_begin_texture(pr_trianglefan, tex);
  //draw_vertex_texture_colour(mean(x1,x2),mean(y1,y2), .5, .5, col, alph);
  draw_vertex_texture_colour(mean(x1,x2),y1, .5,0, col, alph);
  draw_vertex_texture_colour(x1,mean(y1,y2), 0,.5, col, alph);
  draw_vertex_texture_colour(mean(x1,x2),y2, .5,1, col, alph);
  draw_vertex_texture_colour(x2,mean(y1,y2), 1,.5, col, alph);

draw_primitive_end()*/


draw_primitive_begin_texture(pr_trianglefan, tex);
//Draw middle vertex
//draw_vertex_texture_colour(mean(x1,x2),mean(y1,y2), .5*xscale, .5*yscale, col, alph);
 
cx=x1+radius
cy=y1+radius
for(i=90;i<=180;i+=90/prec)
{
  xx=cx+lengthdir_x(radius,i)
  yy=cy+lengthdir_y(radius,i)
  draw_vertex_texture_colour(xx,yy, (xx-x1)/w*xscale,(yy-y1)/h*yscale, col, alph);
}
 
cx=x1+radius
cy=y2-radius
for(i=180;i<=270;i+=90/prec)
{
  xx=cx+lengthdir_x(radius,i)
  yy=cy+lengthdir_y(radius,i)
  draw_vertex_texture_colour(xx,yy, (xx-x1)/w*xscale,(yy-y1)/h*yscale, col, alph);
}
 
cx=x2-radius
cy=y2-radius
for(i=270;i<=360;i+=90/prec)
{
  xx=cx+lengthdir_x(radius,i)
  yy=cy+lengthdir_y(radius,i)
  draw_vertex_texture_colour(xx,yy, (xx-x1)/w*xscale,(yy-y1)/h*yscale, col, alph);
}
 
cx=x2-radius
cy=y1+radius
for(i=0;i<=90;i+=90/prec)
{
  xx=cx+lengthdir_x(radius,i)
  yy=cy+lengthdir_y(radius,i)
  draw_vertex_texture_colour(xx,yy, (xx-x1)/w*xscale,(yy-y1)/h*yscale, col, alph);
}
 
//draw_vertex(x1+radius,y1) //<-- The first vertex must be the same as the last one.
 
draw_primitive_end()
