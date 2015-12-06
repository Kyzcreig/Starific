/// TweenGo(prop,ease,delta,dur,start,dest)
/*
    @prop     property setter script (doesn't support extended property setters)
    @ease     ease algorithm script
    @delta    use seconds timing?
    @dur      duration of tween in seconds or steps
    @start    starting value for eased property
    @dest     destination value for eased property
    
    RETURN:
        tween id
    
    INFO:
        A stripped down version of TweenFire() with only essential parameters for tweening.
        !!Extended property setters are not supported!!
        
    Example:
        TweenGo(x__, EaseInElastic, true, 1.0, x, mouse_x);
*/

return TweenFire(id, argument0, argument1, 0, argument2, 0, argument3, argument4, argument5);