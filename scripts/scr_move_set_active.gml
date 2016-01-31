///scr_move_set_active()

if !MOVE_ACTIVE{
    // Play Turn Begin Sound
    scr_sound(sd_turn_begin,1,false);
}

MOVE_ACTIVE = true;
MUSIC_ACTIVE = true;
