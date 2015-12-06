///draw_text_colour_strikethrough(x, y, string, c1, c2, c3, c4, alpha, valign, halign);


var xx, yy, str, c1, c2, c3, c4, alph;

xx = argument0;
yy = argument1;
str = argument2;
c1 = argument3;
c2 = argument4;
c3 = argument5;
c4 = argument6;
alph = argument7;

// Draw Text
draw_text_colour(xx, yy, str, c1, c2, c3, c4, alph);


// Draw Strike Through
var ln_x1, ln_y1, ln_x2, ln_y2, str_w, str_h, v_align, h_align;
str_w = string_width(str);
str_h = string_height(str);
v_align = argument8;
h_align = argument9;

switch v_align {
case fa_top:
    ln_y1 = yy + str_h/2; 
    ln_y2 = yy + str_h/2; 
break;
case fa_middle:
    ln_y1 = yy ; 
    ln_y2 = yy ;
break;
case fa_bottom:
    ln_y1 = yy - str_h/2; 
    ln_y2 = yy - str_h/2;
break;
}

switch h_align {
case fa_left:
    ln_x1 = xx; 
    ln_x2 = xx + str_w; 
break;
case fa_center:
    ln_x1 = xx - str_w/2; 
    ln_x2 = xx + str_w/2; 
break;
case fa_right:
    ln_x1 = xx - str_w; 
    ln_x2 = xx; 
break;
}


ln_w = str_h * .15; 
draw_line_width_sprite(ln_x1, ln_y1, ln_x2, ln_y2, ln_w, c1, alph, scr_return_solid_sprite(0));
