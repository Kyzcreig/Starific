///analytics_send_unlock(data, gamesPlayedTotal)


with(obj_control_analytics){
    var data = argument[0];
    var gamesPT = argument[1];
    var event_name = "unlocked_content";
    var param_names, param_vals, param_string;
    
    // Set up Parameter Names
    var i = -1;
    param_names[2] = "" // alloc memory
    param_names[++i] = "playerID"; //i0
    param_vals[i] = global.playerID; 
    param_names[++i] = "unlock_name";
    param_vals[i] = scr_unlock_get_name_long(data); 
    param_names[++i] = "gamesPlayedTotal"; //i2
    param_vals[i] = gamesPT;
    

    
    
    //Send game stats
    analytics_send_helper(event_name, param_names, param_vals);
    

}
