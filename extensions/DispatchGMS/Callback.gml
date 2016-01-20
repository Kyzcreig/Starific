#define DispatcherCallbackExists
/// DispatcherCallbackExists(callback)

return ds_map_exists(global.DGMS_MAP_CALLBACK, argument0);
#define DispatcherCallbackDefine
/// DispatcherCallbackDefine(dispatcher,callback,target,script,[arg0,arg1,...])

// IF dispatcher not null
if (argument[0])
{
    // Get dispatcher
    var _dispatcher = global.DGMS_MAP_DISPATCHER[? argument[0]];
    // Get callback
    var _cb = global.DGMS_MAP_CALLBACK[? argument[1]];
    // Signal callback to be defined
    _cb[@ 0] = -10;
    
    // Find index of callback to define
    var _cbIndex = ds_list_size(_dispatcher);
    repeat(_cbIndex-3)
    {
        // Get callback
        var _cb = _dispatcher[| --_cbIndex];
        
        // IF callback is designated for being defined
        if (_cb[0] == -10)
        {
            break;
        }
    }
    
    // Declare value to hold new callback array
    var _cbNew; 
    // Create index for iterating argument adding
    var _iarg = argument_count;
    
    // Add arguments to callback -- in reverse for improved performance
    repeat(argument_count-4)
    {
        --_iarg;
        _cbNew[_iarg] = argument[_iarg];
    }
    
    // Set active target
    _cbNew[3] = argument[2];
    // Set self reference index
    _cbNew[2] = argument[1];
    // Add script to callback
    _cbNew[1] = argument[3];
    // Add target to callback
    _cbNew[0] = argument[2];
    // Assign updated callback to dispatcher
    _dispatcher[| _cbIndex] = _cbNew;
    // Update callback index map with new callback array
    global.DGMS_MAP_CALLBACK[? argument[1]] = _cbNew;
}
#define DispatcherCallbackSetEnabled
/// DispatcherCallbackSetEnabled(callback,enabled)

// IF callback not null
if (argument0)
{
    // Get callback data
    var _callback = global.DGMS_MAP_CALLBACK[? argument0];
    
    // IF to enable
    if (argument1)
    {
        // Set active target as callback target
        _callback[@ 3] = _callback[0];
    }
    else
    {
        // Set active target as 'noone' -- effectively preventing calls
        _callback[@ 3] = noone;
    }
}
#define DispatcherCallbackGetEnabled
/// DispatcherCallbackGetEnabled(callback)

// IF callback not null
if (argument0)
{
    // Get callback data
    var _callback = global.DGMS_MAP_CALLBACK[? argument0];

    // Return true if active target isn't 'noone'
    return _callback[3] != noone;
}
#define DispatcherCallbackNull
/// DispatcherCallbackNull()

return 0;
