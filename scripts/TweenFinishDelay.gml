#define TweenFinishDelay
/// TweenFinishDelay(tween,call_event)
/*

*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) { return undefined; }

if (_t[TWEEN.DELAY] > 0)
{
    // Mark delay for removal from delay list
    _t[@ TWEEN.DELAY] = -1; 
    
    // Execute FINISH DELAY event
    if (argument1) { TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH_DELAY); }
    // Set tween as active
    _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];                      
    // Update property with start value
    if (argument1) { script_execute(_t[TWEEN.PROPERTY], _t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET]); }
    // Execute PLAY event
    TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_PLAY);
}

#define TweenFinishDelayAll
/// TweenFinishDelayAll(call_event,deactivated)

TweensExecute(TWEENS_ALL, 0, argument1, TweenFinishDelay, argument0);

#define TweenFinishDelayGroup
/// TweenFinishDelayGroup(group,call_event,deactivated)

TweensExecute(TWEENS_GROUP, argument0, argument2, TweenFinishDelay, argument1);

#define TweenFinishDelayTarget
/// TweenFinishDelayTarget(target,call_event,deactivated)

TweensExecute(TWEENS_TARGET, argument0, argument2, TweenFinishDelay, argument1);