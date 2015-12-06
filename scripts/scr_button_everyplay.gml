#define scr_button_everyplay
///scr_button_everyplay()


analytics_button_counter("everyplayPrompt");

// Get Button Data
var buttonIndex = scr_go_is_button(21);
var buttonData = go_sp_buttons[| buttonIndex]; 


// Spawn Prompt
ep_prompt = instance_create(x,y,obj_prompt_everyplay);
ep_prompt.enable_share_reward = buttonData[7];
ep_prompt.parent_button_data = buttonData;
/* 
with (ep_prompt) {
    enable_share_reward = true;
    share_flag_data = other
}*/


// Schedule Helper
ScheduleScript(id, false, 5, scr_button_everyplay_helper, 21);



#define scr_button_everyplay_helper
///scr_button_everyplay_helper(button_index)

// Get Button Data
var buttonIndex = scr_go_is_button(argument0);
var buttonData = go_sp_buttons[| buttonIndex]; 


if everyplay_is_recording() {
    // Flash Icon
    buttonData[@ 3] = 1;
}
else {
    // No Flash 
    buttonData[@ 3] = 0;
}


// Check if enough cash for prize, and Add Prize wheel button
scr_check_if_available_prize_wheel();