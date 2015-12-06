///scr_isEmptyCell(gX,gY,confirmEmpties)
var gridX, gridY, isEmpty, confirmEmpties,listData;
gridX = argument[0];
gridY = argument[1];
isEmpty = global.FIELD_OBJECTS[# gridX,gridY] == noone;

// Check Empty Queue Lists?
if argument_count > 2{
    confirmEmpties = argument[2];
} else {
    confirmEmpties = false;
}

if confirmEmpties {
   listData = scr_field_empty_find(gridX,gridY);
   if listData[1] != -1 {
       isEmpty = isEmpty and false;
   }
}


return isEmpty;
