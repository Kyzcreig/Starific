/// TPSetExt(**Deprecated**ext_property,arg0,arg1,...)
/*
    Creates and returns an extended tween property.
*/

var _property;
var _args;

// Set extended property setter script
_property[0] = argument[0];
// Set final property argument first, for arry array init optimisation
_args[argument_count-2] = argument[argument_count-1];

// Add remaining property arguments
var _argIndex = -1;
repeat(argument_count-2)
{
    ++_argIndex;
    _args[_argIndex] = argument[_argIndex+1];
}

// Add arguments to property
_property[1] = _args;

// Return property handle
return _property;
