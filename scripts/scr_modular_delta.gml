///scr_modular_delta(start, delta, max_index)

var start_index = argument0;
var delta = argument1;
var max_index = argument2;
// Readjust Adjustor 
while (delta < 0)  {
    //NB: becausse GMS can't handle negative modulo
    delta = max_index + delta;
}

// Return New Index
return (start_index + delta) mod max_index;
