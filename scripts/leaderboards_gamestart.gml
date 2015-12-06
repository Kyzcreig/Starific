#define leaderboards_gamestart
///leaderboards_gamestart()
globalvar 
LEADERBOARDS;

    
if (os_type == os_ios || os_type == os_android){ 
    //Log into achievement Service
    achievement_login();
    LEADERBOARDS = 1;
}
//HTML
else if os_browser != browser_not_a_browser{
    //If browser add gamejolt networking (later add our own networking)
    instance_create(x,y,obj_gj_networking);
    LEADERBOARDS = 1;

}
// Not mobile
else {
    //No External Leaderboard Services 
    LEADERBOARDS = 0;


}

 



#define scr_everyplay_init
///scr_everyplay_init()

globalvar
EVERYPLAY_ENABLED,
EVERYPLAY_AUTO;

if os_type == os_ios { //or os_type == os_android
    EVERYPLAY_ENABLED = true;
} else {
    EVERYPLAY_ENABLED = false;
}


//EVERYPLAY_ENABLED = true; //debugging

// Init Everyplay
if EVERYPLAY_ENABLED {
    everyplay_init("2976c8ed4a6f1b8608633696d8102db9a3434ef6","6d5826af9a9214e1a11e4d864b40de836d690e3a");
}

// Set Auto Recording
ini_open("savedata.ini");
    EVERYPLAY_AUTO = ini_read_real("settings", "EVERYPLAY_AUTO", 1);
ini_close();