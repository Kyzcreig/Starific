///DestroyReflector(id,toggleMA)
//TOGGLE DEATH EVENT
var tmp = MOVE_ACTIVE;
var toggleMA = argument1;

if toggleMA and MOVE_ACTIVE {
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

if toggleMA{
   MOVE_ACTIVE = tmp
}
