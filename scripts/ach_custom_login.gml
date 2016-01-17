#define ach_custom_login
///ach_custom_login()

//Log into achievement Service
if CONFIG == CONFIG_TYPE.IOS{ 
    achievement_login();
} else if CONFIG == CONFIG_TYPE.ANDROID {
    // GoogleServices
    achievement_login();
    
} else if CONFIG == CONFIG_TYPE.AMAZON {
    // AmazonServices
    AmazonGameCircle_InitFeatures(AmazonGameCircle_Achievements| AmazonGameCircle_Leaderboards| AmazonGameCircle_Whispersync| AmazonGameCircle_Progress| AmazonGameCircle_IAP);
    AmazonGameCircle_SetAppKey("b51db49a7364426ca82130bdbcc2f8de"); //NB: This is the app key on your amazon app page.  http://i.imgur.com/5fMsypU.png
    AmazonGameCircle_Login();

} else if CONFIG == CONFIG_TYPE.HTML{ 
    //If browser add gamejolt networking (later add our own networking)
    instance_create(x,y,obj_gj_networking);

}

#define ach_custom_available
///ach_custom_available()
var rtn = false;

if CONFIG == CONFIG_TYPE.IOS{ 
    rtn = achievement_available();
} else if CONFIG == CONFIG_TYPE.ANDROID {
    rtn = achievement_available();

}else if CONFIG == CONFIG_TYPE.AMAZON {
    rtn = AmazonGameCircle_IsSignedIn();
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

if CONFIG == CONFIG_TYPE.IOS{ 
    achievement_show_leaderboards();
    rtn = true;
} else if CONFIG == CONFIG_TYPE.ANDROID {
    achievement_show_leaderboards();
    rtn = true;

}else if CONFIG == CONFIG_TYPE.AMAZON {
    AmazonGameCircle_ShowLeaderboards();
    rtn = true;
}
//HTML 
//TO DO: MAYBE

return rtn;

#define ach_custom_post_score
///ach_custom_post_score(leaderboard_id, score)


if CONFIG == CONFIG_TYPE.IOS{ 
    achievement_post_score(
        get_leaderboard_id(MODE,GRID),
        lastScore);
} else if CONFIG == CONFIG_TYPE.ANDROID {
    achievement_post_score(
        get_leaderboard_id(MODE,GRID),
        lastScore);

}else if CONFIG == CONFIG_TYPE.AMAZON {
    AmazonGameCircle_PostLeaderboardScore(
        get_leaderboard_id(MODE,GRID),
        lastScore);
}else if CONFIG == CONFIG_TYPE.HTML {

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