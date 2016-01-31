#define scr_new_unlock
///scr_new_unlock(type, default_status, load_as_new, criteria_type, critieria_quantity,  name) 

/* default_status: 0 = locked, 
                   1 = unlocked but not displayed on gameover
                   2 = unlocked and seen on gameover
                   3 = default unlocked
                   4 = premium IAP
                   
   load_as_new:    0 = load in stats from file
                   1 = set stats to default_status
*/


var z;
z = -1;
//Get Prefix and Type Data
var type = argument[++z];
//var prefix_type = scr_unlock_type_to_prefix(type);
var type_index = UNLOCKS_DATA_SIZES[type]++;
var key = scr_unlock_get_key(type, type_index)//prefix_type+"-"+string(UNLOCKS_DATA_SIZES[type]++);

//Get Status
var default_status = argument[++z];
var load_as_new = argument[++z];
var status;
if !load_as_new {
    status = ini_read_real("UNLOCKS_DATA", key+"-status", default_status);
} else { //We use this for debugging
    status = default_status
}

//Get Data
var default_views = 0;
//set defaults unlocks to 1 view to prevent notifications for them
if default_status == 3{ 
    default_views = 1;
}
var views;
if !load_as_new {
    views = ini_read_real("UNLOCKS_DATA", key+"-views", default_views);
} else { //We use this for debugging
    views = default_views
}
var criteria_type = argument[++z];
var criteria_quantity = argument[++z];
var name = argument[++z];
var type_name = scr_unlock_type_to_name(type);

var plays = ini_read_real("UNLOCKS_DATA", key+"-plays", 0);



var new_unlock = noone;
z = -1;
new_unlock[++z] = type; //
new_unlock[++z] = status; //1
new_unlock[++z] = views; //
new_unlock[++z] = criteria_type; //3
new_unlock[++z] = criteria_quantity; //4
new_unlock[++z] = name; //5
new_unlock[++z] = type_name; //6
new_unlock[++z] = type_index; // 7
new_unlock[++z] = 0; // 8 //misc val
new_unlock[++z] = plays; // 9 //playcount



//Add to Map
ds_map_add_value(UNLOCKS_DATA, key, new_unlock)

#define scr_unlock_type_to_prefix
///scr_unlock_type_to_prefix(unlock_type)

var type = argument0;
var type_name = "";
switch type {
case 0: 
    type_name = "grid";
break;
case 1: 
    type_name = "mode";
break;
case 2: 
    type_name = "rigor";
break;
case 3: 
    type_name = "theme";
break;
case 4: 
    type_name = "misc";
break;
case 5: 
    type_name = "achieve";
break;


}

return type_name;

#define scr_unlock_type_to_name
///scr_unlock_type_to_name(unlock_type)
//NB: We use this on the unlock prompts

var type = argument0
var type_name = "";
switch type {
case 0: 
    type_name = "grids";
break;
case 1: 
    type_name = "mode";
break;
case 2: 
    type_name = "rigor";
break;
case 3: 
    type_name = "theme";
break;
case 4: 
    type_name = "misc";
break;
case 5: 
    type_name = "achievement"; //as in achievement unlocked like on xbox
break;


}

return type_name;

#define scr_unlock_get_key
///scr_unlock_get_key(type,index)


var type = argument0;
var index = argument1;
var key = scr_unlock_type_to_prefix(type)+"-"+string(index)
return key;

#define scr_unlock_get_data
///scr_unlock_get_data(type,index)


var type = argument0;
var index = argument1;
var key = scr_unlock_get_key(type,index);
return UNLOCKS_DATA[? key];

#define scr_unlock_get_status
///scr_unlock_get_status(type,index)


var type = argument0;
var index = argument1;
var data = scr_unlock_get_data(type,index);
return data[1];

#define scr_unlock_set_status
///scr_unlock_set_status(type,index,status,save)

var type = argument0;
var index = argument1;
var val = argument2;
var save = argument3;
var data = scr_unlock_get_data(type,index);
// Set Status
data[@ 1] = val;

// Save Status
if save {
    var key = scr_unlock_get_key(type, index);
    ini_open("scores.ini");
       ini_write_real("UNLOCKS_DATA", key+"-status", data[@ 1]);
    ini_close();
}

#define scr_unlock_get_name
///scr_unlock_get_name(type,index)

var type = argument0;
var index = argument1;
var data = scr_unlock_get_data(type,index);

return data[5];

#define scr_unlock_get_name_long
///scr_unlock_get_name_long(data | type,index)
var data;
if is_array(argument[0]) {
    data = argument[0];
} else {
    data = scr_unlock_get_data(argument[0], argument[1]);
}

return data[5]+" "+data[6];