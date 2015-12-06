#define scr_gameover_init
///scr_gameover_init()





//Create Gameover Object
objGameOver = instance_create(x,y, obj_control_gameover)

levelUp = false;
MOVE_ACTIVE = false
GAME_ACTIVE = false

// Gameover Screenshot for sharing
scr_share_screen_gameover_make()

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



#define scr_go_set_gameover_rating_set_index
///scr_go_set_gameover_rating_set_index() //base_score

var gameover_text_len, scoreRatio, scoreRatioRemainder, interval;

gameover_text_len = array_length_1d(gameover_text);

//goodScoreThreshold = .70; 
scoreRatio = lastScore / max(1,highScore);
scoreRatioRemainder = scoreRatio - GOOD_SCORE_THRESHOLD;

/// If we're at the great score threshold and not a new bemax(1,highScore)st score
if scoreRatioRemainder >= 0 and lastScore < highScore 
{
    // Calculate Interval
    interval = (1 - GOOD_SCORE_THRESHOLD) / gameover_text_len; //NB: Can't divide by zero error could happen is goodscore theshold was 1
    //.03 //30 / .03 = 10

    // Get Which Tier We're on
    gameover_text_index = floor(scoreRatioRemainder / interval) ;
        //NB:  We floor to prevent index being == len
    // Offset by 1 for the empty starting index
    //gotnum += 1;
}



/*
   
//90*levelDiffAdj
//var scoreInput = argument0; //NB: No longer used.
            //I decided to go with a relative system.
//gameover text selector
gotnum = clamp(
            floor( 
                logn( 2, score_p1 / scoreInput) ),  //2.5
            0, array_length_1d(gameover_text) -1)
            //Good Score threshold is currently len(gameover_text) / 2 = 8

#define scr_go_set_gameover_rating_set_text
///scr_go_set_gameover_rating_set_text()


i=-1;
/*
gameover_text[++i] = "starible :("
gameover_text[++i] = "starible :("
gameover_text[++i] = "starible :("
gameover_text[++i] = "starendous :("
gameover_text[++i] = "starifying :(" //5
gameover_text[++i] = "starless :|" 
gameover_text[++i] = "starferior :|"
gameover_text[++i] = "starocious :|"
gameover_text[++i] = "starish :|" //9
*/
//half way (gotnum > size /2)
//gameover_text[++i] = ""// :)" //0
gameover_text[++i] = "starperb!"// :)" //
gameover_text[++i] = "starpendous!"// :)" 2
gameover_text[++i] = "starceptional!"// :)" 3
gameover_text[++i] = "starmazing!"// :)" 4
gameover_text[++i] = "starmented!"// :)" 
gameover_text[++i] = "startastic!"// :)" // 6
gameover_text[++i] = "starlightful!"// :)" 
gameover_text[++i] = "starific!"// :)" // 8

//Init Rating Index
gameover_text_index = -1;




#define scr_go_init_stat_display
///scr_go_init_stat_display()


go_display_index = 0
//Stat Display Labels
var i = -1;
                                        //label, value, best, bestVal, newBest
go_display_score[++i] = scr_create_array("score: ", 0, "best: ", 0, 0);
go_display_score[++i] = scr_create_array("level: ", 0, "best: ", 0, 0);
go_display_score[++i] = scr_create_array("time: ", 0, "best: ", 0, 0);
go_display_score[++i] = scr_create_array("earned: ", 0, "total: ", 0, 0);



#define scr_go_set_stat_display
///scr_go_set_stat_display()

//Set display stats
var i = -1;

// Score
var data = go_display_score[++i];
data[@ 1] = lastScore; //current stat
data[@ 3] = highScore; //best stat
data[@ 4] = obj_control_game.newBestFlag[i]; //is new best
playHighScoreSound = playHighScoreSound and data[4];

            
// Level
var data = go_display_score[++i];
data[@ 1] = lastLevel; //current stat
data[@ 3] = highLevel; //best stat
data[@ 4] = obj_control_game.newBestFlag[i]; //is new best
playHighScoreSound = playHighScoreSound and data[4];

// Playtime
var data = go_display_score[++i];
data[@ 1] = time_decode_opt_custom(0,1,1,lastPlaytime,60); //current stat
data[@ 3] = time_decode_opt_custom(0,1,1,longestPlaytime,60); //best stat
data[@ 4] = obj_control_game.newBestFlag[i]; //is new best
playHighScoreSound = playHighScoreSound and data[4];

// Cash
var data = go_display_score[++i];
data[@ 1] = "$"+string(STAR_CASH - obj_control_game.starCashStart); //earned cash 
data[@ 3] = "$"+string(STAR_CASH); //total cash
data[@ 4] = (STAR_CASH - obj_control_game.starCashStart) > 100; //rapacity
playHighScoreSound = playHighScoreSound and data[4];
#define scr_great_game_check
///scr_great_game_check()


if GAMEOVER {
    return (lastScore / max(1,highScore ) > GOOD_SCORE_THRESHOLD) or //.70
           (obj_control_game.newBestFlag[1] == 1) or //flag for new best level
           (obj_control_game.newBestFlag[2] == 1) or  //flag for new best time
           SHARE_ALWAYS_OVERRIDE;
} else {
    return (score_p1 / max(1,highScore ) > GOOD_SCORE_THRESHOLD) or //.70
           (level > highLevel ) or //flag for new best level
           (lastPlaytime * RMSPD_DELTA > longestPlaytime ) or  //flag for new best time
           SHARE_ALWAYS_OVERRIDE;
}