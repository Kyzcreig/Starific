#define scr_restart_game_init
///scr_restart_game_init()


//draw_set_alpha(1)
RESTART_GAME = 1;



#define scr_reset_game_room_state
///scr_reset_game_room_state()



//Clear Inputs
keyboard_clear(ord('P'));
keyboard_clear(vk_backspace);
mouse_clear(mb_left);

//Save Game Stats
GAME_ACTIVE = false
//Don't save if game didn't start
if lastPlaytime > 0 {scr_stats_save()}


//Clear Sound Effects
for (i = 0; i<ds_list_size(sfx_list);i++){
    audio_stop_sound(sfx_list[| i])
} 
//Clear Music
scr_StopMusic(1);

//Clear Special Effects (Particles, Shake, Tween)
part_system_clear(PSYS_SUBSTAR_LAYER)
part_system_clear(PSYS_FIELD_LAYER)
part_system_clear(PSYS_STAR_LAYER)
//part_particles_clear(ind);
SHAKE_TIME = -1
TweenSystemClearAllRooms()

//Depersist Game Room
room_persistent = false
// Set Last Room
LAST_ROOM = rm_menu 
       
        

//Disable tutorial
TUTORIAL_ENABLED = false;