///draw_rectangle_cd_barfill(x1, y1, x2, y2, value,count,sprite)
var v, x1, y1, x2, y2, xm, ym,sprite;
v = argument4 //0-1 value 
//if (v <= 0) return 0 // nothing to be drawn
x1 = argument0; y1 = argument1; // top-left corner
x2 = argument2; y2 = argument3; // bottom-right corner
count = argument5; sprite = argument6;

//set coordinates midx, midy, fill of y
var xm = (x1+x2)/2;
var ym = (y1+y2)/2;
var filly = (y2-y1)*v

//Sets alpha of this region to 1
draw_set_alpha(1)
draw_roundrect_colour_ext(xm-30,y1,xm+30,y2, 15,15,COLORS[6],COLORS[6],false)//COLORS[6]
//draw_roundrect_colour_ext(xm-30,y1,xm+30,y2, 15,15,c_white,c_white,false)//COLORS[6]

//Draw sprite only in above region w/ alpha 1
//We multiply source at the dest alpha (1 inside the above roundrect)
//Then we add that to the dest colors * zero
draw_set_blend_mode_ext(bm_dest_alpha,bm_inv_src_alpha);
draw_sprite_ext(sprite,0,xm,ym,1,1,0,c_white,1);


//Draw count indicator
draw_set_blend_mode(bm_normal);
//Consider using draw outline color with a slight outline
draw_text_colour(x2-8-2,y1+string_height('0')-5,string(count),COLORS[6],COLORS[6],COLORS[6],COLORS[6],1)//
//draw_text_outline_color(x2-8,y1+string_height('0')-5,string(count),COLORS[6],COLORS[6],COLORS[6],COLORS[6],1,2,c_black,8)//COLORS[0]


//Draw icon fill only in above region w/ alpha 1 and up to the bar fill
draw_set_alpha(.35)
draw_set_color(c_black)
//We multiply the source by the dest alpha (1 inside the above roundrect)
//Then we add that to the product of the dest color and the inverse src alpha (1-.25) above
//This has the effect of decreasing all the colors by a factor of .75, which darkens them
//The dest pixels outside the roundrect are still 0 color, 0 alpha and are unaffected.
draw_set_blend_mode_ext(bm_dest_alpha,bm_inv_src_alpha)
draw_rectangle(x1,y2-filly,x2,y2,false);

draw_set_blend_mode(bm_normal);
draw_set_color(c_white)
draw_set_alpha(1)
