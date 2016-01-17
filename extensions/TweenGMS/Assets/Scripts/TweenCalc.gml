#define TweenCalc
/// TweenCalc(tween)
/*
    @tween = tween id
    
    RETURN:
        real
        
    INFO:
        Returns a calculated value using a tweens current state.
        
        Note: Useful with null property setters which can be set by
        using an empty string "" for property argument.
        
    EXAMPLE:
        // Create defined tween
        tween = TweenFire(id, "", EaseInOutQuint, 0, true, 0.0, 2.5, x, mouse_x);
        
        // Calculate value of tween at its current state
        x = TweenCalcAmount(tween);
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) return 0;

var _duration = _t[TWEEN.DURATION];

// Return start if duration is invalid
if (_duration == 0) { return _t[TWEEN.START]; }

// Return tween's calculated value for its current state
return script_execute(_t[TWEEN.EASE], clamp(_t[TWEEN.TIME], 0, _duration), _t[TWEEN.START], _t[TWEEN.CHANGE], _duration);

#define TweenCalcTime
/// TweenCalcTime(tween,time)
/*
    @tween = tween id
    @time  = specific time in steps or seconds
    
    RETURN:
        real
        
    INFO:
        Returns a calculated value using a tweens current state
        at a specified point in time.
        
        Note: Useful with null property setters which can be set by
        using an empty string "" for property argument.
        
    EXAMPLE:
        // Create defined tween
        tween = TweenCreate(id, "", EaseInOutQuint, 0, true, 0.0, 2.5, x, mouse_x);
        
        // Calculate value of tween at 1.5 seconds through time
        x = TweenCalcAmount(tween, 1.5);
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) return 0;
    
// Return start if duration is invalid
if (_t[TWEEN.DURATION] == 0) { return _t[TWEEN.START]; }

// Return tween's calculated value based on its state at a set time
return script_execute(_t[TWEEN.EASE], argument1, _t[TWEEN.START], _t[TWEEN.CHANGE], _t[TWEEN.DURATION]);

#define TweenCalcAmount
/// TweenCalcAmount(tween,amount)
/*
    @tween  = tween id
    @amount = relative time between 0.0 and 1.0
    
    RETURN:
        real
        
    INFO:
        Returns a calculated value using a tweens current state
        at a relative point in time.
        
        Note: Useful with null property setters which can be set by
        using an empty string "" for property argument.
        
    EXAMPLE:
        // Create defined tween
        tween = TweenCreate(id, "", EaseInOutQuint, 0, true, 0.0, 2.5, x, mouse_x);
        
        // Calculate value of tween at 25% through time
        x = TweenCalcAmount(tween, 0.25);
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) return 0;

// Return start if duration is invalid
if (_t[TWEEN.DURATION] == 0) { return _t[TWEEN.START]; }

// Return tween's calculated value based on its state at a relative amount of time
return script_execute(_t[TWEEN.EASE], argument1, _t[TWEEN.START], _t[TWEEN.CHANGE], 1);