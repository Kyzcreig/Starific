///draw_roundrect_value_color(x1, y1, x2, y2, value, radius, circle precision,color,alpha,inverse)

//Draws a textured rounded rectangle
//Does not work on HTML5

var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var v = argument4;
var radius = argument5/2;
var prec = argument6;
var col = argument7;
var alph = argument8;
var inv = argument9; //inverse the fill
//texture_set_repeat(rep);

//If inversed we take 1-v value instead of v
var filly = (y2-y1)*(v*!inv+(1-v)*inv) //height if fill
/*
var w,h;
w=(x2-x1)
h=(y2-y1)
var xscale, yscale;
xscale = 1//w/texture_get_width(tex);
yscale = 1//h/texture_get_height(tex);*/

var cx,cy,xx,yy;

draw_primitive_begin(pr_trianglefan);


cx=x1+radius
cy=y1+radius
//if cy <= (y2-filly)
{
    for(i=90;i<=180;i+=90/prec)
    {
      xx=cx+lengthdir_x(radius,i)
      yy=cy+lengthdir_y(radius,i)
      if yy <= (y2-filly) and !inv {yy=y2-filly}
      if yy >= (y1+filly) and inv {yy=y1+filly}
      draw_vertex_colour(xx,yy, col, alph);
    }
}
 
cx=x1+radius
cy=y2-radius
//if cy < (y2-filly)
{
    for(i=180;i<=270;i+=90/prec)
    {
      xx=cx+lengthdir_x(radius,i)
      yy=cy+lengthdir_y(radius,i)
      if yy <= (y2-filly) and !inv {yy=y2-filly}
      if yy >= (y1+filly) and inv {yy=y1+filly}
      draw_vertex_colour(xx,yy, col, alph);
    }
}
 
cx=x2-radius
cy=y2-radius
//if cy <= (y2-filly)
{
    for(i=270;i<=360;i+=90/prec)
    {
      xx=cx+lengthdir_x(radius,i)
      yy=cy+lengthdir_y(radius,i)
      if yy <= (y2-filly) and !inv {yy=y2-filly}
      if yy >= (y1+filly) and inv {yy=y1+filly}
      draw_vertex_colour(xx,yy, col, alph);
    }
}
 
cx=x2-radius
cy=y1+radius
//if cy <= (y2-filly)
{
    for(i=0;i<=90;i+=90/prec)
    {
      xx=cx+lengthdir_x(radius,i)
      yy=cy+lengthdir_y(radius,i)
      if yy <= (y2-filly) and !inv {yy=y2-filly}
      if yy >= (y1+filly) and inv {yy=y1+filly}
      draw_vertex_colour(xx,yy, col, alph);
    }
}
 
draw_primitive_end()
