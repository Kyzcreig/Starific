///scr_board_mixer_fill(foundList, chance)

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
    

    
    //Case Empty Cell
    if currentCell == noone{
        //If Lucky, Spawn
        if effectRNG{
            // Spawn Basic Deflector
            scr_spawner(gridXY[0],gridXY[1],false,-1);
            scr_field_empty_remove(gridXY[0],gridXY[1])
            cellSpawning = true;
        }
    }
    
    //Particle effect fake-spawn
    if !cellSpawning{
            ScheduleScript(id,1,.5,ParticlesCreateColor,PSYS_FIELD_LAYER,
            fieldXY[0],fieldXY[1],p_spawn,power_type_colors(0,0),1); //not sure what color to use here
    }
}
