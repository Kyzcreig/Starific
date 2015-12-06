///scr_board_mixer_transform(foundList, chance)

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
    var currentCell = global.FIELD_OBJECTS[# gridXY[0],gridXY[1]];
    var cellSpawning = false;
    

    
    //Case Occupied Special Cell
    if currentCell >= DENSITY and !object_is_ancestor(currentCell.object_index,obj_reflector_parent_basic){
        
        // Tween Out, Destroy
        scr_deflector_cell_outro(currentCell, 1, 0);
        //If Lucky, Spawn
        if effectRNG{
            ScheduleScript(id,1,.5,scr_spawner,gridXY[0],gridXY[1],false,1)
            scr_field_set(gridXY[0],gridXY[1],2) //Used as mutex value to prevent double spawning
            cellSpawning = true;
        }
        //Else add to empties
        else{
            scr_field_empty_add(gridXY); 
        }
    }
    //Case Empty or Respwning or Basic Cell
    else {

        //Particle effect fake unspawn
        part_particles_create_color(PSYS_FIELD_LAYER, fieldXY[0], fieldXY[1], p_unspawn,power_type_colors(2,0),1); //not sure about color
        
    }
    
    //Particle effect fake-spawn
    if !cellSpawning{
            ScheduleScript(id,1,.5,ParticlesCreateColor,PSYS_FIELD_LAYER,
            fieldXY[0],fieldXY[1],p_spawn,power_type_colors(2,0),1); //not sure what color to use here
    }
}
