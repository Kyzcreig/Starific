#define scr_paddle_collision_step
///scr_paddle_collision_step()


//scr_rebounds_and_catching_list();
//scr_rebounds_and_catching_array();

/* NB: Step skipping does help but I fear it will cause problems 
    when the objects are moving very fast, so I'd rather not risk it.
*/
    
// Skip Every Other Step on 30FPS
//currentStep = STEP-birthStep;
//altStep = currentStep & 1;
if RMSPD_DEFAULT == 60 and ALTERNATE_STEP_INTERVAL {
    exit;
}
scr_rebounds_and_catching_list();

#define scr_rebounds_and_catching_list
///scr_rebounds_and_catching_list()


if GAME_ACTIVE {
    //Check for stars in collision
    scr_paddle_detect_collision_list(obj_star)
    for ( var i = 0, n = ds_list_size(caughtList); i < n ;i++){
        // Get Data
        vals = noone; vals = caughtList[| i];
        
        // If Caught Object In Play
        switch vals[0].inFieldState {
            case 1:
            case 2:
                // Reset Play State, because still touching paddle
                with (vals[0]) {
                    inFieldState = 0;
                }    
                break;
            case 3:
                // Process Caught Object
                with (vals[0]){
                   scr_collision_paddle(other.vals[1]) 
                }
                // Flag Near Miss On Last Star Text
                scr_set_near_miss(vals[2])
                break;
        }
    }
    // Clear List
    ds_list_clear(caughtList);
    
    //Check for powerups in collision
    scr_paddle_detect_collision_list(obj_powerup_falling)
    for ( var i = 0, n = ds_list_size(caughtList); i < n ;i++){
        // Get Data
        vals = noone; vals = caughtList[| i];
        
        // Process Caught Object
        with (vals[0]){
             caught = true;
             catcher = other.id;
             caughtAngle = other.vals[1];//Angle paddle is facing center
             instance_destroy() 
        }
    }
    // Clear List
    ds_list_clear(caughtList);
}

#define scr_rebounds_and_catching_array
///scr_rebounds_and_catching_array()


if GAME_ACTIVE {
    //Check for stars in collision
    caughtShooters = scr_paddle_detect_collision_array(obj_star)
    for ( var i = 0, n = array_length_1d(caughtShooters); i < n ;i++){
        // Get Data
        vals = noone; vals = caughtShooters[i];
        // If Not Array Break
        if !is_array(vals) {
            break;
        }
        
        // Process Caught Object
        with (vals[0]){
           scr_collision_paddle(other.vals[1]) 
        }
        //Near Miss On Last Star?
        scr_set_near_miss(vals[2])
    }
    
    //Check for powerups in collision
    caughtPowers = scr_paddle_detect_collision_array(obj_powerup_falling)
    for ( var i = 0, n = array_length_1d(caughtPowers); i < n ;i++){
        // Get Data
        vals = noone; vals = caughtPowers[i];
        // If Not Array Break
        if !is_array(vals) {
            break;
        }
        
        // Process Caught Object
        with (vals[0]){
             caught = true;
             catcher = other.id;
             caughtAngle = other.vals[1];//Angle paddle is facing center
             instance_destroy() 
        }
    }
}

#define scr_set_near_miss
///scr_set_near_miss(line_id)

var line_id = argument0;

// If Star saved by Paddle's Backline
if global.ActiveStarCount <= 1 and line_id == 1 {
   with (obj_control_game) {
        near_miss = 1;
   }
}
#define scr_inField_set
///scr_inField_set(gridX,gridY)

if gamecell_is_valid(argument0, argument1){
    inFieldState = inFieldActive;
}
else {
    inFieldState = 0;
}