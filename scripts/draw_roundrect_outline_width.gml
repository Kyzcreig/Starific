///draw_roundrect_outline_width(x1, y1, x2, y2, width, radius, circle precision,color,alpha)

//Draws a textured rounded rectangle
//Does not work on HTML5

var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var width = argument4;
var radius = argument5/2;
var prec = argument6;
var col = argument7;
var alph = argument8;
//texture_set_repeat(rep);


//ALPHA UNUSED/not working


var cx,cy,xx1,yy1,xx2,yy2;
var increment = 90/prec;


cx=x1+radius;
cy=y1+radius;
draw_line_width_colour(x1,y1+radius,x1,y2-radius,width,col,col); //draw left border
{

    for(i=90;i<180;i+=increment)
    {
      xx1=cx+lengthdir_x(radius,i)
      yy1=cy+lengthdir_y(radius,i)
      xx2=cx+lengthdir_x(radius,i+increment)
      yy2=cy+lengthdir_y(radius,i+increment)
      
      draw_line_width_colour(xx1,yy1,xx2,yy2,width,col,col); 
    }
}
 
cx=x1+radius;
cy=y2-radius;
draw_line_width_colour(x1+radius,y2,x2-radius,y2,width,col,col); //draw bottom border
{
    for(i=180;i<270;i+=increment)
    {
      xx1=cx+lengthdir_x(radius,i)
      yy1=cy+lengthdir_y(radius,i)
      xx2=cx+lengthdir_x(radius,i+increment)
      yy2=cy+lengthdir_y(radius,i+increment)
      draw_line_width_colour(xx1,yy1,xx2,yy2,width,col,col); 
    }
}
 
cx=x2-radius;
cy=y2-radius;
draw_line_width_colour(x2,y1+radius,x2,y2-radius,width,col,col); //draw right border
{
    for(i=270;i<360;i+=increment)
    {
      xx1=cx+lengthdir_x(radius,i)
      yy1=cy+lengthdir_y(radius,i)
      xx2=cx+lengthdir_x(radius,i+increment)
      yy2=cy+lengthdir_y(radius,i+increment)
      draw_line_width_colour(xx1,yy1,xx2,yy2,width,col,col); 
    }
}
 
cx=x2-radius;
cy=y1+radius;
draw_line_width_colour(x1+radius,y1,x2-radius,y1,width,col,col); //draw top border
{
    for(i=0;i<90;i+=increment)
    {
      xx1=cx+lengthdir_x(radius,i)
      yy1=cy+lengthdir_y(radius,i)
      xx2=cx+lengthdir_x(radius,i+increment)
      yy2=cy+lengthdir_y(radius,i+increment)
      draw_line_width_colour(xx1,yy1,xx2,yy2,width,col,col); 
    }
}
