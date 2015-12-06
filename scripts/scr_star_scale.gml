///scr_star_scale(ease, duration, property, destination, tween)

var ease = argument[0];
var dur = argument[1];
var prop = argument[2];
var dest = argument[3];
var tween = argument[4];

  
if TweenExists(tween[0]){
    TweenDestroy(tween[0]);
}

tween[@ 0] = TweenFire(id,prop,ease,TWEEN_MODE_ONCE, 
                        true, 0, dur, prop[0], dest)      
                   
                   
                   
