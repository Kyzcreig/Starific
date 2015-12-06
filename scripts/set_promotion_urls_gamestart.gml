#define set_promotion_urls_gamestart
///set_promotion_urls_gamestart()


globalvar FREE_APP_URL, PREMIUM_APP_URL, LANDING_PAGE_URL, COMPANY_URL;

LANDING_PAGE_URL = "http://StarificGame.com/";
COMPANY_URL = "http://BeveledEdge.co/";

// Following URLS mostly just used for the Rate Button
//Android 
if os_type == os_android{
   // Google Play
   if PLATFORM_SUBTYPE <= 0 {
       FREE_APP_URL = "https://play.google.com/store/apps/details?id=com.alexgierczyk.starific"; 
       //market://play.google.com/store/apps/details?id=com.alexgierczyk.starific"; 
       PREMIUM_APP_URL = FREE_APP_URL; 
   }
   // Amazon Store
   else if PLATFORM_SUBTYPE == 1 {
       FREE_APP_URL = "http://www.amazon.com/gp/mas/dl/android?p=com.alexgierczyk.starific";
       PREMIUM_APP_URL = FREE_APP_URL; 
   }
}
//iOS 
else if os_type == os_ios{
   FREE_APP_URL = "https://itunes.apple.com/us/app/starific/id954647642";
   PREMIUM_APP_URL = FREE_APP_URL; 
} 
//HTML 
else{
   FREE_APP_URL = LANDING_PAGE_URL; //Maybe don't use these
   PREMIUM_APP_URL = LANDING_PAGE_URL; //Maybe don't use these, instead use landing page
}

globalvar URL_TARGET;
URL_TARGET = "_parent" //_blank //_self

#define scr_share_gameplay_screen_init
///scr_share_gameplay_screen_init()

globalvar
SHARE_SCREEN_GAMEOVER,
SHARE_ALWAYS_OVERRIDE,
GOOD_SCORE_THRESHOLD;


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
else if TOUCH_ENABLED {
    SHARE_SCREEN_GAMEOVER = 0;
}
// For Debugging (override)
//SHARE_SCREEN_GAMEOVER = true  (comment out)

//Show Share on Gameover
SHARE_ALWAYS_OVERRIDE = 0;

// For Debugging (override)
//SHARE_ALWAYS_OVERRIDE = 1  0 //1
    //NB: Causes share button to always show up, not just on a good game
