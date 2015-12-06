///scr_board_mixer_old_upgrade(foundList, chance)
//Spawns new deflectors or upgrades basics into specials.


var foundList = argument0;
var effectChance = argument1;
var spawnBonus = 0;

//Set spawnbonus
for (i=0;i<ds_list_size(foundList);i++){
    //We do this because we basically ignore power objects
    //so we're rewarding the player for concentrating them
    var gridXY = foundList[| i];
    var currentCell = global.FIELD_OBJECTS[# gridXY[0], gridXY[1]];
    //increment for each special object
    if currentCell >= DENSITY and !object_is_ancestor(currentCell.object_index,obj_reflector_parent_basic){
        spawnBonus++;
    } 
}
for (i=0;i<ds_list_size(foundList);i++){
    
    
    //Chance to Spawn for cell
    var effectRNG = random(1) - spawnBonus*0 <= effectChance;
    // Get Grid Coordinates
    var gridXY = foundList[| i];
    // Convert To Field Coordinates
    var fieldXY = noone; //NB: This is initialized to clear the array for html bugs
    fieldXY = convertGridtoXY(gridXY[0],gridXY[1]);
    // Get Cell Value
    var currentCell = global.FIELD_OBJECTS[#  gridXY[0],gridXY[1]];
    var cellSpawning = false;
    
    
    
    
    //IF UNOCCUPIED AND NOT NULL, TRY SPAWNING
    if currentCell == noone{
        if effectRNG{
            ScheduleScript(id,1,.5,scr_spawner,gridXY[0],gridXY[1],false)
            cellSpawning = true;
            scr_field_empty_remove(gridXY[0],gridXY[1]);
        }//One of the reasons we don't eliminate respawn block redundancy is because we would lose track of the corner null cells.
        
    }
    //IF OCCUPIED CELL
    else if currentCell >= DENSITY{
        //Check if object is ancestor of basic reflector parent
        if object_is_ancestor(currentCell.object_index,obj_reflector_parent_basic) and effectRNG
        {
            //DESTROY
            // Tween Out, Destroy
            scr_deflector_cell_outro(currentCell, 1, 0);
            scr_field_set(gridXY[0],gridXY[1],2) //Used as mutex value to prevent double spawning
            //SPAWN_COUNTER += 1;
            //scr_spawner(gX,gY)
            ScheduleScript(id,1,.5,scr_spawner,gridXY[0],gridXY[1],false,false)
            cellSpawning = true;
            spawnBonus = max(spawnBonus - 1,0);
        }
        //Else schedule particle effects
        else{
            cellSpawning = true;
            part_particles_create_color(PSYS_FIELD_LAYER, fieldXY[0], fieldXY[1], p_unspawn,currentCell.c_part,1);
            ScheduleScript(id,1,.5,ParticlesCreateColor,PSYS_FIELD_LAYER,
            fieldXY[0],fieldXY[1],p_spawn,currentCell.c_part,1);
        
        }
    }
    
    //PARTICLE EFFECT FOR NON-OCCUPIED CELLS
    if !cellSpawning{
            part_particles_create_color(PSYS_FIELD_LAYER, fieldXY[0], fieldXY[1], p_unspawn,COLORS[0],1);
            ScheduleScript(id,1,.5,ParticlesCreateColor,PSYS_FIELD_LAYER,
            fieldXY[0],fieldXY[1],p_spawn,COLORS[0],1);
    }
}
