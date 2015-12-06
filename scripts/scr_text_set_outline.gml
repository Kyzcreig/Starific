///scr_text_set_outline(fore_text,back_text)

var fore_text = argument[0]; 
var back_text = argument[0]; 
/*
    NB: Text color currently unused, we're just looking at the background brightness.
*/
return (color_get_hsl_lightness(back_text) > 75);
