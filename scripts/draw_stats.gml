#define draw_stats
///draw_stats(text x, text y, score x, score y, text, score, background,alpha);

var x1 = argument[0];
var y1 = argument[1];
var x2 = argument[2];
var y2 = argument[3];
var text = argument[4];
var value = argument[5];
var background = argument[6];
var alpha = argument[7];

//Draw Backcoloring
if background{
    s_backlight_w = (GAME_W*14/32)*2;
    s_backlight_h = 32;
    s_backlight_x = (GAME_W-s_backlight_w)/2;
    s_backlight_y = y1 +2 -s_backlight_h/2//-(s_StatsTextHeight-s_StatsDisplayHeight)*s_Scroll;
    s_backlight_spr = s_v_background_solid_menu;
    s_backlight_xscale = s_backlight_w/sprite_get_width(s_backlight_spr);
    s_backlight_yscale = s_backlight_h/sprite_get_height(s_backlight_spr);
    //s_backlight_col = merge_colour(COLORS[0],COLORS[6],.95);
    s_backlight_col = COLORS[0];
    draw_sprite_ext(s_backlight_spr,0,s_backlight_x,s_backlight_y,s_backlight_xscale,s_backlight_yscale ,0,s_backlight_col,min(alpha,.4))
}    
    

//regular non-caps font
draw_set_font(fnt_menu_calibri_24_bold);
draw_set_halign(fa_left);
draw_text(x1, y1, text)
//bold non-caps font
draw_set_font(fnt_menu_calibri_22_bold);
draw_set_halign(fa_right);
draw_text(x2, y2, string(value))

#define draw_stats_background
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

#define draw_stats_text
///draw_stats_text(x, y, value, font, halign);

var value_x = argument[0];
var value_y = argument[1];
var value_val = string(argument[2]);
var value_font = argument[3];
var value_halign = argument[4];

//Draw Stat Value
draw_set_font(value_font);
draw_set_halign(value_halign);
draw_text(value_x, value_y, value_val)