///scr_clock_tick_tock()



if HALF_SECOND_INTERVAL{
    if FULL_SECOND_INTERVAL {
     scr_sound(sd_clock_tick);
    } else {     
     scr_sound(sd_clock_tock);
    }
}
