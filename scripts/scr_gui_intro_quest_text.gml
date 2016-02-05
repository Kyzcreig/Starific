///scr_gui_intro_quest_text()


// Set Quest Text    
if QUEST_DATA[3] > 0 and QUEST_DATA[2] < QUEST_DATA[1] {
    quest_text_cache = "Quest: " + scr_quest_text(0, scr_quest_progress());
    //New Quest?
    if QUEST_DATA[3] == 1 {
        quest_text_cache = "New " + quest_text_cache;
        // If First Quest 
        if QUEST_DATA[4] < 1 { //and QUEST_DATA[3] == 1
            //Mention that they can be cancelled
            quest_text_cache += "##" + "Quests can be cancelled from the pause menu.";
        }
    }
} else {
    quest_text_cache = "";
}

return quest_text_cache;
