///scr_check_if_available_prize_wheel()


// Check if enough cash for prize 
if STAR_CASH >= PRIZE_WHEEL_COST { 
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
        // Replace With Fresh Button
        //scr_go_replace_button(15,15);
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
