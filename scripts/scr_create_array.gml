#define scr_create_array
///scr_create_array(arg0, arg1, ...);

var _ret, _maxIndex = argument_count-1;

// Set the high argument first, for optimisation
_ret[_maxIndex] = argument[_maxIndex];

// Add remaining arguments to array
var i = -1;
repeat(_maxIndex)
{
    ++i;
    _ret[i] = argument[i];
}

// Return extended data array
return _ret;

#define scr_init_array_loop
///scr_init_array_loop(val,repeat)

var arr = noone;
for (var i = 0, n = argument1; i < n; i++ ){

    arr[i] = argument0;    
}

return arr;