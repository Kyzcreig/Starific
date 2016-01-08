#define scr_stats_load
///scr_stats_load()

globalvar gamesPlayedTotal, careerPlaytimeTotal, gamesPlayed;//, gamesPlayedArcade, gamesPlayedTimed, gamesPlayedMoves;
globalvar highScore, careerScore, lastScore, averageScore, worstScore;
globalvar highLevel, lastLevel, averageLevel, careerLevel;
globalvar longestStreaksTotal, longestStreak, lastLongestStreak, averageLongestStreak;
globalvar careerReflects, highReflects, lastReflects, averageReflects;
globalvar careerPlaytime, longestPlaytime, lastPlaytime, averagePlaytime;
globalvar careerDeaths, averageDeaths, lastDeaths, 
globalvar highestPPD, lastPPD, averagePPD;
globalvar highestRPD, lastRPD, averageRPD;
globalvar highestBestCombo, lastBestCombo, averageBestCombo,careerBestComboTotal;
globalvar careerSCatches, highestSCatches, lastSCatches,averageSCatches;
globalvar careerDCatches, highestDCatches, lastDCatches,averageDCatches;
globalvar careerStars, highestStars, lastStars, averageStars;
globalvar careerStarsSaved, highestStarsSaved, lastStarsSaved, averageStarsSaved;

ini_open("scores.ini")

//We flatten the array here by turning MODE and gridsize into 1 value
//It's gamemdoe + gridsize as a single digit * number of modes
//So we can extra each parameter with div and mod.
//The minus 1 is there because we start MODE at 1,2,3
//It would probably be a good idea to change it to 0,1,2 but i don't want to hunt that down right now
    var currentSection = scr_stats_get_section(MODE, GRID, 0)

    gamesPlayed = ini_read_real(currentSection, "gamesPlayed", 0);
    
    highScore = ini_read_real(currentSection, "highScore", 0);
    careerScore = ini_read_real(currentSection, "careerScore", 0);
    lastScore = ini_read_real(currentSection, "lastScore", 0);
    averageScore = ini_read_real(currentSection, "averageScore", 0);
    worstScore = ini_read_real(currentSection, "worstScore", noone);
    
    careerLevel = ini_read_real(currentSection, "careerLevel", 0);
    highLevel = ini_read_real(currentSection, "highLevel", 0);
    lastLevel = ini_read_real(currentSection, "lastLevel", 0);
    averageLevel = ini_read_real(currentSection, "averageLevel", 0);
    
    longestStreaksTotal = ini_read_real(currentSection, "longestStreaksTotal", 0);
    longestStreak = ini_read_real(currentSection, "longestStreak", 0);
    lastLongestStreak = ini_read_real(currentSection, "lastLongestStreak", 0);
    averageLongestStreak = ini_read_real(currentSection, "averageLongestStreak", 0);
    
    careerReflects = ini_read_real(currentSection, "careerReflects", 0);
    highReflects = ini_read_real(currentSection, "highReflects", 0);
    lastReflects = ini_read_real(currentSection, "lastReflects", 0);
    averageReflects = ini_read_real(currentSection, "averageReflects", 0);
    
    careerPlaytime = ini_read_real(currentSection, "careerPlaytime", 0);
    longestPlaytime = ini_read_real(currentSection, "longestPlaytime", 0);
    lastPlaytime = ini_read_real(currentSection, "lastPlaytime", 0);
    averagePlaytime = ini_read_real(currentSection, "averagePlaytime", 0);
    
    careerDeaths = ini_read_real(currentSection, "careerDeaths", 0);
    lastDeaths = ini_read_real(currentSection, "lastDeaths", 0);
    averageDeaths = ini_read_real(currentSection, "averageDeaths", 0);
    
    highestPPD = ini_read_real(currentSection, "highestPPD", 0);
    lastPPD = ini_read_real(currentSection, "lastPPD", 0);
    averagePPD = ini_read_real(currentSection, "averagePPD", 0);
    
    highestRPD = ini_read_real(currentSection, "highestRPD", 0);
    lastRPD = ini_read_real(currentSection, "lastRPD", 0);
    averageRPD = ini_read_real(currentSection, "averageRPD", 0);
    
    careerBestComboTotal =  ini_read_real(currentSection, "careerBestComboTotal", 0);
    highestBestCombo = ini_read_real(currentSection, "highestBestCombo", 0);
    lastBestCombo = ini_read_real(currentSection, "lastBestCombo", 0);
    averageBestCombo = ini_read_real(currentSection, "averageBestCombo", 0);
    
    careerDCatches = ini_read_real(currentSection, "careerDCatches", 0);
    highestDCatches = ini_read_real(currentSection, "highestDCatches", 0);
    lastDCatches = ini_read_real(currentSection, "lastDCatches", 0);
    averageDCatches = ini_read_real(currentSection, "averageDCatches", 0);
    
    careerSCatches = ini_read_real(currentSection, "careerSCatches", 0);
    highestSCatches = ini_read_real(currentSection, "highestSCatches", 0);
    lastSCatches = ini_read_real(currentSection, "lastSCatches", 0);
    averageSCatches = ini_read_real(currentSection, "averageSCatches", 0);
    
    careerStars = ini_read_real(currentSection, "careerStars", 0);
    highestStars = ini_read_real(currentSection, "highestStars", 0);
    lastStars = ini_read_real(currentSection, "lastStars", 0);
    averageStars = ini_read_real(currentSection, "averageStars", 0);
    
    careerStarsSaved = ini_read_real(currentSection, "careerStarsSaved", 0);
    highestStarsSaved = ini_read_real(currentSection, "highestStarsSaved", 0);
    lastStarsSaved = ini_read_real(currentSection, "lastStarsSaved", 0);
    averageStarsSaved = ini_read_real(currentSection, "averageStarsSaved", 0);
    
    // Total Stats
    gamesPlayedTotal = ini_read_real_MS_total("0,1,2,3","0,1,2,3", false,"gamesPlayed",0) ;
    careerPlaytimeTotal = ini_read_real_MS_total("0,1,2,3","0,1,2,3", false,"careerPlaytime",0) ;

    // New Best Array (For Gameover Stats)
    newBestFlag = scr_create_array(0,0,0,0);
    
        
    //Reset Deflector Data Catch and Death Counts
    scr_reset_deflector_data();
    
    
    //RESET LOADED STATS
    roundPlaytime = 0
    gamesPlayed += 1
    lastReflects = 0
    lastDeaths = 0
    lastPPD = 0
    lastRPD = 0
    lastPlaytime = 0
    lastLongestStreak = 0
    lastDCatches = 0
    lastSCatches = 0
    lastBestCombo = 0
    lastStars = 0;

        
    
    //Update Analytics
    if ANALYTICS{
       ana_GP[0] += 1;  //games started
    }
    
    
    
    //show_message(string(date_current_datetime()))
    //show_message(string(date_create_datetime(1991, 3, 20, 7, 40, 2)))
        //It seems datetimes are stored as reals.
    
    // Grab datetimes of next quest and gift
    var giftNextTime = ini_read_real("misc", "GIFT_NEXT_TIME", 0);
    var questNextTime = ini_read_real("misc", "QUEST_NEXT_TIME", 0);
    // Quest is available if current datatime is after questNextTime and before giftNextTime
    var newQuestAvailable = ( date_compare_datetime(questNextTime,date_current_datetime() ) != 1 ) and
                            ( date_compare_datetime(giftNextTime,date_current_datetime() ) != -1 );
    var veteranPlaytime = careerPlaytimeTotal > 60*60*3; // gamesPlayedTotal > 2
    
    //If No Quest Selected and Quest is Available
    if QUEST_DATA[0] == -1 and veteranPlaytime and newQuestAvailable //and random(1) > .5
    {
        // Get new quest
        //randomize();
        QUEST_DATA[0] = scr_quest_selector(); //quest type
        QUEST_DATA[1] = scr_quest_criteria_selector(QUEST_DATA[0]); //criteria
        QUEST_DATA[2] = 0; //progress
        QUEST_DATA[3] = 1; //how long has it taken
        
        // Save quest data
        ini_write_real("misc", "QUEST_TYPE", QUEST_DATA[0]);
        ini_write_real("misc", "QUEST_CRITERIA", QUEST_DATA[1]);
        ini_write_real("misc", "QUEST_PROGRESS", QUEST_DATA[2]);
        ini_write_real("misc", "QUEST_DURATION", QUEST_DATA[3]);
    }
    //Else If Quest Incomplete, show Quest Text
    else if QUEST_DATA[0] != -1 {
        ini_write_real("misc", "QUEST_DURATION", ++QUEST_DATA[3]);
        //Update Criteria incase of rebalancing
        //QUEST_DATA[1] = scr_quest_criteria_selector(QUEST_DATA[0]); //criteria
        //To Do, you'd need to save the CTier as well.
        //And we can make the ctier system much better to make things less overwhelming for new users
    }

    
    //STAR_CASH = 100;
ini_close();

#define scr_reset_deflector_data
///scr_reset_deflector_data()

var size, key, data;
size = ds_map_size(DEFLECTOR_DATA)
key = ds_map_find_first(DEFLECTOR_DATA)
for (var i = 0; i < size ; i++){
    //Pull and Reset Deaths/Catches Data
    data = DEFLECTOR_DATA[? key];
    //Death Data
    data[@ 6] = 0; //this game
    data[@ 7] = 0//ini_read_real(currentSection, "careerDeaths-"+key, 0);; //running total
    //Catches Data
    data[@ 8] = 0; //this game
    data[@ 9] = 0//ini_read_real(currentSection, "careerCatches-"+key, 0);; //running total
    //Iterate to next key.
    key = ds_map_find_next(DEFLECTOR_DATA, key); 
}