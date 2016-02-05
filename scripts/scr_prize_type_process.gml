#define scr_prize_type_process
///scr_prize_type_process(slice_type)

prizeData = noone;


// Sort Indexes of Prizes
switch argument0 {

// Empty Slice
case 0: 
    var prize_buttons = noone;
    // Create Button Data
    prize_buttons = scr_prize_button_make(1);
    //Make Prize Data
    prizeData = scr_prompt_prize_create_data(s_v_frown_x2,2,
                    "try again!", "nothing", 0, argument0, 0, 0, "", prize_buttons);

break;

// Cash
case 1:
    // Calculate Cash Reward
    rewardValue = scr_cash_reward_create(1, false);
    prizeData = scr_prize_cash_create(rewardValue, "winner!", 3);

    
break;


// Features
case 2:
    var prizesRemaining = scr_check_if_unlocks_remaining("0,1,2,4", 25);
    var prize_tuple;
    // If Not, Only Draw from Features
    if prizesRemaining {
        prize_tuple = scr_prize_select_unlock_range("0,1,2,4", true, false); 
        //prize_tuple = scr_prize_select_unlock_range("0,1,2,3,4", true, true); 
    }
    //Else Include Skins in Drawing
    else {
        prize_tuple = scr_prize_select_unlock_range("0,1,2,3,4", true, false);
    }
    
    
    var unlock_data = prize_tuple[0];
    var prize_is_winner = prize_tuple[1];
    var prize_name = scr_unlock_get_name_long(unlock_data)
    var prize_desc = scr_button_explain_get_text_long(unlock_data[0], unlock_data[7])
    var prize_text, prize_noise, prize_buttons, prize_desc;
    prize_buttons = noone;
    
    
    // If Winner
    if prize_is_winner {
        prize_text = "winner!";
        prize_noise = 2;
        
        // Create Button Data
        prize_buttons = scr_prize_button_make(0);
    }
    // If Duplicate
    else{
        prize_text = "try again!";
        prize_noise = 0;
        
        // Create Button Data
        prize_buttons = scr_prize_button_make(1);
    }
    
    
    //Make Prize Data
    prizeData = scr_prompt_prize_create_data(s_v_options_x2,1,
                    prize_text, prize_name, prize_noise, argument0, unlock_data, 0, prize_desc, prize_buttons);
break;

// Themes
case 3: 

    var prize_tuple = scr_prize_select_unlock_range("3", false, false);
    
    var unlock_data = prize_tuple[0];
    var prize_is_winner = prize_tuple[1];
    var prize_name = scr_unlock_get_name_long(unlock_data);
    var prize_desc = scr_button_explain_get_text_long(unlock_data[0], unlock_data[7])
    var prize_text, prize_noise, prize_buttons;
    prize_buttons = noone;
    // If Winner
    if prize_is_winner {
        prize_text = "winner!";
        prize_noise = 2;
        
        prize_buttons = scr_prize_button_make(0);
    }
    // If Duplicate
    else{
        prize_text = "try again!";
        prize_noise = 0;
        
        // Create Button Data
        prize_buttons = scr_prize_button_make(1);
    }
    
    

    //Make Prize Data
    prizeData = scr_prompt_prize_create_data(s_v_themeswitcher_x2,4,
                    prize_text, prize_name, prize_noise, argument0, unlock_data, 0, prize_desc, prize_buttons);

    
break;

// Buffs
case 4: 
    
    // Select Buff (Chance Weighted Function)
    var mod_data = scr_prize_mod_select(0);
    var prize_name = string_replace_all(mod_data[6],"#", " ") +" buff";
    var prize_desc = scr_gamemod_make_prompt_description(mod_data);
    var prize_text, prize_noise, prize_buttons;
    prize_buttons = noone;
    prize_text = "winner!";
    prize_noise = 2;
    
    // Create Button Data
    prize_buttons = scr_prize_button_make(2);
    
    //Make Prize Data
    prizeData = scr_prompt_prize_create_data(s_v_smile_x2,1,prize_text, prize_name, prize_noise, 
                argument0, mod_data, 0, prize_desc, prize_buttons);
    
    
break;

// Debuffs 
case 5:

    // Select Buff (Chance Weighted Function)
    var mod_data = scr_prize_mod_select(1);
    var prize_name = string_replace_all(mod_data[6],"#", " ") +" debuff";
    var prize_desc = scr_gamemod_make_prompt_description(mod_data);
    var prize_text, prize_noise, prize_buttons;
    prize_buttons = noone;
    prize_text = "oh no!";
    prize_noise = 0;
    
    // Create Button Data
    prize_buttons = scr_prize_button_make(3);
    
    //Make Prize Data
    prizeData = scr_prompt_prize_create_data(s_v_frown_x2,2,prize_text, prize_name, prize_noise, 
                argument0, mod_data, 0, prize_desc, prize_buttons);

break;

// Success Prompt Type (used for buff doublers and the like)
case 6:
    break;

}

// Spawn Prize Prompt and Pass Prize Data
scr_prompt_prize_spawn(prizeData);





#define scr_prompt_prize_spawn
///scr_prompt_prize_spawn(newPrizeData)

newPrizeData = argument0;

promptID = instance_create(GAME_MID_X,GAME_MID_Y,obj_subprompt_prize)
with (promptID) {
    prizeData = other.newPrizeData;
    dataLoaded = true;
    prize_wheel_active = false;
    
    prizeFanfare = prizeData[4];
    
    // Play Try Again Sound
    if prizeFanfare == 0 {
        TweenAddCallback(mainTween,TWEEN_EV_FINISH,id, scr_sound,sd_bad_prize, 1, false)
    }
    // Play Cash Prize Sound
    else if prizeFanfare == 1{
        //TweenOnFinishAdd(mainTween,id, scr_sound,sd_cash_register, 1, false) //sd_catch_cash
        
        // Cash Prize Confetti
        scr_calculate_confetti(prizeData[6], id, 0);
    } 
    // Play New Unlock Sound
    else if prizeFanfare == 2 {
        TweenAddCallback(mainTween,TWEEN_EV_FINISH,id, scr_sound,sd_gameover_unlock, 1, false)
        
        // New Unlock Confetti
        scr_confetti_new_unlock(0);
    }
    // Play Great Success Sound 
    else if prizeFanfare == 3 {
        TweenAddCallback(mainTween,TWEEN_EV_FINISH,id, scr_sound,sd_great_success, 1, false);
        
        // New Unlock Confetti
        scr_confetti_new_unlock(0);
    }
}


return promptID;
     

#define scr_prompt_prize_create_data
///scr_prompt_prize_create_data(sprite, color, top_text, bottom_text, fanfare_type, prize_type, reward_data, extra, description, button_array) 

var data = noone;

data[0] = argument0 //sprite
data[1] = argument1; //color
data[2] = argument2 //top message
data[3] = argument3 //bottom message (name)
data[4] = argument4; // fanfare type (1 = cash, 2 = new unlock, 0 = try again) scr_check_and_save_unlocks_type
data[5] = argument5;  //prize type
data[6] = argument6;  //reward_data/value
data[7] = argument7;  //extra data
data[8] = argument8;  //long description
data[9] = argument9;  //button array


return data;


/*
var data = noone;
for (var i = 0, n = argument_count; i < n; i++) {
    data[i] = argument[i];
}

#define scr_prize_button_make
///scr_prize_button_make(group_id)

var group_id = argument0;
var prize_buttons = noone;
var i = -1;
switch group_id {
//button_label, button_sprite, function_id, [sub_type, prompt_text])
case 0:
    if TOUCH_ENABLED {
        prize_buttons[++i] = Array("share", spr_button_basic, 0);
    }
    break;

case 1:
    // If Ads Enabled
    if ads_video_is_cached() { 
        prize_buttons[++i] = Array("redo spin#for free", spr_button_basic_double, 1, 0, "redo this spin?");
    }
    if IAP_ENABLED or STAR_CASH >= 50 {
        prize_buttons[++i] = Array("redo spin#for "+CASH_STR+"50", spr_button_basic_double, 2, 0);
    }
    break;

case 2:
    
    // If Ads Enabled
    if ads_video_is_cached() { 
        prize_buttons[++i] = Array("double it#for free", spr_button_basic_double, 1, 1, "double this buff?");
    }
    if IAP_ENABLED or STAR_CASH >= 50 {
        prize_buttons[++i] = Array("double it#for "+CASH_STR+"50", spr_button_basic_double, 2, 1);
    }
    break;

case 3:
    
    // If Ads Enabled
    if ads_video_is_cached() { 
        prize_buttons[++i] = Array("remove#for free", spr_button_basic_double, 1, 2, "remove this debuff?");
    }
    if IAP_ENABLED or STAR_CASH >= 50 {
        prize_buttons[++i] = Array("remove#for "+CASH_STR+"50", spr_button_basic_double, 2, 2);
    }
    break;

}



return prize_buttons;

#define scr_prize_mod_select
///scr_prize_mod_select(type)

var mod_type = argument0;
var type_len = GAMEMOD_DATA_SIZES[# mod_type, 0];

//Set Weights of Types
var w = 0, wVals, wResult, wRNG, data;
for (var w = 0; w < type_len; w++) {
    // Get Mod Data
    data = scr_gamemod_get_data(mod_type, 0, w);
    // Set Chance       // Set Result
    wVals[w] = data[4];    wResult[w] = data;
}
//draw from hat
wRNG = random(1.0)
//scale probability
wRNG *= array_sum_1d(wVals) 
for( var w = 0; wRNG > wVals[w]; w++) wRNG -= wVals[w];

//Process Result
var mod_data = wResult[w];
// Set Count
mod_data[@ 8] = max(1, mod_data[@ 8]); //max rather than add +1, to prevent stacking
// Set Time
if mod_data[@ 9] <= 0 {
    mod_data[@ 9] = mod_data[3]; 
}
// Set Discovered
if mod_data[11] == 0{
    mod_data[@ 11] += 1;
}

// Get Key
var mod_key = scr_gamemod_get_key(mod_data[0]);
// Save Mod Data
ini_open("scores.ini");
    ini_write_real("GAMEMOD_DATA", mod_key+"-count", mod_data[8]);
    ini_write_real("GAMEMOD_DATA", mod_key+"-timer", mod_data[9]);
    ini_write_real("GAMEMOD_DATA", mod_key+"-discovered", mod_data[11]);
ini_close();

// Return Result
return mod_data;

#define scr_prize_select_unlock_range
///scr_prize_select_unlock_range(string_of_types, use_queue, use_duplicates)


var types = string_split_real(",",argument0);
var use_queue = argument1;
var use_duplicates = argument2;



var old_prize_count = 0;
var new_prize_count = 0;
var total_prize_count = 0;
var old_prizes, new_prizes;
old_prizes = ds_list_create();
if use_queue {
    new_prizes = ds_priority_create();
} else {
    new_prizes = ds_list_create();
}

prize_tuple = noone; //non temp var for scoping reasons


// For Each Type
var types_len, prefix, key;
types_len = array_length_1d(types);
for (var i = 0; i < types_len; i++){
    // For Each Unlock
    for (var j = 0; j < UNLOCKS_DATA_SIZES[types[i]]; j++ ){
        data = scr_unlock_get_data(types[i],j);
        // If Criteria is Prize Wheel
        if data[3] == 25 {
            // Increment Total Prize Count
            total_prize_count++;
            // If Old Prize
            if data[1] >= 2 {
                //Increment Old Prize Count
                old_prize_count++;
                // Add to Old Prize List
                ds_list_add(old_prizes, data);
            }
            // Else New Prize
            else {
                //Increment New Prize Count
                new_prize_count++;
                
                if use_queue {
                    // Add to New Prize PQueue
                    ds_priority_add(new_prizes, data, data[4]); //sorted by criteria data
                } else {
                    // Add to New Prize List 
                    ds_list_add(new_prizes, data); //sorted by criteria data
                    
                }
            
            }
        } 
    }
}

// Set Prize Chance (floor at 10%)
var newPrizeChance = max(.10, new_prize_count / total_prize_count)


// Select a New Prize
if new_prize_count > 0 and 
(!use_duplicates or random(1) < newPrizeChance) 
{

    if use_queue {
        // Select New Prize from PQueue
        data = ds_priority_delete_min(new_prizes);
    } else {
        // Select New Prize From List
        var rng_index = irandom(new_prize_count-1);
        data = new_prizes[| rng_index] //NB: Don't make data a var, we pass it in with
    }
    // Update Unlocks Data
    data[@ 1] = 2; // Flag as Unlocked
    data[@ 2] = 0; // Flag as Viewable
    
    
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
    
    
    // Add Index to Be Processed into Button Later
    with(obj_prompt_prize_wheel){
        ds_list_add(prizeList, other.data);
    }
    
    // Set Tupple Return Data
    prize_tuple[0] = data;
    prize_tuple[1] = 1; // enable sound effect
    
}
// Select Old Prize Instead
else {
    var rng_index = irandom(old_prize_count-1);
    data = old_prizes[| rng_index] //NB: Don't make data a var, we pass it in with
    
    
    key = scr_unlock_get_key(data[0],data[7]);
    keyType = string(data[0]);
    // Save Data
    ini_open("scores.ini");
        var tmp;
        // Get Repeat Count
        tmp = ini_read_real("UNLOCKS_DATA",key+"-repeats",0)
        // Increment and Save
        ini_write_real("UNLOCKS_DATA",key+"-repeats",++tmp)
        // Get Type Repeat Count
        tmp = ini_read_real("UNLOCKS_DATA",keyType+"-repeats",0)
        // Increment and Save
        ini_write_real("UNLOCKS_DATA",keyType+"-repeats",++tmp)
    ini_close();
    
    
        
    // Set Tupple Return Data
    prize_tuple[0] = data; 
    prize_tuple[1] = 0;
    
}


// Garbage Collection
ds_list_destroy(old_prizes);
if use_queue {
    ds_priority_destroy(new_prizes);
} else {
    ds_list_destroy(new_prizes);
}

return prize_tuple;

#define scr_unlock_types_get_repeats
////scr_unlock_types_get_repeats(type_string)


var types = string_split_real(",",argument0);
var total = 0;

// For Each Type
var types_len, prefix, key, keyType;
types_len = array_length_1d(types);
for (var i = 0; i < types_len; i++){
    keyType = string(types[i]);
    total += ini_read_real("UNLOCKS_DATA",keyType+"-repeats",0);
}

return total;

#define scr_check_if_unlocks_remaining
///scr_check_if_unlocks_remaining(string_of_types, criteria_type)

var types = string_split_real(",",argument0);
var criteria_type = argument1;
var stillPrizes = false;


// For Each Type
var types_len, data;
types_len = array_length_1d(types);
for (var i = 0; i < types_len; i++){
    // For Each Unlock
    for (var j = 0; j < UNLOCKS_DATA_SIZES[types[i]]; j++ ){
        data = scr_unlock_get_data(types[i],j);
        // If Criteria is Prize Wheel
        if data[3] == criteria_type {
            // If Unlocked
            if data[1] <= 0 {
                stillPrizes = true;
                break;
            }
        } 
    }
}



return stillPrizes;

#define scr_confetti_new_unlock
///scr_confetti_new_unlock(tex_page)

// Set Texture Page
scr_confetti_set_sprite(partConfetti_3, argument0);

var confettiCount, pCol, p_x, p_y;
confettiCount = 64;
p_x[0] = GAME_X;
p_x[1] = GAME_MID_X;
p_x[2] = GAME_X+GAME_W;
p_y = GAME_Y+GAME_H*.1;
for (var i = 0; i < confettiCount; i++) {
    pCol = irandom_range(0,5);
    //Left
    TweenAddCallback(mainTween,TWEEN_EV_FINISH,id,ParticlesCreateColor,
                        PSYS_SUBSTAR_LAYER,p_x[0],p_y,partConfetti_3,COLORS[pCol],4)
    //Middle 
    TweenAddCallback(mainTween,TWEEN_EV_FINISH,id,ParticlesCreateColor,
                        PSYS_SUBSTAR_LAYER,p_x[1],p_y,partConfetti_3,COLORS[pCol],4)
    //Right
    TweenAddCallback(mainTween,TWEEN_EV_FINISH,id,ParticlesCreateColor,
                        PSYS_SUBSTAR_LAYER,p_x[2],p_y,partConfetti_3,COLORS[pCol],4)
}