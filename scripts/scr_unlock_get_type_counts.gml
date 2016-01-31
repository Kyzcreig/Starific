#define scr_unlock_get_type_counts
///scr_unlock_get_type_counts(types)

var data;
var types_string = argument0;
var types = string_split_real(",",types_string);
var counts;
counts[0] = 0; //total
counts[1] = 0; //unlocked
counts[2] = 0; //new

// For Each Type
var types_len, data;
types_len = array_length_1d(types);
for (var i = 0; i < types_len; i++){
    // For Each Unlock
    for (var j = 0; j < UNLOCKS_DATA_SIZES[types[i]]; j++ ){
        data = scr_unlock_get_data(types[i],j);
        counts[0]++;
        // If Unlocked
        if data[1] >= 2 {
            counts[1]++;
            // If New
            if scr_unlock_is_new(data) {
                counts[2]++;
            }
        } 
    }
}

return counts;



#define scr_unlock_increment_views
///scr_unlock_increment_views(type, index, increment, save)

var data = scr_unlock_get_data(argument0,argument1);

/// If Unlocked
if data[1] > 0 {
    // Increment Views
    data[@ 2] += argument2;
}

// Save
if argument3 {
    var key = scr_unlock_get_key(data[0],data[7]);
    ini_write_real("UNLOCKS_DATA", key+"-views", data[2]);
}