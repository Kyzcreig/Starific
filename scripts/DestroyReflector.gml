///DestroyReflector(target,disable death events)
//TOGGLE DEATH EVENT
var __retoggleturn = argument1;
var tmpMA = MOVE_ACTIVE;

if __retoggleturn and MOVE_ACTIVE {
   MOVE_ACTIVE = false;
}

//DESTROY
with (argument0) {
    event_perform(ev_alarm,0);
}
/*
with(argument0) {
    instance_destroy();
}
*/

if __retoggleturn{
   MOVE_ACTIVE = tmpMA
}
