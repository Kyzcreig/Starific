#define scr_board_init
///scr_board_init()

MOVE_ACTIVE = false;

      
//Clear Deflectors
with(obj_reflector_parent){
   instance_destroy()
   // NB: Not part of scr_board_reset because we call it on gameover too
}

// Gameplay Data Reset 
scr_board_reset()

//Set Board Intro Tween Params 
//randomize()
INTRO_ANGLE = irandom(5)
INTRO_RAD = irandom(4)
INTRO_DIST = irandom(8)
INTRO_DUR = irandom(4)
INTRO_EASE = irandom(10)
//INTRO_ANGLE = 0; INTRO_RAD = 4; INTRO_DIST = 7; INTRO_DUR = 1; INTRO_EASE = 5; 
// Set Begin Game Alarm (Adjusted by Intro Tween)
alarm[0] = .5 * room_speed;

// Clear Game Field Data
scr_field_data_clear()

var i, j, obj, count;
count = 0;
//Iterate over each grid cell
for(i = 0; i < fieldW; i ++) { 
    for(j = 0; j < fieldH; j ++) {
          // Check if Cell is Valid (within corners)
          if gamecell_is_valid(i, j, 0) {
             // Random Probability to Spawn
             if random(1) <= 1*fieldDensity*fieldSat and 
                global.FIELD_OBJECTS[# i,j] == noone
             {
                /// Spawn Object to Fill Cell
                scr_spawner(i,j,0, scr_spawner_set_power_flag());
                count++;
               
             }
             // Empty Cell
             else if global.FIELD_OBJECTS[# i,j] == noone{
                // Set Value and Add to Spawn Queue
                scr_field_empty_add(Array(i, j));  
             }
         }
         // Set Invalid Cells to Null Value
         else{
            scr_field_set(i,j, -1)
         }
    } 
}


// Shuffle Empties
scr_field_empty_shuffle()

//Increment boardinit counter
BOARD_INIT_COUNT += 1;

// Set Starting Board Count
//ScheduleScript(id, false, 1, scr_moves_board_start_set());
moves_board_start = count;//instance_number(obj_reflector_parent);













#define scr_board_reset
///scr_board_reset()

  
// If There is a power controller
if object_exists(obj_control_powers){
    //powerups
    scr_clear_powers();
    
}

// Set Bomb Stuff
scr_bomb_force_clear()

//Clear combo counter
if MODE == MODES.ARCADE {
    global.pComboTimer = -1
    global.pComboCount = 0
    //Restore current theme
    //scr_restore_color_theme();
    
    //Clear Text
    with(obj_text_generic){instance_destroy()}
}
// Clear Falling Powers
with(obj_powerup_falling){instance_destroy()}

//Reset board nuke cooldowns
scr_board_wide_effects_clear();


//clear particles
/*
if BOARD_INIT_COUNT ==1{
    part_system_clear(PSYS_SUBSTAR_LAYER)
    part_system_clear(PSYS_FIELD_LAYER)
}*/

#define scr_respawn_tween
///scr_respawn_tween()

MOVE_ACTIVE = false;


//Blur tween out board
with(obj_reflector_parent){
    scr_deflector_cell_outro(id, true,false);
}
// Clear Powers
if instance_exists(obj_control_powers){
    //powers
    scr_clear_powers();
}
//scr_board_reset() //this is redundant in board_init
//but we're calling it early to wipe tapper texts
// Schedule Board Init
ScheduleScript(id,1,.6,scr_board_init);


//Set RoundBegin Alarm
alarm[0] = room_speed*1.2 //NB: outro tween takes .5 seconds, plus intro spawn takes .6


#define scr_sum_powers
///scr_sum_powers()


//show_debug_message("GETTING POWER COUNT");
var pTotal = 0;
var i = -1; 
var p, val;
//Sum the number of active powers
repeat(array_length_1d(POWER_ARRAY)){
    ++i;
    p = POWER_ARRAY[i];
    //val = p[0];
    //show_debug_message("name,val="+string(p[5])+","+string(val));
    pTotal += sign(p[0]);
    
}          

return pTotal;


#define scr_clear_powers
///scr_clear_powers()

for (var z = 0, n = array_length_1d(POWER_ARRAY); z < n ; z++){
    //Clear Power Counts
    var p = noone; p = POWER_ARRAY[z];
    //Clear Timer Lists
    var l = noone; l = p[@ 1];
    for (var w = 0, m =ds_list_size(l); w < m; w++){
        l[| w] = 0;
    }
    //Reset Misc Values
    //p[@ 7] = p[8];
    
}


    

#define scr_clear_power_ups
///scr_clear_power_ups()


for (var z = 0, n = array_length_1d(POWER_ARRAY); z < n ; z++){
    //Clear Power Counts
    var p = noone; p = POWER_ARRAY[z];
    //Clear Up Timer Lists
    if p[@ 3] == 1{
        var l = noone;
        l = p[@ 1];
        for (var w = 0, m =ds_list_size(l); w < m; w++){
            l[| w] = 0;
        }
    }
}


/*
if POWER_addgrow[@ 7] > 1 POWER_addgrow[@ 7] = 1;
if POWER_addslower[@ 7] < 1 POWER_addslower[@ 7] = 1;

for (var z = 0, n = array_length_1d(POWER_ARRAY); z < n ; z++){
    //Clear Power Counts
    var p = noone;
    p = POWER_ARRAY[z];
    if p[3] == 1{
        p[@ 0] = 0;
        //Clear Timer Lists
        var l = noone;
        l = p[@ 1];
        ds_list_clear(l);
    }
}


scr_scale_paddle()
//clear mirror paddles
with (obj_launcher_mirror) {scr_paddle_tween_out()}


    

#define scr_clear_power_downs
///scr_clear_power_downs()



for (var z = 0, n = array_length_1d(POWER_ARRAY); z < n ; z++){
    //Clear Power Counts
    var p = noone; p = POWER_ARRAY[z];
    //Clear Down Timer Lists
    if p[@ 3] == 2{
        var l = noone;
        l = p[@ 1];
        for (var w = 0, m =ds_list_size(l); w < m; w++){
            l[| w] = 0;
        }
    }
}


/*
if POWER_subshrink[@ 7]  < 1 POWER_subshrink[@ 7]  = 1;
if POWER_subfaster[@ 7] > 1 POWER_subfaster[@ 7] = 1;
//unfreeze
PADDLE_MOTION = 1;

for (var z = 0, n = array_length_1d(POWER_ARRAY); z < n ; z++){
    //Clear Power Counts
    var p = noone;
    p = POWER_ARRAY[z];
    if p[3] == 2{
        p[@ 0] = 0;
        //Clear Timer Lists
        var l = noone;
        l = p[@ 1];
        ds_list_clear(l);
    }
}

scr_scale_paddle()
    
#define scr_board_wide_effects_clear
///scr_board_wide_effects_clear()

boardWideEffectTimer = -1;
boardFilledTimer = -1;
boardClearedTimer = -1;

// Set board wide CD penalty duration
boardWideEffectTimerMax = 5*room_speed;
// Delay Board Clear/Fill Effects for New Players (to prevent overwhelm)
if gamesPlayedTotal < 3 {
    boardWideEffectTimerMax *= 3; // Scaled by 3x
}