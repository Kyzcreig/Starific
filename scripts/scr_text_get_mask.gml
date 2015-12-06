///scr_text_get_mask(horizontal_align, vertical_align)




var ha_type = argument0;
var va_type = argument1;
var ha_suffix = "";
var va_suffix = "";


switch ha_type{

case fa_left:
    ha_suffix = "L"
    break;

case fa_center:
    ha_suffix = "C"
    break;

case fa_right:
    ha_suffix = "R"
    break;
}

switch va_type{

case fa_top:
    va_suffix = "T"
    break;

case fa_middle:
    va_suffix = "M"
    break;

case fa_bottom:
    va_suffix = "B"
    break;
}

return asset_get_index("spr_mask_collision_"+ha_suffix+"_"+va_suffix);
