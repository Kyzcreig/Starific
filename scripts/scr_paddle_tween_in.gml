///scr_paddle_tween_in()
//var oldxscale = max(.2,image_xscale)
//scaleTweener = TweenSimpleScale(0,1,image_xscale,1,room_speed,EaseInOutCubic)//EaseLinear)


/*if TweenExists(scaleTweener) and GAME_ACTIVE{
    TweenFinish(scaleTweener,false)
}*/
scaleTweener = TweenFire(id,pad_xscale, EaseLinear,
                    TWEEN_MODE_ONCE,1,0,.5,0,pad_xscale[0])

return scaleTweener;
