///scr_unlock_get_status_counts(string_of_types)


var types = string_split_real(",",argument0);
var rtn = noone;
rtn[0] = 0;
rtn[1] = 0;
rtn[2] = 0;


// For Each Type
var types_len, data;
types_len = array_length_1d(types);
for (var i = 0; i < types_len; i++){
    // For Each Unlock
    for (var j = 0; j < UNLOCKS_DATA_SIZES[types[i]]; j++ ){
        data = scr_unlock_get_data(types[i],j);
        //Increment Total Count
        rtn[@ 0]++;
        //Check if Unlocked
        if data[1] > 0 {
            //Increment Unlocked Count   
            rtn[@ 1]++;
        }     
        // Check if new unseen
        if scr_unlock_is_new(data){
            //Increment New Count
            rtn[@ 2]++;
        }
    }
}

return rtn;
