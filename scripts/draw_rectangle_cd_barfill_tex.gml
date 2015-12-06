///draw_rectangle_cd_barfill_tex(x1, y1, x2, y2, value,count,texture)
var v, x1, y1, x2, y2, xm, ym,tex;
v = argument4 //0-1 value 
//if (v <= 0) return 0 // nothing to be drawn
x1 = argument0; y1 = argument1; // top-left corner
x2 = argument2; y2 = argument3; // bottom-right corner
count = argument5; tex = argument6;

//set coordinates midx, midy, fill of y
var xm = (x1+x2)/2;
var ym = (y1+y2)/2;
var filly = (y2-y1)*v //height from bottom

//Draws roundrect of cooldown icon
draw_roundrect_texture(xm-30,y1,xm+30,y2, 30, tex, 5,false)


//Draw icon fill only in above region w/ alpha 1 and up to the bar fill
draw_roundrect_value_color(xm-30,y1,xm+30,y2, v, 30,5,COLORS[0],.45,0)
//draw_roundrect_value_color(xm-30,y2-filly,xm+30,y2, v, 15,5,5066 061,.8)
//draw_rectangle(x1,y2-filly,x2,y2,false);


//Draw count indicator
draw_roundrect_colour_ext(xm+30-16, y1-8, xm+30+8, y1+16, 6, 6, COLORS[0], COLORS[0], false);
draw_text_colour(xm+30-4,y1,string(count),COLORS[6],COLORS[6],COLORS[6],COLORS[6],1)
