///scr_board_mixer_clean(foundList, chance)

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
    //var cellSpawning = false;
    

    
    //Case Empty Cell or Special Cell
    if currentCell == noone or !object_is_ancestor(currentCell.object_index,obj_reflector_parent_basic){
        //Particle effect default
        part_particles_create_color(PSYS_FIELD_LAYER, fieldXY[0], fieldXY[1], p_unspawn,power_type_colors(4,0),1);
        
    }
    //Case Occupied Basic Cell
    else if currentCell >= DENSITY{
        //If Lucky
        if effectRNG{
            // Tween Out, Destroy
            scr_deflector_cell_outro(currentCell, 1, 0);
            // Add to Empties
            scr_field_empty_add(gridXY); 
        }
    }
    
}
