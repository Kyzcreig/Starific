#define scr_button_questCancel
///scr_button_questCancel()


analytics_button_counter("questCancel", scr_get_quest_data_string());
    //We Send data about quest cancel to help identify problem quests

var questDelayMinutes = scr_button_questClear(false);


// Update Quest Text with Strikethrough
if questDelayMinutes > 0 {
    // Replaces Dialogue with "Next Quest in X" time
    ScheduleScript(id, 0, 5, scr_go_replace_dialogue, 1, 8);
} else {
    // Replaces Dialogue with Strikethrough styling
    ScheduleScript(id, 0, 5, scr_go_set_style_dialogue, 1, 1);
}


//Update Button State/Text
scr_button_helper_update(17, -1, "quest#reset")

#define scr_get_quest_data_string
///scr_get_quest_data_string()


return "QUEST_TYPE,"+string(QUEST_DATA[0])+
       "QUEST_CRITERIA,"+string(QUEST_DATA[1])+ 
       "QUEST_PROGRESS,"+string(QUEST_DATA[2])+ 
       "QUEST_DURATION,"+string(QUEST_DATA[3]);
#define scr_quest_cancel
///scr_quest_cancel()

//if enough cash
if STAR_CASH >= 25 {
    //Cancel Quest
    analytics_button_counter("questCancelConfirm", scr_get_quest_data_string());
        //We Send data about quest cancel to help identify problem quests
    
    var questDelayMinutes = scr_button_questClear(false);
                        
    //Decrement Cash
    STAR_CASH -= 25;
    
    // Play Buy Sound
    scr_sound(sd_coin_bag);
    
}
//IF not enough cash
else {
    //add jiggle to "NO" button 
    prompt_jiggle[0,0] += 1*room_speed;
    //play not enough cash sound
    scr_sound(sd_not_enough_cash);
}
                