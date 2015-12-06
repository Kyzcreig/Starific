///scr_align_text()
var loc_xG = (x >= ox+(global.fieldW*2/3)*cellW);
var loc_yG = (y >= oy+(global.fieldH*2/3)*cellW);
var loc_xL = (x < ox+(global.fieldW/3)*cellW);
var loc_yL = (y < oy+(global.fieldH/3)*cellW);
if loc_xG and loc_yG{ 
    draw_set_valign(fa_bottom);
    draw_set_halign(fa_right);
}
else if loc_xG and loc_yL{
    draw_set_valign(fa_top);
    draw_set_halign(fa_right);
}
else if loc_xG{
    draw_set_valign(fa_middle);
    draw_set_halign(fa_right);
}
else if loc_xL and loc_yG{ 
    draw_set_valign(fa_bottom);
    draw_set_halign(fa_left);
}
else if loc_xL and loc_yL{ 
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
}
else if loc_xL{ 
    draw_set_valign(fa_middle);
    draw_set_halign(fa_left);
}
else if loc_yG{
    draw_set_valign(fa_bottom);
    draw_set_halign(fa_center);
}
else if loc_yL{
    draw_set_valign(fa_top);
    draw_set_halign(fa_center);
}
else{
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);
}
