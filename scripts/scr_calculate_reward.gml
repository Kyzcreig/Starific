#define scr_calculate_reward
///scr_calculate_reward()


//Set Weights of Types
var w =0, wVals, wResult, wRNG;

// add weights
wVals[w] = 1.0;    wResult[w++] = 50; 
wVals[w] = .50;    wResult[w++] = irandom_range(50,75); 
wVals[w] = .25;    wResult[w++] = irandom_range(75,100); 
wVals[w] = .10;    wResult[w++] = irandom_range(100,250); 
wVals[w] = .05;    wResult[w++] = irandom_range(250, 500); 
wVals[w] = .01;    wResult[w++] = irandom_range(500,1000); 
wVals[w] = .005;    wResult[w++] = irandom_range(1000, 2000); 


//draw from hat
wRNG = random(1.0)
//scale probability
wRNG *= array_sum_1d(wVals) 
for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];

//Set Result
return wResult[w];


#define scr_calculate_confetti
///scr_calculate_confetti(rewardVal, promptID, texture_page)
//, promptID);
var 
rewardVal, 
confettiBombData, 
confettiBombFont,  
confettiBombCount,
confettiSoundCountMax,
confettiQuantum, 
confettiDelayDuration,
promptID, 
tex_page;

// Set Reward Value
rewardVal = argument[0];
promptID = argument[1];
tex_page = argument[2];


if !tex_page {
    confettiBombFont = fnt_menu_bn_60_bold//fnt_menu_bn_40_bold;
} else {
    confettiBombFont = fnt_game_bn_60_bold
}
confettiDelayDuration = .2; // default duration
confettiSoundCountMax = 4 / confettiDelayDuration //4 seconds of pops max


// Viable Confetti Bombs
var z = -1, j = -1, k = 5;
                            //cash size, confetti size, odds, min cash, max cash
confettiQuantum[++z] = Array(1, 32*1, 1, 0, 40);
confettiQuantum[++z] = Array(5, 32*2, 1, 0, 160);
confettiQuantum[++z] = Array(10, 32*3, 1, 0, 320);
confettiQuantum[++z] = Array(25, 32*4, 1, 50, 780); //
confettiQuantum[++z] = Array(50, 32*5, 1, 100, 1560); //
confettiQuantum[++z] = Array(100, 32*6, 1, 200, 3120); //
confettiQuantum[++z] = Array(250, 32*6, 1, 500, 7800); //NB: comes in handy if the click video multiplier hits a jackpot
confettiQuantum[++z] = Array(500, 32*6, 1, 1000, 15600); //NB: comes in handy if the click video multiplier hits a jackpot
confettiQuantum[++z] = Array(1000, 32*6, 1, 2500, 32000); //NB: comes in handy if the click video multiplier hits a jackpot




// Calculate Confetti Bombs
confettiBombCount = 0;
var CQ_count;
CQ_count = array_length_1d(confettiQuantum);
while ( rewardVal > 0 ) {

    //Set Weights of Types
    var w = -1, j = -1, wVals = noone, wResult, wRNG;
    // add weights
    repeat(CQ_count){
        ++j;
        // Get Confetti Data
        var confettiData = confettiQuantum[j];
        // Add Confetti Data to Chance List
        if confettiData[4] >= rewardVal and // under max threshold 
           confettiData[3] <=  rewardVal and // over min threshold 
           rewardVal >= confettiData[0] //enough remaining cash
        { 
            // Add Confetti to Chance Array
            ++w;     wVals[w] = confettiData[2];    wResult[w] = j; 
        }
    }
    // Draw from hat
    wRNG = random(1.0)
    //scale probability
    wRNG *= array_sum_1d(wVals) 
    for( var w = 0; wRNG > wVals[w]; w++) {wRNG -= wVals[w];}
    
    //Set Result
    var confettiData = confettiQuantum[wResult[w]];
    
        
    confettiBombData[0, confettiBombCount] = "+"+CASH_STR+string(confettiData[0]); //text
    confettiBombData[1, confettiBombCount] = confettiData[1] //size
    confettiBombData[2, confettiBombCount] = confettiData[0] //value
    rewardVal -= confettiData[0];
    confettiBombCount++;
}
// Set Time Quantum
if confettiBombCount > confettiSoundCountMax {
    //confettiBombCount = ceil(rewardVal / cashQuantums[z]);
    confettiDelayDuration = 4 / confettiBombCount;

}


//Create Confetti in random places
var rngX, rngY, tCol, dDur;
// First Explosion in center;
rngX = GAME_MID_X; 
rngY = GAME_MID_Y;
tCol = 0;
var promptDelay = .75;
for (var z = 0; z < confettiBombCount; z++) {
    dDur = promptDelay + confettiDelayDuration * z
    // Create Confetti Bomb
    ScheduleScript(promptID, 1, dDur, scr_create_confetti, rngX, rngY, confettiBombData[1,z], confettiBombData[1,z],tex_page);
    // Zoomup Cash Text
    ScheduleScript(promptID, 1, dDur, scr_popup_text_zoomup, rngX, rngY, confettiBombData[0,z], 
                                                COLORS[tCol], confettiBombFont, false, 3*room_speed); 
    // Update Prompt Cash Text
    ScheduleScript(promptID, 1, dDur, scr_prompt_cash_update, promptID,  confettiBombData[2,z]);
    
    
    
    // Play Cha-Ching Sound
    //ScheduleScript(id, true, confettiDelayDuration * z, scr_sound, sd_catch_cash, 1, false);
    //ScheduleScript(id, true, confettiDelayDuration * z, scr_sound_iff_only, sd_catch_cash, 1, false);
    
    //rngX = GAME_X + irandom_range(1, 9) * .1 * GAME_W;
    //rngY = GAME_Y + irandom_range(1, 9) * .1 * GAME_H;
    rngX = GAME_X + random_range(.1, .9) * GAME_W;
    rngY = GAME_Y + random_range(.1, .6) * GAME_H;
    tCol = 0///irandom_range(0,5);
}
//scr_sound(sd_cash_register, 1, false);

// Play Cha Ching Sound 
for (var s = 0; s < min(confettiSoundCountMax,confettiBombCount); s++) { 
    dDur = promptDelay + .2 * s;
    // Play Cha-Ching Sound
    ScheduleScript(promptID, 1, dDur, scr_sound, sd_catch_cash, 1, false);

}




#define scr_cash_reward_create
///scr_cash_reward_create(rewardScalar, rewardExecute)

var rewardScalar = argument0;
var rewardExecute = argument1;

// Calculate Reward
rewardValue = round(scr_calculate_reward() * rewardScalar);

    //.2 for sharing

// Save Cash
ini_open("scores.ini")
    STAR_CASH += rewardValue; //prompt_buttons[i,2];
    ini_write_real("misc", "STAR_CASH", STAR_CASH);
ini_close()  

// Create Reward Text Zoomup and Confetti
if rewardExecute {
    var prizeData = scr_prize_cash_create(rewardValue, "earned!", 0)
    scr_prompt_prize_spawn(prizeData);
}

return rewardValue;

#define scr_prize_cash_create
///scr_prize_cash_create(rewardValue, top_text, color, [sharing])

var rewardValue = argument[0];
var top_text = argument[1];
var col_index = argument[2];
var sharing = true;
if argument_count > 3 {
    sharing = argument[3];
}

var prize_buttons = noone;
if rewardValue >= 200 and sharing {
    // Create Button Data
    prize_buttons = scr_prize_button_make(0);
}
prizeData = scr_prompt_prize_create_data(s_v_cash_circle_x2,0,
                top_text, "+"+CASH_STR+string(0), 1, 1, rewardValue, 0, "", prize_buttons);
                
return prizeData;


#define scr_prompt_cash_update
///scr_prompt_cash_update(promptID, value)

var promptID = argument0;
with(promptID) {
    prizeData[@ 7] += argument1;
    prizeData[@ 3] = "+"+CASH_STR+string(prizeData[7]) //prize description
    
    //Maybe even ease it up? inside the step code, only for cash prizes.
    //we'd ease it up, using ceil or whatever.  or just 1 at a time like the score_display
}

#define scr_button_reward_helper
///scr_button_reward_helper(button_id, rewardScalar, [remove_button])

var buttonID = argument[0];
var rewardScalar = argument[1];
var removeButton = false;
if argument_count > 2 {
    removeButton = argument[2];
}

// Calculate Reward and Confetti
rewardValue = scr_cash_reward_create(rewardScalar, true);


// Check if enough cash for prize, and add prize wheel button
scr_refresh_prize_wheel_button();

//Update Button State/Text
scr_button_helper_update(buttonID, -2, "earned#+"+CASH_STR+string(rewardValue), removeButton);
/*
// Remove Button from List [disabled]
var rewardButtonIndex = scr_go_is_button(buttonID);
ds_list_delete( go_sp_buttons, rewardButtonIndex)
*/



#define scr_button_helper_update
///scr_button_helper_update(button_id, button_state, [button_text, remove_button])

var buttonID = argument[0];
var buttonState = argument[1];

// Update Button to indicate used
var buttonIndex = scr_go_is_button(buttonID);
var buttonData = go_sp_buttons[| buttonIndex]; 
// Set Button State
buttonData[@ 3] = buttonState; ///comment out for unlimited rewards 

//If New Button Text
if argument_count > 2 {
    if argument[2] != "" { // If button_text == "", we leave text unchanged
        buttonData[@ 1] = argument[2]; //"earned#+"+CASH_STR+string(rewardValue); 
    }
}
// If Remove Button
if argument_count > 3 {
    if argument[3] {
        // Schedule Button State to Ease Out/Remove
        ScheduleScript(id, true, .5, array_set_index_1d,buttonData, 3, -3);
        
    }
    // Reset Notifcation Bubble
    buttonData[@ 6] = 0 //count indicator
}