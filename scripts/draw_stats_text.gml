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
