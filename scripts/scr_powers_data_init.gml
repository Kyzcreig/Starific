#define scr_powers_data_init
////scr_powers_data_init()

globalvar 
POWER_ARRAY,
// Uppers/Downers/Rounders 
POWER_grow,
POWER_shrink, 
POWER_faster, 
POWER_slower,  
POWER_pmulti,
POWER_pdivis, 
POWER_mirror, 
POWER_freeze,
POWER_hugestar,
POWER_halfangle,
POWER_threehalfangle,
POWER_randomangle, 
POWER_reverseangle,
POWER_noangle,
POWER_diagturn,
POWER_slowpaddle,
POWER_multistar,
POWER_addgrow,
POWER_subshrink,
POWER_addslower,
POWER_subfaster,
POWER_longerpowerups,
POWER_shorterpowerdowns,
POWER_invertcontrols,
POWER_multibonus,
POWER_multimalus,
POWER_splitpaddle,
POWER_cashtap,
POWER_offsetpaddle,
POWER_cashx2,
POWER_density_doubler
POWER_multidensity;


POWER_ARRAY = noone; //init var, so we can make it an array later
POWER_grow[0] = 0;
POWER_shrink[0] = 0;
POWER_faster[0] = 0;
POWER_slower[0] = 0;
POWER_pmulti[0] = 0;
POWER_pdivis[0] = 0;
POWER_mirror[0] = 0;
POWER_freeze[0] = 0;
POWER_hugestar[0] = 0;
POWER_halfangle[0] = 0;
POWER_threehalfangle[0] = 0;
POWER_randomangle[0] = 0;
POWER_reverseangle[0] = 0;
POWER_noangle[0] = 0;
POWER_diagturn[0] = 0;
POWER_slowpaddle[0] = 0;
POWER_multistar[0] = 0;
POWER_addgrow[0] = 0;
POWER_subshrink[0] = 0;
POWER_addslower[0] = 0;
POWER_subfaster[0] = 0;
POWER_longerpowerups[0] = 0;
POWER_shorterpowerdowns[0] = 0;
POWER_invertcontrols[0] = 0;
POWER_multibonus[0] = 0;
POWER_multimalus[0] = 0;
POWER_splitpaddle[0] = 0;
POWER_cashtap[0] = 0;
POWER_offsetpaddle[0] = 0;
POWER_cashx2[0] = 0;
POWER_density_doubler[0] = 0;
POWER_multidensity[0] = 0;


#define scr_powers_data_set
///scr_powers_data_set()


var i = -1;
//NB: Keep set in this order or the indexes for the jiggle icons will be off.


//Count    //Timer List     //Dur      //objIndex    ///Tapper Text      //Misc Value   // Jiggle Index
scr_new_power(POWER_grow,ds_list_create(), 0, obj_powerup_growpaddle, "",1,++i) 
scr_new_power(POWER_shrink,ds_list_create(), 0, obj_powerup_shrinkpaddle, "",1,++i) 
scr_new_power(POWER_faster,ds_list_create(), 0, obj_powerup_faster, "",1,++i) 
scr_new_power(POWER_slower,ds_list_create(), 0, obj_powerup_slower, "",1,++i) 
scr_new_power(POWER_pmulti,ds_list_create(), 0, obj_powerup_points, "",1,++i) 
scr_new_power(POWER_pdivis,ds_list_create(), 0, obj_powerup_antipoints, "",1,++i) 
scr_new_power(POWER_mirror,ds_list_create(), 0, obj_powerup_mirrorpaddle, "",-1,++i)  //NB: Misc value=-1
scr_new_power(POWER_freeze,ds_list_create(), 0, obj_powerup_freezepaddle, "tap to unfreeze#paddle",1,++i) 
scr_new_power(POWER_hugestar,ds_list_create(), 0, obj_powerup_bigstar, "",1,++i) 
scr_new_power(POWER_halfangle,ds_list_create(), 0, obj_powerup_halfangleturn, "",1,++i) 
scr_new_power(POWER_threehalfangle,ds_list_create(), 0, obj_powerup_threehalvesangle, "",1,++i) 
scr_new_power(POWER_randomangle,ds_list_create(), 0, obj_powerup_randomturn, "",1,++i) 
scr_new_power(POWER_reverseangle,ds_list_create(), 0, obj_powerup_reverseturn, "",1,++i) 
scr_new_power(POWER_noangle,ds_list_create(), 0, obj_powerup_pierce, "",1,++i) 
scr_new_power(POWER_diagturn,ds_list_create(), 0, obj_powerup_diagturn, "",1,++i) 
scr_new_power(POWER_slowpaddle,ds_list_create(), 0, obj_powerup_slowpaddle, "tap to unslow#paddle",1,++i) 
scr_new_power(POWER_multistar,ds_list_create(), 0, obj_powerup_multistar, "tap for#extra stars",1,++i) 
scr_new_power(POWER_addgrow,ds_list_create(), 0, obj_powerup_addgrow, "tap to grow#paddle",1,++i) 
scr_new_power(POWER_subshrink,ds_list_create(), 0, obj_powerup_subshrink, "tap to unshrink#paddle",1,++i) 
scr_new_power(POWER_addslower,ds_list_create(), 0, obj_powerup_addslower, "tap to slow#stars",1,++i) 
scr_new_power(POWER_subfaster,ds_list_create(), 0, obj_powerup_subfaster, "tap to unspeed#stars",1,++i) 
scr_new_power(POWER_longerpowerups,ds_list_create(), 0, obj_powerup_longerpowerups, "tap to make#uppers longer",1,++i) 
scr_new_power(POWER_shorterpowerdowns,ds_list_create(), 0, obj_powerup_shorterpowerdowns, "tap to make#downers shorter",1,++i) 
scr_new_power(POWER_invertcontrols,ds_list_create(), 0, obj_powerup_invertpaddle, "tap to fix#inverted controls", -1,++i) //NB: Misc value=-1
scr_new_power(POWER_multibonus,ds_list_create(), 0, obj_powerup_multibonus, "tap for extra#combos",1,++i) 
scr_new_power(POWER_multimalus,ds_list_create(), 0, obj_powerup_multimalus, "tap to enable#combos",1,++i)  
scr_new_power(POWER_splitpaddle,ds_list_create(), 0, obj_powerup_splitpaddle, "tap to unsplit#paddle",0,++i) //NB: Misc value=0
scr_new_power(POWER_cashtap,ds_list_create(), 0, obj_powerup_cash_tap, "tap for#cash",1, ++i)  
scr_new_power(POWER_offsetpaddle,ds_list_create(), 0, obj_powerup_offsetpaddle, "",0, ++i) //NB: Misc value=0 //"tap to reset#paddle"
scr_new_power(POWER_cashx2,ds_list_create(), 0, obj_powerup_cash_x2, "",1, ++i)  
scr_new_power(POWER_density_doubler,ds_list_create(), 0, obj_powerup_density_doubler, "",1, ++i)  
scr_new_power(POWER_multidensity,ds_list_create(), 0, obj_powerup_multidensity, "tap to spawn#deflectors", 1, ++i)  


/* NB: Be sure to set the texture group for the power icon for EVERY configuration, GMS is silly like that.


*/



#define scr_powers_controller_init
///scr_powers_controller_init()


defaultPowerDuration =  (15 + 3 * GRID) * 60//25*room_speed
    //NB: Powers last longer on bigger grid sizes, I find this works better.
var mAdj = 1;
//If MOVES_LEFT mode
if MODE == MODES.MOVES{ mAdj = .75}


POWER_grow[@ 2] = defaultPowerDuration;
POWER_shrink[@ 2] = defaultPowerDuration;
POWER_faster[@ 2] = defaultPowerDuration
POWER_slower[@ 2] = defaultPowerDuration
POWER_mirror[@ 2] = defaultPowerDuration 
POWER_freeze[@ 2] = defaultPowerDuration * .2 
POWER_pmulti[@ 2] = defaultPowerDuration;
POWER_pdivis[@ 2] = defaultPowerDuration;
POWER_hugestar[@ 2] = defaultPowerDuration * .4
POWER_halfangle[@ 2] = defaultPowerDuration * .4 * sqr(mAdj)//10*room_speed;
POWER_threehalfangle[@ 2] = defaultPowerDuration * .4 * sqr(mAdj)//10*room_speed;
POWER_randomangle[@ 2] = defaultPowerDuration * .4 * sqr(mAdj)//10*room_speed;
POWER_reverseangle[@ 2] = defaultPowerDuration * .1 * mAdj//5*room_speed;
POWER_noangle[@ 2] = defaultPowerDuration * .1 * mAdj//5*room_speed;
POWER_diagturn[@ 2] = defaultPowerDuration * .4 * sqr(mAdj)//10*room_speed;
POWER_slowpaddle[@ 2] = defaultPowerDuration * .4;
POWER_multistar[@ 2] = defaultPowerDuration * .6; 
POWER_addgrow[@ 2] = defaultPowerDuration * .4;
POWER_subshrink[@ 2] = defaultPowerDuration * .4;
POWER_addslower[@ 2] = defaultPowerDuration * .4;
POWER_subfaster[@ 2] = defaultPowerDuration * .4;
POWER_longerpowerups[@ 2] = defaultPowerDuration * .6; 
POWER_shorterpowerdowns[@ 2] = defaultPowerDuration * .6;
POWER_invertcontrols[@ 2] = defaultPowerDuration * .4; 
POWER_multibonus[@ 2] = defaultPowerDuration * .6; 
POWER_multimalus[@ 2] = defaultPowerDuration * .6;
POWER_splitpaddle[@ 2] = defaultPowerDuration * .6;
POWER_cashtap[@ 2] = defaultPowerDuration * .6;
POWER_offsetpaddle[@ 2] = defaultPowerDuration * .4;
POWER_cashx2[@ 2] = defaultPowerDuration //* .6;
POWER_density_doubler[@ 2] = defaultPowerDuration * .4; //we probably don't want this to be too long
POWER_multidensity[@ 2] = defaultPowerDuration * .6; //we probably don't want this to be too long
//30 total


// Unit to Decrement Time
powerDecrement = RMSPD_DELTA;
railCoverageWithOutTappers = 0;

paddleScale = false;

modifyDur = 0;

powers_len = array_length_1d(POWER_ARRAY);
gamemods_len = scr_gamemod_count(false);



jiggletime = 1.0*room_speed
for (var i=0, n = powers_len + gamemods_len; i < n; i++){ 
    for (j=0;j<4;j++){
        cd_jiggle[i,j] = 0;
    }
}

tap_text_index = -1;
tap_timerval = 0;
tap_col = COLORS[0];
tap_text = "";


mainEase[0] = 0;
mainTween = noone;



touchPadTap = false;
touchPadTapEase[0] = 1;
touchPadTapTween = noone;

#define scr_powers_controller_step_powers
///scr_powers_controller_step_powers()


/* TO DO name a variable here then place it in all the decrement timer areas as a scalar
    by default it can be = to RMSPD_DELTA, since we're now using a 60fps timer


*/
// Reset Power Duration Step Decrement
powerDecrement = RMSPD_DELTA;
if scr_gamemod_get_index("half_duration", 8) > 0 {
    // Scale Duration Decrement By Game Mod
    powerDecrement /= scr_gamemod_get_index("half_duration", 10);
}
if scr_gamemod_get_index("double_duration", 8) > 0 {
    // Scale Duration Decrement By Game Mod
    powerDecrement /= scr_gamemod_get_index("double_duration", 10);
}
        


//Detect Overloaded Rail Coverage
if instance_exists(obj_launcher) {
    var maxScale = RAIL_LENGTH/PADDLE_W;
    var currentPadScale = paddle_id.pad_xscale[0];
    //NB: Number of Paddles Over Max Scale
    railCoverage = currentPadScale * (1 + POWER_mirror[@ 0]) / maxScale 
    // Remove Tapper Scalar Effects
    railCoverageWithOutTappers = railCoverage / (POWER_addgrow[@ 7]*POWER_subshrink[@ 7]);
}

if railCoverageWithOutTappers > .80 { 
   railOverload = true;
}
else {
   railOverload = false;
}
// Paddle Coverage Achievement
if railCoverage >= 1 and MOVE_ACTIVE {
     // Set Achievement
     scr_unlock_set_status(5,0,2,false); //NB: Avoid I/O in steps
}
    

//Set Duration Modifying Flag
if modifyDur != 0{
   //Sets Flag for detection
   if abs(modifyDur) < 1{
      modifyDur = round(modifyDur*10);
   }
   //Clears Flag
   else{
      modifyDur = 0;
   }
   //We Do this this way so that we can set all durations on the same STEP
}


//Scale paddle
if paddleScale {
    if GAME_ACTIVE scr_scale_paddle(); 
    paddleScale=false;
}


// Decrement Board Wide Effects Spawner CD
if boardWideEffectTimer > 0 {
    boardWideEffectTimer--;
}
// Decrement Board Fill CD
if boardFilledTimer > 0 {
    boardFilledTimer--;
}
// Decrement Board Clear CD
if boardClearedTimer > 0 {
    boardClearedTimer--;
}

// Clear Touch Tap Flag
touchPadTap = false;

/*
// Create Temp Power Vars
var //NB: Not really necessary..
powerArray,
powerTimer,
powerMaxDur, 
powerIndex,
antiPowerArray,
antiPowerTimer,
antiPowerIndex;
*/

//POWER_grow[@ 0] stuff
powerArray = POWER_grow;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
antiPowerArray = POWER_shrink;
antiPowerTimer = antiPowerArray[@ 1];
antiPowerIndex = antiPowerArray[@ 8]

if powerArray[@ 0] > ds_list_size(powerTimer){
    var dur = powerMaxDur
    if antiPowerArray[@ 0] > 0{
        for (var i = ds_list_size(antiPowerTimer) - 1; i >= 0;i--){
            dur -= antiPowerTimer[| i];
            antiPowerTimer[| i] = 0;
            if dur < 0{antiPowerTimer[| i] = antiPowerTimer[| i] - dur}
            if dur <= 0{break}
        }
    }
    if dur > 0{
        ds_list_insert(powerTimer,0,dur)
        cd_jiggle[powerIndex,0] = jiggletime;
    }
    else{ //else jiggle contra powerup
        powerArray[@ 0] -= 1;
        cd_jiggle[antiPowerIndex,0] = jiggletime;
    }
    paddleScale = true;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
        paddleScale = true;
    }
    else powerTimer[| i] -= max(1,scr_power_get_quick_deplete_value())*powerDecrement;
    //else powerTimer[| i] -= (1+ railOverload*ds_list_size(powerTimer))
}





//POWER_shrink[@ 0] stuff
powerArray = POWER_shrink;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
antiPowerArray = POWER_grow;
antiPowerTimer = antiPowerArray[@ 1];
antiPowerIndex = antiPowerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    var dur = powerMaxDur
    if antiPowerArray[@ 0] > 0{
        for (var i = ds_list_size(antiPowerTimer) - 1; i >= 0;i--){
            dur -= antiPowerTimer[| i];
            antiPowerTimer[| i] = 0;
            if dur < 0{antiPowerTimer[| i] = antiPowerTimer[| i] - dur}
            if dur <= 0{break}
        }
    }
    if dur > 0{
        ds_list_insert(powerTimer,0,dur)
        cd_jiggle[powerIndex,0] = jiggletime;
    }
    else{ //else jiggle contra powerup
        powerArray[@ 0] -= 1;
        cd_jiggle[antiPowerIndex,0] = jiggletime;
    }
    paddleScale = true;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
        paddleScale = true;
    }
    else powerTimer[| i] -= 1*powerDecrement//(1+ railOverload*ds_list_size(powerTimer))
        //Maybe we don't hyper decrement the shrinks so you might end up super small after a big paddle.
    //else powerTimer[| i] = powerTimer[| i] - (1)
    
    /*if railCoverage > .3 and i == ds_list_size(powerTimer) - 1{
       powerTimer[| i] = powerTimer[| i] - sqr(i)*railOverload
    }*/
    
    
}





//POWER_faster[@ 0] stuff
powerArray = POWER_faster;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
antiPowerArray = POWER_slower;
antiPowerTimer = antiPowerArray[@ 1];
antiPowerIndex = antiPowerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    var dur = powerMaxDur;
    if antiPowerArray[@ 0] > 0{
        for (var i = ds_list_size(antiPowerTimer) - 1; i >= 0;i--){
            dur -= antiPowerTimer[| i];
            antiPowerTimer[| i] = 0;
            if dur < 0{antiPowerTimer[| i] = antiPowerTimer[| i] - dur}
            if dur <= 0{break}
        }
    }
    if dur > 0{
        ds_list_insert(powerTimer,0,dur)
        cd_jiggle[powerIndex,0] = jiggletime;
    }
    else{ //else jiggle contra powerup
        powerArray[@ 0] -= 1;
        cd_jiggle[antiPowerIndex,0] = jiggletime;
    }
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){

    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }


    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
    
}


//POWER_slower[@ 0] stuff
powerArray = POWER_slower;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8];
antiPowerArray = POWER_faster;
antiPowerTimer = antiPowerArray[@ 1];
antiPowerIndex = antiPowerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    var dur = powerMaxDur
    if antiPowerArray[@ 0] > 0{
        for (var i = ds_list_size(antiPowerTimer) - 1; i >= 0;i--){
            dur -= antiPowerTimer[| i];
            antiPowerTimer[| i] = 0;
            if dur < 0{antiPowerTimer[| i] = antiPowerTimer[| i] - dur}
            if dur <= 0{break}
        }
    }
    if dur > 0{
        ds_list_insert(powerTimer,0,dur)
        cd_jiggle[powerIndex,0] = jiggletime;
    }
    else{ //elseo jiggle contra powerup
        powerArray[@ 0] -= 1;
        cd_jiggle[antiPowerIndex,0] = jiggletime;
    }
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }

    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
       
}






//POWER_pmulti[@ 0] stuff
powerArray = POWER_pmulti;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
antiPowerArray = POWER_pdivis;
antiPowerTimer = antiPowerArray[@ 1];
antiPowerIndex = antiPowerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    var dur = powerMaxDur
    if antiPowerArray[@ 0] > 0{
        for (var i = ds_list_size(antiPowerTimer) - 1; i >= 0;i--){
            dur -= antiPowerTimer[| i];
            antiPowerTimer[| i] = 0;
            if dur < 0{antiPowerTimer[| i] = antiPowerTimer[| i] - dur}
            if dur <= 0{break}
        }
    }
    if dur > 0{
        ds_list_insert(powerTimer,0,dur)
        cd_jiggle[powerIndex,0] = jiggletime;
    }
    else{ //else jiggle contra powerup
        powerArray[@ 0] -= 1;
        cd_jiggle[antiPowerIndex,0] = jiggletime;
    }
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
    
    
}



//POWER_pdivis[@ 0] stuff
powerArray = POWER_pdivis;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
antiPowerArray = POWER_pmulti;
antiPowerTimer = antiPowerArray[@ 1];
antiPowerIndex = antiPowerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    var dur = powerMaxDur
    if antiPowerArray[@ 0] > 0{
        for (var i = ds_list_size(antiPowerTimer) - 1; i >= 0;i--){
            dur -= antiPowerTimer[| i];
            antiPowerTimer[| i] = 0;
            if dur < 0{antiPowerTimer[| i] = antiPowerTimer[| i] - dur}
            if dur <= 0{break}
        }
    }
    if dur > 0{
        ds_list_insert(powerTimer,0,dur)
        cd_jiggle[powerIndex,0] = jiggletime;
    }
    else{ //else jiggle contra powerup
        powerArray[@ 0] -= 1;
        cd_jiggle[antiPowerIndex,0] = jiggletime;
    }
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
}




//POWER_mirror[@ 0] stuff
powerArray = POWER_mirror;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
    
    //Multifaceted Achievement
    if powerArray[@ 0] >= 3 {
        // Set Achievement
        scr_unlock_set_status(5,1,2,false); //NB: Avoid I/O in steps
    }
    
    
}
// Update Array of Mirrors each step
arr_of_mirrors = noone;
var count = instance_number(obj_launcher_mirror)
for (z = 0 ; z < count; z++){ 
    arr_of_mirrors[z] = instance_find(obj_launcher_mirror,z)
    // Reset Low Time Coloring/Alpha
    with (arr_of_mirrors[z]) {  
        pad_alpha = 1; 
        mirrorColorDeath = false; 
    }
}

//if POWER_mirror[@ 7] != -1 POWER_mirror[@ 7] = -1;
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){

    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }

    // If Timer Finished
    if powerTimer[| i] <= 0{
        // Delete Timer
        ds_list_delete(powerTimer,i)
        
        // Decrement Power Counter
        powerArray[@ 0] -= 1;   
        
    
        var newestMirror = scr_paddle_mirror_get_nth(arr_of_mirrors, powerArray[@ 0]);
        // Check that mirror isn't already destroyed by a game restart
        if instance_exists(newestMirror) {
            //  With Mirror Paddle
            with (newestMirror) {
                // Flag it Tweening
                tweeningOut = true; //NB: Prevent Double Count in the iteration loop
                // Tween it Out
                scr_paddle_tween_out()
                
                //Set Pad Alpha to 1
                pad_alpha = 1;
                //Set Color back to normal if gameover
                if !GAME_ACTIVE {
                    mirrorColorDeath = false;
                }
            }
        }
    }
    else {
        // Dock Time From Timer
        powerTimer[| i] -= max(1,(POWER_grow[@ 0] < 2)*(1 + scr_power_get_quick_deplete_value()))*powerDecrement;
                        /*  NB: We don't start hyperdecrementing mirrors until all grows are gone.  
                            this will fascillitate more, (smaller) higher duration mirros, which makes things more fun.
                        */
        
        // If Time Remaining < 10% of max time
        if powerTimer[| i] < powerMaxDur * .20 {
            // Here we find the corresponding Mirror (not tweening) and blink its alpha
            var currentMirror = scr_paddle_mirror_get_nth(arr_of_mirrors, i);
            if instance_exists(currentMirror) {
                with (currentMirror) {
                    // Lerp the Pad Alpha
                    pad_alpha = lerp(.20, .80, FULL_SECOND_LERP);
                    // Flag Mirror Color as Dying (So Color can be LERPed
                    //mirrorColorDeath = true;
                }
            }
            
        }
        
    }
    
}



//POWER_freeze[@ 0] stuff
powerArray = POWER_freeze;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
    // Freeze Paddle Motion
    PADDLE_MOTION = 0;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    
    //Tapper stuff
    if mouse_check_button_pressed(mb_left){
       powerTimer[| i] = powerTimer[| i] - powerMaxDur/10;
       touchPadTap = true; 
    }

    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
        // Un Freeze Paddle Motion
        if powerArray[@ 0] == 0 {
            PADDLE_MOTION = 1;
        }

    }
    else powerTimer[| i] -= 1*powerDecrement
    
}


//POWER_hugestar[@ 0] stuff
powerArray = POWER_hugestar;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){

    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else{
        // Dock Time
        powerTimer[| i] -= max(1, .75*global.ActiveStarCount*(1 + .33 * railOverload))*powerDecrement;
                        /*NB: We Dock time based on star count to avoid crazy positive feedback.
                                We also decrement it faster if the rail is overloaded.
                        */
    
    }
}


//POWER_halfangle[@ 0] stuff
powerArray = POWER_halfangle;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
    
    //ds_list_clear(POWER_halfangle[@ 1]); POWER_halfangle[@ 0]=0;
    ds_list_clear(POWER_threehalfangle[@ 1]); POWER_threehalfangle[@ 0]=0;
    ds_list_clear(POWER_randomangle[@ 1]); POWER_randomangle[@ 0]=0;
    ds_list_clear(POWER_reverseangle[@ 1]); POWER_reverseangle[@ 0]=0;
    ds_list_clear(POWER_noangle[@ 1]); POWER_noangle[@ 0]=0;
    ds_list_clear(POWER_diagturn[@ 1]); POWER_diagturn[@ 0]=0;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }

    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
    
}



//POWER_threehalfangle[@ 0] stuff
powerArray = POWER_threehalfangle;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
    
    ds_list_clear(POWER_halfangle[@ 1]); POWER_halfangle[@ 0]=0;
    //ds_list_clear(POWER_threehalfangle[@ 1]); POWER_threehalfangle[@ 0]=0;
    ds_list_clear(POWER_randomangle[@ 1]); POWER_randomangle[@ 0]=0;
    ds_list_clear(POWER_reverseangle[@ 1]); POWER_reverseangle[@ 0]=0;
    ds_list_clear(POWER_noangle[@ 1]); POWER_noangle[@ 0]=0;
    ds_list_clear(POWER_diagturn[@ 1]); POWER_diagturn[@ 0]=0;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }

    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
    
}

//POWER_randomangle[@ 0] stuff
powerArray = POWER_randomangle;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
    
    ds_list_clear(POWER_halfangle[@ 1]); POWER_halfangle[@ 0]=0;
    ds_list_clear(POWER_threehalfangle[@ 1]); POWER_threehalfangle[@ 0]=0;
    //ds_list_clear(POWER_randomangle[@ 1]); POWER_randomangle[@ 0]=0;
    ds_list_clear(POWER_reverseangle[@ 1]); POWER_reverseangle[@ 0]=0;
    ds_list_clear(POWER_noangle[@ 1]); POWER_noangle[@ 0]=0;
    ds_list_clear(POWER_diagturn[@ 1]); POWER_diagturn[@ 0]=0;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }

    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
    
}



//POWER_reverseangle[@ 0] stuff
powerArray = POWER_reverseangle;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
    
    ds_list_clear(POWER_halfangle[@ 1]); POWER_halfangle[@ 0]=0;
    ds_list_clear(POWER_threehalfangle[@ 1]); POWER_threehalfangle[@ 0]=0;
    ds_list_clear(POWER_randomangle[@ 1]); POWER_randomangle[@ 0]=0;
    //ds_list_clear(POWER_reverseangle[@ 1]); POWER_reverseangle[@ 0]=0;
    ds_list_clear(POWER_noangle[@ 1]); POWER_noangle[@ 0]=0;
    ds_list_clear(POWER_diagturn[@ 1]); POWER_diagturn[@ 0]=0;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }

    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
    
}



//POWER_noangle[@ 0] stuff
powerArray = POWER_noangle;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
    
    ds_list_clear(POWER_halfangle[@ 1]); POWER_halfangle[@ 0]=0;
    ds_list_clear(POWER_threehalfangle[@ 1]); POWER_threehalfangle[@ 0]=0;
    ds_list_clear(POWER_randomangle[@ 1]); POWER_randomangle[@ 0]=0;
    ds_list_clear(POWER_reverseangle[@ 1]); POWER_reverseangle[@ 0]=0;
    //ds_list_clear(POWER_noangle[@ 1]); POWER_noangle[@ 0]=0;
    ds_list_clear(POWER_diagturn[@ 1]); POWER_diagturn[@ 0]=0;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }

    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
    
}


//POWER_diagturn[@ 0] stuff
powerArray = POWER_diagturn;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
    
    ds_list_clear(POWER_halfangle[@ 1]); POWER_halfangle[@ 0]=0;
    ds_list_clear(POWER_threehalfangle[@ 1]); POWER_threehalfangle[@ 0]=0;
    ds_list_clear(POWER_randomangle[@ 1]); POWER_randomangle[@ 0]=0;
    ds_list_clear(POWER_reverseangle[@ 1]); POWER_reverseangle[@ 0]=0;
    ds_list_clear(POWER_noangle[@ 1]); POWER_noangle[@ 0]=0;
    //ds_list_clear(POWER_diagturn[@ 1]); POWER_diagturn[@ 0]=0;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }

    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
    
}



//POWER_slowpaddle[@ 0] stuff
powerArray = POWER_slowpaddle;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    //Tapper stuff
    if mouse_check_button_pressed(mb_left){
       powerTimer[| i] = powerTimer[| i] - powerMaxDur/10;
       touchPadTap = true; 
    }
    
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
    
}



//POWER_multistar[@ 0] stuff
powerArray = POWER_multistar;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){

    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] { //This may be a bad idea to mix with extra stars, we'll see.
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    
    //Tapper stuff
    if mouse_check_button_pressed(mb_left){
       powerTimer[| i] -= powerMaxDur * random_range(.05,.15);
       
       touchPadTap = true; 
       
       //Spawn Extra Star
       var obj = shooter_nearest_valid(centerfieldx,centerfieldy);
       if obj != noone{
            scr_popup_text_field_moving(obj.x,obj.y,'extra star!',COLORS[1])
            with (obj){
                 var copyFieldXY = convertGridtoXY(intGridXY[0], intGridXY[1]);
                 spawn_star(direction +choose(1,2,3)*90,copyFieldXY[0],copyFieldXY[1])
            }
        }
    }
    
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= max(1,scr_power_get_quick_deplete_value())*powerDecrement;
        //NB: We decrement this faster if there is already a lot of stars in play already.  Helps performance.
    
}



//POWER_addgrow[@ 0] stuff
powerArray = POWER_addgrow;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
antiPowerArray = POWER_subshrink;
antiPowerTimer = antiPowerArray[@ 1];
antiPowerIndex = antiPowerArray[@ 8]

if powerArray[@ 0] > ds_list_size(powerTimer){
    var dur = powerMaxDur
    if antiPowerArray[@ 0] > 0{
        for (var i = ds_list_size(antiPowerTimer) - 1; i >= 0;i--){
            dur -= antiPowerTimer[| i];
            antiPowerTimer[| i] = 0;
            if dur < 0{antiPowerTimer[| i] = antiPowerTimer[| i] - dur}
            if dur <= 0{break}
        }
    }
    if dur > 0{
        ds_list_insert(powerTimer,0,dur)
        cd_jiggle[powerIndex,0] = jiggletime;
    }
    else{ //else jiggle contra powerup
        powerArray[@ 0] -= 1;
        cd_jiggle[antiPowerIndex,0] = jiggletime;
    }
    // Flag Scaling On (powerArray[@ 7] is already = 1, and we don't reset it incase it's already active)
    paddleScale = true;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){


    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }

    
    //Tapper stuff
    if mouse_check_button_pressed(mb_left) and i == 0{ 
       
       // Get Distance to Ease, to Cover Rail in Terms of Rail
       var distToEaseCoverage = clamp( (1.20 - railCoverage) * .10, .025, .10);
       // Ease Rail Coverage Towards 100% (1)
       powerArray[@ 7] += distToEaseCoverage / railCoverage; 
       with(paddle_id){
            padColorTimers[0] = max(padColorTimers[0],room_speed*.25)//.5
       }
       paddleScale = true;
       
       
       touchPadTap = true; 
    }
    
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
        
        //Reset paddlesize
        if powerArray[@ 0] == 0{
           //tapper_PaddleSize = 1;
           powerArray[@ 7] = 1;
           paddleScale = true;
        }
    }
    else powerTimer[| i] -= max(1,scr_power_get_quick_deplete_value())*powerDecrement;
        //We decrement faster if board is overloaded
    
    
    
}


//POWER_subshrink[@ 0] stuff

powerArray = POWER_subshrink;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
antiPowerArray = POWER_addgrow;
antiPowerTimer = antiPowerArray[@ 1];
antiPowerIndex = antiPowerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    var dur = powerMaxDur
    if antiPowerArray[@ 0] > 0{
        for (var i = ds_list_size(antiPowerTimer) - 1; i >= 0;i--){
            dur -= antiPowerTimer[| i];
            antiPowerTimer[| i] = 0;
            if dur < 0{antiPowerTimer[| i] = antiPowerTimer[| i] - dur}
            if dur <= 0{break}
        }
    }
    if dur > 0{
        ds_list_insert(powerTimer,0,dur)
        cd_jiggle[powerIndex,0] = jiggletime;
    }
    else{ //else jiggle contra powerup
        powerArray[@ 0] -= 1;
        cd_jiggle[antiPowerIndex,0] = jiggletime;
    }
    
   //Set Shrink
   powerArray[@ 7] = min(.05 * railCoverage, .10);
   with(paddle_id){
        // Color Paddle
        padColorTimers[2] = max(padColorTimers[2],room_speed*.5)//.5
   }
   paddleScale = true;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){

    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }

    //Tapper stuff
    if mouse_check_button_pressed(mb_left) and i == 0{
    
       //Decrement effect and timer, hybrid system
       powerTimer[| i] = powerTimer[| i] - powerMaxDur/15;
       
       //Undecrease Paddle Size
       //POWER_subshrink[@ 7] += (1 - POWER_subshrink[@ 7])*.1;
       var baseShrink = min(.05 * railCoverage, .10);
       var remainingTimeRatio = powerTimer[| i] / powerMaxDur;
       powerArray[@ 7] =  baseShrink * remainingTimeRatio +  1 * (1 - remainingTimeRatio);
       with(paddle_id){
            padColorTimers[0] = max(padColorTimers[0],room_speed*.25)//.5
       }
       paddleScale = true;
       
       touchPadTap = true; 
    }


    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
        
        //Reset paddlesize
        if powerArray[@ 0] == 0{
           //tapper_PaddleSize = 1;
           powerArray[@ 7] = 1;
           paddleScale = true;
        }
    }
    else powerTimer[| i] -= 1*powerDecrement   
    
}





//POWER_addslower[@ 0] stuff
powerArray = POWER_addslower;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
antiPowerArray = POWER_subfaster;
antiPowerTimer = antiPowerArray[@ 1];
antiPowerIndex = antiPowerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    var dur = powerMaxDur
    if antiPowerArray[@ 0] > 0{
        for (var i = ds_list_size(antiPowerTimer) - 1; i >= 0;i--){
            dur -= antiPowerTimer[| i];
            antiPowerTimer[| i] = 0;
            if dur < 0{antiPowerTimer[| i] = antiPowerTimer[| i] - dur}
            if dur <= 0{break}
        }
    }
    if dur > 0{
        ds_list_insert(powerTimer,0,dur)
        cd_jiggle[powerIndex,0] = jiggletime;
    }
    else{ //else jiggle contra powerup
        powerArray[@ 0] -= 1;
        cd_jiggle[antiPowerIndex,0] = jiggletime;
    }
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    
    //Tapper stuff
    if mouse_check_button_pressed(mb_left) and i == 0{ 
       
       //Decrease ShooterSpeed
       //tapper_ShooterSpeed += (.25 - tapper_ShooterSpeed)*.05;
       powerArray[@ 7] += (.25 - powerArray[@ 7])*.05;
       touchPadTap = true; 
       
    }
    
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
        
        //Reset paddlesize
        if powerArray[@ 0] == 0{
           //tapper_ShooterSpeed = 1;
           powerArray[@ 7] = 1;
        }
    }
    else powerTimer[| i] -= 1*powerDecrement
    
    
}



//POWER_subfaster[@ 0] stuff
powerArray = POWER_subfaster;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
antiPowerArray = POWER_addslower;
antiPowerTimer = antiPowerArray[@ 1];
antiPowerIndex = antiPowerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    var dur = powerMaxDur
    if antiPowerArray[@ 0] > 0{
        for (var i = ds_list_size(antiPowerTimer) - 1; i >= 0;i--){
            dur -= antiPowerTimer[| i];
            antiPowerTimer[| i] = 0;
            if dur < 0{antiPowerTimer[| i] = antiPowerTimer[| i] - dur}
            if dur <= 0{break}
        }
    }
    if dur > 0{
        ds_list_insert(powerTimer,0,dur)
        cd_jiggle[powerIndex,0] = jiggletime;
    }
    else{ //else jiggle contra powerup
        powerArray[@ 0] -= 1;
        cd_jiggle[antiPowerIndex,0] = jiggletime;
    }
    
    //Set Speed Fast
    //tapper_ShooterSpeed = 1.6;
    powerArray[@ 7] = 1.6;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    
    //Tapper stuff
    if mouse_check_button_pressed(mb_left) and i == 0{
       //Decrement effect and timer, hybrid system
       powerTimer[| i] = powerTimer[| i] - powerMaxDur/15;

       //Decrease ShooterSpeed
       powerArray[@ 7] += (1 - powerArray[@ 7])*.05;
       
       touchPadTap = true; 
    }
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
        
        //Reset paddlesize
        if powerArray[@ 0] == 0{
           //tapper_ShooterSpeed = 1;
           powerArray[@ 7] = 1;
        }
    }
    else powerTimer[| i] -= 1*powerDecrement;
}






//POWER_longerpowerups[@ 0] stuff
powerArray = POWER_longerpowerups;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
   
    
    //Tapper stuff
    if mouse_check_button_pressed(mb_left){
       powerTimer[| i] = powerTimer[| i] - powerMaxDur/20;
       
       //Set Increase Dur Flag
       modifyDur = .1;
       touchPadTap = true; 
    }
     
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
}





//POWER_shorterpowerdowns[@ 0] stuff
powerArray = POWER_shorterpowerdowns;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){

    //Tapper stuff
    if mouse_check_button_pressed(mb_left){
       powerTimer[| i] = powerTimer[| i] - powerMaxDur/20;
       
       //Set Decrease Dur Flag
       modifyDur = -.2;
       touchPadTap = true; 
    }
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
}







//POWER_invertcontrols[@ 0] stuff
powerArray = POWER_invertcontrols;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){

     //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    //Tapper stuff
    if mouse_check_button_pressed(mb_left){
       powerTimer[| i] = powerTimer[| i] - powerMaxDur/10;
       
       touchPadTap = true; 
    }
    
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
        
        //Reset Inverted Mouse Angle
        if powerArray[@ 0] == 0{
           powerArray[@ 7] = -1;
        }
        
    }
    else powerTimer[| i] -= 1*powerDecrement
}






//POWER_multibonus[@ 0] stuff
powerArray = POWER_multibonus;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
    //NB: We may want to use the multiplication sign as the symbol, we can enlarge it in inkscape.
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){

     //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
     //Tapper stuff
    if mouse_check_button_pressed(mb_left){
    
       //Increment Combo Bonus
       global.pComboTimer = global.pComboTimerMax
       global.pComboCount += 1;
       global.pComboColor = 1//power_type_colors(1,0)
       
       //Decrement Timer
       powerTimer[| i] -= powerMaxDur/10;
       touchPadTap = true; 
    }
     
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;

    }
    else powerTimer[| i] -= 1*powerDecrement
}




//POWER_multimalus[@ 0] stuff
powerArray = POWER_multimalus;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
    
    //Disable Combo Bonus
    global.pComboTimer = 0
    
    //NB: We may want to use the division sign as the symbol, we can enlarge it in inkscape.
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){

     //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
     //Tapper stuff
    if mouse_check_button_pressed(mb_left){
    
       powerTimer[| i] = powerTimer[| i] - powerMaxDur/10;
       touchPadTap = true; 
    }
    
    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
  
    }
    else powerTimer[| i] -= 1*powerDecrement
}



//POWER_splitpaddle[@ 0] stuff
powerArray = POWER_splitpaddle;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
    
    //ease to split
    if powerArray[@ 0] == 1{
        TweenFire(obj_control_game, property_splitsize, EaseLinear,
                TWEEN_MODE_ONCE, true, 0, 1, powerArray[7], 45/2); //ease to 90/4
    }
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    
     //Tapper stuff
    if mouse_check_button_pressed(mb_left){
       powerTimer[| i] = powerTimer[| i] - powerMaxDur/15;
       touchPadTap = true; 
    }

    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
        
        //ease from split
        if powerArray[0] == 0{
            TweenFire(obj_control_game, property_splitsize, EaseLinear, 
                TWEEN_MODE_ONCE, true, 0,1, powerArray[7], 0);
        }

    }
    else powerTimer[| i] -= 1*powerDecrement
    
}



//POWER_cashtap[@ 0] stuff
powerArray = POWER_cashtap;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;

}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    
     //Tapper stuff
    if mouse_check_button_pressed(mb_left){
       // Decrement Random Amount 
       //var decrementSize = irandom_range(5,20); 
       powerTimer[| i] = powerTimer[| i] - powerMaxDur * random_range(.05,.15);//decrementSize;
       touchPadTap = true; 
       
       // Add 1 cash per tap
       var cash_value = scr_starcash_power_caught(1);
       
       // Confetti Bomb
       var cash_text = "+"+CASH_STR+string(cash_value);
       //Maybe rng x/y would make more sense on touchpad?
       //var cash_x = mouse_x + RU * irandom_range(-1,1) * 10;
       //var cash_y = mouse_y + RU * irandom_range(-1,1) * 10;
       var cash_x = centerfieldx + RU * random_range(-1,1) * GAME_W * .35;
       var cash_y = centerfieldy + RU * random_range(-1,1) * GAME_W * .35;
            //NB: We rng a bit off the mouse so people see they're getting more than $1
       scr_create_confetti(cash_x, cash_y, 32, 32, 1);
       scr_popup_text_zoomup(cash_x,cash_y,cash_text,COLORS[3], fnt_game_bn_60_bold, false, 3*room_speed)
       scr_sound(sd_catch_cash, 1, false); //maybe redundant with click sound?
    }

    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;


    }
    else powerTimer[| i] -= 1*powerDecrement
    
}


//POWER_offsetpaddle[@ 0] stuff
powerArray = POWER_offsetpaddle;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
    
    // Get New Offset
    var newOffset = choose(90,180,-90);
    // Ease Misc Val to New Offset
    TweenFire(obj_control_game, property_offsetpaddle, EaseLinear, 
        TWEEN_MODE_ONCE, true, 0, 1, powerArray[7], newOffset);


}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    // Decrement Timer
    if powerTimer[| i] <= 0{
        // Delete Timer if Complete
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
        // Ease Back Offset to 0
        if powerArray[@ 0] <= 0{
            TweenFire(obj_control_game, property_offsetpaddle, EaseLinear, 
                TWEEN_MODE_ONCE, true, 0, 1,  powerArray[7], 0);
        }
    }
    else powerTimer[| i] -= 1*powerDecrement
    
}


//POWER_cashx2[@ 0] stuff
powerArray = POWER_cashx2;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;

}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    // Decrement Timer
    if powerTimer[| i] <= 0{
        // Delete Timer if Complete
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;
    }
    else powerTimer[| i] -= 1*powerDecrement
    
}
    
    


//POWER_density_doubler[@ 0] stuff
powerArray = POWER_density_doubler;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8];
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }

    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;

    }
    else powerTimer[| i] -= 1*powerDecrement
    
}









//POWER_multidensity[@ 0] stuff
powerArray = POWER_multidensity;
powerTimer = powerArray[@ 1];
powerMaxDur = powerArray[@ 2];
powerIndex = powerArray[@ 8]
if powerArray[@ 0] > ds_list_size(powerTimer){
    ds_list_insert(powerTimer,0,powerMaxDur)
    cd_jiggle[powerIndex,0] = jiggletime;
}
for (var i = ds_list_size(powerTimer) - 1; i >= 0;i--){
    
    //Modify Duration
    if abs(modifyDur) == powerArray[@ 3] {
       powerTimer[| i] += sign(modifyDur)*powerMaxDur/10;
    }
    
    
     //Tapper stuff
    if mouse_check_button_pressed(mb_left){
        // Decrement Random Amount 
        //var decrementSize = irandom_range(5,20); 
        powerTimer[| i] = powerTimer[| i] - powerMaxDur * random_range(.05,.15);//decrementSize;
        touchPadTap = true; 
        
        // Spawn Extra Deflectors
        with (obj_control_game) {
            // Get Field Stats
            var _FillMax = BOARD_TOTAL; 
            var _FillCurrent = instance_number(obj_reflector_parent);
            
            // Calculate Remaining Possible Spawns
            var _RemainingPossibleSpawns = max(0,(BOARD_TOTAL - (_FillCurrent + SPAWN_COUNTER))); 
            
            // Calculate How Many to Spawn
            var _SpawnCount =  max(_RemainingPossibleSpawns * .05, 
                                        min(_RemainingPossibleSpawns, GRID+3));
            
            // Add Deflectors to Spawn Queue
            scr_field_respawn_queue_add(_SpawnCount, true); 
        }
    }

    if powerTimer[| i] <= 0{
        ds_list_delete(powerTimer,i)
        powerArray[@ 0] -= 1;


    }
    else powerTimer[| i] -= 1*powerDecrement
    
}


#define scr_powers_controller_draw
///scr_powers_controller_draw()


/// Draw Duration Timers, Tapper Text
if MOVE_ACTIVE and 
   mainEase[0] == 0 and 
   !TweenExists(mainTween) 
{
    mainTween = TweenFire(id, mainEase, EaseLinear, TWEEN_MODE_ONCE, true, .25, .5, mainEase[0], 1);
}
else if !MOVE_ACTIVE and 
   mainEase[0] > 0 and 
   !TweenExists(mainTween) 
{
    mainEase[@ 0] = 0;
    //mainTween = TweenFire(id, mainEase, EaseLinear, TWEEN_MODE_ONCE, true, 0, .5, mainEase[0], 0);
}



if !GAMEOVER and mainEase[0] != 0//MOVE_ACTIVE 
{
    
    icon_width = 75;
    icon_height = 60;
    icon_row_h = 100;
    powers_count = scr_sum_powers();
    mods_count = scr_gamemod_count(true);
    timers_count =  powers_count + mods_count;
    timers_row_size = min(7, timers_count);
    timers_alpha = mainEase[0];
    
    
    
    if timers_count > 0
    {
        /*
            //NB: If we wanted the additional rows to reset we could do that like this.
            //We'd need to move the adj x down below
        icon_row = index div timers_row_size;
        if timers_count > (icon_row+1) * 7 {
            timers_row_size = 7;
        } else {
            timers_row_size = timers_count mod 7;
        }
        */
        var timers_start_x, timers_start_y, timers_start_adj_x, timers_start_adj_y, timer_fill, index;
        timers_start_x = GAME_MID_X;
        timers_start_y = mixers_y[mixPos[0]] -icon_height/2;
        timers_start_adj_x = timers_start_x-timers_row_size*icon_width/2;
        timers_start_adj_y = timers_start_y;
        timer_fill = 0
        index = 0 //iterator for _timer width
    
        draw_set_font(fnt_game_bn_15_black)
        draw_set_valign(fa_middle)
        draw_set_halign(fa_center)
        
        /// Draw Powers
        for (var i = 0; i < powers_len; i++)
        {
    
            CurrentPower = POWER_ARRAY[i];
            CurrentPowerTimer = CurrentPower[1];
            if ds_list_size(CurrentPowerTimer) > 0
            {  
                //Get MetaData
                CurrentPowerCount = CurrentPower[0];
                CurrentPowerTimerMaxDur = CurrentPower[2];
                CurrentPowerType = CurrentPower[3];
                CurrentPowerSprite = CurrentPower[4];
                CurrentPowerText = CurrentPower[5];
                CurrentPowerTapText = CurrentPower[6];
                
                //Set Val
                timer_fill = clamp(CurrentPowerTimer[| 0]/CurrentPowerTimerMaxDur,0,1);
                //Set Coordinates
                iconx1 = timers_start_adj_x + (index mod timers_row_size) * icon_width + cd_jiggle[i,1];
                icony1 = timers_start_adj_y + (index div timers_row_size) * icon_row_h + cd_jiggle[i,2];
                iconx2 = iconx1 + icon_width;
                icony2 = icony1 + icon_height;
                
                //Set Colors
                icon_col = power_type_colors(CurrentPowerType,0);
                sym_color = power_type_colors(CurrentPowerType,1);
                
                //Draw Power Icon
                draw_rectangle_cd_barfill_icon_sprite(iconx1, icony1, iconx2, icony2, timer_fill,
                CurrentPowerCount,CurrentPowerSprite, icon_col, sym_color, timers_alpha, s_v_icon_background);
                
                //Draw Description Text
                if cd_jiggle[i,3] > 0{ // timer var
                    draw_set_font(fnt_game_bn_12_bold)
                    draw_text_colour((iconx1+iconx2)/2,icony2+16,CurrentPowerText,
                    COLORS[0],COLORS[0],COLORS[0],COLORS[0],timers_alpha)
                }   
                    
                
                //Set Tapper Dialoue Text
                if CurrentPowerTapText != "" and tap_text_index < powers_len-i{
                   tap_text_index = powers_len-i;
                   tap_col = icon_col;
                   tap_timerval = timer_fill;
                   tap_text = CurrentPowerTapText;
                }
            
                // Increment Index
                index++
            }
        }
        
        /// Draw Gamemods
        var types = Array(0,1,2)
        var sub_types = Array(0);
        var types_len, sub_types_len, index_len;
        var mod_data, mod_key;
        
        types_len = array_length_1d(types);
        sub_types_len = array_length_1d(sub_types);
        // For Each Type
        for (var i = 0; i < types_len; i++){
            // For Each SubType
            for (var j = 0; j < sub_types_len; j++ ){
                index_len = GAMEMOD_DATA_SIZES[# types[i], sub_types[j]];
                // For Each Index
                for (var k = 0; k < index_len; k++ ){
                    CurrentMod = scr_gamemod_get_data(types[i], sub_types[j], k);
                    CurrentModCount = CurrentMod[8];
                    // Active Count
                    if CurrentModCount > 0 {
                    
                        //Get MetaData
                        CurrentModTimer = CurrentMod[9];
                        CurrentModTimerMaxDur = CurrentMod[3];
                        CurrentModType = CurrentMod[1]; // shift right by 1
                        CurrentModSprite = CurrentMod[5];
                        CurrentModText = CurrentMod[6];
                        
                        //Set Val
                        timer_fill = clamp(CurrentModTimer/CurrentModTimerMaxDur,0,1);
                        //Set Coordinates
                        iconx1 = timers_start_adj_x + (index mod timers_row_size) * icon_width //+ cd_jiggle[i,1];
                        icony1 = timers_start_adj_y + (index div timers_row_size) * icon_row_h //+ cd_jiggle[i,2];
                        iconx2 = iconx1 + icon_width;
                        icony2 = icony1 + icon_height;
                        
                        //Set Colors
                        //icon_col = power_type_colors(-1,CurrentModType+9);  //power_type_colors(CurrentModType,0);
                        //sym_color = power_type_colors(-1, 6)//power_type_colors(CurrentModType,1);
                        
                        icon_col = power_type_colors(CurrentModType+1, 0);  //power_type_colors(CurrentModType,0);
                        sym_color = power_type_colors(CurrentModType+1, 1)//power_type_colors(CurrentModType,1);
                        
                        //Draw Power Icon (Octagon)
                        draw_rectangle_cd_barfill_icon_sprite(iconx1, icony1, iconx2, icony2, timer_fill,
                        CurrentModCount,CurrentModSprite, icon_col, sym_color, timers_alpha, s_v_deflector_rounder_60)// s_v_game_mod_60)
                
                        //Draw Description Text
                        draw_set_font(fnt_game_bn_12_bold)
                        draw_text_colour((iconx1+iconx2)/2,icony2+16,CurrentModText,
                        COLORS[0],COLORS[0],COLORS[0],COLORS[0],timers_alpha)
                     
                        // Increment Index
                        index++
                    
                    }
                } 
            }
        }
        
    }
    
    
    //Tap Text Dialogue
    if tap_text_index >= 0{
        if touchPadTap {
            // Ease Text Scale A Bit
            if TweenExists(touchPadTapTween){
                TweenDestroy(touchPadTapTween);
            }
            // Reset Ease
            touchPadTapEase[0] = 1;
            touchPadTapTween = TweenFire(id, touchPadTapEase,EaseLinear,
                                 TWEEN_MODE_BOUNCE, true, 0,.1, touchPadTapEase[0], 1.2);
                                    //touchPadTapEase[0]
                                        //We may want to do two chained tweens here.. not sure.
                                            //We'd schedule it in that case.
            //TweenPlayBounce(touchPadTapTween)
            //TweenDestroyWhenDone(touchPadTapTween,true, false)
            // Play Tap Sound
            scr_sound(sd_menu_click);
            touchPadTap = false;
        }
           
        txt_font = fnt_game_bn_40_bold;//fnt_game_bn_30_black; 
        draw_set_font(txt_font)
        txt_height = (string_height("H")*.6 + string_height(tap_text) * .5) * touchPadTapEase[0];
        scr_draw_text_tap_dialogue(centerfieldx,centerfieldy+txt_height,
        tap_text,touchPadTapEase[0],tap_col, 1, txt_font, true); //max(.5,tap_timerval)
        
        
        // Clear Tapped Index
        tap_text_index = -1;
        
    } 
    /*
    // Clear Touch Tap Flag
    else if touchPadTap {
        touchPadTap = false;
    
    }*/
    
    
    
    
    //Decrement icon jigglers
    var jiggle_strength = 4;
    for (var i=0, n = array_height_2d(cd_jiggle); i < n; i++){ 
        //Decrement Jiggler
        if cd_jiggle[i,0] > 0{
            cd_jiggle[i,0] -= 1
            cd_jiggle[i,1] = random_range(-1,1)*jiggle_strength;
            cd_jiggle[i,2] = random_range(-1,1)*jiggle_strength;
            //Set description text duration
            if cd_jiggle[i,0] >= jiggletime-1 {cd_jiggle[i,3] = defaultPowerDuration}//jiggletime*8}
        }
        //Disable Jiggles
        else if cd_jiggle[i,0] >= -1{
            cd_jiggle[i,0] = -2
            cd_jiggle[i,1] = 0;
            cd_jiggle[i,2] = 0;
        
        }
        //Decrement display text
        if cd_jiggle[i,3] > 0{
            cd_jiggle[i,3] -= 1
        }
    }
}