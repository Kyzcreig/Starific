#define scr_button_prizeWheel
///scr_button_prizeWheel()


analytics_button_counter("prizeWheelPrompt");

// If Prize Wheel Available
if scr_prize_wheel_spin_available() {
    // Revalidate Prize Wheel Button
    ScheduleScript(obj_control_gameover, false, 3, scr_validate_prize_wheel_button);
    
    // Create Prize Wheel
    var prizeWheelObj = instance_create(x,y,obj_prompt_prize_wheel);
    var prizeList = prizeWheelObj.prizeList;
    
    // Schedule Processing of Unlock Index List
    ScheduleScript(id, false, 2, scr_prize_wheel_process_prizes, prizeList);
    
}
// Else Go to Shop PAge 
else if IAP_ENABLED{
    // Refresh Prize Wheel Button
    ScheduleScript(obj_control_gameover, false, 3, scr_refresh_prize_wheel_button);
    
    //Spawn Quick Settings Room Changer
    scr_options_goto(Array(obj_settings_shop, false));
    

}


#define scr_prize_wheel_process_prizes
//scr_prize_wheel_process_prizes(prizeList)


with (obj_control_gameover){ 
    //NB: This is done so we can test prize wheel from main menuvar prizeList = argument0;
    var prizeList = argument0;
    // Process Unlocked Indexes
    for (var i = 0, n = ds_list_size(prizeList); i < n; i++) {
        // Add Appropriate buttons
        scr_go_queue_button(prizeList[| i]);
    }
}

ds_list_destroy(argument0);