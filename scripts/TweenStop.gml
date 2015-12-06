#define TweenStop
/// TweenStop(tween)
/*
    @tween = tween id
    
    RETURN:
        na
        
    INFO:
        Stops the specified tween
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) { return 0; }

if (_t[TWEEN.STATE] >= 0 || _t[TWEEN.STATE] <= TWEEN_STATE.PAUSED)
{
    if (_t[TWEEN.DELAY] > 0)
    {
        _t[@ TWEEN.DELAY] = -1;
        _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;
        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_STOP_DELAY);
    }
    else
    {
        if (_t[TWEEN.DELAY] != -10) { _t[@ TWEEN.DELAY] = -1; }
        _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;
        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_STOP);
    }
        
    if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }
}

#define TweenStopAll
/// TweenStopAll(deactivated)
/*
    @deactivated = affect tweens associated with deactivated targets?
    
    RETURN:
        NA
        
    INFO:
        Stops all active tweens
*/

TweensExecute(TWEENS_ALL, 0, argument0, TweenStop);


#define TweenStopGroup
/// TweenStopGroup(group,deactivated)
/*
    @group       = tween group
    @deactivated = affect tweens associated with deactivated targets?
    
    RETURN:
        NA
        
    INFO:
        Stops all active tweens associated with specified tween group
*/

TweensExecute(TWEENS_GROUP, argument0, argument1, TweenStop);

#define TweenStopTarget
/// TweenStopTarget(target,deactivated)
/*
    @target      = target instance id or object index
    @deactivated = include tweens associated with deactivated targets? 
    
    RETURN:
        NA
        
    INFO:
        Stops all active tweens associated with specified target
*/

TweensExecute(TWEENS_TARGET, argument0, argument1, TweenStop);