///scr_ModifiersLaunchStars(markerType, failsafe)

//Tap to launch star
if MOVE_ACTIVE == false and MOVE_READY and SWIPE_TAP == true and bMSelected[0] == noone 
and abs(mouse_y - mixers_y[mixPos[0]]) > 60 and instance_exists(argument0) and argument1
//we ignore taps near the board mixers
{
    //Check if hovering on a star marker, if so ignore tap
    sMSelected = false;
    
    with (argument0){
         if Creator_ID == other.id and ( hoverScale > 1 or selected[0] ){
            other.sMSelected = true; 
            break;
         }
    }
    if !sMSelected{
        //Iterate through each star marker
        with(argument0){
            if Creator_ID == other.id {
                star_launch = true;
            }
        }
        
        // Set Move to Active State
        scr_move_set_active();
  
        //Tween in Paddle
        if MODE == MODES.SANDBOX{
           paddle_id = instance_create(0,0,obj_launcher)
           scr_touch_pad_tween_in(); 
        }
        
        
        SWIPE_TAP = false;
        scr_sound(sd_turn_begin,1,false)
    }

}
