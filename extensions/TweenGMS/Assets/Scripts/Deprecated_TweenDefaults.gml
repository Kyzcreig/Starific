#define Deprecated_TweenDefaults



#define TweenDefaultSetGroup
/// TweenDefaultSetGroup(**Deprecated**group)
/*
    Set default group assigned to newly created tweens
*/

global.TGMS_TweenDefault[@ TWEEN.GROUP] = argument0;

#define TweenDefaultGetGroup
/// TweenDefaultGetGroup(**Deprecated**)
/*
    Get default group assigned to newly created tweens
*/

return global.TGMS_TweenDefault[TWEEN.GROUP];

#define TweenDefaultSetTimeScale
/// TweenDefaultSetTimeScale(**Deprecated**scale)
/*
    Set default time scale assigned to newly created tweens
*/

global.TGMS_TweenDefault[@ TWEEN.TIME_SCALE] = clamp(argument0, 0, 100);

#define TweenDefaultGetTimeScale
/// TweenDefaultGetTimeScale(**Deprecated**)
/*
    Get default time scale assigned to newly created tweens
*/

return global.TGMS_TweenDefault[TWEEN.TIME_SCALE];

#define TweenDefaultDestroyWhenDone
/// TweenDefaultDestroyWhenDone(**Deprecated**destroy)
/*
    Indicate if created tweens should be destroyed by default when done
*/

global.TGMS_TweenDefault[@ TWEEN.DESTROY] = argument0;