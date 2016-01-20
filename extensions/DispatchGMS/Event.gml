#define DynamicEventsRegister
/// DynamicEventsRegister(target)

argument0.__DynamicEvents__ = ds_map_create();
#define DynamicEventsUnregister
/// DynamicEventsUnregister(target)


// If dynamic events have been registered
if (argument0.__DynamicEvents__ != -1)
{
    // Iterate through all added event types
    repeat(ds_map_size(argument0.__DynamicEvents__))
    {
        // Get first main event type
        var _eventType = ds_map_find_value(argument0.__DynamicEvents__, ds_map_find_first(argument0.__DynamicEvents__));
        // Remove event type from events map
        ds_map_delete(argument0.__DynamicEvents__, ds_map_find_first(argument0.__DynamicEvents__));
        
        // Iterate through all event numbers of event type
        repeat(ds_map_size(_eventType))
        {
            // Destroy event number dispatcher
            DispatcherDestroy(_eventType[? ds_map_find_first(_eventType)]);
            // Delete event number from event type map
            ds_map_delete(_eventType, ds_map_find_first(_eventType));
        }
    }
   
    // Invalidate Dynamic Events
    argument0.__DynamicEvents__ = -1;
}
#define DynamicEventAdd
/// DynamicEventAdd(target,type,numb,script,[arg0,arg1,...])

var _eventType;
var _eventNumb;
var _dynamicEvents = argument[0].__DynamicEvents__;

if (ds_map_exists(_dynamicEvents, argument[1]) == false)
{
    _eventType = ds_map_create();
    _dynamicEvents[? argument[1]] = _eventType;
}
else
{
    _eventType = _dynamicEvents[? argument[1]];
}

if (ds_map_exists(_eventType, argument[2]) == false)
{
    _eventNumb = DispatcherCreate();
    _eventType[? argument[2]] = _eventNumb;
}
else
{
    _eventNumb = _eventType[? argument[2]];
}

switch(argument_count-4)
{
case 0: return DispatcherAdd(_eventNumb, id, argument[3]); break;
case 1: return DispatcherAdd(_eventNumb, id, argument[3], argument[4]); break;
case 2: return DispatcherAdd(_eventNumb, id, argument[3], argument[4], argument[5]); break;
case 3: return DispatcherAdd(_eventNumb, id, argument[3], argument[4], argument[5], argument[6]); break;
case 4: return DispatcherAdd(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7]); break;
case 5: return DispatcherAdd(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8]); break;
case 6: return DispatcherAdd(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9]); break;
case 7: return DispatcherAdd(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10]); break;
case 8: return DispatcherAdd(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11]); break;
case 9: return DispatcherAdd(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12]); break;
case 10: return DispatcherAdd(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13]); break;
case 11: return DispatcherAdd(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14]); break;
case 12: return DispatcherAdd(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15]); break;
}
#define DynamicEventInsert
/// DynamicEventInsert(target,type,numb,script,[arg0,arg1,...])

var _eventType;
var _eventNumb;
var _dynamicEvents = argument[0].__DynamicEvents__;

if (ds_map_exists(_dynamicEvents, argument[1]) == false)
{
    _eventType = ds_map_create();
    _dynamicEvents[? argument[1]] = _eventType;
}
else
{
    _eventType = _dynamicEvents[? argument[1]];
}

if (ds_map_exists(_eventType, argument[2]) == false)
{
    _eventNumb = DispatcherCreate();
    _eventType[? argument[2]] = _eventNumb;
}
else
{
    _eventNumb = _eventType[? argument[2]];
}

switch(argument_count-4)
{
case 0: return DispatcherInsert(_eventNumb, id, argument[3]); break;
case 1: return DispatcherInsert(_eventNumb, id, argument[3], argument[4]); break;
case 2: return DispatcherInsert(_eventNumb, id, argument[3], argument[4], argument[5]); break;
case 3: return DispatcherInsert(_eventNumb, id, argument[3], argument[4], argument[5], argument[6]); break;
case 4: return DispatcherInsert(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7]); break;
case 5: return DispatcherInsert(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8]); break;
case 6: return DispatcherInsert(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9]); break;
case 7: return DispatcherInsert(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10]); break;
case 8: return DispatcherInsert(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11]); break;
case 9: return DispatcherInsert(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12]); break;
case 10: return DispatcherInsert(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13]); break;
case 11: return DispatcherInsert(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14]); break;
case 12: return DispatcherInsert(_eventNumb, id, argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10], argument[11], argument[12], argument[13], argument[14], argument[15]); break;
}
#define DynamicEventInvoke
/// DynamicEventInvoke(type,numb);

if (__DynamicEvents__ != -1 && ds_map_exists(__DynamicEvents__, argument0))
{
    DispatcherInvoke(ds_map_find_value(ds_map_find_value(__DynamicEvents__, argument0), argument1));
}
#define DynamicEventRemove
/// DynamicEventRemove(target,type,numb,callback)

var _eventType = argument0.__DynamicEvents__[? argument1];
var _eventNumb = _eventType[? argument2];

DispatcherRemove(_eventNumb, argument3);
#define DynamicEventRemoveAll
/// DynamicEventRemoveAll(target,type,numb)

var _eventType = argument0.__DynamicEvents__[? argument1];
var _eventNumb = _eventType[? argument2];

DispatcherRemoveAll(_eventNumb);
#define DynamicEventRemoveScript
/// DynamicEventRemoveScript(target,type,numb,script)

var _eventType = argument0.__DynamicEvents__[? argument1];
var _eventNumb = _eventType[? argument2];

DispatcherRemoveScript(_eventNumb, argument3);
#define DynamicEventRemoveTarget
/// DynamicEventRemoveTarget(target,type,numb,target)

var _eventType = argument0.__DynamicEvents__[? argument1];
var _eventNumb = _eventType[? argument2];

DispatcherRemoveTarget(_eventNumb, argument3);
#define DynamicEventSetEnabled
/// DynamicEventSetEnabled(target,type,numb,enabled)

// IF dynamic events not initialised
if (argument0.__DynamicEvents__ == -1)
{
    // Create eynamic events map
    argument0.__DynamicEvents__ = ds_map_create();
}

// Get event type map
var _eventType = argument0.__DynamicEvents__[? argument1];

// IF event type map doesn't exist
if (_eventType == 0)
{
    // Create event type map
    _eventType = ds_map_create();
    // Assign event type to dynamic events map
    argument0.__DynamicEvents__[? argument1] = _eventType;
}

// Get event number dispatcher
var _eventNumb = _eventType[? argument2];

// IF event number dispatcher doesn't exist
if (_eventNumb == 0)
{
    // Create event number map dispather
    _eventNumb = DispatcherCreate();
    // Assign event number dispatcher to event type map
    _eventType[? argument2] = _eventNumb;
}

// Set dispatcher enabled state
DispatcherSetEnabled(_eventNumb, argument3);
#define DynamicEventGetEnabled
/// DynamicEventGetEnabled(target,type,numb)

// Cache dynamic events
var _dynamicEvents = argument0.__DynamicEvents__;

// IF dynamic events not initialised
if (_dynamicEvents != -1 && ds_map_exists(_dynamicEvents, argument1))
{
    // Get event type map
    var _eventType = _dynamicEvents[? argument1];
    
    if (ds_map_exists(_eventType, argument2))
    {
        // Get event number dispatcher
        var _eventNumb = _eventType[? argument2];
        // Return dispatcher enabled state
        return DispatcherGetEnabled(_eventNumb);
    }
}

return true;

