#define scr_refresh_prize_wheel_button
///scr_refresh_prize_wheel_button()


// Check if enough cash for prize 
if scr_veteran_playtime_status(0) {
    if scr_prize_wheel_spin_available() {
        var buttonIndex = scr_go_is_button(15);  
        // Add Prize button
        if  buttonIndex == -1{
            // If not, add to list 
            scr_gameover_add_button(15);
        }
        // Else Enable Prize Button
        else{
            var buttonData = go_sp_buttons[| buttonIndex]; 
            buttonData[@ 1] = "win#prize" 
            buttonData[@ 3] = 0; //reenables button if it was disabled
            buttonData[@ 6] = 1; //reenables button if it was disabled
            // Replace With Fresh Button
            //scr_go_replace_button(15,15);
                //NB: We don't replace it because we want to keep the same x/y.
                    //I guess one way to do that would be to cache the x/y then replace and set x/y
        }
    } else {
        // Adaptive: Give Adverts if Not Enough for Prize
        scr_gameover_buttons_add_adverts(false);
    }

    // Get prize dialogue index
    var prizeTextIndex = scr_go_is_dialogue(3); 
    if prizeTextIndex != -1{
        var prizeTextData = go_dialogue_txt[| prizeTextIndex];
        prizeTextData[@ 0] =  CASH_STR+string(min(STAR_CASH,PRIZE_WHEEL_COST))+"/"+string(PRIZE_WHEEL_COST) 
                                + " to go for prize" 
        // If complete, strike it through;
        if STAR_CASH >= PRIZE_WHEEL_COST {
            prizeTextData[@ 1] =  1;
        } else {
            prizeTextData[@ 1] =  0;
        }
    }
}

#define scr_validate_prize_wheel_button
///scr_validate_prize_wheel_button()

// Check if enough cash for prize 
if !scr_prize_wheel_spin_available()  {    
    // Update Button to indicate Used
    var buttonIndex = scr_go_is_button(15);
    var buttonData = go_sp_buttons[| buttonIndex]; 
    //Change Button Text
    buttonData[@ 1] = "out of#spins"; 
    
    // Disable or Remove Button
    if IAP_ENABLED { //NB: Comment out these buttonData[3] lines for unlimited use
        buttonData[@ 3] = -1; //Leaves button up after use, but it takes you to shop page
    } else {
        buttonData[@ 3] = -3;//Removes Button after use 
    }
    // Reset Indicator
    buttonData[@ 6] = 0;
    
    // Adaptive: We Give Adverts if Not Enough for Prize
    scr_gameover_buttons_add_adverts(false);

}
// Get prize dialogue index
var prizeTextIndex = scr_go_is_dialogue(3); 
if prizeTextIndex != -1{
    var prizeTextData = go_dialogue_txt[| prizeTextIndex];
    prizeTextData[@ 0] =  CASH_STR+string(min(STAR_CASH,PRIZE_WHEEL_COST))+"/"+string(PRIZE_WHEEL_COST) 
                            + " to go for prize" 
    // If complete, strike it through;
    if STAR_CASH >= PRIZE_WHEEL_COST {
        prizeTextData[@ 1] =  1;
    }
}

#define scr_prize_wheel_spin_available
///scr_prize_wheel_spin_available()

return STAR_CASH >= PRIZE_WHEEL_COST;

#define scr_veteran_playtime_status
///scr_veteran_playtime_status(lastPlaytime)

return careerPlaytimeTotal+argument0 > 60 * 60 * 1.0 //and gamesPlayedTotal > 3//2.5;
