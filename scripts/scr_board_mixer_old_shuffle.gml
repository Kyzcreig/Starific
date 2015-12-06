///scr_board_mixer_old_shuffle(foundList, chance)


var foundList = argument0;
var effectChance = argument1;

for (i=0;i<ds_list_size(foundList);i++){
       
    //Chance to Spawn for cell
    var effectRNG = random(1) <= effectChance;
    // Get Grid Coordinates
    var gridXY = foundList[| i];
    // Convert To Field Coordinates
    var fieldXY = noone; //NB: This is initialized to clear the array for html bugs
    fieldXY = convertGridtoXY(gridXY[0],gridXY[1]);
    // Get Cell Value
    var currentCell = global.FIELD_OBJECTS[#  gridXY[0],gridXY[1]];
    var cellSpawning = false;
    
    
    
    
    //PARTICLE EFFECT FOR NON-OCCUPIED CELLS
    if currentCell < DENSITY{
            part_particles_create_color(PSYS_FIELD_LAYER, fieldXY[0], fieldXY[1], p_unspawn,COLORS[0],1);
    
    }
    
    //IF UNOCCUPIED AND NOT NULL, TRY SPAWNING
    if currentCell == noone{
        //SPAWN NEW REFLECTOR OR PASS
        if effectRNG{
            ScheduleScript(id,1,.5,scr_spawner,gridXY[0],gridXY[1],false)
            cellSpawning = true;
            scr_field_empty_remove(gridXY[0],gridXY[1])
        }//One of the reasons we don't eliminate respawn block redundancy is because we would lose track of the corner null cells.
    }
    //IF OCCUPIED CELL DESTROY AND TRY SPAWNING
    else if currentCell >= DENSITY{
        
        // Tween Out, Destroy
        scr_deflector_cell_outro(currentCell, 1, 0);
        //SPAWN NEW REFLECTOR OR ADD TO EMPTIES LIST
        if effectRNG{
            //SPAWN_COUNTER += 1; //NB: Not necessary here, see decrement spawned optional bool
            //scr_spawner(gX,gY)
            ScheduleScript(id,1,.5,scr_spawner,gridXY[0],gridXY[1],false)
            cellSpawning = true;
        }
        else{
            scr_field_empty_add(gridXY); 
        }//One of the reasons we don't eliminate respawn block redundancy is because we would lose track of the corner null cells.
    }
    //IF RESPAWNING (AND THEREFORE DURING GAMEPLAY)
    else if MOVE_ACTIVE and currentCell >= DENSITY * fieldDensity{
        var index = scr_field_respawn_find(gridXY[0],gridXY[1]);
        if index != -1{
           SPAWN_COUNTER -= 1;
           scr_field_respawn_remove(index);
        }
        //SPAWN NEW REFLECTOR OR ADD TO EMPTIES LIST
        if effectRNG {
            //SPAWN_COUNTER += 1; //NB: Not necessary here, see decrement spawned optional bool
            //scr_spawner(gX,gY)
            ScheduleScript(id,1,.5,scr_spawner,gridXY[0],gridXY[1],false)
            cellSpawning = true;
        }
        else{
            scr_field_empty_add(gridXY); 
        }//One of the reasons we don't eliminate respawn block redundancy is because we would lose track of the corner null cells.
    }
    
    //PARTICLE EFFECT FOR NON-OCCUPIED CELLS
    if !cellSpawning{
            ScheduleScript(id,1,.5,ParticlesCreateColor,PSYS_FIELD_LAYER,
            fieldXY[0],fieldXY[1],p_spawn,COLORS[0],1);
    }
}
