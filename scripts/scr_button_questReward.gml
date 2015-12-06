///scr_button_questReward()


analytics_button_counter("questReward");


var questDelayMinutes = scr_button_questClear(true);

// Calculate Reward, Set Cash and Execute Confetti
scr_button_reward_helper(13, 1)


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
