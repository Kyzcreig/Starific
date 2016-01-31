#define scr_board_mixer
///scr_board_mixer(grid mouseX, grid mouseY, quantity, effect type, unoccupied only)
/* Takes grid coordinates and a number of cells and 
 * modifies that many cells around the coordinate value 
 * as selected by effect type.
 * 
 */

var originX = argument[0];
var originY = argument[1];
var findCount = argument[2];
var mType = argument[3];

var foundList = ds_list_create();

//Only find empty cells
var emptiesOnly = false;
if argument_count > 4{
   emptiesOnly = argument[4];
}

scr_find_nearest_gridcells(originX,originY,findCount,foundList,emptiesOnly);

//Check that star markers aren't being overwritten
for (var i = 0, n = ds_list_size(foundList); i < n; i++){
    gridXY = foundList[| i];
    
    //Remove star marker and restore star inventory
    with (bMStarType){
         if gridX == other.gridXY[0] and gridY == other.gridXY[1]{
            ParticleDeath = false;
            instance_destroy()
            with (obj_control_game){
                 boardMixers[bMStarIndex,0] += 1;
            }
         }
    }
}
//in the future we could only do this check for the mixers where it would matter
//a switch would work for that but let's wait on that.

//Place star marker
if mType == -1{
   scr_create_star_marker(foundList);
}
//Fill area with basic deflectors
else if mType == 0{
    scr_board_mixer_fill(foundList,1);
}
//Remake area with new deflectors
else if mType == 1{
    scr_board_mixer_remake(foundList,fieldDensity);
    //scr_board_mixer_clean(foundList,1);//Clear area of basic deflectors
}
//Promote basic deflectors in area to special deflectors
else if mType == 2{
    scr_board_mixer_promote(foundList,1);
}
//Remix area (delete and respawn)
else if mType == 3{
    scr_board_mixer_shuffle(foundList,1);
}
//Demote special deflectors to basic deflectors
else if mType == 4{
    scr_board_mixer_transform(foundList,1);
}

//Garbage Collect
ds_list_destroy(foundList)

#define scr_deflector_cell_outro
///scr_deflector_cell_outro(currentCell, destroy, respawn)

with(argument0){
    particleDeath = false
    //Particle effect unspawn
    tweenSpawn = TweenFire(id,reflectorScale__,EaseLinear,
                           TWEEN_MODE_ONCE, 1,0,.5,1,0)
    part_particles_create_color(PSYS_FIELD_LAYER, x, y, p_unspawn,image_blend,1);
    
    //Queue Self Destruct
    if argument1 {
        TweenAddCallback(tweenSpawn,TWEEN_EV_FINISH,id,DestroyReflector,id,false) //false means we ignore the death code for the deflector
    }
    //Queue Respawn tween
    if argument2 {
        // Create Respawn Tween
        var tweenUnSpawn = TweenCreate(id,reflectorScale__,EaseLinear, 
                                    TWEEN_MODE_ONCE,1,0,.5,0,1)
        // Flag As Fire
        TweenDestroyWhenDone(tweenUnSpawn,true,false);
        // Schedule It
        ScheduleScript(id,1,.5,TweenPlay,tweenUnSpawn); 
    }
}