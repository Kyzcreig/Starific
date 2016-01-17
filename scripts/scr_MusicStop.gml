#define scr_MusicStop
///scr_MusicStop()
// Set Volume to 0
MusicSoundGain(0);
// Stop Song
audio_stop_sound(CURRENT_SONG);
// Clear Timer
//CURRENT_SONG_TIME = -1;
// Clear Song
CURRENT_SONG = noone;
//musicPlaying = 0;

#define scr_MusicPause
///scr_MusicPause(soundid)

audio_pause_sound(argument0)
//musicPlaying = 2;

#define scr_MusicResume
///scr_MusicResume()

// If Music is Playing
if MUSIC_STATE == 1{
    //Resume Music
    if audio_exists(CURRENT_SONG){
        audio_resume_sound(CURRENT_SONG);
    }
    MUSIC_ACTIVE = true;
}