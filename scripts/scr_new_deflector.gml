#define scr_new_deflector
///scr_new_deflector(obj_index, obj_type, sub_type, power_array, spr_symbol, text_description, enabled);  
var z;
z = -1;

// Get Deflector Key
var obj_index = argument[++z];
var obj_type = argument[++z];
var sub_type = argument[++z];
var type_index = DEFLECTOR_DATA_SIZES[# obj_type, sub_type]++; //increment up size count
var key = scr_deflector_make_key(obj_type, sub_type, type_index);//object_get_name(obj_index);
// Add Mapping from obj_index to key
ds_map_add(DEFLECTOR_DATA_KEYS, string(obj_index), key) //abstraction in case we refactor obj names

// Get Deflector Data
var power_array = argument[++z];
var spr_symbol = argument[++z];
var text_description = argument[++z];
var deaths = 0;
var total_deaths = 0
var catches = 0;
var total_catches = 0;
/* NB: I decided to use total_catches as an extra variable instead.
        To generate the bestiary we can just read the files.

*/
var discovered = ini_read_real("DEFLECTOR_DATA", key+"-discovered", 0);
var enabled = argument[++z];

var new_deflector = noone;
z = -1;
new_deflector[++z] = obj_index; //obj index
new_deflector[++z] = obj_type; //obj type
new_deflector[++z] = sub_type; //sub type e.g. tapper, timer, cash, etc.
new_deflector[++z] = power_array; //power array if power
new_deflector[++z] = spr_symbol; //spr_symbol
new_deflector[++z] = text_description; //icon text
    //NB: We'll check if this is an array and if it is we'll check for the symbol
    //In the reflector spawn code.
new_deflector[++z] = deaths; // 6
new_deflector[++z] = total_deaths; // 7
new_deflector[++z] = catches; // 8
new_deflector[++z] = total_catches; // 9
new_deflector[++z] = type_index; // 10
new_deflector[++z] = discovered; // 11 lock status
new_deflector[++z] = enabled; // 12 in codex/enabled



//Add to Deflector Map
ds_map_add(DEFLECTOR_DATA, key, new_deflector);

#define scr_deflector_make_key
///scr_deflector_make_key(type,subtype, index)
return string(argument0)+"-"+string(argument1)+"-"+string(argument2);


#define scr_deflector_get_key
///scr_deflector_get_key(obj_index)

return DEFLECTOR_DATA_KEYS[? string(argument0)]

#define scr_deflector_get_data
///scr_deflector_get_data(obj_index)

return DEFLECTOR_DATA[? scr_deflector_get_key(argument0)]

#define scr_deflector_get_list
///scr_deflector_get_list(type_string,subtype_string,enabled_only)

var types = string_split_real(",",argument0);
var sub_types = string_split_real(",",argument1);
var enabled_only = argument2;
var types_len, sub_types_len, index_len;
var types_len, data;

var returnList = ds_list_create();
types_len = array_length_1d(types);
sub_types_len = array_length_1d(sub_types);
// For Each Type
for (var i = 0; i < types_len; i++){
    // For Each SubType
    for (var j = 0; j < sub_types_len; j++ ){
        index_len = DEFLECTOR_DATA_SIZES[# types[i], sub_types[j]];
        // For Each Index
        for (var k = 0; k < index_len; k++ ){
            data = scr_deflector_get_data_from_index(types[i], sub_types[j], k);
            // If Enabled_Only Flagged but Deflector Not Enabled
            if enabled_only and data[12] == 0{
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

#define scr_deflector_mark_as_seen
///scr_deflector_mark_as_seen(type_string,subtype_string,enabled_only)

var types = string_split_real(",",argument0);
var sub_types = string_split_real(",",argument1);
var enabled_only = argument2;
var types_len, sub_types_len, index_len;
var types_len, data, key;

types_len = array_length_1d(types);
sub_types_len = array_length_1d(sub_types);
// For Each Type
for (var i = 0; i < types_len; i++){
    // For Each SubType
    for (var j = 0; j < sub_types_len; j++ ){
        index_len = DEFLECTOR_DATA_SIZES[# types[i], sub_types[j]];
        // For Each Deflector
        for (var k = 0; k < index_len; k++ ){
            data = scr_deflector_get_data_from_index(types[i], sub_types[j], k);
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
                key = scr_deflector_get_key(data[0]);
                //key = scr_deflector_make_key(types[i], sub_types[j], k);
                ini_write_real("DEFLECTOR_DATA", key+"-discovered", data[11]);
            }
        } 
    }
}




#define scr_deflector_get_data_from_index
///scr_deflector_get_data_from_index(type, sub_type, index)

return DEFLECTOR_DATA[? scr_deflector_make_key(argument0, argument1, argument2)];