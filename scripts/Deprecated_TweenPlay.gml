#define Deprecated_TweenPlay


#define TweenPlayOnce
/// TweenPlayOnce(**Deprecated**tween,[ease,start,dest,dur])

var _t = TGMS_FetchTween(argument[0]);
if (is_undefined(_t)) { return 0; }

if (argument_count == 1)
{
    TweenSetMode(_t, TWEEN_MODE_ONCE);
    TweenPlay(_t);
}
else
{
    TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], argument[1], TWEEN_MODE_ONCE, _t[TWEEN.DELTA], 0, argument[4], argument[2], argument[3]); 
}

#define TweenPlayBounce
/// TweenPlayBounce(**Deprecated**tween,[ease,start,dest,dur])

var _t = TGMS_FetchTween(argument[0]);
if (is_undefined(_t)) { return 0; }

if (argument_count == 1)
{
    TweenSetMode(_t, TWEEN_MODE_BOUNCE);
    TweenPlay(_t);
}
else
{
    TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], argument[1], TWEEN_MODE_BOUNCE, _t[TWEEN.DELTA], 0, argument[4], argument[2], argument[3]); 
}

#define TweenPlayPatrol
/// TweenPlayPatrol(**Deprecated**tween,[ease,start,dest,dur])

var _t = TGMS_FetchTween(argument[0]);
if (is_undefined(_t)) { return 0; }

if (argument_count == 1)
{
    TweenSetMode(_t, TWEEN_MODE_PATROL);
    TweenPlay(_t);
}
else
{
    TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], argument[1], TWEEN_MODE_PATROL, _t[TWEEN.DELTA], 0, argument[4], argument[2], argument[3]); 
}

#define TweenPlayLoop
/// TweenPlayLoop(**Deprecated**tween,[ease,start,dest,dur])

var _t = TGMS_FetchTween(argument[0]);
if (is_undefined(_t)) { return 0; }

if (argument_count == 1)
{
    TweenSetMode(_t, TWEEN_MODE_LOOP);
    TweenPlay(_t);
}
else
{
    TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], argument[1], TWEEN_MODE_LOOP, _t[TWEEN.DELTA], 0, argument[4], argument[2], argument[3]); 
}

#define TweenPlayRepeat
/// TweenPlayRepeat(**Deprecated**tween,[ease,start,dest,dur])

var _t = TGMS_FetchTween(argument[0]);
if (is_undefined(_t)) { return 0; }

if (argument_count == 1)
{
    TweenSetMode(_t, TWEEN_MODE_REPEAT);
    TweenPlay(_t);
}
else
{
    TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], argument[1], TWEEN_MODE_REPEAT, _t[TWEEN.DELTA], 0, argument[4], argument[2], argument[3]); 
}

#define TweenPlayOnceDelay
/// TweenPlayOnceDelay(**Deprecated**tween,delay[,ease,start,dest,dur])

var _t = TGMS_FetchTween(argument[0]);
if (is_undefined(_t)) { return 0; }
    
if (argument_count == 2)
{    
    return TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], _t[TWEEN.EASE], TWEEN_MODE_ONCE, _t[TWEEN.DELTA], argument[1], _t[TWEEN.DURATION], _t[TWEEN.START], _t[TWEEN.START]+_t[TWEEN.CHANGE]);
}
else
{
    return TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], argument[2], TWEEN_MODE_ONCE, _t[TWEEN.DELTA], argument[1], argument[5], argument[3], argument[4]);   
}

#define TweenPlayBounceDelay
/// TweenPlayBounceDelay(**Deprecated**tween,delay[,ease,start,dest,dur])

var _t = TGMS_FetchTween(argument[0]);
if (is_undefined(_t)) { return 0; }
    
if (argument_count == 2)
{    
    return TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], _t[TWEEN.EASE], TWEEN_MODE_BOUNCE, _t[TWEEN.DELTA], argument[1], _t[TWEEN.DURATION], _t[TWEEN.START], _t[TWEEN.START]+_t[TWEEN.CHANGE]);
}
else
{
    return TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], argument[2], TWEEN_MODE_BOUNCE, _t[TWEEN.DELTA], argument[1], argument[5], argument[3], argument[4]);   
}

#define TweenPlayPatrolDelay
/// TweenPlayPatrolDelay(**Deprecated**tween,delay[,ease,start,dest,dur])

var _t = TGMS_FetchTween(argument[0]);
if (is_undefined(_t)) { return 0; }
    
if (argument_count == 2)
{    
    return TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], _t[TWEEN.EASE], TWEEN_MODE_PATROL, _t[TWEEN.DELTA], argument[1], _t[TWEEN.DURATION], _t[TWEEN.START], _t[TWEEN.START]+_t[TWEEN.CHANGE]);
}
else
{
    return TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], argument[2], TWEEN_MODE_PATROL, _t[TWEEN.DELTA], argument[1], argument[5], argument[3], argument[4]);   
}

#define TweenPlayLoopDelay
/// TweenPlayLoopDelay(**Deprecated**tween,delay[,ease,start,dest,dur])

var _t = TGMS_FetchTween(argument[0]);
if (is_undefined(_t)) { return 0; }
    
if (argument_count == 2)
{    
    return TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], _t[TWEEN.EASE], TWEEN_MODE_LOOP, _t[TWEEN.DELTA], argument[1], _t[TWEEN.DURATION], _t[TWEEN.START], _t[TWEEN.START]+_t[TWEEN.CHANGE]);
}
else
{
    return TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], argument[2], TWEEN_MODE_LOOP, _t[TWEEN.DELTA], argument[1], argument[5], argument[3], argument[4]);   
}

#define TweenPlayRepeatDelay
/// TweenPlayRepeatDelay(**Deprecated**tween,delay[,ease,start,dest,dur])

var _t = TGMS_FetchTween(argument[0]);
if (is_undefined(_t)) { return 0; }
    
if (argument_count == 2)
{    
    return TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], _t[TWEEN.EASE], TWEEN_MODE_REPEAT, _t[TWEEN.DELTA], argument[1], _t[TWEEN.DURATION], _t[TWEEN.START], _t[TWEEN.START]+_t[TWEEN.CHANGE]);
}
else
{
    return TweenPlay(_t, _t[TWEEN.PROPERTY_RAW], argument[2], TWEEN_MODE_REPEAT, _t[TWEEN.DELTA], argument[1], argument[5], argument[3], argument[4]);   
}