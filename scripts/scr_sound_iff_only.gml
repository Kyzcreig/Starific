///scr_sound_iff_only(sound, priority, looping)

var sound, priority, looping;
sound = argument[0]
if (argument_count > 1){priority = argument[1]}
else {priority = random(99)}
if (argument_count > 2) {looping = argument[2];}
else {looping = false}

// Wrapper Call 
if !audio_is_playing(sound) {
    scr_sound(sound, priority, looping);
}
