///ds_map_add_value(id, key, value)

var map_id = argument0;
var key = argument1;
var val = argument2;

// Check if Key in Map
if ds_map_exists(map_id, key) { 
    //If Key Already in Map, overwrite it
    map_id[? key] = val;
} else {
    // Add Key to Map
    ds_map_add(map_id, key, val);
}
