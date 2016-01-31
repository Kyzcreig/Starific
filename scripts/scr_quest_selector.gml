#define scr_quest_selector
///scr_quest_selector()
var cTier = scr_quest_tier();




//Select Quest Type

//Set Weights of Types
var w =0, wVals, wResult, wRNG;

// NB: we can tweak the probabilities later

// add weights
wVals[w] = 1;    wResult[w++] = 0; // games played
wVals[w] = 1;    wResult[w++] = 1; // reach score
//wVals[w] = .1;    wResult[w++] = 2; // reach combo 
    //NB: I found combo quest too hard to balance across settings/skill levels
wVals[w] = 1;    wResult[w++] = 3; // reach level
wVals[w] = 1;    wResult[w++] = 4; // deflectors destroyed
wVals[w] = 1;    wResult[w++] = 5; // bombs detonated
wVals[w] = 1;    wResult[w++] = 6; // powers triggered
wVals[w] = 1;    wResult[w++] = 7; // rebounded stars
wVals[w] = 1;    wResult[w++] = 8; // stars spawned
// Don't select these for first timer mission
if cTier >= 1 {
    // Check that mode is unlocked
    if scr_unlock_get_status(1,0) {
        wVals[w] = 1;    wResult[w++] = 9; // games played arcade
    }
    if scr_unlock_get_status(1,1) {
        wVals[w] = 1;    wResult[w++] = 10; // games played MOVES_LEFT
    }
    if scr_unlock_get_status(1,2) {
        wVals[w] = 1;    wResult[w++] = 11; // games played time
    }
    if scr_unlock_get_status(1,3) {
        wVals[w] = 1;    wResult[w++] = 12; // games played sandbox
    }
    if scr_unlock_get_status(0,0) {
        wVals[w] = 1;    wResult[w++] = 13; // games played 15x
    }
    if scr_unlock_get_status(0,1) {
        wVals[w] = 1;    wResult[w++] = 14; // games played 20x
    }
    if scr_unlock_get_status(0,2) {
        wVals[w] = 1;    wResult[w++] = 15; // games played 25x
    }
    if scr_unlock_get_status(0,3) {
        wVals[w] = 1;    wResult[w++] = 16; // games played 30x
    }
    wVals[w] = 1;    wResult[w++] = 17; // collect grow paddles
    wVals[w] = 1;    wResult[w++] = 18; // collect shrink paddles
    wVals[w] = 1;    wResult[w++] = 19; // collect slower stars
    wVals[w] = 1;    wResult[w++] = 20; // collect faster stars
    wVals[w] = 1;    wResult[w++] = 21; // collect mirror paddles
    wVals[w] = 1;    wResult[w++] = 22; // collect big stars
    wVals[w] = 1;    wResult[w++] = 23; // collect turn modifiers
    wVals[w] = .5;    wResult[w++] = 24; // collect freeze padles
    wVals[w] = .5;    wResult[w++] = 25; // collect split paddles
    wVals[w] = .5;    wResult[w++] = 26; // collect slow paddles
    wVals[w] = 1;    wResult[w++] = 27; // collect any powers
    wVals[w] = 1;    wResult[w++] = 28; // collect board clears
    wVals[w] = 1;    wResult[w++] = 29; // collect board fills
    wVals[w] = 1;    wResult[w++] = 30; // collect uppers
    wVals[w] = 1;    wResult[w++] = 31; // collect downers
    //wVals[w] = .5;    wResult[w++] = 32; // collect rounders
}
wVals[w] = 1;    wResult[w++] = 33; // playtime


//draw from hat
wRNG = random(1.0)
//scale probability
wRNG *= array_sum_1d(wVals) 
for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];

//Set Result
return wResult[w];




#define scr_quest_criteria_selector
///scr_quest_criteria_selector(quest_type)

var cTier = scr_quest_tier();


//Select Quest Criteria
switch argument0 {
    
    //Games played
    case 0:
        
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 3;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 4; 
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 5; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 7; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];

    break;
    
    
    //Reach Score
    case 1:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        /*
        wVals[w] = 1;      wResult[w++] = 100*1000;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 500*1000;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 1000*1000; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 2.5*1000*1000; 
        }*/
        wVals[w] = 1;      wResult[w++] = 10*1000;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 50*1000;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 100*1000; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 250*1000; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    
    
    //Reach Combo 
    case 2:
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 50;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 100;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 150; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 200; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
         
    break;
    
    
    //Reach level
    case 3:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 30;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 40;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 50; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 60; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    
    //Deflectors Destroyed
    case 4:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 2500;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 5000;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 10000; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 20000; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    
    //Bombs Destroyed
    case 5:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 250;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 500;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 750; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 1000; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    
    //Triggered Powers
    case 6:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 500;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 1000;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 2000; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 5000; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    
    
    //Rebound Stars
    case 7:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 300;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 400;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 500; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 600; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    
    //Unique Stars Seen/Spawned
    case 8:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 100;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 250;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 500; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 1000; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    
    //GamesPlayed Arcade [unused]
    case 9:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 3;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 4; 
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 5; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 7; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w]; 
    break;
         
    //GamesPlayed Moves
    case 10:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 3;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 4; 
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 5; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 7; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w]; 
    break;
         
    //GamesPlayed Time
    case 11:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 3;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 4; 
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 5; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 7; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];  
    break;
         
    //GamesPlayed Sandbox [unused]
    case 12:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 3;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 4; 
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 5; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 7; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w]; 
    break;
    
    //GamesPlayed Size 15x15
    case 13:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 3;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 4; 
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 5; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 7; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w]; 
    break;
         
    //GamesPlayed Size 20x20
    case 14:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 3;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 4; 
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 5; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 7; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w]; 
    break;
         
    //GamesPlayed Size 25x25 [unused] 
    case 15:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 3;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 4; 
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 5; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 7; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w]; 
    break;
         
    //GamesPlayed Size 30x30
    case 16:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 3;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 4; 
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 5; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 7; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w]; 
    break;
    
    //Collect Grow Paddles
    case 17:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 20;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 25;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 30; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 35; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w]; 
    break;
    //Collect Shrink Paddles
    case 18:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 20;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 25;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 30; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 35; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    //Collect Slower Stars
    case 19:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 20;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 25;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 30; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 35; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    //Collect Faster Stars
    case 20:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 20;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 25;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 30; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 35; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    //Collect Mirror Paddles
    case 21:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 4;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 5;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 6; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 7; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    //Collect Big Stars
    case 22:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 8;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 10;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 12; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 15; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    //Collect Turn Changers
    case 23:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 8;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 10;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 12; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 15; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    //Collect Freeze Paddles
    case 24:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 1;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 2;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 3; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 4; 
        }
        
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    //Collect Split Paddles
    case 25:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 1;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 2;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 3; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 4; 
        }
        
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    //Collect Slow Paddles
    case 26:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 1;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 2;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 3; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 4; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
         
    //Collect (Any) Powers
    case 27:
    
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 250;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 500;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 750; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 1000; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    
    //Collect Board Clears
    case 28:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 1;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 2;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 3; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 4; 
        }
        
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    //Collect Board Fills
    case 29:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        

        
        // add weights
        wVals[w] = 1;      wResult[w++] = 1;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 2;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 3; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 4; 
        }
        
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    
    
    //Collect Uppers
    case 30:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 100;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 250;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 500; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 750; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    
    //Collect Downers
    case 31:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 100;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 250;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 500; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 750; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
         
    break;
    //Collect Rounders
    case 32:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 50;
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 75;
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 100; 
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 150; 
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    
    
    //Deflectors Destroyed
    case 33:
    
        //Set Weights of Types
        var w =0, wVals, wResult, wRNG;
        
        // add weights
        wVals[w] = 1;      wResult[w++] = 6*60*room_speed* RMSPD_DELTA; //minutes ->60 fps steps
        if cTier >= 1 {
            wVals[w] = .5;    wResult[w++] = 8*60*room_speed* RMSPD_DELTA; //minutes ->60 fps steps
        }
        if cTier >= 2 {
            wVals[w] = .25;    wResult[w++] = 10*60*room_speed* RMSPD_DELTA; //minutes ->60 fps steps
        }
        if cTier >= 3 {
            wVals[w] = .05;    wResult[w++] = 12*60*room_speed* RMSPD_DELTA; //minutes ->60 fps steps
        }
        
        //draw from hat
        wRNG = random(1.0)
        //scale probability
        wRNG *= array_sum_1d(wVals) 
        for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];
        
        //Set Result
        return wResult[w];
    break;
    
    //Not Implemented   
    default:
        return 0;
    break;
    
    
    
    










}

#define scr_quest_tier
///scr_quest_tier()
var cTier = 0;
//Set criteria tier
if gamesPlayedTotal > 60 {
    cTier = 4;
}
else if gamesPlayedTotal > 45 {
    cTier = 3;
}
else if gamesPlayedTotal > 30 {
    cTier = 2;
}
else if gamesPlayedTotal > 15 {
    cTier = 1;
}


return cTier;