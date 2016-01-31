#define scr_SetMusicState
///scr_SetMusicState(value)
MUSIC_STATE = argument0//!musicPlaying
//vtracktime = -1

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
    if ScheduleExists(MUSIC_SCHEDULE) {
        ScheduleCancel(MUSIC_SCHEDULE);
    }
     
     // Destroy Previous Easers
     if TweenExists(MUSIC_TWEEN) {
        TweenDestroy(MUSIC_TWEEN);
     }
     
     // Ease Music
     MUSIC_TWEEN = TweenFire(id, MusicSoundGain, EaseLinear, TWEEN_MODE_ONCE, false, 
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
     if TweenExists(MUSIC_TWEEN) {
        TweenDestroy(MUSIC_TWEEN);
     }
     // Cancel Scheduled Stop                
     if ScheduleExists(MUSIC_SCHEDULE) {
        ScheduleCancel(MUSIC_SCHEDULE);
     }
     
     // Ease Music
     MUSIC_TWEEN = TweenFire(id, MusicSoundGain, EaseLinear, TWEEN_MODE_ONCE, false, 
                    0, fadeDuration, CURRENT_SONG_GAIN, 0);
                
     // Schedule Music Stop
     TweenAddCallback(MUSIC_TWEEN, TWEEN_EV_FINISH, obj_control_main, scr_MusicStop);
     //NB: We use TweenCallback here because ScheduleScript breaks across rooms for persistent objects
     
     // Clear Song Time
     CURRENT_SONG_TIME = -1;
}


// Set Music State to None
//MUSIC_STATE = 1;
ScheduleScript(obj_control_main, false, fadeDuration, scr_SetMusicState, 0);
     //NB: We use TweenCallback here because ScheduleScript breaks across rooms for persistent objects

#define scr_FadeMusic
//scr_FadeMusic(duration);
var fadeDuration = argument0; //Steps

// If Not Game Room, make effect instant
if room != rm_game {
    fadeDuration = 1; 
}
     
if audio_exists(CURRENT_SONG) and 
   audio_is_playing(CURRENT_SONG) and 
   !ScheduleExists(MUSIC_SCHEDULE)
{
     

     // Destroy Previous Easers
     if TweenExists(MUSIC_TWEEN) {
        TweenDestroy(MUSIC_TWEEN);
     }
     
     // Ease Music
     MUSIC_TWEEN = TweenFire(id, MusicSoundGain, EaseLinear, TWEEN_MODE_ONCE, false, 
                    0, fadeDuration, CURRENT_SONG_GAIN, 0);
                                  
                    
     // Schedule Music Pauser
     MUSIC_SCHEDULE = ScheduleScript(id,false,fadeDuration,scr_MusicPause,CURRENT_SONG);
}

// Set Music State to Fade Paused
MUSIC_STATE = 2;
MUSIC_ACTIVE = false;
//ScheduleScript(id,false,fadeDuration,scr_SetMusicState,2);