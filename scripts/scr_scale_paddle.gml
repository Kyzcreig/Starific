///scr_scale_paddle()
with(paddle_id){
    var oldxscale = pad_xscale[0]
    var netscale = (POWER_grow[@ 0]-POWER_shrink[@ 0])
    
    if TweenExists(scaleTweener){
        TweenDestroy(scaleTweener)
    }
    var powerbase = 1+(.20/PADDLE_SCALE)*sign(netscale);  // /(POWER_addgrow[@ 7]*POWER_subshrink[@ 7]))*sign(netscale);
    //we added /PADDLE_SCALE to the exponent base so that it would be less crazy when you got a grow or shrink early on
    var rawxscale = power(powerbase,abs(netscale))*PADDLE_SCALE*(POWER_addgrow[@ 7]*POWER_subshrink[@ 7]);
    
    var newxscale = clamp(rawxscale,.25,15);
    scaleTweener = TweenFire(id,pad_xscale,EaseInOutElastic,
                     TWEEN_MODE_ONCE,1,0,.5,pad_xscale[0],newxscale)
}
