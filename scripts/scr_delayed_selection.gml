///scr_delayed_selection(array,value)

var selection_array = argument0;
var index = argument1;
selection_array[@ 0] = index;
selection_array[@ 1] = true;

/*
//argument0 = selection_array
if room == rm_options{  //Necessary due to a very silly HTML bug
    selected[@ 0] = index;
    selected[@ 1] = true;
}
*/

event_user(0)
