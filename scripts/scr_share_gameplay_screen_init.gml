#define scr_share_gameplay_screen_init
///scr_share_gameplay_screen_init()

globalvar
SHARE_ALWAYS_OVERRIDE,
SHARE_SCREEN_GAMEOVER,
GOOD_SCORE_THRESHOLD;

//Show Share on Gameover
SHARE_ALWAYS_OVERRIDE = 0; 

// Set Good Score Threshold
GOOD_SCORE_THRESHOLD = .70;
// Declare Share Screen Vars
scr_share_screen_init();

/* SHARE_SCREEN_GAMEOVER
    0 = no screenshot
    1 = only on gameover, if great game
    2 = during gameplay, if great game

*/
// Set Share Screen Enable
if os_type == os_ios //or os_type == os_android
{
    // Grab Screenshots During Game                
    SHARE_SCREEN_GAMEOVER = 2; 
}
else if os_type == os_android{
    // Only Grab Screenshots on Gameover
    SHARE_SCREEN_GAMEOVER = 1;
    //NB :Maybe the condition for which type of share screen could be if it's 60fps or not and mobile
}
else {//if TOUCH_ENABLED {
    SHARE_SCREEN_GAMEOVER = 0;
}


// For Debugging (override)
//SHARE_SCREEN_GAMEOVER = 2;  //(comment out)
//SHARE_ALWAYS_OVERRIDE = 1  //(comment out)
    //NB: Causes share button to always show up, not just on a good game
    
    
    
    

#define scr_share_screen_init
///scr_share_screen_init()

// Screenshot Stuff for Taking a Cool Shareable SS
globalvar 
SHARE_SCREEN_METRIC,
SHARE_SCREEN_SPR;
//SHARE_SCREEN_FLAG;



SHARE_SCREEN_SPR = noone;
SHARE_SCREEN_METRIC = noone;
//SHARE_SCREEN_FLAG = false;

#define scr_share_screen_reset
///scr_share_screen_reset()

if sprite_exists(SHARE_SCREEN_SPR){
    sprite_delete(SHARE_SCREEN_SPR); 
}

SHARE_SCREEN_SPR = noone;
SHARE_SCREEN_METRIC = noone;
//SHARE_SCREEN_FLAG = false;