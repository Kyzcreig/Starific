///scr_scale_paddle()
with(paddle_id){
    if TweenExists(scaleTweener){
        TweenDestroy(scaleTweener)
    }
    
    var netscale = (POWER_grow[@ 0]-POWER_shrink[@ 0])
    var powerbase = 1 + (.20/PADDLE_SCALE) * sign(netscale); 
        //NB: We added  division by PADDLE_SCALE to the exponent base so that
         //  it would be less crazy when you got a grow or shrink early on
    var rawXScale = PADDLE_SCALE * power(powerbase,abs(netscale)) * (POWER_addgrow[7]*POWER_subshrink[7]);
    
    //show_debug_message("rawXScale="+string(rawXScale))
    
    var maxScale = RAIL_LENGTH/PADDLE_W;
    var newXScale = clamp(rawXScale,.025 * maxScale, 1.5 * maxScale);
    //show_debug_message("newXScale="+string(newXScale))
    scaleTweener = TweenFire(id,pad_xscale,EaseLinear, //EaseInOutElastic
                     TWEEN_MODE_ONCE,1,0,.5,pad_xscale[0],newXScale)
    //show_debug_message("pad_xscale[0]="+string(pad_xscale[0]))
}
