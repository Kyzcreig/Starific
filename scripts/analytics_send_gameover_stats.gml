#define analytics_send_gameover_stats
///analytics_send_gameover_stats(mode, size, difficulty, score, level, playtime, gamesPlayedType, gamesPlayedTotal)

with(obj_control_analytics){

    // Set Event Name
    var event_name = "gameover_stats";
    var param_names, param_vals, param_string;
    var i = -1;
    // Set up Parameter Names
    param_names[8] = "" // alloc memory
    param_names[++i] = "playerID"; //i0
    param_names[++i] = "mode";
    param_names[++i] = "grid";
    param_names[++i] = "rigor"; // i3
    param_names[++i] = "score";
    param_names[++i] = "gamesPlayedType";
    param_names[++i] = "gamesPlayedTotal"; //i6 
    param_names[++i] = "level";
    param_names[++i] = "playtime"; // i8 
            /*NB: We messed up the order here because HTML5 only takes 7 data
              due to the GMS delphi limit of 15 arguments.
              
              Sure you could implode the data somehow but it's not worth the trouble.              
            */
    // Set up Parameter Values
    for (var i = argument_count-1; i >= 0; i--){
        param_vals[i+1] = argument[i];
    }
    param_vals[0] = global.playerID;
    
    
    // Send Data 
    analytics_send_helper(event_name, param_names,param_vals);
    
        
    // Check if Send Failed
    if os_is_network_connected(){
        
    
        // Check if any unsent data and send it too
        if ini_section_exists("UNSENT_DATA"){
            
            // Set Event Name
            var event_name = "gameover_stats_offline";
                
            // Loop Through Unsent Data
            for (var i = analytics_get_buffer_index()-1; i >= 0; i--){
                
                // Load Previously Saved Game Data
                var param_data = ini_read_string("UNSENT_DATA",string(i), "");
                if param_data != "" {   
                    // Extract Data
                    param_vals = string_split_real(",",param_data);
                    // Send Flurry Event
                    analytics_send_helper(event_name, param_names, param_vals);
                    // Clear Save Data
                    ini_key_delete("UNSENT_DATA",string(i))
                }
            } 
            
            // Clear Section
            ini_section_delete("UNSENT_DATA");
        }
    
    }
    else{
        // Get most recent params index
        var saveIndex = analytics_get_buffer_index();
        
        var cached_vals = string_join_real(",",param_vals);
        // Save "Unsent Data to File
        ini_write_string("UNSENT_DATA",string(saveIndex), cached_vals);
    
    }
    
    
    
    //NB:  I think the right way to analyze this will be to download the file.csv
    //Then graph it in excel or whatever, maybe use python to munge the data.
    
    //Essentially I want a visual feel for how quickly people are dying/losing.
    //e.g. what kinds of scores are they getting:
    // "score_log10"+","+string( round(log10(argument2)))+","+
    

}

#define analytics_send_helper
///analytics_send_helper(event_name, param_names, param_values)

var event_name = argument0;
var param_names = argument1;
var param_vals = argument2;

// Mobile Analytics
if global.ana_type == 1 {
    // Format Parameters into String
    var param_string = analytics_mobile_helper(param_names,param_vals);
    // Send Data
    FlurryAnalytics_SendEventExt(event_name, param_string)
} 
// HTML5 Analytics
else if global.ana_type == 2 {
}
/* NB: HTML5 Flurry Disabled for now
// TO DO reenable this when html5 flurry is fixed
    var param_len = array_length_1d(param_names);
    
    switch param_len {
    
    case 1:
        analytics_event_ext(event_name, 
                        param_names[0], param_vals[0]
                        );
        break;
        
    case 2:
        analytics_event_ext(event_name, 
                        param_names[0], param_vals[0],
                        param_names[1], param_vals[1]
                        );
        break;
        
    case 3:
        analytics_event_ext(event_name, 
                        param_names[0], param_vals[0],
                        param_names[1], param_vals[1],
                        param_names[2], param_vals[2]
                        );
        break;
        
    case 4:
        analytics_event_ext(event_name, 
                        param_names[0], param_vals[0],
                        param_names[1], param_vals[1],
                        param_names[2], param_vals[2],
                        param_names[3], param_vals[3]
                        );
        break;
        
    case 5:
        analytics_event_ext(event_name, 
                        param_names[0], param_vals[0],
                        param_names[1], param_vals[1],
                        param_names[2], param_vals[2],
                        param_names[3], param_vals[3],
                        param_names[4], param_vals[4]
                        );
        break;
        
    case 6:
        analytics_event_ext(event_name, 
                        param_names[0], param_vals[0],
                        param_names[1], param_vals[1],
                        param_names[2], param_vals[2],
                        param_names[3], param_vals[3],
                        param_names[4], param_vals[4],
                        param_names[5], param_vals[5]
                        );
        break;
        
    case 7:
        analytics_event_ext(event_name, 
                        param_names[0], param_vals[0],
                        param_names[1], param_vals[1],
                        param_names[2], param_vals[2],
                        param_names[3], param_vals[3],
                        param_names[4], param_vals[4],
                        param_names[5], param_vals[5],
                        param_names[6], param_vals[6]
                        );
        break;
    // For Longer data use the first 7 only
    default:
        analytics_event_ext(event_name, 
                        param_names[0], param_vals[0],
                        param_names[1], param_vals[1],
                        param_names[2], param_vals[2],
                        param_names[3], param_vals[3],
                        param_names[4], param_vals[4],
                        param_names[5], param_vals[5],
                        param_names[6], param_vals[6]
                        );
        break;
    }

}

#define analytics_mobile_helper
////analytics_mobile_helper(param_names,param_vals)

var param_names = argument0;
var param_vals = argument1;
var param_string = ""

for (var i = 0, n = array_length_1d(param_names); i < n; i++) {
    if i != 0 {
        param_string += ","
    }
    param_string += param_names[i]+","+string(param_vals[i]);
} 

return param_string;




#define analytics_get_buffer_index
///analytics_get_buffer_index()

if ini_section_exists("UNSENT_DATA"){

    var tmp = 0;
    //Iterate through keys until we find the last one
    while (ini_key_exists("UNSENT_DATA", string(tmp))){
        tmp++;
    }

    return tmp;

}


return 0;