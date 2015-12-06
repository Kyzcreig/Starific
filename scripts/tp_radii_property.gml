#define tp_radii_property
///tp_radii_property(value)

tp_bigR = scr_tp_set_rad_clamp(0) * argument0;
tp_smlR = scr_tp_set_rad_clamp(1) * argument0;

#define tp_set_radii
///tp_set_radii()


if TweenExists(tp_tween){

    tp_bigR = scr_tp_set_rad_clamp(0) * tp_scale[0];
    tp_smlR = scr_tp_set_rad_clamp(1) * tp_scale[0];
}