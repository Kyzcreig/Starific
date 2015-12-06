///scr_inc_button_array_cursor(array,cursor)

//Increment Cursor Position
var unlock_array = argument0;
var unlock_cursor = argument1;

unlock_cursor[@ 0] = (++unlock_cursor[@ 0]) mod array_length_1d(unlock_array)

return unlock_array[unlock_cursor[0]];
