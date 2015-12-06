///scr_board_mixer_shuffle(foundList, chance)

var foundList = argument0;
var effectChance = argument1;
var moveList = ds_list_create();

//Loop through and remove random cells based on chance value
for (var i=ds_list_size(foundList)-1;i>=0;i--){
    //Chance to Effect for cell
    var effectRNG = !(random(1) <= effectChance);
    if effectRNG{
        // Get Grid Coordinates
        var gridXY = foundList[| i];
        // Convert To Field Coordinates
        var fieldXY = noone; //NB: This is initialized to clear the array for html bugs
        fieldXY = convertGridtoXY(gridXY[0],gridXY[1]);
        
        //Particle effects for unused cells
        part_particles_create_color(PSYS_FIELD_LAYER, fieldXY[0], fieldXY[1], p_unspawn,power_type_colors(3,0),1); //not sure about color
        ScheduleScript(id,1,.5,ParticlesCreateColor,PSYS_SUBSTAR_LAYER,
        fieldXY[0],fieldXY[1],p_spawn,power_type_colors(3,0),1); 
        
        //Remove from list
        ds_list_delete(foundList,i);
    }
}

//List for moving around cells
ds_list_copy(moveList,foundList);
// Shuffle Move List
ds_list_shuffle(moveList);


/*  Unlike other mixers it's important we schedule the grid value changes later so we don't compromise the order of things.


*/

// Swap Objects In FoundList with MoveList
for (var i=0,n=ds_list_size(foundList);i<n;i++){
    
    //Grab FROM Cell coordinates
    var fromGridXY = foundList[| i];
    // Convert To Field Coordinates
    var fromFieldXY = noone; //NB: This is initialized to clear the array for html bugs
    fromFieldXY = convertGridtoXY(fromGridXY[0],fromGridXY[1]);
    
    //Grab TO Cell coordinates 
    var toGridXY = moveList[| i];
    // Convert To Field Coordinates
    var toFieldXY = noone; //NB: This is initialized to clear the array for html bugs
    toFieldXY = convertGridtoXY(toGridXY[0],toGridXY[1]);
    
    // Get Cell Value
    var currentCell = global.FIELD_OBJECTS[# fromGridXY[0],fromGridXY[1]];
    var cellSpawning = false;
    

    
    //Case Empty Cell
    if currentCell == noone {
        
        //Particle effect unspawn
        part_particles_create_color(PSYS_FIELD_LAYER, toFieldXY[0], toFieldXY[1], p_unspawn,power_type_colors(3,0),1); //not sure about color
        //Particle effect fake-spawn
        ScheduleScript(id,1,.5,ParticlesCreateColor,PSYS_FIELD_LAYER,
        toFieldXY[0],toFieldXY[1],p_spawn,power_type_colors(3,0),1); //not sure what color to use here
        
        
        //Replace empties list value
        scr_field_empty_remove(fromGridXY[0],fromGridXY[1]);
        ScheduleScript(id, 0, 1, scr_field_empty_add, toGridXY); 
            //NB: Delayed by 1 step so we don't mess up our cell value lookups during iteration.
        
    }
    //Case Occupied Cell
    else if currentCell >= DENSITY{
    
        //Tween Cell Out and Back In
        scr_deflector_cell_outro(currentCell, 0, 1)
        
        //Repawn effect
        ScheduleScript(id,1,.5,ParticlesCreateColor,PSYS_FIELD_LAYER,
        toFieldXY[0],toFieldXY[1],p_spawn,currentCell.c_part,1);
        //ScheduleScript(id,false,.5*room_speed,TweenFire,currentCell,
        //reflectorScale__,false,EaseLinear,0,1,room_speed*.5); //not sure what color to use here
        

        //Move Deflector to new location (during spawn effect)
        ScheduleScript(id,1,.5,scr_move_instance,currentCell,toFieldXY[0],toFieldXY[1]);
        //Update grid value
        ScheduleScript(id,0,1,scr_grid_change_val,global.FIELD_OBJECTS,toGridXY[0],toGridXY[1],currentCell);
            //NB: Delayed by 1 step so we don't mess up our cell value lookups during iteration.
        
    }
    
}

ds_list_destroy(moveList);
