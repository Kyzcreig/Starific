#define scr_field_respawn_queue_add
///scr_field_respawn_queue_add(iterations)

var remainingSpawns = argument[0];
var list, listSize, rngIndex, resXY;

var continue_max = 13; //12
            //NB: 12 would cover all the 3 corner pieces for 4 corners

// Iterate Until Spawns Complete
while ( remainingSpawns > 0 ) {

    // Get Top Priority List
    list = ds_priority_find_min(global.FIELD_EMPTIES_QUEUE);
    // Select a Random Cell in List
    listSize = ds_list_size(list);
    if listSize <= 0{
        /*NB: This happens for legitimate reasons, e.g. all other spawn blocks are too dense
           and this one is on the corner with only a few valid cells.
           So this is a simple stopgap measure.
        */
        
        ds_priority_change_priority(global.FIELD_EMPTIES_QUEUE, list, DENSITY);
        //remainingSpawns--;
            //NB: Decrement it to prevent infinite loops?
            
        // Limit Infinite Looping
        continue_max--;
        if continue_max <= 0 {
            break;
        }else {
            continue;
        }
    }
    rngIndex = irandom(listSize-1);
    resXY = list[| rngIndex];
    
    // Set Respawn Timer for Cell
    scr_field_respawn_add(resXY[0],resXY[1], irandom(gridSize * .5) * room_speed)

    //Decrement Count
    remainingSpawns--;
}









#define scr_field_respawn_queue
///scr_field_respawn_queue()



//Resets field saturation %
if fieldSet and FULL_SECOND_INTERVAL{
    //Reset Field Density Scalar every so many seconds
   alarm[1] = 1 + irandom_range(10,20) * room_speed //(15)
   fieldSet = false;
}
// Get Field Stats
var _FillPercentMax = fieldDensity * fieldSat;
// Scaleup by Field Density Doubler
if POWER_density_doubler[0] > 0 {
    _FillPercentMax *= 2;
}
// Clamp to 1
_FillPercentMax = min(1,_FillPercentMax); 
var _FillMax = BOARD_TOTAL * _FillPercentMax; 
var _FillCurrent = instance_number(obj_reflector_parent);
//var _FillPercent = (_FillCurrent+SPAWN_COUNTER*.5) / _FillMax;  
//var _FillPercent = _FillCurrent / _FillMax;
    //NB: I like not counting spawners as alive because it gives the game a wave-y vibe.
//Nerf Spawn Rate During railOverload
if railOverload{
    _FillMax *= .8;
}
// Nerf Spawn Rate By Star Count
var steepness = 10+GRID*2;//14
_FillMax *= (1 / (global.ActiveStarCount + steepness)) * (steepness+1);
                //NB: Scale effect by levelDiffAdj

// Calculate Weight of Respawning Cells
var _RespawnScalar = .5;//.75
var _RespawnWeight = SPAWN_COUNTER * _RespawnScalar;
    /* NB: Counting respawning cells at 50% has the effect of the board bouncing back into fullness
        after a big explosion, especially after the board clear powerup.
        Overall I think that makes it more fun.  And if necessary the effect can be mitigated by 
        making the scalar on SPAWN_COUNTER closer to 1.
        
        I also prefer counting it in the _PossibleLoops here as opposed to _FillCurrent
        Because it allows you to keep the two stats distinct.
    */
// Set Possible Spawn Count
var _PossibleSpawns = max(0,(_FillMax - (_FillCurrent + _RespawnWeight) )); //*.75 
// Calculate Max Possible
var _MaxPossibleSpawns = max(0,(BOARD_TOTAL - _FillCurrent)); //*.75 
// Clamp to the Unoccupied Cells Available
_PossibleSpawns = min(_PossibleSpawns, _MaxPossibleSpawns - SPAWN_COUNTER);


// Cap Loops According to GridSize so they don't all spawn immediately.
var _CapLoops = max(0,round((25 - gridSize * .33) * RMSPD_DELTA));
    // NB: Leave the numbers alone, they're fine (and must stay positive).

// Add Deflectors to Spawn Queue
scr_field_respawn_queue_add(min(_CapLoops, _PossibleSpawns)); 
