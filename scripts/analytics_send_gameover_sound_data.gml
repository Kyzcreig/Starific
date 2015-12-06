///analytics_send_gameover_sound_data(music_volume, music_enabled, sfx_volume, sfx_enabled)

with(obj_control_analytics){

    //Send game stats
    var params = "playerID"+","+string(global.playerID)+","+
                 "premium"+","+string(PREMIUM)+","+
                 "music_volume"+","+string(argument0)+","+
                 "music_enabled"+","+string( argument1)+","+
                 "sfx_volume"+","+string( argument2)+","+
                 "sfx_enabled"+","+string( argument3)
                 
    FlurryAnalytics_SendEventExt( "gameover_sound_data", params);
    

}
