#define TweenIterator
/// TweenIterator(**Deprecated**)
/*
    RETURN:
        iterator
        
    INFO:
        Used to iterate through system's active tween list
        
        I think this kind of stinks right now...
        It might be useful, but I'll be looking into a better/faster solution.

    EXAMPLE:
        var _iterator = TweenIterator()
        while(TweenIteratorNext(_iterator))
        {
            var _tween = _iterator[0];
            TweenDoSomething(_tween);
        }
*/

var _tweens = SharedTweener().tweens;
var _iterator;

_iterator[0] = -1; // cached tween handle
_iterator[1] = -1; // iterator index
_iterator[2] = ds_list_size(_tweens); // tween list size
_iterator[3] = _tweens; // cache tweens list

return _iterator;

#define TweenIteratorNext
/// TweenIteratorNext(**Deprecated**iterator)

var _iterator = argument0;

while(true)
{
    _iterator[@ 1] += 1;
    
    if (_iterator[1] < _iterator[2])
    {
        var _t = ds_list_find_value(_iterator[3], _iterator[1]);
        
        if (instance_exists(_t[TWEEN.TARGET]))
        {
            _iterator[@ 0] = _t[TWEEN.ID];
            return true;
        }
        
        instance_activate_object(_t[TWEEN.TARGET]);
        
        if (instance_exists(_t[TWEEN.TARGET]))
        {
            instance_deactivate_object(_t[TWEEN.TARGET]);
            _iterator[@ 0] = _t[TWEEN.ID];
            return true;
        }
    }
    else
    {
        return false;
    }
}

#define TweenIteratorReset
/// TweenIteratorReset(**Deprecated**iterator)

var _tweens = SharedTweener().tweens;

argument0[@ 0] = -1; // cached tween handle
argument0[@ 1] = -1; // iterator index
argument0[@ 2] = ds_list_size(_tweens); // tween list size
argument0[@ 3] = _tweens; // cache tweens list