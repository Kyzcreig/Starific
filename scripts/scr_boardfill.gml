#define scr_boardfill
///scr_boardfill()
var resXY, data;

//Toggle off spawn delay mutex at roundstart for this effect
obj_control_game.spawnDelay = 0;
// Set Duration
var dur = 1*room_speed;

//Set All Respawn Timers to 1 Second
for (var i = ds_list_size(global.FIELD_RESPAWNS) - 1; i >= 0 ; i--)
{
   data = global.FIELD_RESPAWNS[| i];
   data[@ 2] = irandom(dur);
}   

//Add All Empty Cells to Respawner
//Iterate Through Empty Lists
for (var i = 0; i < 5; i++){
    for (var j = 0; j < 5; j++){
        // Get List
        list = global.FIELD_EMPTIES[# i, j];
        // Iterate Through Empty List
        listSize = ds_list_size(list);
        for (var k = listSize-1; k >= 0; k--){
            var resXY = list[| k];  
            //Set Respawn Timer
            scr_field_respawn_add(resXY[0],resXY[1], irandom(dur));
        }
    }
}


// Set Board Fill Cooldowns
boardWideEffectTimer += boardWideEffectTimerMax //cooldown for spawner
            //NB: += is good here, to keep it calm after the storm.
boardFilledTimer = dur; //cooldown for screenshots
        //NB: Flag is used to prevent board fill/clear from chaining

#define scr_cellfill
///scr_cellfill(gx,gy, delay)
var gridX = argument[0]
var gridY = argument[1]
var duration = argument[2]

var index, list_index;
if gamecell_is_valid(gridX,gridY)
{
    cellVal = global.FIELD_OBJECTS[# gridX,gridY];
    
    // If Empty Cell
    if cellVal < 0 {
       scr_field_respawn_add(gridX,gridY,duration);
       exit;
    
    } 
    // Else if Respawning Cell
    else if cellVal < DENSITY {
       scr_field_respawn_set_dur(gridX,gridY,duration);
       exit;
    }
        
}