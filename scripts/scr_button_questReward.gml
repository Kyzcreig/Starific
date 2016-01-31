#define scr_button_questReward
///scr_button_questReward()


analytics_button_counter("questReward");

// Process Quest Completition
var questDelayMinutes = scr_button_questClear(true);

// Give Quest Reward
scr_quest_give_reward(QUEST_DATA[4], 13, true);



// Update Quest Text with Next Quest Time
if questDelayMinutes > 0{
    ScheduleScript(id, 0, 5, scr_go_replace_dialogue, 2, 8);
}

// Add Reward Earned Text To Dialogue
/*
scr_gameover_add_dialogue(  5);        
var TxtLen = ds_list_size(go_dialogue_txt)/2 +.5;
go_TweenSlideText = TweenFire(id, go_SlideTweenText,false,EaseLinear,go_SlideTweenText[0],
                    TxtLen, room_speed * .5 );


// Remove Button from List [disabled]
var rewardButtonIndex = scr_go_is_button(13);
ds_list_delete( go_sp_buttons, rewardButtonIndex)
*/

#define scr_quest_give_reward
///scr_quest_give_reward(quests_complete, button_id, remove_button)

var quests_complete = argument0;
var button_id = argument1;
var remove_button = argument2;
var cash_reward = true;


// Get Next Quest Reward
reward_data = scr_quest_select_reward("0,1,2,3,4", 24, quests_complete, true);

// If Reward Data Found
if is_array(reward_data) {
    // Process Reward into Button Afterwards
    var prizeList = ds_list_create();
    ds_list_add(prizeList, reward_data);
    ScheduleScript(id, false, 5, scr_prize_wheel_process_prizes, prizeList);
    
    // Set Prize Prompt
    var prizeData, prizeText, prizeName, prizeNoise, prizeButton;
    prizeText = "good job!"; //kudos! //winner!
    prizeName = scr_unlock_get_name_long(reward_data);
    prizeNoise = 2; //unlock noise
    prizeDesc = scr_button_explain_get_text_long(reward_data[0], reward_data[7])
    // Create Buttons Data
    prizeButton = scr_prize_button_make(0);
    // Create PrizePrompt Data
    prizeData = scr_prompt_prize_create_data(s_v_options_x2,4,prizeText, prizeName, 
                    prizeNoise, 2, reward_data, 0, prizeDesc, prizeButton);
    // Create Prize Prompt
    scr_prompt_prize_spawn(prizeData)
  
    // Schedule ClaimPrize Button to be Removed
    ScheduleScript(id, false, 2, scr_button_helper_update, 
                button_id, -2, "", remove_button);
}
// Else Give Cash Reward
else {
    // Calculate Reward, Set Cash and Execute Confetti
    scr_button_reward_helper(13, 1, remove_button); 
}







#define scr_quest_select_reward
///scr_quest_select_reward(string_of_types, criteria_type, criteria_value, exact_criteria)


var types = string_split_real(",",argument0);
var criteria_type = argument1;
var criteria_value = argument2;
var exact_criteria = argument3;



// For Each Type
var types_len, prefix, key;
types_len = array_length_1d(types);
for (var i = 0; i < types_len; i++){
    // For Each Unlock
    for (var j = 0; j < UNLOCKS_DATA_SIZES[types[i]]; j++ ){
        data = scr_unlock_get_data(types[i],j);
        // If Criteria is Prize Wheel
        if (exact_criteria and data[3] == criteria_type) or 
           (!exact_criteria and data[3] >= criteria_type) 
        {
            // If Exact Criteria
            if data[4] == criteria_value {
                // If Still Locked
                if data[1] < 2 {
                    // Update Unlocks Data
                    data[@ 1] = 2; // Flag as Unlocked
                    data[@ 2] = 0; // Flag as Viewable
                    
                    // Get Key
                    key = scr_unlock_get_key(data[0],data[7]);
                    // Save Data
                    ini_open("scores.ini");
                        // Save Views/Status
                        ini_write_real("UNLOCKS_DATA",key+"-status",data[1])
                        ini_write_real("UNLOCKS_DATA",key+"-views",data[2])
                        // Get Gamesplay In Case We're Doing Wheel Outside Game Room
                        if room != rm_game { 
                            gamesPlayedTotal = ini_read_real_MS_total("0,1,2,3","0,1,2,3", false,"gamesPlayed",0) 
                        }
                    ini_close();
                    
                    // Track Unlock Event
                    analytics_send_unlock(data,gamesPlayedTotal)
                    
                    // Return Data; Break
                    return data;
                }
            
            }
        } 
    }
}

return noone;