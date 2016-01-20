#define scr_stats_save
///scr_stats_save()


ini_open("scores.ini")
    
    var currentSection = scr_stats_get_section(MODE, GRID, 0);
    
    
    //Scores
    lastScore = score_p1
    if highScore < lastScore {
       highScore = lastScore;
       // Mark New Best
       with (obj_control_game){
            newBestFlag[0] = 1;
       }
       
    }
    careerScore += lastScore
    //Average Score
    if gamesPlayed != 0{averageScore = round(careerScore / gamesPlayed)}
    //Worst Cose
    if worstScore > lastScore or worstScore == noone{
       worstScore = lastScore
    }
    
    //Levels
    lastLevel = level
    if highLevel < lastLevel {
        highLevel = lastLevel
       // Mark New Best
       with (obj_control_game){
            newBestFlag[1] = 1;
       }
       
    }
    careerLevel += level
    //Averaging Level
    if gamesPlayed != 0{averageLevel = round(careerLevel / gamesPlayed)}
    
    
    //Playtime
    lastPlaytime *= RMSPD_DELTA;
    if longestPlaytime < lastPlaytime {
        longestPlaytime = lastPlaytime;
       // Mark New Best
       with (obj_control_game){
            newBestFlag[2] = 1;
       }
       
    }
    if gamesPlayed != 0{averagePlaytime = round(careerPlaytime / gamesPlayed)}else{averagePlaytime = 0}
    careerPlaytime += lastPlaytime
    
    //Reflects
    if highReflects < lastReflects {highReflects = lastReflects}
    if gamesPlayed != 0{averageReflects = round(careerReflects / gamesPlayed)}
    
    //Deaths
    for (i = 0; i<lives; i++){careerDeaths ++} //adds lives to deaths when exiting
    careerDeaths += lastDeaths
    if gamesPlayed != 0{averageDeaths = round(careerDeaths / gamesPlayed)}
    
    //Reflects per death
    if careerDeaths != 0{averageRPD = round(careerReflects / careerDeaths)}
    if lastDeaths != 0{lastRPD = round(lastReflects / lastDeaths)}
    
    
    //Points per death
    if careerDeaths != 0{averagePPD = round(careerScore / careerDeaths)}
    if lastDeaths != 0{lastPPD = round(lastScore / lastDeaths)}
    
    
    //Longest Streaks
    longestStreaksTotal += lastLongestStreak
    if lastLongestStreak > longestStreak {longestStreak = lastLongestStreak}
    if gamesPlayed != 0{averageLongestStreak = round(longestStreaksTotal / gamesPlayed)}else{averageLongestStreak = 0}
    
    
    //Deflector Catches
    highestDCatches = max(highestDCatches,lastDCatches)
    careerDCatches += lastDCatches;
    if gamesPlayed != 0{averageDCatches = round(careerDCatches / gamesPlayed)}
    
    //Star Catches
    highestSCatches = max(highestSCatches,lastSCatches)
    careerSCatches += lastSCatches;
    if gamesPlayed != 0{averageSCatches = round(careerSCatches / gamesPlayed)}
    
    
    //Combos
    highestBestCombo = max(highestBestCombo,lastBestCombo)
    careerBestComboTotal += lastBestCombo
    if gamesPlayed != 0{averageBestCombo = round(careerBestComboTotal / gamesPlayed)}
    
    
    //Stars seen per game
    if highestStars < lastStars {highestStars = lastStars}
    careerStars += lastStars;
    if gamesPlayed != 0{averageStars = round(careerStars / gamesPlayed)}
    
    //Star save percentage
    if (lastStars+lastSCatches) != 0 {lastStarsSaved = lastSCatches/(lastStars+lastSCatches)};
    if highestStarsSaved < lastStarsSaved {highestStarsSaved = lastStarsSaved}
    if gamesPlayed != 0{careerStarsSaved = (careerStarsSaved*(gamesPlayed-1)+lastStarsSaved) / gamesPlayed}
    if (careerStars+careerSCatches) != 0{averageStarsSaved = careerSCatches / (careerStars+careerSCatches)}
    
    
        
    // !Specific! Deflector Catch and Death Counts (For Bestiary/Analytics)
    var size, key, data, tmp, tmp1;
    DEFLECTOR_DISCOVERED = false;
    DEFLECTOR_DISCOVERED_COUNT = 0;
    size = ds_map_size(DEFLECTOR_DATA)
    key = ds_map_find_first(DEFLECTOR_DATA)
    for (var i = 0; i < size ; i++){
        //Pull Data
        data = DEFLECTOR_DATA[? key];
        
        //If Moves Mode Parents
        if MODE == MODES.MOVES and data[2] != -1 {
            // Reshift Total back to Current Game Count
            data[@ 6] += data[@ 7]
            data[@ 7] = 0;
        }
        //Load Totals
        data[@ 7] = ini_read_real(currentSection, "careerDeaths-"+key, 0);
        data[@ 9] = ini_read_real(currentSection, "careerCatches-"+key, 0);
        
        // Deaths
            // Last 
        ini_write_real(currentSection, "lastDeaths-"+key, data[@ 6]);
            // Highest 
        tmp =  ini_read_real(currentSection, "highestDeaths-"+key, 0);
        if tmp < data[@ 6] {
            ini_write_real(currentSection, "highestDeaths-"+key, data[@ 6]);
        }
            //Career 
        data[@ 7] += data[@ 6];
        ini_write_real(currentSection, "careerDeaths-"+key, data[@ 7]);
            //Average 
        tmp = round(data[@ 7] / max(1, gamesPlayed));
        ini_write_real(currentSection, "averageDeaths-"+key, tmp);
        
        // Catches
            // Last 
        ini_write_real(currentSection, "lastCatches-"+key, data[@ 8]);
            // Highest 
        tmp =  ini_read_real(currentSection, "highestCatches-"+key, 0);
        if tmp < data[@ 8] {
            ini_write_real(currentSection, "highestCatches-"+key, data[@ 8]);
        }
            //Career 
        data[@ 9] += data[@ 8];
        ini_write_real(currentSection, "careerCatches-"+key, data[@ 9]);
            //Average 
        tmp = round(data[@ 9] / max(1, gamesPlayed));
        ini_write_real(currentSection, "averageCatches-"+key, tmp);
        
        // If Undiscovered
        if data[11] == 0 { 
            // Check if Discovered
            if scr_deflector_is_discovered(data) { 
                // Mark Deflector as Discovered
                data[@ 11] = 1;
                // If Veteran Player
                if gamesPlayedTotal > 15 {
                    // Set Flag to Add "New Codex" Dialogue
                    DEFLECTOR_DISCOVERED = true;
                } else {
                    // Mark as Discovered and Seen
                    data[@ 11] = 2;
                }
                
                // Save
                ini_write_real("DEFLECTOR_DATA", key+"-discovered", data[11]);
            }
        } else {
            DEFLECTOR_DISCOVERED_COUNT++;
        }
        
        //Reset Totals
        data[@ 7] = 0;
        data[@ 9] = 0;
        
        //Iterate to next key.
        key = ds_map_find_next(DEFLECTOR_DATA, key); 
    }
    

    /*NB: We flatten the array here by turning MODE and gridsize into 1 value
          (MODE - 1) * gridSizeIndex
          So we can access each parameter with div and mod.
          The minus 1 is there because we start MODE at 1,2,3
    */
    ini_write_real(currentSection, "gamesPlayed", gamesPlayed);
    
    ini_write_real(currentSection, "highScore", highScore);
    ini_write_real(currentSection, "careerScore", careerScore);
    ini_write_real(currentSection, "lastScore", lastScore);
    ini_write_real(currentSection, "averageScore", averageScore);
    ini_write_real(currentSection, "worstScore", worstScore);
    
    ini_write_real(currentSection, "highLevel", highLevel);
    ini_write_real(currentSection, "careerLevel", careerLevel);
    ini_write_real(currentSection, "lastLevel", lastLevel);
    ini_write_real(currentSection, "averageLevel", averageLevel);
    
    ini_write_real(currentSection, "careerReflects", careerReflects);
    ini_write_real(currentSection, "highReflects", highReflects);
    ini_write_real(currentSection, "lastReflects", lastReflects);
    ini_write_real(currentSection, "averageReflects", averageReflects);
    
    ini_write_real(currentSection, "highestPPD", highestPPD);
    ini_write_real(currentSection, "lastPPD", lastPPD);
    ini_write_real(currentSection, "averagePPD", averagePPD);
    
    ini_write_real(currentSection, "highestRPD", highestRPD);
    ini_write_real(currentSection, "lastRPD", lastRPD);
    ini_write_real(currentSection, "averageRPD", averageRPD);
    
    ini_write_real(currentSection, "careerDeaths", careerDeaths);
    ini_write_real(currentSection, "lastDeaths", lastDeaths);
    ini_write_real(currentSection, "averageDeaths", averageDeaths);
    
    ini_write_real(currentSection, "careerPlaytime", careerPlaytime);
    ini_write_real(currentSection, "longestPlaytime", longestPlaytime);
    ini_write_real(currentSection, "lastPlaytime", lastPlaytime);
    ini_write_real(currentSection, "averagePlaytime", averagePlaytime);
    
    ini_write_real(currentSection, "longestStreaksTotal", longestStreaksTotal);
    ini_write_real(currentSection, "longestStreak", longestStreak);
    ini_write_real(currentSection, "lastLongestStreak", lastLongestStreak);
    ini_write_real(currentSection, "averageLongestStreak", averageLongestStreak);
    
    ini_write_real(currentSection, "careerBestComboTotal", careerBestComboTotal);
    ini_write_real(currentSection, "highestBestCombo", highestBestCombo);
    ini_write_real(currentSection, "lastBestCombo", lastBestCombo);
    ini_write_real(currentSection, "averageBestCombo", averageBestCombo);
    
    ini_write_real(currentSection, "careerDCatches", careerDCatches);
    ini_write_real(currentSection, "highestDCatches", highestDCatches);
    ini_write_real(currentSection, "lastDCatches", lastDCatches);
    ini_write_real(currentSection, "averageDCatches", averageDCatches);
    
    ini_write_real(currentSection, "careerSCatches", careerSCatches);
    ini_write_real(currentSection, "highestSCatches", highestSCatches);
    ini_write_real(currentSection, "lastSCatches", lastSCatches);
    ini_write_real(currentSection, "averageSCatches", averageSCatches);
    
    ini_write_real(currentSection, "careerStars", careerStars);
    ini_write_real(currentSection, "highestStars", highestStars);
    ini_write_real(currentSection, "lastStars", lastStars);
    ini_write_real(currentSection, "averageStars", averageStars);
    
    ini_write_real(currentSection, "careerStarsSaved", careerStarsSaved);
    ini_write_real(currentSection, "highestStarsSaved", highestStarsSaved);
    ini_write_real(currentSection, "lastStarsSaved", lastStarsSaved);
    ini_write_real(currentSection, "averageStarsSaved", averageStarsSaved);
    
   
   
    //Save StarCash
    ini_write_real("misc", "STAR_CASH", STAR_CASH);
   
             
       
    //Update Quest Progress
    scr_quest_update_progress()
      
    // Add Gameover Buttons
    scr_gameover_set_buttons();
    
    //Increment Play Count on Current Settings  
    scr_save_count_for_settings(); //NB: Best to keep this above check and save unlocks
    
    //Check for unlocks    
    scr_check_and_save_unlocks(!GAME_PAUSE,false);
  


    
    //Update Analytics
    if ANALYTICS{
       ana_GP[2] += lastPlaytime;  //playtime
       //Report on each game's stats
       analytics_send_gameover_stats(scr_unlock_get_name(1,MODE), scr_unlock_get_name(0,GRID), scr_unlock_get_name(2,RIGOR), lastScore, 
                      gamesPlayed, gamesPlayedTotal, lastLevel, lastPlaytime)
       //Report on sound data
       //analytics_send_gameover_sound_data(music_sound[0],music_sound[1],sfx_sound[0],sfx_sound[1])
    }
    
    //If mobile Leaderboards
    if LEADERBOARDS{// and achievement_available(){ 
                //NB: I believe leaderboard stuff is saved when offline and sent automatically later.
        scr_leaderboard_post_score()
    
    }


ini_close();

#define scr_gameover_set_buttons
///scr_gameover_set_buttons()

with (obj_control_gameover) {
     
    // Add Share and Get Buttons
    sh_greatGame = scr_great_game_check();
    // Delay For New Players
    sh_veteran = scr_veteran_playtime_status(lastPlaytime); // (gamesPlayedTotal > 4) 
    // Share Stat
    sh_doShare = (sh_veteran and sh_greatGame) or SHARE_ALWAYS_OVERRIDE;
    // If Non-Mobile Version
    if touchPad == 0{
        //Add Landing Page (GET) Button
        if random(1) > .75 {
            scr_gameover_add_button(9);
        }
        //Add Share Buttons (HTML)
        if sh_doShare {
            if random(1) > .5 {
                //Facebook Share
                scr_gameover_add_button(4);
            } else {
                //Twitter Share
                scr_gameover_add_button(5);
            }
        }
    }
    // Mobile Version
    else{
    
        // Schedule Rate Prompt to Appear
        rateNextTime = ini_read_real("misc", "RATE_NEXT_TIME", 0);
        currentDate = date_current_datetime();
        rateAvailable = date_compare_datetime(rateNextTime, currentDate) == -1;
        // If rate available, add button and blank dialogue
        if rateAvailable and 
           gamesPlayedTotal > 15 and 
           obj_control_game.newBestFlag[0] == 1 //flag for new best score
           //(lastScore == highScore and sh_greatGame)/// and random(1) > .5)  
        { 
            // Flag Rate Prompt to Appear
            rate_prompt[0] = true;
            // Add 15min Cooldown on Rate Prompt
            rateNextTime = date_inc_minute(currentDate,15);
            ini_write_real("misc", "RATE_NEXT_TIME",rateNextTime);
            /*
            // Add rate Button to Gameover
            if scr_go_is_button(6)  == -1{ // if button not in list
                scr_gameover_add_button(  6);
            }
            */
        }
        
        //Add Deluxe/No-Ads Button
        if PREMIUM == 0 { //DISABLED because I'm no longer doing premium version
            //Get Deluxe
            scr_gameover_add_button(7);
        }
        
        // Add Everyplay Button
        if everyplay_is_recording() 
        {
            scr_gameover_add_button(21);
        } 
        //Add Share Button (Mobile)
        else if sh_doShare //or 1 
        {
            scr_gameover_add_button(8);
        } 
    }
       
         
    //Add Quest Dialogues and/or Reward Button
    if QUEST_DATA[0] != -1 {
         
         //Check if Quest Complete
         if QUEST_DATA[2] >= QUEST_DATA[1] {
             // Add Quest Reward Button to Gameover
             if scr_go_is_button(13)  == -1{ // if button not in list
                 scr_gameover_add_button(  13);
             }
             // Add Quest Complete Text on Gameover
             scr_gameover_add_dialogue( 2);
             
         }
         else {
             // Add Quest Progressing Text on Gameover
             if random(1) > .5 or ds_list_size(go_dialogue_txt) < 1 {
                 scr_gameover_add_dialogue( 1);
                 /*
                 //Add Cancel Quest Button if Taking too Long
                 if QUEST_DATA[3] >= 4 and random(1) > .5  {
                     scr_gameover_add_button(  17);
                 }*/
             } 
         }
     }
           
     
     // Delay For New Players
     if sh_veteran 
     {
         // Check if time for a gift
         questRewardAvailable = scr_go_is_button(13) != -1;
         giftNextTime = ini_read_real("misc", "GIFT_NEXT_TIME", 0); 
         giftAvailable = date_compare_datetime(giftNextTime, date_current_datetime()) == -1;
         //If No Reward Button (To Avoid Button Crowding)
         if !questRewardAvailable {
             // If gift available
             if giftAvailable{ 
                 // Add Gift Button to Gameover
                 if scr_go_is_button(14)  == -1{ // if button not in list
                     scr_gameover_add_button(  14);
                 }
                 // Add Placeholder Dialogue object for "Free Gift in Time" Text
                 ScheduleScript(id, 0, 5, scr_gameover_add_dialogue,  6);
             }
             // Else add "Free Gift in Time" dialogue
             else if random(1) > .5{
                 ScheduleScript(id, 0, 5, scr_gameover_add_dialogue,  7);
             }
         }
         
         
         // Add Prize Wheel Button
         if scr_prize_wheel_available()  { 
             // Add Prize Wheel Button to Gameover
             if scr_go_is_button(15)  == -1{ // if button not in list
                 scr_gameover_add_button(  15);
             }
         }
         // Else add dialogue "$#/100 to go for prize" text
         else if random(1) > .5 or ds_list_size(go_dialogue_txt) < 2{
            // Add To Go Prize Text on Gameover
             scr_gameover_add_dialogue( 3);
         }
         
         
         
         // Add Video Reward Button
         scr_gameover_buttons_add_adverts(true);
         
         
         
         //If New Deflector Discovered
         if DEFLECTOR_DISCOVERED { //DEFLECTOR_DISCOVERED_COUNT > 20{
                        //NB: We delay showing the codex thing until they're farther along.
             DEFLECTOR_DISCOVERED = false;
             // Add Dialogue
             scr_gameover_add_dialogue( 9);
         }
     }
     
     
     
     
}

#define scr_save_count_for_settings
///scr_save_count_for_settings()



//Update Plays and Views for Settings
with (obj_control_gameover) {


    
    
    // Save gridSize
    scr_unlock_increment_plays(0, GRID);
    scr_unlock_increment_views(0, GRID, 1, 1);
    
    // Save Mode
    scr_unlock_increment_plays(1, MODE);
    scr_unlock_increment_views(1, MODE, 1, 1);
    
    //Save Rigor
    scr_unlock_increment_plays(2, RIGOR);
    scr_unlock_increment_views(2, RIGOR, 1, 1);
    
    //Save Theme
    scr_unlock_increment_plays(3, CURSKIN);
    scr_unlock_increment_views(3, CURSKIN, 1, 1);



}

#define scr_unlock_increment_plays
///scr_unlock_increment_plays(type, index)

var type = argument0;
var index = argument1;


var data = scr_unlock_get_data(type, index);
var key = scr_unlock_get_key(data[0], data[7])
ini_write_real("UNLOCKS_DATA", key+"-plays", ++data[@ 9]);

#define ini_read_real_MS_total
///ini_read_real_MS_total(modes_string, sizes_string, convert_to_index, key, default)

var modes = string_split_real(",",argument0);
var sizes = string_split_real(",",argument1); 
var convert_to_index = argument2;
var tmp = 0, currentSection;

for (var i = 0, n = array_length_1d(modes); i < n; i++){
    for (var j = 0, m = array_length_1d(sizes); j < m; j++){
        currentSection = scr_stats_get_section(modes[i], sizes[j], convert_to_index)
        tmp += ini_read_real(currentSection, argument3, argument4);
            
            //NB:  we could have another script that takes some method integer and adds or gets the max, min etc as needed.
            // let's save that for later though.
    }
}

return tmp;






#define scr_stats_get_section
///scr_stats_get_section(game_mode, gridSize, convert)


var mode = argument0;
var size = argument1;
var convert = argument2;


return "Stats_"+string(scr_convert_mode_and_grid_to_index(mode,size,convert));


#define scr_convert_mode_and_grid_to_index
///scr_convert_mode_and_grid_to_index(mode,grid,convert)


if argument2 {
    return convert_mode_to_index(argument0)+convert_grid_to_index(argument1)*4;
} 
else {
    return argument0+(argument1)*4;
}