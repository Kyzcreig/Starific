///analytics_send_buttonpress(button_event_name, count, [optional_params_string])

with(obj_control_analytics){


    
    var event_name = "button_pressed_"+argument[0];
    
    //Send game stats
    var params = "playerID"+","+string(global.playerID)+","+
                 //"premium"+","+string(PREMIUM)+","+
                 "count"+","+string(argument[1]);
    if argument_count > 2 {
        params += ","+argument[2];
        /*
        var extra_params;
        extra_params = argument[2];
        for (var i = 0, n = array_length_1d(extra_params); i < n; i++) {
                params += ","+extra_params[i];
        }*/
    }
                 
    FlurryAnalytics_SendEventExt(event_name , params);
    

}
