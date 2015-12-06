///analytics_send_roomtime(room)

with(obj_control_analytics){

    var event_name, ri;
    ini_open("savedata.ini")
    switch argument0{
           case rm_menu:
                event_name = "time_in_room_menu";
                ri = 0;
                ini_write_real("room_visits","menu", ++ana_roomtimes[ri]);
                break;
           case rm_stats:
                event_name = "time_in_room_stats";
                ri = 1;
                ini_write_real("room_visits","stats", ++ana_roomtimes[ri]);
                break;
           case rm_options:
                event_name = "time_in_room_options";
                ri = 2;
                ini_write_real("room_visits","options", ++ana_roomtimes[ri]);
                break;
           case rm_game:
                event_name = "time_in_room_game";
                ri = 3;
                ini_write_real("room_visits","game", ++ana_roomtimes[ri]);
                break;
           default:
                event_name = "time_in_room_other";
                ri = 4;
                ini_write_real("room_visits","other", ++ana_roomtimes[ri]);
                break;
    
    }
    ini_close();
    //Update Visit Counts
    
    

    //Send game stats
    var params = "playerID"+","+string(global.playerID)+","+
                 "premium"+","+string(PREMIUM)+","+
                 "visit_count"+","+string(ana_roomtimes[ri])+","+
                 "time_seconds"+","+string(time_in_room / 60)
    FlurryAnalytics_SendEventExt( event_name, params);
    

}
