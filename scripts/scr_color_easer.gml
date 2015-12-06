#define scr_color_easer
///scr_color_easer(dur)

//Color Easer
with (obj_control_colors){
    
    if TweenExists(ColorTween) {
        TweenDestroy(ColorTween);
    } 
    //NB: I found I like the color easing transition better without the tweenfinish call
    

    ColorTween = TweenFire(id,ColorEase,EaseLinear, 
                        TWEEN_MODE_ONCE, 1,0,argument0,0,1);
    
    ColorPrevNew = true;
    
    //Set Skin Name
    COLORS[SKIN_NAME_INDEX] = mColors[SKIN_NAME_INDEX,CURSKIN];
    
}

#define scr_color_easer_instant
///scr_color_easer_instant(dur)

//Color Easer
with (obj_control_colors){
    
    if TweenExists(ColorTween) {
        TweenDestroy(ColorTween);
        
    } 
    //NB: I found I like the color easing transition better without the tweenfinish call
    

    ColorTween = TweenFire(id,ColorEase,EaseLinear, 
                        TWEEN_MODE_ONCE,1,0,argument0,1,1); 
                                                //NB: not a type, it goes from 1 to 1
    
    ColorPrevNew = true;
    
    //Set Skin Name
    COLORS[SKIN_NAME_INDEX] = mColors[SKIN_NAME_INDEX,CURSKIN];
    
}