///scr_button_questClear(bool)


//Clear Quest Data
QUEST_DATA[0] = -1;
QUEST_DATA[1] = 1;
QUEST_DATA[2] = 0;
QUEST_DATA[3] = 0;

var questCompleted = argument0;

//Update Quest Data
ini_open("scores.ini")
    if questCompleted {
        ini_write_real("misc", "QUEST_COUNT", ++QUEST_DATA[4]); 
    }
    questDelayMinutes = 0; 
    questNextTime =  date_inc_minute(date_current_datetime(), questDelayMinutes)
    ini_write_real("misc", "QUEST_NEXT_TIME", 
       questNextTime); 
    // Save quest data
    ini_write_real("misc", "QUEST_TYPE", QUEST_DATA[0]);
    ini_write_real("misc", "QUEST_CRITERIA", QUEST_DATA[1]);
    ini_write_real("misc", "QUEST_PROGRESS", QUEST_DATA[2]);
    ini_write_real("misc", "QUEST_DURATION", QUEST_DATA[3]);
ini_close()  

return questDelayMinutes;
