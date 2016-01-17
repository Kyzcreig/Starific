///leaderboards_gamestart()
globalvar 
LEADERBOARDS;

// Mobile and HTML   
if (os_type == os_ios or 
    os_type == os_android or 
    CONFIG == CONFIG_TYPE.HTML){ 
    //Log into achievement Service
    ach_custom_login();
    LEADERBOARDS = 1;
}
// Desktop 
else {
    //No External Leaderboard Services 
    LEADERBOARDS = 0;
}

 

