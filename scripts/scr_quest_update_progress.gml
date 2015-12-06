///scr_quest_update_progress()

     
//Add Quest Dialogues and/or Reward Button
if QUEST_DATA[0] != -1 {
     // Update Quest Progress
     QUEST_DATA[2] += scr_quest_progress() ; 
     //QUEST_DATA[2] +=  QUEST_DATA[1]; //for debugging 
     
     
     // Save quest progress
     ini_write_real("misc", "QUEST_TYPE", QUEST_DATA[0]);
     ini_write_real("misc", "QUEST_CRITERIA", QUEST_DATA[1]);
     ini_write_real("misc", "QUEST_PROGRESS", QUEST_DATA[2]);
     ini_write_real("misc", "QUEST_DURATION", QUEST_DATA[3]);
}
     
