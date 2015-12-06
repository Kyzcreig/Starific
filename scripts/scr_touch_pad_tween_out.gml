///scr_touch_pad_tween_out()

if touchPad{
    with(obj_control_game){
    
        tp_tween = TweenFire(id, tp_scale, EaseLinear, 
                            TWEEN_MODE_ONCE, 1, 0, .5 , tp_scale[0], 0);
           
    }
}
