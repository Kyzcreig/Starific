///scr_collision_sound()
//This script is called when an object is destroyed by the ball.
//It checks the object_index and plays a sound accordingly.


switch objType {

case 0:
    scr_sound(sd_collide_basic)
break;
case 1:
    scr_sound_iff_only(sd_collide_trigger_powerup)
break;
case 2:
    scr_sound_iff_only(sd_collide_trigger_powerup)
break;
case 3:
    scr_sound_iff_only(sd_collide_trigger_powerup)
break;
case 4:
    scr_sound_iff_only(sd_collide_bomb)
break;

}
