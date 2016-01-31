///draw_rectangle_cd_barfill_icon_sprite(x1, y1, x2, y2, value,count,sprite,color,symcolor, alpha, icon_spr)
var v, x1, y1, x2, y2, xm, ym,sprite, alpha, icon_spr;
v = argument4 //0-1 value 
//if (v <= 0) return 0 // nothing to be drawn
x1 = argument0; y1 = argument1; // top-left corner
x2 = argument2; y2 = argument3; // bottom-right corner
count = argument5; sprite = argument6;
color = argument7;
symcolor = argument8;
alpha = argument9//s_v_icon_background;
icon_spr = argument10//s_v_icon_background;

//set coordinates midx, midy, fill of y
var xm = (x1+x2)/2;
var ym = (y1+y2)/2;
var filly = (y2-y1)*v;

//var w = x2 - x1; //we can use this later for scaling if necessary
//var h = y2 - y1;

//probably want to calc the width/height for scaling the sprite

//Sets alpha of this region to 1
draw_sprite_ext(icon_spr,0,xm,ym,1,1,0,color,1*alpha) //60x60 canvas for these
draw_sprite_ext(sprite,0,xm,ym,1,1,0,symcolor,1*alpha);

//Draw icon fill only in above region w/ alpha 1 and up to the bar fill
draw_sprite_part_ext(icon_spr,0,0,0,60,(1-v)*60,xm-30,ym-30,1,1,COLORS[7],.45*alpha)


//Draw count indicator
//draw_set_valign(fa_middle)
//draw_set_halign(fa_center)
//we can make a little rectangle here maybe or scale it down might be ok
if count > 1{
    draw_set_font(fnt_game_bn_15_black)
    draw_sprite_ext(s_v_icon_background,0,xm+30-4,y1+4,24/60,24/60,0,
        COLORS[0],1*alpha) //24x24 canvas for these
    draw_text_colour(xm+30-4,y1,string(count),
        COLORS[6],COLORS[6],
        COLORS[6],COLORS[6],1*alpha)
}
