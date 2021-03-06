///scr_sound(sound, priority, looping)


// Set Parameters
var sound, priority, loping;
sound = argument[0]
if (argument_count > 1){priority = argument[1]}
else {priority = random(99)}
if (argument_count > 2) {looping = argument[2];}
else {looping = false}


// If SFX Priority
if priority < 100{
    var list, maxSize, listSize;
    list = MANAGED_SOUNDS[? sound];
    listSize = ds_list_size(list);
    maxSize = MANAGED_SOUND_CAPS[? sound];
    
    // If More than Max Sounds in List
    if (listSize >= maxSize) {
        //NB: We go from top to bottom because we're deleting
        for (var i = listSize -1; i>=0; i--) {
            var oldSound = list[| i];
            // Delete Any Finished Playing Sounds
            if !audio_is_playing(oldSound) or !audio_exists(oldSound)
            {
                ds_list_delete(list, i);
                listSize--;
            }
        }
    }
    
    // While Still More Than Max Sounds
    //listSize = ds_list_size(list);
    while (listSize >= maxSize){
        // Delete The Oldest Sounds
        audio_stop_sound(list[| 0])
        ds_list_delete(list, 0);
        //listSize = ds_list_size(list);
        listSize--;
    }
    // Add and Play New Sound
    var newSound = audio_play_sound(sound,priority,looping);
    ds_list_add(list, newSound);
    //ds_list_add(list, audio_play_sound(sound,priority,looping));
    audio_sound_gain(newSound,sfx_sound[0]*sfx_sound[1],0);
    
    // Return Sound Instance ID
    return newSound;
}
// Else if Music Priority
else{

   // Play New Song
   var newSong = audio_play_sound(sound, priority, looping);//music_emit
   //audio_sound_gain(newSong,music_sound[0]*music_sound[1],3*room_speed);
   
    // Mute if Music Disabled
   if !music_sound[1]{
        audio_sound_gain(newSong,0,0);
   }
    // Else Gain to Volume
   else{
        audio_sound_gain(newSong,music_sound[0],3*room_speed);
   }
   
    // Return Sound Instance ID
   return newSong 
     
}
