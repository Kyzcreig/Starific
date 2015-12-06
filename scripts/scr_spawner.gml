#define scr_spawner
///scr_spawner(gridX, gridY, decrement_spawn_counter, spawnFlag)

/* 
    Spawn flags:
    -2 = star cash
    -1 = basic deflectors
     0 = none
     1 = special deflectors
*/

var rng, result, obj, spawnFlag, decrementSpawner, gridX, gridY, fieldXY;


// Set Coordinate Data
gridX = argument[0];
gridY = argument[1];
fieldXY = convertGridtoXY(gridX, gridY)

// Set Spawn Decrementor
if argument_count > 2{
    if argument[2]{
        decrementSpawner = 1;
    } else {
        decrementSpawner = 0;
    }
} else {
    decrementSpawner = 1;
}
// Decrement Spawner
if decrementSpawner {
    SPAWN_COUNTER -= 1;
}

// Set Spawn Flags
if argument_count > 3{
    spawnFlag = argument[3];
} else {
    spawnFlag = 0;
}

/* NB: If the "overwhelmingness" of the game is still a problem
   we can use gamesPlayedTotal or careerPlaytimeTotal to conditionally
   restrict the variety of powerups, to make it easier on people. 
*/


// -- Select Deflector Type to be Spawned -- //
// If No Flag
if spawnFlag == 0 {
    // Random Selection
    result = scr_spawner_outcome("deflector_types");
} else {
    switch spawnFlag {
    
    case -2:
        result = 0;
    break;
    
    case -1:
        result = 2;
    break;
    
    case 1:
        result = 1;
    break;
    
    }
}



//NB: We could turn all this stuff into switches also



//Spawn Star Cash
if (result == 0)
{
    result = scr_spawner_outcome("cash");
}
//Spawn Basic Deflector
else if (result == 2){
    result = scr_spawner_outcome("basic");

}
//Spawn Special Deflectors
else {
    // Set Spawn Tier
    var tier;
    if level <= ceil(8/levelDiffAdj){
        tier = "1";
    }
    else if level <= ceil(16/levelDiffAdj){
        tier = "2";
    }
    else if level <= ceil(24/levelDiffAdj){
        tier = "3";
    }
    else {
        tier = "4";
    }

    // Spawns for Moves Mode    
    if MODE == MODES.MOVES{ //spawn special deflectors
        // Select Special Type
        result = scr_spawner_outcome("special_types_moves");
        
        // Select Bomb (chain effects)
        if result == 0{
            result = scr_spawner_outcome("bombs_moves");
        }
        // Select Powerup (instant effect)
        else if result == 1{ 
            result = scr_spawner_outcome("instant_moves_onCD");
            //NB: Decided against including any of these CD powerups at all.
            // Too OP.
        }
        // Select Powerup (duration effect)
        else if result == 2{
            result = scr_spawner_outcome("duration_moves_tier_"+tier);
        }
    }
    // Spawn for Other Modes
    else { 
        // Select Special Type
        result = scr_spawner_outcome("special_types_tier_"+tier);
        
        // Select Bomb (chain effects)
        if result == 0{
            result = scr_spawner_outcome("bombs_tier_"+tier);
        }
        // Select Powerup (instant effect)
        else if result == 1{
            if boardWideEffectTimer <= 0 and instance_number(obj_powerup_parent_board) < 2 {//cooldown
                result = scr_spawner_outcome("instant_offCD_tier_"+tier);
            
            }else {
                result = scr_spawner_outcome("instant_onCD_tier_"+tier);
            }
        }
        // Select Powerup (duration effect)
        else if result == 2{
            result = scr_spawner_outcome("duration_tier_"+tier);
        }
    }
}

// Spawn Object from Pool
obj = scr_spawner_create( fieldXY[0], fieldXY[1], result);

/* nb: sINCE WE need to wait 1 step for the instance data to change
    we may need to not call scr_spawner unless there's a pool object extant in the ds_list


*/


// Set Field Data
scr_field_set(gridX,gridY, 1, obj)


return obj 

#define scr_spawner_create
///scr_spawner_create(x,y,newObj);



//ds_queue_dequeue(global.FIELD_POOL)
if RESOURCE_POOLING {
    // Pool Spawn
    with (ds_queue_dequeue(global.FIELD_POOL)) {
        x = argument0;
        y = argument1;
        instance_change(argument2, true);
        return id;
        break;
    }
} else {
    // Normal Spawn
    return instance_create(argument0, argument1, argument2);
}



#define scr_pool_enqueue
///scr_pool_enqueue(id);


ds_queue_enqueue(global.FIELD_POOL,argument0);