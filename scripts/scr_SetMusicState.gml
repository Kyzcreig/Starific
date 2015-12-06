#define scr_SetMusicState
///scr_SetMusicState(value)
MUSIC_STATE = argument0//!musicPlaying
//vtracktime = -1

#define scr_StopMusic
///scr_StopMusic(duration)
var fadeDuration = argument0; //steps
// If Not Game Room, make effect instant
if room != rm_game {
    fadeDuration = 1; 
}


if audio_exists(CURRENT_SONG)
{
         
     
     // Destroy Previous Easers
     if TweenExists(musicEaser) {
        TweenDestroy(musicEaser);
     }
     
     // Ease Music
     musicEaser = TweenFire(id, MusicSoundGain, EaseLinear, TWEEN_MODE_ONCE, false, 
                    0, fadeDuration, CURRENT_SONG_GAIN, 0);
                         
    // Cancel Scheduled Stop                
    if ScheduleExists(musicStopper) {
        ScheduleCancel(musicStopper);
    }
                
     // Schedule Music Stop
     musicStopper = ScheduleScript(id,false,fadeDuration,scr_MusicStop);
     
     // Clear Song Time
     CURRENT_SONG_TIME = -1;
}


// Set Music State to None
//MUSIC_STATE = 1;
ScheduleScript(id,false,fadeDuration,scr_SetMusicState,0);

#define scr_FadeMusic
//scr_FadeMusic(duration);
var fadeDuration = argument0; //Steps

// If Not Game Room, make effect instant
if room != rm_game {
    fadeDuration = 1; 
}
     
if audio_exists(CURRENT_SONG) and audio_is_playing(CURRENT_SONG) and !ScheduleExists(musicStopper){
     

     // Destroy Previous Easers
     if TweenExists(musicEaser) {
        TweenDestroy(musicEaser);
     }
     
     // Ease Music
     musicEaser = TweenFire(id, MusicSoundGain, EaseLinear, TWEEN_MODE_ONCE, false, 
                    0, fadeDuration, CURRENT_SONG_GAIN, 0);
                    
                    
     // Schedule Music Pauser
     musicStopper = ScheduleScript(id,false,fadeDuration,scr_MusicPause,CURRENT_SONG);
}

// Set Music State to Fade Paused
MUSIC_STATE = 2;
MUSIC_ACTIVE = false;
//ScheduleScript(id,false,fadeDuration,scr_SetMusicState,2);

#define scr_ResumeMusic
///scr_ResumeMusic(duration)

var fadeDuration = argument0;

if room != rm_game {
    fadeDuration= 1; 
}

// If Musice Paused
if (MUSIC_STATE == 2) and audio_exists(CURRENT_SONG)
{
     // Resume Music
     audio_resume_sound(CURRENT_SONG);
                         
    // Cancel Scheduled Stop                
    if ScheduleExists(musicStopper) {
        ScheduleCancel(musicStopper);
    }
     
     // Destroy Previous Easers
     if TweenExists(musicEaser) {
        TweenDestroy(musicEaser);
     }
     
     // Ease Music
     musicEaser = TweenFire(id, MusicSoundGain, EaseLinear, TWEEN_MODE_ONCE, false, 
                    0, fadeDuration, CURRENT_SONG_GAIN, 1); 

 
}

// Set State to Playing
MUSIC_STATE = 1;

#define MusicSoundGain
///MusicSoundGain(val)

CURRENT_SONG_GAIN = argument0;


// If Muted
if !music_sound[1]{
   // Mute
   audio_sound_gain(CURRENT_SONG,0,0);
}
else {
    // Calculate Volume
    var songVolume = music_sound[0] * CURRENT_SONG_GAIN;
   // Fade Up
   audio_sound_gain(CURRENT_SONG,songVolume,0); //uses milliseconds
}