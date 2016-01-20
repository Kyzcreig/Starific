#define DispatcherCreate
/// DispatcherCreate()

// Create list to hold dispatcher data
var _dispatcher = ds_list_create();
// Get new dispatcher index handle
var _index = ++global.DGMS_INDEX_DISPATCHER;
// Add dispatcher STATE | INDEX HANDLE | ENABLED
ds_list_add(_dispatcher, -1, _index, true);
// Add dispatcher to index map
global.DGMS_MAP_DISPATCHER[? _index] = _dispatcher;
// Return new index handle
return _index;
#define DispatcherDestroy
/// DispatcherDestroy(dispatcher)

// IF dispatcher not null
if (argument0)
{
    // Get dispatcher from index map
    var _dispatcher = global.DGMS_MAP_DISPATCHER[? argument0];
    // Invalidate index map handle
    ds_map_delete(global.DGMS_MAP_DISPATCHER, argument0);
    
    // Iterate through all dispatcher callbacks
    var _cbIndex = ds_list_size(_dispatcher);
    repeat(_cbIndex-3)
    {
        // Get callback
        var _cb = _dispatcher[| --_cbIndex];
        
        // IF callback not null
        if (_cb[0] != noone)
        {
            // Invalidate callback index handle
            ds_map_delete(global.DGMS_MAP_CALLBACK, _cb[2]);
            // Mark callback for removal
            _cb[@ 0] = noone;
            // Nullify self-referenced index handle
            _cb[@ 2] = 0;
        }
    }
    
    // IF dispatcher not currently invoked
    if (_dispatcher[| 0] == -1)
    {   
        // Destroy dispatcher
        ds_list_destroy(_dispatcher);
    }
    else
    {
        // Mark dispatcher for safe destruction
        _dispatcher[| 0] = -3;
    }
}
#define DispatcherAdd
/// DispatcherAdd(dispatcher,target,script,[arg0,arg1,arg2,...])

// IF dispatcher not null
if (argument[0])
{
    // Declare callback array
    var _cb;
    // Create index for iterating argument adding
    var _iarg = argument_count;
    
    // Add arguments to callback -- in reverse for improved performance
    repeat(argument_count-3)
    {
        --_iarg;
        _cb[_iarg+1] = argument[_iarg];
    }
    
    // Get new index handle
    var _cbHandle = ++global.DGMS_INDEX_CALLBACK;
    // Set active target -- used for disabling callback
    _cb[3] = argument[1];
    // Assign index handle to callback
    _cb[2] = _cbHandle;
    // Add script to callback
    _cb[1] = argument[2];
    // Add target to callback
    _cb[0] = argument[1];
    
    // Assign new map/index reference
    global.DGMS_MAP_CALLBACK[? _cbHandle] = _cb;
    // Add callback to dispatcher
    ds_list_add(global.DGMS_MAP_DISPATCHER[? argument[0]], _cb);
    // Return new callback index handle
    return _cbHandle;
}
#define DispatcherInsert
/// DispatcherInsert(dispatcher,target,script,[arg0,arg1,arg2,...])

// IF dispatcher not null
if (argument[0])
{
    // Declare callback array
    var _cb;
    // Create index for iterating argument adding
    var _iarg = argument_count;
    
    // Add arguments to callback -- in reverse for improved performance
    repeat(argument_count-3)
    {
        --_iarg;
        _cb[_iarg+1] = argument[_iarg];
    }
    
    // Get new index handle
    var _cbHandle = ++global.DGMS_INDEX_CALLBACK;
    // Set active target -- used for disabling callback
    _cb[3] = argument[1];
    // Assign index handle to callback
    _cb[2] = _cbHandle;
    // Add script to callback
    _cb[1] = argument[2];
    // Add target to callback
    _cb[0] = argument[1];
    
    // Assign new map/index reference
    global.DGMS_MAP_CALLBACK[? _cbHandle] = _cb;
    // Add callback to dispatcher
    ds_list_insert(global.DGMS_MAP_DISPATCHER[? argument[0]], 3, _cb);
    // Return new callback index handle
    return _cbHandle;
}
#define DispatcherInvoke
/// DispatcherInvoke(dispatcher)

// IF dispatcher isn't null
if (argument0)
{
    // Get dispatcher
    var _dispatcher = global.DGMS_MAP_DISPATCHER[? argument0];
    
    // IF dipsatcher contains callbacks AND is enabled
    if (ds_list_size(_dispatcher) > 3 && _dispatcher[| 2])
    {
        // Hold return value for first callback
        var _return = 0;
        // Used to reference callback indexes within dispatcher -- callback indexes start at 3
        var _index = 3;
        // Set dispatcher list state as being invoked
        _dispatcher[| 0] = -2;
        
        //------------------------------------------------
        // Execute first callback and get return value
        //------------------------------------------------
        // Get first callback
        var _cb = _dispatcher[| _index];
        
        // Execute callback script with appropriate set of arguments
        switch(array_length_1d(_cb) - 4)
        {
        case 0: with(_cb[3]) _return = script_execute(_cb[1]); break;
        case 1: with(_cb[3]) _return = script_execute(_cb[1], _cb[4]); break;
        case 2: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5]); break;
        case 3: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6]); break;
        case 4: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7]); break;
        case 5: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8]); break;
        case 6: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9]); break;
        case 7: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10]); break;
        case 8: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11]); break;
        case 9: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12]); break;
        case 10: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12], _cb[13]); break;
        case 11: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12], _cb[13], _cb[14]); break;
        case 12: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12], _cb[13], _cb[14], _cb[15]); break;
        case 13: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12], _cb[13], _cb[14], _cb[15], _cb[16]); break;
        default:
            // Remove callback marked for destruction -- decrement index
            ds_list_delete(_dispatcher, _index--);
               
            // Try to find replacement for return value
            repeat(ds_list_size(_dispatcher) - 3)
            {
                // Get callback
                _cb = _dispatcher[| ++_index];
                
                // IF callback is null
                if (_cb[0] == noone)
                {
                    // Remove from dispatcher
                    ds_list_delete(_dispatcher, _index--);
                }
                else
                {
                    // Execute callback script with appropriate set of arguments and get return value
                    switch(array_length_1d(_cb) - 4)
                    {
                    case 0: with(_cb[3]) _return = script_execute(_cb[1]); break;
                    case 1: with(_cb[3]) _return = script_execute(_cb[1], _cb[4]); break;
                    case 2: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5]); break;
                    case 3: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6]); break;
                    case 4: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7]); break;
                    case 5: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8]); break;
                    case 6: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9]); break;
                    case 7: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10]); break;
                    case 8: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11]); break;
                    case 9: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12]); break;
                    case 10: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12], _cb[13]); break;
                    case 11: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12], _cb[13], _cb[14]); break;
                    case 12: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12], _cb[13], _cb[14], _cb[15]); break;
                    case 13: with(_cb[3]) _return = script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12], _cb[13], _cb[14], _cb[15], _cb[16]); break;
                    }
                }
            }
        }
        
        //-------------------------------
        // Execute remaining callbacks
        //-------------------------------
        repeat(ds_list_size(_dispatcher) - 4)
        {
            // Cache callback
            _cb = _dispatcher[| ++_index];
        
            // Execute callback script with appropriate set of arguments
            switch(array_length_1d(_cb) - 4)
            {
            case 0: with(_cb[3]) script_execute(_cb[1]); break;
            case 1: with(_cb[3]) script_execute(_cb[1], _cb[4]); break;
            case 2: with(_cb[3]) script_execute(_cb[1], _cb[4], _cb[5]); break;
            case 3: with(_cb[3]) script_execute(_cb[1], _cb[4], _cb[5], _cb[6]); break;
            case 4: with(_cb[3]) script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7]); break;
            case 5: with(_cb[3]) script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8]); break;
            case 6: with(_cb[3]) script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9]); break;
            case 7: with(_cb[3]) script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10]); break;
            case 8: with(_cb[3]) script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11]); break;
            case 9: with(_cb[3]) script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12]); break;
            case 10: with(_cb[3]) script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12], _cb[13]); break;
            case 11: with(_cb[3]) script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12], _cb[13], _cb[14]); break;
            case 12: with(_cb[3]) script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12], _cb[13], _cb[14], _cb[15]); break;
            case 13: with(_cb[3]) script_execute(_cb[1], _cb[4], _cb[5], _cb[6], _cb[7], _cb[8], _cb[9], _cb[10], _cb[11], _cb[12], _cb[13], _cb[14], _cb[15], _cb[16]); break;
            default:
                // Remove callback marked for destruction -- decrement index
                ds_list_delete(_dispatcher, _index--);
            }
        }
        
        // IF dispatcher not marked for destruction
        if (_dispatcher[| 0] != -3)
        {
            // Set dispatcher list state back to normal
            _dispatcher[| 0] = -1;
        }
        else
        {            
            // Destroy dispatcher
            ds_list_destroy(_dispatcher);
        }
        
        // Return value from first callback
        return _return;
    }
}
#define DispatcherInvokeExt
/// DispatcherInvokeExt(dispatcher,[arg0,arg1,arg2,...])

// IF dispatcher isn't null
if (argument[0])
{
    // Get dispatcher
    var _dispatcher = global.DGMS_MAP_DISPATCHER[? argument[0]];
    
    // IF dipsatcher contains callbacks AND is enabled
    if (ds_list_size(_dispatcher) > 3 && _dispatcher[| 2])
    {
        // Hold return value for first callback
        var _return = 0;
        // Used to reference callback indexes within dispatcher -- callback indexes start at 3
        var _index = 3;
        // Set dispatcher list state as being invoked
        _dispatcher[| 0] = -2;
        
        //------------------------------------------------
        // Execute first callback and get return value
        //------------------------------------------------
        // Get first callback
        var _cb = _dispatcher[| _index];
        
        // Execute callback script with appropriate set of arguments
        switch(array_length_1d(_cb) - 4)
        {
        case 0: with(_cb[3]) _return = script_execute(_cb[1]); break;
        case 1: with(_cb[3]) _return = script_execute(_cb[1], argument[1]); break;
        case 2: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2]); break;
        case 3: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3]); break;
        case 4: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4]); break;
        case 5: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5]); break;
        case 6: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6]); break;
        case 7: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7]); break;
        case 8: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8]); break;
        case 9: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9]); break;
        case 10: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10]); break;
        case 11: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11]); break;
        case 12: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12]); break;
        case 13: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13]); break;
        default:
            // Remove callback marked for destruction -- decrement index
            ds_list_delete(_dispatcher, _index--);
               
            // Try to find replacement for return value
            repeat(ds_list_size(_dispatcher) - 3)
            {
                // Get callback
                _cb = _dispatcher[| ++_index];
                
                // IF callback is null
                if (_cb[0] == noone)
                {
                    // Remove from dispatcher
                    ds_list_delete(_dispatcher, _index--);
                }
                else
                {
                    // Execute callback script with appropriate set of arguments and get return value
                    switch(array_length_1d(_cb) - 4)
                    {
                    case 0: with(_cb[3]) _return = script_execute(_cb[1]); break;
                    case 1: with(_cb[3]) _return = script_execute(_cb[1], argument[1]); break;
                    case 2: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2]); break;
                    case 3: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3]); break;
                    case 4: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4]); break;
                    case 5: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5]); break;
                    case 6: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6]); break;
                    case 7: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7]); break;
                    case 8: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8]); break;
                    case 9: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9]); break;
                    case 10: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10]); break;
                    case 11: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11]); break;
                    case 12: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12]); break;
                    case 13: with(_cb[3]) _return = script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13]); break;
                    }
                }
            }
        }
        
        //-------------------------------
        // Execute remaining callbacks
        //-------------------------------
        repeat(ds_list_size(_dispatcher) - 4)
        {
            // Cache callback
            _cb = _dispatcher[| ++_index];
        
            // Execute callback script with appropriate set of arguments
            switch(array_length_1d(_cb) - 4)
            {
            case 0: with(_cb[3]) script_execute(_cb[1]); break;
            case 1: with(_cb[3]) script_execute(_cb[1], argument[1]); break;
            case 2: with(_cb[3]) script_execute(_cb[1], argument[1], argument[2]); break;
            case 3: with(_cb[3]) script_execute(_cb[1], argument[1], argument[2], argument[3]); break;
            case 4: with(_cb[3]) script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4]); break;
            case 5: with(_cb[3]) script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5]); break;
            case 6: with(_cb[3]) script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6]); break;
            case 7: with(_cb[3]) script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7]); break;
            case 8: with(_cb[3]) script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8]); break;
            case 9: with(_cb[3]) script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9]); break;
            case 10: with(_cb[3]) script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10]); break;
            case 11: with(_cb[3]) script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11]); break;
            case 12: with(_cb[3]) script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12]); break;
            case 13: with(_cb[3]) script_execute(_cb[1], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13]); break;
            default:
                // Remove callback marked for destruction -- decrement index
                ds_list_delete(_dispatcher, _index--);
            }
        }
        
        // IF dispatcher not marked for destruction
        if (_dispatcher[| 0] != -3)
        {
            // Set dispatcher list state back to normal
            _dispatcher[| 0] = -1;
        }
        else
        {            
            // Destroy dispatcher
            ds_list_destroy(_dispatcher);
        }
        
        // Return value from first callback
        return _return;
    }
}
#define DispatcherRemove
/// DispatcherRemove(dispatcher,callback)

// IF dispatcher not null
if (argument0)
{
    // Get dispactcher
    var _dispatcher = global.DGMS_MAP_DISPATCHER[? argument0];
    
    // IF callback not null
    if (argument1)
    {
        // Get callback
        _cb = global.DGMS_MAP_CALLBACK[? argument1];
        // Invalidate callback index handle
        ds_map_delete(global.DGMS_MAP_CALLBACK, argument1);
        // Mark callback for removal
        _cb[@ 0] = noone;
        // Nullify self-referenced index handle
        _cb[@ 2] = 0;
         
        // Cycle through all callbacks to find index of invalidated callback
        var _cbIndex = ds_list_size(_dispatcher);
        repeat(_cbIndex-3)
        {
            // Callback to check for removal
            var _cbCheck = _dispatcher[| --_cbIndex];
            
            // IF callback designated for removal
            if (_cbCheck[0] == noone)
            {
                // IF dispatcher is not being invoked
                if (_dispatcher[| 0] == -1)
                {  
                    // Remove callback from dispatcher
                    ds_list_delete(_dispatcher, _cbIndex);
                }
                else
                {
                    // Signal for later removal
                    _dispatcher[| _cbIndex] = global.DGMS_NULL_CALLBACK;
                }
            }
        }
    }
}
#define DispatcherRemoveAll
/// DispatcherRemoveAll(dispatcher)

// IF dispatcher not null
if (argument0)
{
    // Get dispactcher
    var _dispatcher = global.DGMS_MAP_DISPATCHER[? argument0];

    // Cycle through all callbacks to find index of invalidated callback
    var _cbIndex = ds_list_size(_dispatcher);
    repeat(_cbIndex-3)
    {
        // Callback to check for removal
        var _cb = _dispatcher[| --_cbIndex];
        
        // IF callback not already designated for removal
        if (_cb[0] != noone)
        {
            // Invalidate callback index handle
            ds_map_delete(global.DGMS_MAP_CALLBACK, _cb[2]);
            // Mark callback for removal
            _cb[@ 0] = noone;
            // Nullify self-referenced index handle
            _cb[@ 2] = 0;
        }
        
        // IF dispatcher is not being invoked
        if (_dispatcher[| 0] == -1)
        {  
            // Remove callback from dispatcher
            ds_list_delete(_dispatcher, _cbIndex);
        }
        else
        {
            // Signal for later removal
            _dispatcher[| _cbIndex] = global.DGMS_NULL_CALLBACK;
        }
    }
}
#define DispatcherRemoveScript
/// DispatcherRemoveScript(dispatcher,script)

// IF dispatcher not null
if (argument0)
{
    // Get dispactcher
    var _dispatcher = global.DGMS_MAP_DISPATCHER[? argument0];
    
    // Cycle through all callbacks to find index of invalidated callback
    var _cbIndex = ds_list_size(_dispatcher);
    repeat(_cbIndex-3)
    {
        // Callback to check for removal
        var _cb = _dispatcher[| --_cbIndex];
        
        // IF callback designated for removal
        if (_cb[1] == argument1)
        {
            // Mark callback for removal
            _cb[@ 0] = noone;
            // Invalidate callback index handle
            ds_map_delete(global.DGMS_MAP_CALLBACK, _cb[2]);
            // Nullify self-referenced index handle
            _cb[@ 2] = 0;
    
            // IF dispatcher is not being invoked
            if (_dispatcher[| 0] == -1)
            {  
                // Remove callback from dispatcher
                ds_list_delete(_dispatcher, _cbIndex);
            }
            else
            {
                // Signal for later removal
                _dispatcher[| _cbIndex] = global.DGMS_NULL_CALLBACK;
            }
        }
    }
}
#define DispatcherRemoveTarget
/// DispatcherRemoveTarget(dispatcher,target)

// IF dispatcher not null
if (argument0)
{
    // Get dispactcher
    var _dispatcher = global.DGMS_MAP_DISPATCHER[? argument0];
    
    // Cycle through all callbacks to find index of invalidated callback
    var _cbIndex = ds_list_size(_dispatcher);
    repeat(_cbIndex-3)
    {
        // Callback to check for removal
        var _cb = _dispatcher[| --_cbIndex];
        
        // IF callback designated for removal
        if (_cb[0] == argument1)
        {
            // Mark callback for removal
            _cb[@ 0] = noone;
            // Invalidate callback index handle
            ds_map_delete(global.DGMS_MAP_CALLBACK, _cb[2]);
            // Nullify self-referenced index handle
            _cb[@ 2] = 0;
    
            // IF dispatcher is not being invoked
            if (_dispatcher[| 0] == -1)
            {  
                // Remove callback from dispatcher
                ds_list_delete(_dispatcher, _cbIndex);
            }
            else
            {
                // Signal for later removal
                _dispatcher[| _cbIndex] = global.DGMS_NULL_CALLBACK;
            }
        }
    }
}
#define DispatcherSetEnabled
/// DispatcherSetEnabled(dispatcher,enabled)

// IF dispatcher not null
if (argument0)
{
    // Get dispatcher data
    var _dispatcher = global.DGMS_MAP_DISPATCHER[? argument0];
    // Set dispatcher's [enabled] boolean state
    _dispatcher[| 2] = argument1;
}
#define DispatcherGetEnabled
/// DispatcherGetEnabled(dispatcher)

// IF dispatcher not null
if (argument0)
{
    // Get dispatcher data
    var _dispatcher = global.DGMS_MAP_DISPATCHER[? argument0];
    // Return dispatcher's [enabled] boolean state
    return _dispatcher[| 2];
}
#define DispatcherHasScript
/// DispatcherHasScript(dispatcher,script)

// IF dispatcher not null
if (argument0)
{
    // Get dispatcher
    var _dispatcher = global.DGMS_MAP_DISPATCHER[? argument0];
    
    // Iterate through dispatcher callbacks
    var _cbIndex = 2;
    repeat(ds_list_size(_dispatcher) - 3)
    {
        // Get callback
        var _cb = _dispatcher[| ++_cbIndex];
        
        // IF callback script equals checked script
        if (_cb[1] == argument1)
        { 
            return true;
        }
    } 
}
#define DispatcherHasTarget
/// DispatcherHasTarget(dispatcher,target)

// IF dispatcher not null
if (argument0)
{
    // Get dispatcher
    var _dispatcher = global.DGMS_MAP_DISPATCHER[? argument0];
    
    // Iterate through dispatcher callbacks
    var _cbIndex = 2;
    repeat(ds_list_size(_dispatcher) - 3)
    {
        // Get callback
        var _cb = _dispatcher[| ++_cbIndex];
        
        // IF callback target equals checked target
        if (_cb[0] == argument1)
        { 
            return true;
        }
    } 
}
#define DispatcherSize
/// DispatcherSize(dispatcher)

// IF dispather not null
if (argument0)
{
    // Get dispatcher data
    var _dispatcher = global.DGMS_MAP_DISPATCHER[? argument0];
    // Init variable to hold count
    var _count = 0;
    
    // Iterate through dispatcher callbacks
    var _index = 2;
    repeat(ds_list_size(_dispatcher) - 3)
    {
        _count += array_length_1d(_dispatcher[| ++_index]) > 1;
    }
    
    // Return callback count
    return _count
}
#define DispatcherExists
/// DispatcherExists(dispatcher)

// Return true if dispatcher not null and dispatcher index exists in dispatcher map
return ds_map_exists(global.DGMS_MAP_DISPATCHER, argument0);
#define DispatcherNull
/// DispatcherNull()

return 0;
