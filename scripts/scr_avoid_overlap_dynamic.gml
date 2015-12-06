#define scr_avoid_overlap_dynamic
//scr_avoid_overlap_dynamic(other_instance)

var __collided = argument0;

// If Moving Text, try to make them not overlap
if top_speed != 0 {
    // If same direction
    if __collided != noone 
        and direction == __collided.direction 
    {
        //If collided object is younger
        //or other object is not moving
        if birthStep < __collided.birthStep or
           __collided.current_speed == 0
        {
           //add speed to this object
           current_speed += .1
        }
        //else if collided object is older
        //or other object is moving faster
        else if birthStep > __collided.birthStep or
           __collided.current_speed > current_speed
        {
           //subract speed to this object
           current_speed -= .1
        }
       //Else if instances same age
        else if birthStep == __collided.birthStep {
           //Randomize step
           birthStep += irandom_range(-50,50) 
            //NB: birthStep must remain integer for modulus portability
        }
         
    }
    //Else if Different directions or no collision
    else if current_speed != top_speed {
         // Ease back up to top speed
         current_speed += (top_speed - current_speed) * .1;
    }

}




#define scr_avoid_overlap_static
//scr_avoid_overlap_static(other_instance)

var __collided = argument0;

if deleteOld {
    if __collided != noone {
        //If this instance is was born earlier than collided, destroy self
        if birthStep < __collided.birthStep and __collided.deleteOld {
            instance_destroy()
        }
        //Else if this instance was born after collided instance, destroy collided
        else if birthStep > __collided.birthStep and __collided.deleteAble{
            with(__collided){ 
                instance_destroy();
                //show_debug_message('instance exists'+string(instance_exists(id)));
            }
        }
        //Else if instances same age
        else if birthStep == __collided.birthStep {
            //Randomize step
            birthStep += irandom_range(-50,50);
        }
    }
}