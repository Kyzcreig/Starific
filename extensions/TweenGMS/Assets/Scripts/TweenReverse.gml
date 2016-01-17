#define TweenReverse
/// TweenReverse(tween)
/*
    @tween = tween id
    
    RETURN:
        NA
        
    INFO:
        Reverses play direction of specified tween
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) { return 0; }

if (_t[TWEEN.STATE] > 0 || _t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
{
    _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];
    _t[@ TWEEN.TIME_SCALE] = -_t[TWEEN.TIME_SCALE];
    TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_REVERSE);
}

#define TweenReverseAll
/// TweenReverseAll(deactivated)
/*
    @deactivated = affect tweens associated with deactivated targets?
    
    RETURN:
        NA
        
    INFO:
        Reverses play direction of all active tweens
*/

TweensExecute(TWEENS_ALL, 0, argument0, TweenReverse);

#define TweenReverseGroup
/// TweenReverseGroup(group,deactivated)
/*
    @group       = tween group
    @deactivated = affect tweens associated with deactivated targets?
    
    RETURN:
        NA
        
    INFO:
        Reverses tweens associated with specified tween group
*/

TweensExecute(TWEENS_GROUP, argument0, argument1, TweenReverse);

#define TweenReverseTarget
/// TweenReverseTarget(target,deactivated)
/*
    @target      = target instance id or object index
    @deactivated = affect tweens associated with deactivated targets?
    
    RETURN:
        NA
        
    INFO:
        Reverses play direction of tweens associated with target
*/

TweensExecute(TWEENS_TARGET, argument0, argument1, TweenReverse);