#define TweenPause
/// TweenPause(tween)
/*
    @tween = tween id
    
    RETURN:
        NA
        
    INFO:
        Pauses specified tween
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) { return 0; }
    
if (_t[TWEEN.STATE] >= 0)
{
    _t[@ TWEEN.STATE] = TWEEN_STATE.PAUSED;
    TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PAUSE);
}
else
if (_t[TWEEN.STATE] == TWEEN_STATE.DELAYED)
{
    _t[@ TWEEN.STATE] = TWEEN_STATE.PAUSED;
    TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PAUSE_DELAY);
}

#define TweenPauseAll
/// TweenPauseAll(deactivated)
/*
    @deactivated = affect tweens associated with deactivated targets?
    
    RETURN:
        NA
        
    INFO:
        Pauses all active tweens
*/

TweensExecute(TWEENS_ALL, 0, argument0, TweenPause);

#define TweenPauseGroup
/// TweenPauseGroup(group,deactivated)
/*
    @group       = tween group
    @deactivated = affect tweens associated with deactivated targets?
    
    RETURN:
        NA
        
    INFO:
        Pauses all active tweens associated with specified tween group
*/

TweensExecute(TWEENS_GROUP, argument0, argument1, TweenPause);

#define TweenPauseTarget
/// TweenPauseTarget(target,deactivated)
/*
    @target = target instance id or object index
    
    RETURN:
        NA
        
    INFO:
        Pauses all active tweens associated with specified target
*/

TweensExecute(TWEENS_GROUP, argument0, argument1, TweenPause);