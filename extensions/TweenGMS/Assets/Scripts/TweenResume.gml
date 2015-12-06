#define TweenResume
/// TweenResume(tweens)
/*
    @tween = tween id
    
    RETURN:
        NA
        
    INFO:
        Resumes specified tween
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) { return 0; }
    
if (_t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
{
    if (_t[TWEEN.DELAY] > 0)
    {
        _t[@ TWEEN.STATE] = TWEEN_STATE.DELAYED;
        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_RESUME_DELAY);
    }
    else
    {
        _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];
        TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_RESUME);
    }
}

#define TweenResumeAll
/// TweenResumeAll(deactivated)
/*
    @deactivated = affect tweens with deactivated targets?
    
    RETURN:
        NA
        
    INFO:
        Resumes all active tweens
*/

TweensExecute(TWEENS_ALL, 0, argument0, TweenResume);

#define TweenResumeGroup
/// TweenResumeGroup(group,deactivated)
/*
    @group       = tween group
    @deactivated = affect tweens with deactivated targets?
    
    RETURN:
        NA
        
    INFO:
        Resumes all active tweens associated with specified tween group
*/

TweensExecute(TWEENS_GROUP, argument0, argument1, TweenResume);

#define TweenResumeTarget
/// TweenResumeTarget(target,deactivated)
/*
    @target      = target instance id or object index
    @deactivated = affect tweens with deactivated targets?
    
    RETURN:
        NA
        
    INFO:
        Resumes all active tweens associated with specified target
*/

TweensExecute(TWEENS_TARGET, argument0, argument1, TweenResume);