#define scr_spawner_lane
///scr_spawner_lane(spotXY, direction, inversion, force_spawn)
var i,invertDir, reboundDir, spawn_threshold, force_spawn;

//Clamp Spot XY
spotXY = argument[0];
spotXY[0] = clamp(spotXY[0],0,gridSize-1);
spotXY[1] = clamp(spotXY[1],0,gridSize-1);
    //NB: In Case of some silliness with stars spawning right on the edge of the rail
            //Like if the paddle deflects it out of bounds, which can happen.
// Get Direction
reboundDir = argument[1];
// Get Inversion    
invertDir = argument[2];
// Get Forced Spawn
force_spawn = argument[3];

//spawn_threshold = DENSITY; //* .30;
    //NB: We could use ds_grid_get_line_mean to do a spawn if the line is just super empty.
    //That might be useful in preventing the long passes in a nearly empty lane.

/*  DEBUGGING
    NB: One way this could break is if we had an unaccounted for cell that was blank but greater than density.


*/
    
// Cardinal Checks
if (reboundDir == 0 and !invertDir) or (reboundDir == 180 and invertDir) {
   var max_cell = ds_grid_get_line_max(global.FIELD_OBJECTS, 0, spotXY[1], gridSize-1, spotXY[1]);
   
   if force_spawn or scr_spawn_lane_is_empty(max_cell)
   { 
        scr_spawner_lane_helper(1, spotXY)
   }
}
if (reboundDir == 180 and !invertDir) or (reboundDir == 0 and invertDir){
   var max_cell = ds_grid_get_line_max(global.FIELD_OBJECTS, 0, spotXY[1], gridSize-1, spotXY[1]); 
   
   if force_spawn or scr_spawn_lane_is_empty(max_cell)
   { 
        scr_spawner_lane_helper(1, spotXY)
   }
}
if (reboundDir == 270 and !invertDir) or (reboundDir == 90 and invertDir){
   var max_cell = ds_grid_get_line_max(global.FIELD_OBJECTS, spotXY[0], 0, spotXY[0], gridSize-1) ; 

   if force_spawn or scr_spawn_lane_is_empty(max_cell)
   {    
        scr_spawner_lane_helper(0, spotXY)
   }
}
if (reboundDir == 90 and !invertDir) or (reboundDir == 270 and invertDir){
   var max_cell = ds_grid_get_line_max(global.FIELD_OBJECTS, spotXY[0], 0, spotXY[0], gridSize-1);

   if force_spawn or scr_spawn_lane_is_empty(max_cell)
   { 
        scr_spawner_lane_helper(0, spotXY)
   }
}

//NB: Maybe show message if Force Spawn is called?

//Exit if cardinal direction
if reboundDir mod 90 == 0{
    exit   
}

//Diagonals Checks
slope = 0;
switch reboundDir{
case 45:
    slope = -1;
break;
case 135:
    slope = 1;
break;
case 225:
    slope = -1;
break;
case 315:
    slope = 1;
break;
}

//Declare Start/End X/Y
startXY = spotXY;
endXY = spotXY;
var delta;

// If  X less than 0
if spotXY[0] < 0{
   // Set Start X 
   startXY[0] = 0
   // Set Start Y
   delta = startXY[0]-spotXY[0];
   startXY[1] += slope*(delta) //adjust by slope * delta
   
   // Set End Y (Move from Low to High End: Add)
   endXY[1] = clamp(startXY[1] + slope*gridSize,0,gridSize-1)
   // Set End X
   delta = endXY[1] -startXY[1];
   endXY[0] = startXY[0] + slope*(delta) //add difference
}
// If X Greater than FieldW
else if spotXY[0] > fieldW-1{
   // Set Start X 
   startXY[0] = fieldW-1
   // Set Start Y
   delta = startXY[0]-spotXY[0];
   startXY[1] += slope*(delta) //adjust by slope * delta
   
   // Set End Y (Move from High to Low End: Subtract)
   endXY[1] = clamp(startXY[1] -slope*gridSize,0,gridSize-1)
   // Set End X
   delta = endXY[1] -startXY[1];
   endXY[0] = startXY[0] + slope*(delta) //add difference
}
// If  Y less than 0
else if spotXY[1] < 0{
   // Set Start Y
   startXY[1] = 0
   // Set Start X 
   delta = startXY[1]-spotXY[1];
   startXY[0] += slope*(delta) //adjust by slope * delta
   
   // Set End X (Move from Low to High End: Add)
   endXY[0] = clamp(startXY[0] +slope*gridSize,0,gridSize-1)
   // Set End Y
   delta = endXY[0] -startXY[0];
   endXY[1] = startXY[1] + slope*(delta) //add difference 
}
// If Y Greater than FieldH
else if  spotXY[1] > fieldH-1{
   // Set Start Y
   startXY[1] = fieldH-1  //You know there's a way to condense this whole thing with lots of clamps and sign(startXY[1]-spotXY[1]) stuff.
   // Set Start X 
   delta = startXY[1]-spotXY[1];
   startXY[0] += slope*(delta) //adjust by slope * delta
   
   // Set End X  (Move from High to Low End: Subtract)
   endXY[0] = clamp(startXY[0] -slope*gridSize,0,gridSize-1)
   // Set End Y
   delta = endXY[0] -startXY[0];
   endXY[1] = startXY[1] + slope*(delta) //add difference 
}

/*
//Debugging //disable me
if endXY[0] < 0 or endXY[1] < 0 or endXY[0] >= gridSize or endXY[1] >= gridSize{
    show_message("Bad Diagonal Coordinates")
}*/

// Diagonal Lines
var max_cell = ds_grid_get_line_max(global.FIELD_OBJECTS, startXY[0], startXY[1], endXY[0], endXY[1]);

if force_spawn or scr_spawn_lane_is_empty(max_cell)
{
        scr_spawner_lane_helper(2, spotXY);
}





#define scr_spawner_lane_helper
///scr_spawner_lane_helper(lane_type, spotXY)


var list, listSize, objXY, rngList, rngCell, emptyListY, emptyListX;

var lane_type = argument0;
var spotXY = argument1;

switch lane_type{

// Spawn Horizontally
case 0:

    //Set Empty Cell Lane
    emptyLaneX = spotXY[0]
    
    // Set Empty List Lane
    emptyListX = emptyLaneX div (global.FIELD_EMPTIES_SIZE);
    
    // Use Random Offset to
    rngList = irandom(4);
    //Iterate Through Valid Empty Lists
    for (var i = 0; i < 5; i++){ 
        // Get Empty List
        emptyListY = (i + rngList) mod 5;
        list = global.FIELD_EMPTIES[# emptyListX, emptyListY];
        // Iterate Through Empty List
        listSize = ds_list_size(list);
        // With Random Offset
        rngCell = irandom(listSize-1)
        for (var k = 0; k < listSize; k++){
            listPos = (k + rngCell) mod listSize;
            objXY = list[| listPos];
            
            // If Valid Cell
            if objXY[0] == emptyLaneX {
                //Set Respawn Timer
                scr_field_respawn_add(objXY[0],objXY[1], 1);
                //Exit (Since breaking double loops would be annoying)
                exit;
            } 
        }
    }
    
    // If No Empties Found Iterate Over Respawn Cells
    for (var i = 0, n = ds_list_size(global.FIELD_RESPAWNS); i < n; i++) {
        // Get Cell Data
        objXY = global.FIELD_RESPAWNS[| i];
        // If Valid Cell
        if objXY[0] == emptyLaneX {
            //Decrease the Respawn Time
            objXY[@ 2] = 1;
            exit;
        }
        
    }
    
break;



// Spawn Vertocally
case 1:


    //Set Empty Cell Lane
    emptyLaneY = spotXY[1]
    
    // Set Empty List Lane
    emptyListY = emptyLaneY div (global.FIELD_EMPTIES_SIZE);
    
    // Use Random Offset to
    rngList = irandom(4);
    //Iterate Through Valid Empty Lists
    for (var i = 0; i < 5; i++){
        // Get Empty List
        emptyListX = (i + rngList) mod 5;
        list = global.FIELD_EMPTIES[# emptyListX, emptyListY];
        // Iterate Through Empty List
        listSize = ds_list_size(list);
        // With Random Offset
        rngCell = irandom(listSize-1)
        for (var k = 0; k < listSize; k++){
            listPos = (k + rngCell) mod listSize;
            objXY = list[| listPos];
            
            // If Valid Cell
            if objXY[1] == emptyLaneY {
                //Set Respawn Timer
                scr_field_respawn_add(objXY[0],objXY[1], 1);
                //Exit (Since breaking double loops would be annoying)
                exit;
            } 
        }
    }
    
    // If No Empties Found Iterate Over Respawn Cells
    for (var i = 0, n = ds_list_size(global.FIELD_RESPAWNS); i < n; i++) {
        // Get Cell Data
        objXY = global.FIELD_RESPAWNS[| i];
        // If Valid Cell
        if objXY[1] == emptyLaneY {
            //Decrease the Respawn Time
            objXY[@ 2] = 1;
            exit;
        }
        
    }

break;


case 2:
    
    var listSX, listSY, rngAdjX, rngAdjY, rngCell, listPos, emptyListX, emptyListY, list, listSize, objXY;
    
    // Set Empty List Lane
    listSXY = convertGridtoEmpty(startXY[0],startXY[1]);
    
    // Use Random Offset to
    rngAdjX = irandom(4);
    rngAdjY = irandom(4);
    //Iterate Through Empty Lists
    for (var i = 0; i < 5; i++){
        for (var j = 0; j < 5; j++){
            emptyListX = (i + rngAdjX) mod 5;
            emptyListY = (j + rngAdjY) mod 5;
            //If Valid List
            if abs((emptyListY - listSXY[1]) - (slope * (emptyListX - listSXY[0]))) <= 1 { 
                        //NB: This line might be wrong...
                list = global.FIELD_EMPTIES[# emptyListX, emptyListY];
                // Iterate Through Empty List
                listSize = ds_list_size(list);
                // With Random Offset
                rngCell = irandom(listSize-1);
                for (var k = 0; k < listSize; k++){
                    listPos = (k + rngCell) mod listSize;
                    objXY = list[| listPos];
                    
                    // If Valid Cell
                    if objXY[1] - startXY[1] == slope * (objXY[0] - startXY[0]) {
                        //Set Respawn Timer
                        scr_field_respawn_add(objXY[0],objXY[1], 1);
                        //Exit (Since breaking double loops would be annoying)
                        exit;
                    } 
                }
            }
        }
    }
    
    // If No Empties Found Iterate Over Respawn Cells
    for (var i = 0, n = ds_list_size(global.FIELD_RESPAWNS); i < n; i++) {
        // Get Cell Data
        objXY = global.FIELD_RESPAWNS[| i];
        // If Valid Cell
        if objXY[1] - startXY[1] == slope * (objXY[0] - startXY[0]) {
            //Decrease the Respawn Time
            objXY[@ 2] = 1;
            exit;
        }
        
    }

break;

}

#define scr_spawn_lane_is_empty
///scr_spawn_lane_is_empty(max_cell)

var max_cell = argument0;

if (instance_exists(max_cell) and object_is_ancestor(max_cell.object_index, obj_reflector_parent)) 
// (max_cell < DENSITY) 
{
    return true;

} else {
    return false;
}   