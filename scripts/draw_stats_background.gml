///draw_stats_background(y, width, height, color, alpha);
var yy = argument[0];
var s_backlight_w = argument[1]; //
var s_backlight_h = argument[2]; //;
var s_backlight_col = argument[3]; //;
//s_backlight_col = merge_colour(COLORS[0],COLORS[6],.95);
var alpha = argument[4] * .5//min(argument[4],.5);

//Draw Backcoloring 
s_backlight_x = GAME_MID_X - s_backlight_w/2;
//s_backlight_y = yy +2 -s_backlight_h/2
s_backlight_y = yy;
s_backlight_spr = s_v_background_solid_menu;
draw_sprite_stretched_ext(s_backlight_spr,0,s_backlight_x,s_backlight_y, 
                s_backlight_w, s_backlight_h, s_backlight_col,alpha) 
