#define Array
///Array(arg0, arg1, ...);

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


#define ArrayInit
///ArrayInit(val,repeat)

var arr = noone;
for (var i = 0, n = argument1; i < n; i++ ){

    arr[i] = argument0;    
}

return arr;