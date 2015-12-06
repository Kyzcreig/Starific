///scr_spawner_specific(grid_x, grid_y,object_index)
var obj_instance,fieldXY;
fieldXY = convertGridtoXY(argument[0], argument[1]);

// Spawn Object
obj_instance = instance_create(fieldXY[0], fieldXY[1], argument[2])

//Set Field
scr_field_set(argument[0], argument[1], 1, obj_instance);

return obj_instance
