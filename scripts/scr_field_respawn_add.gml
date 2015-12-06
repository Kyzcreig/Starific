#define scr_field_respawn_add
///scr_field_respawn_add(gridX, gridY, duration)

var resXY = scr_create_array(argument[0],argument[1],argument[2]);

// Update Empty List
scr_field_empty_remove(resXY[0],resXY[1]) 

// Update Spawn Counter
SPAWN_COUNTER += 1
// Update Field Data
scr_field_set(resXY[0],resXY[1],2)

// Add To Respawn List
ds_list_add(global.FIELD_RESPAWNS,resXY);


#define scr_field_respawn_clear
///scr_field_respawn_clear()

ds_list_clear(global.FIELD_RESPAWNS); //empty the respawn list

#define scr_field_respawn_update
///scr_field_respawn_update()

var resXY;
var listSize = ds_list_size(global.FIELD_RESPAWNS);


// Iterate Over Respawn List
for (var i = listSize - 1; i >= 0 ; i--){
    // Get Respawn Data
    resXY = global.FIELD_RESPAWNS[| i];
    // Decrement Respawn Timer
    resXY[@ 2]--;
    // Respawn Deflector
    if resXY[2] <= 0 and (!RESOURCE_POOLING or ds_queue_size(global.FIELD_POOL) > 0){
       scr_field_respawn_remove(i);
       // Double Check there's enough power deflectors every other step
       var spawnFlag =  ALTERNATE_STEP_INTERVAL and scr_spawner_set_power_flag();
                        //NB: Short circuit does work here.  Nice.
       scr_spawner(resXY[0],resXY[1],1,spawnFlag);

    }
}



#define scr_field_respawn_remove
///scr_field_respawn_remove(pos)

ds_list_delete(global.FIELD_RESPAWNS,argument0)

#define scr_field_respawn_find
///scr_field_respawn_find(gridX,gridY)


return scr_field_list_find(argument0,argument1,global.FIELD_RESPAWNS);

#define scr_field_respawn_set_dur
///scr_field_respawn_set_dur(gridX,gridY,duration);

var index = scr_field_respawn_find(argument0, argument1);
var resXY = global.FIELD_RESPAWNS[| index];
resXY[@ 2] = argument2;