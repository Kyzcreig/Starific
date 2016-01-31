///scr_unlock_is_new_count(string_of_types)

var types_string = argument0;
var types = string_split_real(",",types_string);

// For Each Type
var data;
var types_len = array_length_1d(types);
var count = 0;

for (var i = 0; i < types_len; i++){
    // For Each Unlock
    for (var j = 0; j < UNLOCKS_DATA_SIZES[types[i]]; j++ ){
        data = scr_unlock_get_data(types[i],j);
        // If Unlocked
        if data[1] >= 2 {
            // If New
            if scr_unlock_is_new(data) {
                count++;
            }
        } 
    }
}

return count;
