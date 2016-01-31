#define scr_new_gamemod
///scr_new_gamemod( mod_name, mod_type, sub_type, mod_max_dur, chance,  mod_symbol, mod_icon_text, mod_long_desc, mod_extra_data, mod_enabled)
 
var z;
z = -1;

// Get Gamemod Key
var mod_name = argument[++z];
var mod_type = argument[++z];
var mod_subtype = argument[++z];
var type_index = GAMEMOD_DATA_SIZES[# mod_type, mod_subtype]++; //increment up size count
var key = scr_gamemod_make_key(mod_type, mod_subtype, type_index);//object_get_name(obj_index);
// Add Mapping from obj_index to key
ds_map_add(GAMEMOD_DATA_KEYS, string(mod_name), key) //abstraction in case we refactor obj names

// Get Gamemod Data
var mod_max_dur = argument[++z];
var mod_chance = argument[++z];
var mod_symbol = argument[++z];
var mod_icon_text = argument[++z];
var mod_long_desc = argument[++z];
var mod_count = ini_read_real("GAMEMOD_DATA", key+"-count", 0);
var mod_timer = ini_read_real("GAMEMOD_DATA", key+"-timer", 0);
var mod_discovered = ini_read_real("GAMEMOD_DATA", key+"-discovered", 0);
var mod_extra_data = argument[++z];
var mod_enabled = argument[++z];

var new_gamemod = noone;
z = -1;
new_gamemod[++z] = mod_name; //mod_name //0
new_gamemod[++z] = mod_type; //mod_type //1
new_gamemod[++z] = mod_subtype; //sub type e.g. basic, iap //2
new_gamemod[++z] = mod_max_dur; //mod_max_dur //3
new_gamemod[++z] = mod_chance; //mod_chance //4
new_gamemod[++z] = mod_symbol; //spr_symbol //5
new_gamemod[++z] = mod_icon_text; //icon text //6
new_gamemod[++z] = mod_long_desc; // description //7
new_gamemod[++z] = mod_count; //  mod_count //8
new_gamemod[++z] = mod_timer; //  mod_timer // 9
new_gamemod[++z] = mod_extra_data; //  extra_data placeholder // 10 (so we match deflector data)
new_gamemod[++z] = mod_discovered; //  mod_discovered //11
new_gamemod[++z] = mod_enabled; //  in codex/enabled //12



//Add to Deflector Map
ds_map_add(GAMEMOD_DATA, key, new_gamemod);


#define scr_gamemod_make_key
///scr_gamemod_make_key(type, subtype, index)

var type, subtype, index, key;
var type = argument[0];
var subtype = argument[1];
var index = argument[2];
key = string(type)+"-"+string(subtype)+"-"+string(index);
return key;



#define scr_gamemod_get_key
///scr_gamemod_get_key(mod_name)

return GAMEMOD_DATA_KEYS[? argument0];

#define scr_gamemod_get_data
///scr_gamemod_get_data(mod_name)

if argument_count == 1 {
    return GAMEMOD_DATA[? scr_gamemod_get_key(argument[0])];
} else if argument_count == 3 {
    return GAMEMOD_DATA[? scr_gamemod_make_key(argument[0], argument[1], argument[2])];
}


#define scr_gamemod_get_index
///scr_gamemod_get_index(mod_name, index)

var data = scr_gamemod_get_data(argument[0]);
return data[argument[1]];

#define scr_gamemod_set_index
///scr_gamemod_set_index(mod_name, index, value)

var data = scr_gamemod_get_data(argument0);
data[@ argument1] = argument2;

#define scr_gamemod_save
///scr_gamemod_save(types, sub_types, enabled_only)



var types = string_split_real(",",argument0);
var sub_types = string_split_real(",",argument1);
var enabled_only = argument2;
var types_len, sub_types_len, index_len;
var mod_data, mod_key;

types_len = array_length_1d(types);
sub_types_len = array_length_1d(sub_types);
// For Each Type
for (var i = 0; i < types_len; i++){
    // For Each SubType
    for (var j = 0; j < sub_types_len; j++ ){
        index_len = GAMEMOD_DATA_SIZES[# types[i], sub_types[j]];
        // For Each Index
        for (var k = 0; k < index_len; k++ ){
            mod_data = scr_gamemod_get_data(types[i], sub_types[j], k);
            // If Enabled_Only Flagged but Not Enabled
            if enabled_only and mod_data[12] == false{
                // Continue
                continue
            }
            else {
                // Get key
                mod_key = scr_gamemod_get_key(mod_data[0]);
                // Save Count and Timer
                ini_write_real("GAMEMOD_DATA", mod_key+"-count", mod_data[8]);
                ini_write_real("GAMEMOD_DATA", mod_key+"-timer", mod_data[9]);
            }
        } 
    }
}


#define scr_gamemod_count
///scr_gamemod_count(active_only)


var types = Array(0,1,2)
var sub_types = Array(0);
var enabled_only = true;
var active_only = argument0;
var types_len, sub_types_len, index_len;
var mod_data, mod_key;
var total_count = 0;

types_len = array_length_1d(types);
sub_types_len = array_length_1d(sub_types);
// For Each Type
for (var i = 0; i < types_len; i++){
    // For Each SubType
    for (var j = 0; j < sub_types_len; j++ ){
        index_len = GAMEMOD_DATA_SIZES[# types[i], sub_types[j]];
        // For Each Index
        for (var k = 0; k < index_len; k++ ){
            mod_data = scr_gamemod_get_data(types[i], sub_types[j], k);
            // If Enabled_Only Flagged but Not Enabled
            if enabled_only and mod_data[12] == false{
                // Continue
                continue
            }
            // If Active Count
            else if !active_only or  mod_data[8] > 0 {
                total_count++;
            }
        } 
    }
}


return total_count;





#define scr_gamemod_get_list
///scr_gamemod_get_list(type_string,subtype_string,enabled_only)

var types = string_split_real(",",argument0);
var sub_types = string_split_real(",",argument1);
var enabled_only = argument2;
var types_len, sub_types_len, index_len;
var data;

var returnList = ds_list_create();
types_len = array_length_1d(types);
sub_types_len = array_length_1d(sub_types);
// For Each Type
for (var i = 0; i < types_len; i++){
    // For Each SubType
    for (var j = 0; j < sub_types_len; j++ ){
        index_len = GAMEMOD_DATA_SIZES[# types[i], sub_types[j]];
        // For Each Index
        for (var k = 0; k < index_len; k++ ){
            data = scr_gamemod_get_data(types[i], sub_types[j], k);
            // If Enabled_Only Flagged but Deflector Not Enabled
            if enabled_only and data[12] == false{
                // Continue
                continue
            }
            else {
                // Add to List
                ds_list_add( returnList, data);
            }
        } 
    }
}



return returnList;

#define scr_gamemod_mark_as_seen
///scr_gamemod_mark_as_seen(types,sub_types,enabled_only)

var types = argument0;//string_split_real(",",argument0);
var sub_types = argument1;//string_split_real(",",argument1);
var enabled_only = argument2;
var types_len, sub_types_len, index_len;
var types_len, data, key;

types_len = array_length_1d(types);
sub_types_len = array_length_1d(sub_types);
// For Each Type
for (var i = 0; i < types_len; i++){
    // For Each SubType
    for (var j = 0; j < sub_types_len; j++ ){
        index_len = GAMEMOD_DATA_SIZES[# types[i], sub_types[j]];
        // For Each Deflector
        for (var k = 0; k < index_len; k++ ){
            data = scr_gamemod_get_data(types[i], sub_types[j], k);
            // If Enabled_Only Flagged but Deflector Not Enabled
            if enabled_only and data[12] == 0{
                // Continue
                continue
            }
            // Else if Deflector is Newly Discovered
            else if abs(data[11]) == 1 {
                // Mark as Seen
                data[@ 11] = 2;
                // Save
                key = scr_gamemod_get_key(data[0]);
                //key = scr_deflector_make_key(types[i], sub_types[j], k);
                ini_write_real("GAMEMOD_DATA", key+"-discovered", data[11]);
            }
        } 
    }
}