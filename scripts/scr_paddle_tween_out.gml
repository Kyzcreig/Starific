#define scr_paddle_tween_out
///scr_paddle_tween_out(override old)
//var oldxscale = max(.2,image_xscale)*()

/*if TweenExists(scaleTweener) and GAME_ACTIVE{
    TweenFinish(scaleTweener,false)
}*/
scaleTweener = TweenFire(id,pad_xscale, EaseLinear,
                        TWEEN_MODE_ONCE,1,0,.5,pad_xscale[0],0)
TweenAddCallback(scaleTweener,TWEEN_EV_FINISH, id, Destroy, id);

return scaleTweener;

#define scr_paddle_tween_out_force
///scr_paddle_tween_out_force()

if TweenExists(scaleTweener){
    //TweenFinish(scaleTweener,true)
    TweenDestroy(scaleTweener)
}
// Immediately Tween to zero
scaleTweener = TweenFire(id,pad_xscale,EaseLinear, 
                            TWEEN_MODE_ONCE,false,0,1,pad_xscale[0],0)
TweenAddCallback(scaleTweener, TWEEN_MODE_ONCE, id, Destroy, id);

return scaleTweener;