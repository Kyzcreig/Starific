#define scr_unlock_set_description
///scr_unlock_set_description(types)


var types = string_split_real(",",argument0);


// For Each Type
var types_len, data;
types_len = array_length_1d(types);
for (var i = 0; i < types_len; i++){
    // For Each Unlock
    for (var j = 0; j < UNLOCKS_DATA_SIZES[types[i]]; j++ ){
        data = scr_unlock_get_data(types[i],j);
        data[@ 8] = scr_unlock_criteria_text(data);
    }
}












#define scr_unlock_clear_description
///scr_unlock_clear_description(types)


var types = string_split_real(",",argument0);


// For Each Type
var types_len, data;
types_len = array_length_1d(types);
for (var i = 0; i < types_len; i++){
    // For Each Unlock
    for (var j = 0; j < UNLOCKS_DATA_SIZES[types[i]]; j++ ){
        data = scr_unlock_get_data(types[i],j);
        data[@ 8] = 0;
    }
}












#define scr_unlock_update_views
///scr_unlock_update_views(types)


var types = string_split_real(",",argument0);

ini_open("scores.ini");
    // For Each Type
    var types_len, data, key;
    types_len = array_length_1d(types);
    for (var i = 0; i < types_len; i++){
        // For Each Unlock
        for (var j = 0; j < UNLOCKS_DATA_SIZES[types[i]]; j++ ){
            data = scr_unlock_get_data(types[i],j);
            //If Unlocked (And Seen On Gameover)
            if data[1] >= 2 {
                //Update Views Count
                key = scr_unlock_get_key(data[0],data[7]);
                data[@ 2] = ini_read_real("UNLOCKS_DATA", key+"-views", 0);
            }
        }
    }
ini_close();












#define scr_unlock_update_new_views
///scr_unlock_update_new_views(types)


var types = string_split_real(",",argument0);

ini_open("scores.ini");
    // For Each Type
    var types_len, data, key, tmp;
    types_len = array_length_1d(types);
    for (var i = 0; i < types_len; i++){
        // For Each Unlock
        for (var j = 0; j < UNLOCKS_DATA_SIZES[types[i]]; j++ ){
            data = scr_unlock_get_data(types[i],j);
            //If Unlock is New
            if scr_unlock_is_new(data) {
                //Update Views Count
                data[@ 2] = abs(data[2]); 
                    //NB: We trickily mark viewed themes as -1 so they still show up as new
                    //So in this script we convert those -1's to 1's and save.
                key = scr_unlock_get_key(data[0],data[7]);
                // Add Views on "NEW" Themes to File
                tmp = ini_read_real("UNLOCKS_DATA", key+"-views", 0);
                ini_write_real("UNLOCKS_DATA", key+"-views", tmp+data[2]);
            }
        }
    }
ini_close();

#define scr_unlock_update_views_file
///scr_unlock_update_views_file(data)


var data = argument0;

// Check in Unlocked (And Seen on Gameover) 
if data[1] >= 2 {
    //Increment Saved Views
    var key = scr_unlock_get_key(data[0],data[7]);
    var tmp = ini_read_real("UNLOCKS_DATA", key+"-views", 0);
    ini_write_real("UNLOCKS_DATA", key+"-views", ++tmp);
} 