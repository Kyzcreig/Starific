///scr_check_if_unavailable_prize_wheel()


// Check if enough cash for prize 
if STAR_CASH < PRIZE_WHEEL_COST {    
    // Update Button to indicate Used
    var buttonIndex = scr_go_is_button(15);
    var buttonData = go_sp_buttons[| buttonIndex]; 
    buttonData[@ 1] = "out of#spins"; 
    buttonData[@ 3] = -1; ///comment out for unlimited rewards 
    
    // Adaptive: Give Adverts if Not Enough for Prize
    scr_gameover_buttons_add_adverts(false);

}
// Get prize dialogue index
var prizeTextIndex = scr_go_is_dialogue(3); 
if prizeTextIndex != -1{
    var prizeTextData = go_dialogue_txt[| prizeTextIndex];
    prizeTextData[@ 0] =  "$"+string(min(STAR_CASH,PRIZE_WHEEL_COST))+"/"+string(PRIZE_WHEEL_COST) 
                            + " to go for prize" 
    // If complete, strike it through;
    if STAR_CASH >= PRIZE_WHEEL_COST {
        prizeTextData[@ 1] =  1;
    }
}
