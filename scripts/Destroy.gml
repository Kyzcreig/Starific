#define Destroy
///Destroy(target)

with(argument0) instance_destroy();

#define ShowMessage
///ShowMessage(string)

show_message(argument0);

#define ShowDebugArray
///ShowDebugArray(array)

var arr = argument0;
show_message(string(arr[0]));
#define EventUser
///EventUser(target,number)
with (argument0) {
    event_user(argument1);
}