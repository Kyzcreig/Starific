#define scr_field_set
///scr_field_set(gridX,gridY, type, [value])

var gridX, gridY, type, gridVal, list, listPriority;
gridX = argument[0];
gridY = argument[1];
type = argument[2];


switch type {

// Null Cell (Corner)
case -1:
    gridVal = DENSITY*fieldDensity

break;

// Empty Cell
case 0: 
    gridVal = noone

break;

// Filled Cell
case 1:
    //gridVal = DENSITY
break;

// Respawning Cell
case 2:
    gridVal = DENSITY*fieldDensity
    //gridVal = (1+fieldDensity)/2 * DENSITY;
        //NB: This value is half way between fieldDensity and 1.
break;

}

// Get Direct Value
if argument_count > 3 {
    gridVal = argument[3];
}

// Set Grid Value
global.FIELD_OBJECTS[# gridX, gridY] = gridVal;

// Get List Coordinates
listXY = convertGridtoEmpty(gridX,gridY);
// Get List
list = global.FIELD_EMPTIES[# listXY[0],listXY[1]];
// Recalculate Priority for Empty List
listPriority = ds_grid_get_mean(global.FIELD_OBJECTS, 
                                    listXY[0]*(global.FIELD_EMPTIES_SIZE),
                                    listXY[1]*(global.FIELD_EMPTIES_SIZE),
                                    (listXY[0]+1)*(global.FIELD_EMPTIES_SIZE)-1,
                                    (listXY[1]+1)*(global.FIELD_EMPTIES_SIZE)-1
                                    );
// Set Priority
ds_priority_change_priority(global.FIELD_EMPTIES_QUEUE, list, listPriority)





#define scr_field_list_find
///scr_field_list_find(gridX,gridY, list)
/* 
    Returns pos in list
*/
var list = argument2;

// Find Position in List
for (var i = 0, n = ds_list_size(list); i < n ; i++){
    var data = list[| i];
    // Compare Coordinates
    if data[0] == argument0 and
       data[1] == argument1 
    {
        // Found
        return i;
    }

}

return -1;



#define convertGridtoEmpty
///convertGridtoEmpty(gridX,gridY)

return Array(argument0 div (global.FIELD_EMPTIES_SIZE), 
                        argument1 div (global.FIELD_EMPTIES_SIZE));



#define convertXYtoGrid
///convertXYtoGrid(x,y)

return Array(
                    (argument0-ox-cellW/2)/cellW,
                    (argument1-oy-cellH/2)/cellH
                    );

#define convertGridtoXY
///convertGridtoXY(x,y)


return Array(
                    ox +argument0*cellW +cellW/2,
                    oy +argument1*cellH +cellH/2
                    );