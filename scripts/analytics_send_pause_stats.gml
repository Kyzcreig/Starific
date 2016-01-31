///analytics_send_pause_stats()


with(obj_control_analytics){
    //Send stats since last os_pause
    ana_GP[1] = STEP;
    var params = "playerID"+","+string(global.playerID)+","+
                 "games_started"+","+string(ana_GP[0])+","+
                 "uptime_seconds"+","+string( (ana_GP[1] - ana_GS[1]) / room_speed)+","+
                 "playtime_seconds"+","+string( ana_GP[2] / room_speed )+","+
                 //"interstitial_ad_count"+","+string( ana_GP[3] )+","+
                 "gamestart_count"+","+string( ana_GP[4] )
    FlurryAnalytics_SendEventExt("pause_stats_since_last_os_pause", params);
    
    
    
    //Set GameStart stats //Reset GamePause stats
    ana_GS[0] += ana_GP[0]; ana_GP[0] = 0;
    ana_GS[1] += ana_GP[1];
    ana_GS[2] += ana_GP[2]; ana_GP[2] = 0;
    ana_GS[3] += ana_GP[3]; ana_GP[3] = 0;
    ana_GS[4] += 1;
    //Send stats since gamestart
    var params = "playerID"+","+string(global.playerID)+","+
                 "games_started"+","+string(ana_GS[0])+","+
                 "uptime_seconds"+","+string( ana_GS[1] / room_speed)+","+
                 "playtime_seconds"+","+string( ana_GS[2] / room_speed )+","+
                 //"interstitial_ad_count"+","+string( ana_GS[3] )+","+
                 "os_pause_count"+","+string( ana_GS[4] );
    FlurryAnalytics_SendEventExt( "pause_stats_since_last_gamestart", params);
    
    if TUTORIAL_ENABLED and instance_exists(obj_control_tutorial){
        //Send Tutorial Stats
        var params = "playerID"+","+string(global.playerID)+","+
                     "games_started"+","+string(ana_GS[0])+","+
                     "uptime_seconds"+","+string( ana_GS[1] / room_speed)+","+
                     "playtime_seconds"+","+string( ana_GS[2] / room_speed )+","+
                     "MODE"+","+string( scr_unlock_get_name(1,MODE)  )+","+
                     "GRID"+","+string( scr_unlock_get_name(0,GRID)  )+","+
                     "RIGOR"+","+string( scr_unlock_get_name(2,RIGOR)  )+","+
                     "tutorial_frame"+","+string( obj_control_tutorial.tutorialFrame[0] ) ;
        FlurryAnalytics_SendEventExt( "pause_during_tutorial", params);
    }
}



