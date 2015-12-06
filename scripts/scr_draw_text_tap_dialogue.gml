///scr_draw_text_tap_dialogue(x,y, text, scale, color, alpha, font, outline)

var str_x, str_y, str, scale, col, alpha, fnt, outline ;
var i = -1;
str_x = argument[++i];
str_y = argument[++i];
str   = argument[++i];
scale = argument[++i];
col = argument[++i];
alpha = argument[++i];
fnt = argument[++i];
outline = argument[++i];



draw_set_font(fnt);
//If light background use no outline
var background_too_light = scr_text_set_outline(argument[3],COLORS[6]);
if !outline and !background_too_light{
   draw_text_ext_transformed_colour(str_x,str_y, str, -1,-1,scale,scale,0,col,col,col,col,alpha);
    
}
else{
   draw_text_outline_ext_transformed_color(str_x,str_y, str, -1,-1,scale,scale,0,col,col,col,col,alpha, 4, COLORS[6], 4);

}
