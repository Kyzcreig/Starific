///scr_set_touch_pad_touch()

if mouse_check_button_pressed(mb_left){

    /*
     NB: I found things were more intuitive for other people without this...
     if TOUCH_ENABLED and false{  
        //Distance from center to mouse
        DCtoMouseDist = point_distance(mouse_x,mouse_y,dynamicCenterX,dynamicCenterY)
        //Radius from center, clamped to give a range of values
        centerRad = clamp(DCtoMouseDist, TR_min, TR_max);
        //centerRad = TR_min * TouchRad//
        
        dynamicCenterX = mouse_x - dcos((mouseangle))*centerRad
        dynamicCenterY = mouse_y - dsin((mouseangle))*centerRad
             //We would set dynamic X/Y if we wanted the paddle to not move when you tap anywhere, but i don't think this is necessary
             //Maybe I'd use a radius that's less jarring e.g. .5 TouchRad, but nah i think this is ok.
     } 
     */
    // If Linear Style Controls
    if TP_SENSE[1] == 2 {
        // Set Start Angle
        if mouse_check_button_pressed(mb_left) {
            TOUCH_LINE_START_ANGLE = mouseangle;
        }
    }
     
    //Updates coords even if we may not be moving touchcontrols
    oldMX = mouse_x;
    oldMY = mouse_y;
}
