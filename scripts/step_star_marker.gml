///step_star_marker()

mixers_alpha = MixersEase; 

///Detect if selected

if !TweenExists(TweenMarker) and mixers_alpha[0] == 1{

    //SETTING DIRECTION STAR MARKER
    if selected[0]{
        //Grab marker direction with SWIPE
        if mouse_check_button_released(mb_left) and SWIPE_BRK {//SWIPE_TAP{
        
            // Get Swipe Direction
            var swipe_dir = darctan2(SMY - SMYS, SMX - SMXS);
            //swipe_dir = ((swipe_dir+45)+360*5) mod 360;
            marker_dir = real_roundto(swipe_dir, 45);
            // Normalize Direction
            while (marker_dir < 0) {
                marker_dir += 360;
            } 
            while (marker_dir >= 360) {
                marker_dir -= 360;
            } 
            

            //Deselect
            selected[0] = false;
            
            
            //If Additional Stars in Inventory, Reselect Star Egg Placer
            if false{ //Disabled for now, because you never have that many stars to place
                with (Creator_ID){  
                    if boardMixers[bMStarIndex,0] > 0{
                        bMSelected[0] = bMStarIndex;
                    }
                }
            }
        }
    }
    
    //RESELECTING STAR MARKER
    if true{//!selected[0]{
    
         hoverScale = 1;
         hoverSelected = true;
         //If any other star is hovered, pass
         with (object_index){
             if hoverScale > 1{
                other.hoverSelected = false; 
                break;
             }
         }
         
         //If no mixer selected and mouse nearby
         if hoverSelected and bMSelected[0] == noone and star_rad > point_distance(x,y,mouse_x,mouse_y){
            //Scale up
            hoverScale = 1.25;
            
            //If Tapped Pickup Star
            if SWIPE_TAP//mouse_check_button_pressed(mb_left) 
                and !TweenExists(TweenMarker)
            {
            
                pickup_star_marker(true);
            
            }
         
         }
    
    
    } 
    

}

//SETTING -> ARROW COORDINATES
if marker_dir != noone and !selected[0]{

    if !TweenExists(TweenMarker){
        //Find Nearest deflector in direction
        arrowEndXY = scr_nearest_deflector_in_direction(gridX,gridY,marker_dir);
        
        //If no collision is found reset
        if !arrowEndXY[2]{
           selected[0] = true;
           marker_dir = noone 
        }
        //ease towards end coordinates
        else{
            var aX = arrowEndXY[0]-x;
            var aY = arrowEndXY[1]-y;
            arrowEndX += (aX-arrowEndX)*.25;
            arrowEndY += (aY-arrowEndY)*.25;
        }
    }
    //Else if star marker is picked up again, ease back the arrow
    else{
            arrowEndX += (0-arrowEndX)*.25;
            arrowEndY += (0-arrowEndY)*.25;
    }

}

//LAUNCH STAR
if star_launch {// or MOVE_ACTIVE{ //NB: Maybe have a condition so the MOVE_ACTIVE= true doesn't launch this during tutorial sequence for obj_star_marker regular

    var obj = instance_create(x,y,obj_star)
    with (obj)
    {
         speed = 0 //Speed is set in STEP event of shooter
         direction = -(other.marker_dir)*90
         //inPlay = 0 //Disables collision
    }
    ParticleDeath = true;
    instance_destroy();

}


marker_col =  COLORS[0];

/*
if TUTORIAL_ENABLED{
    mixers_alpha = obj_control_tutorial.tutorialTextTween[0]; 
}
else{
    mixers_alpha = obj_control_game.mixersTween[0];
}
