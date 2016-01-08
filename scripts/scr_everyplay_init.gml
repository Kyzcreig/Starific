#define scr_everyplay_init
///scr_everyplay_init()

globalvar
EVERYPLAY_ENABLED,
EVERYPLAY_AUTO;

if os_type == os_ios 
{
    EVERYPLAY_ENABLED = true;
} else if os_type == os_android {
    // Get OS Info
    var os_map, version, major;
    os_map = os_get_info()
    
    if os_map != -1
    {
        //Get Android Version
        version = os_map[? "RELEASE"];
        show_debug_message("os_map[?'RELEASE'] = "+version);
        //Compare Top Level
        major = real(string_char_at(version,1));
        
        if major >= 5 {
            // Enable for Newer Phones
            EVERYPLAY_ENABLED = true;
        
        } else {
            // Disable for Older Phones
            EVERYPLAY_ENABLED = false;
        }
        ds_map_destroy(os_map);
    }
}
else {
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

#define leaderboards_gamestart
///leaderboards_gamestart()
globalvar 
LEADERBOARDS;

// Mobile and HTML   
if (os_type == os_ios or 
    os_type == os_android or 
    os_browser != browser_not_a_browser){ 
    //Log into achievement Service
    ach_custom_login();
    LEADERBOARDS = 1;
}
// Desktop 
else {
    //No External Leaderboard Services 
    LEADERBOARDS = 0;
}

 


