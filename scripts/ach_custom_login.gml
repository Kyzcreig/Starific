#define ach_custom_login
///ach_custom_login()

if (os_type == os_ios ){ 
    //Log into achievement Service
    achievement_login();
}
else if (os_type == os_android) {
    //Log into achievement Service
    if PLATFORM_SUBTYPE == 0{
        // GoogleServices
        achievement_login();
    
    } else if PLATFORM_SUBTYPE == 1 {
        // AmazonServices
        ///Start our services
        AmazonGameCircle_InitFeatures(AmazonGameCircle_Achievements| AmazonGameCircle_Leaderboards| AmazonGameCircle_Whispersync| AmazonGameCircle_Progress| AmazonGameCircle_IAP);
        AmazonGameCircle_SetAppKey("b51db49a7364426ca82130bdbcc2f8de"); //NB: This is the app key on your amazon app page.  http://i.imgur.com/5fMsypU.png

    }
    
}
//HTML
else if os_browser != browser_not_a_browser{ 
    //If browser add gamejolt networking (later add our own networking)
    instance_create(x,y,obj_gj_networking);

}

#define ach_custom_available
///ach_custom_available()
var rtn = false;

// Android
if (os_type == os_android) {
    
    // Google
    if PLATFORM_SUBTYPE == 0 {
        rtn = achievement_available();
    
    }
    // Amazon
    else if PLATFORM_SUBTYPE == 1{
        rtn = AmazonGameCircle_IsSignedIn();
    }

}
// iOS 
else if (os_type == os_ios) {
    rtn = achievement_available();
}
//HTML 
//TO DO: MAYBE

return rtn;

#define ach_custom_show_leaderboards
///ach_custom_show_leaderboards()
/*
    wrapper that calls show leaderboard for respective service
    and returns whether anything was called
*/

var rtn = false;

// Android
if (os_type == os_android) {
    
    // Google
    if PLATFORM_SUBTYPE == 0 {
        achievement_show_leaderboards();
        rtn = true;
    
    }
    // Amazon
    else if PLATFORM_SUBTYPE == 1{
        AmazonGameCircle_ShowLeaderboards();
        rtn = true;
    }

}
// iOS 
else if (os_type == os_ios) {
    achievement_show_leaderboards();
    rtn = true;
}
//HTML 
//TO DO: MAYBE

return rtn;

#define ach_custom_post_score
///ach_custom_post_score(leaderboard_id, score)


// Android
if os_type == os_android{
    // Google
    if PLATFORM_SUBTYPE == 0 {
        achievement_post_score(
            get_leaderboard_id(MODE,GRID),
            lastScore);
    }
    // Amazon
    else if PLATFORM_SUBTYPE == 1{
        AmazonGameCircle_PostLeaderboardScore(
            get_leaderboard_id(MODE,GRID),
            lastScore);
    }     
    //NB: The leaderboard services already handle offline submission of scores.
}
// iOS 
else if (os_type == os_ios) {
    achievement_post_score(
        get_leaderboard_id(MODE,GRID),
        lastScore);
}
//HTML 
else if (os_browser != browser_not_a_browser){

    // booksmaster added this
    /*
    with obj_networking
    {
        scr_bm_net_score(score_p1,MODE,(gridSize/5 - 2),level);
    }*/
    with obj_gj_networking
    {
        scr_bm_gj_score(lastScore,MODE,GRID,level); 
    }

} else {
//TO DO custom leaderboard stuff here


}