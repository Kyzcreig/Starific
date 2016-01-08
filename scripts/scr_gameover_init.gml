#define scr_gameover_init
///scr_gameover_init()





//Create Gameover Object
objGameOver = instance_create(x,y, obj_control_gameover)

levelUp = false;
MOVE_ACTIVE = false
GAME_ACTIVE = false

// Gameover Screenshot for sharing
if !everyplay_is_recording() {
    scr_share_screen_gameover_make()
}

//Board Clear
scr_board_reset();
//ScheduleScript(id, 0, 2, scr_board_reset);
// Schedule Clear Powers So Any Last Step Catches have time to register
ScheduleScript(id, 0, 3, scr_clear_powers);


//Effects
with (obj_launcher) {scr_paddle_tween_out()}
scr_touch_pad_tween_out()

//Gameover sound test
scr_sound(sd_gameover,1,false);


//Outro Effects
ScheduleScript(objGameOver, true, .5, scr_gameover_effects)




#define scr_gameover_effects
///scr_gameover_effects()



// Set Minimum Outro Duration
alarm[0] = .5*room_speed;

with (obj_reflector_parent){
    //NB: Outro Spawn will update alarm as needed.
    outrospawn(INTRO_ANGLE, INTRO_RAD, INTRO_DIST,INTRO_DUR,INTRO_EASE);
}




//probably do a tweener on objgui here and on complete, toggle the gameover
//Outro GUI drawing
with (obj_control_rail){
   mainTween = TweenFire(id,mainEase,obj_control_game.guiEaseReverse,
                    TWEEN_MODE_ONCE,1,0,1, mainEase[0],0);
}
//Outro Scoreboard
with (obj_control_game){
    TweenScore = TweenFire(id,scoreTween,guiEaseReverse,
                    TWEEN_MODE_ONCE, 1,0,1, 1,0);
}
with (obj_control_modifiers){
    MixersTween = TweenFire(id,MixersEase,EaseLinear,
                        TWEEN_MODE_ONCE,1,0,1, MixersEase[0],0);
}


