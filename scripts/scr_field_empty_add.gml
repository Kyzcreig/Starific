#define scr_field_empty_add
///scr_field_empty_add(gridXY)

var emptyList, emptyXY;

// Get Grid Coords
emptyXY = argument0; //scr_create_array(argument0,argument1);

// Set Game Grid to Empty
scr_field_set(emptyXY[0],emptyXY[1], 0)

// Get Empties SubList
emptyList = scr_field_empty_get_list(emptyXY[0],emptyXY[1]);

/*
// Debug Check
if FIELD_DEBUGGER {
    var pos = scr_field_list_find(gridXY[0], gridXY[1], emptyList);
    if pos != -1 {
        var debugMsg = argument2;
        show_message( "Duplicate Empty Found at"+debugMsg
                     +", gridX="+string(gridXY[0])
                     +", gridY="+string(gridXY[1])
                     +", fieldVal="+string(global.FIELD_OBJECTS[# gridXY[0], gridXY[1]])
                     )
    }
}*/

// Add Coordinates To Empty List
ds_list_insert(emptyList,0, emptyXY);
 





#define scr_field_empty_remove
///scr_field_empty_remove(gridX,gridY)

var emptyXY;
// Get Grid Coords
emptyXY = scr_create_array(argument[0],argument[1]);

// Get List Data (list and pos)
var listData;
listData = scr_field_empty_find(emptyXY[0],emptyXY[1]);

/*
// Debug Check
if FIELD_DEBUGGER {
    if listData[1] == -1 {
        show_message("Missing Empty on Removal")
    }
}*/

// Add Coordinates To Empty List
ds_list_delete(listData[0], listData[1]);

#define scr_field_empty_find
///scr_field_empty_find(gridX,gridY, [list])
/* 
    Returns tuple array holding the list and index position;
    index position will be -1 if not found
*/

var emptyList;

// Get Empties SubList
emptyList = scr_field_empty_get_list(argument0,argument1);
pos = scr_field_list_find(argument0, argument1, emptyList);

return scr_create_array(emptyList,pos);

#define scr_field_empty_get_list
///scr_field_empty_get_list(gridX,gridY)


// Translate to Grid Coords to List Location
listXY = convertGridtoEmpty(argument0,argument1)

// Get Empty List
return global.FIELD_EMPTIES[# listXY[0], listXY[1]];

#define scr_field_empty_clear
///scr_field_empty_clear()

// Clear Queue
//ds_priority_clear(global.FIELD_EMPTIES_QUEUE);
        
for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 5; j++){
        var emptyList = global.FIELD_EMPTIES[# i, j];
        // Clear List
        ds_list_clear(emptyList);
        
        // Reset Priority in Queue
        ds_priority_change_priority(global.FIELD_EMPTIES_QUEUE, emptyList, 0);
        
        
        // Re-add list to queue 
        //ds_priority_add(global.FIELD_EMPTIES_QUEUE, global.FIELD_EMPTIES[# i, j], 0);
    }
}




#define scr_field_empty_shuffle
///scr_field_empty_shuffle()

var list, listSize;

//Iterate Through Empty Lists
for (var i = 0; i < 5; i++){
    for (var j = 0; j < 5; j++){
        list = global.FIELD_EMPTIES[# i, j];
        // Shuffle List
        ds_list_shuffle(list);
    }
}