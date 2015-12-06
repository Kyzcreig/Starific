#define scr_prize_type_process
///scr_prize_type_process(slice_type)

prizeData = noone;


// Sort Indexes of Prizes
switch argument0 {

// Empty Slice
case 0: 
    prizeData = scr_prompt_prize_create_data(s_v_frown_x2,2,
                    "try again!", "nothing", 0, argument0, 0, 0, "");

break;

// Cash
case 1:
    // Calculate Cash Reward
    rewardValue = scr_reward_set(1, false);
    
    prizeData = scr_prompt_prize_create_data(s_v_cash_circle_x2,3,
                    "winner!", "+$"+string(0), 1, argument0, rewardValue, 0, "");

    
break;


// Features
case 2:
    var prizesRemaining = scr_check_if_prizes_remaining("0,1,2,4");
    var prize_tuple;
    // If Not, Only Draw from Features
    if prizesRemaining {
        prize_tuple = scr_prize_select_unlock_range("0,1,2,4", true);
        //prize_tuple = scr_prize_select_unlock_range("0,1,2,3,4", true); 
            //EVALUATE ME: It seems people don't like that this gives themes, oh well
            // We can add the perks here to fill it out I think. 
    }
    //Else Include Skins in Drawing
    else {
        prize_tuple = scr_prize_select_unlock_range("0,1,2,3,4", true)//false)
    }
    
    
    var data = prize_tuple[0];
    var prize_noise = prize_tuple[1] * 2;
    var prize_name = scr_unlock_get_name_long(data)
    var prize_text;
    if prize_tuple[1] {
        prize_text = "winner!";
    }else{
        prize_text = "try again!";
    }
    
    //TO DO prize_description = ""
    
    prizeData = scr_prompt_prize_create_data(s_v_options_x2,1,
                    prize_text, prize_name, prize_noise, argument0, data, 0, "");
break;

// Themes
case 3: 

    var prize_tuple = scr_prize_select_unlock_range("3", false);
    
    var data = prize_tuple[0];
    var prize_noise = prize_tuple[1] * 2;
    var prize_name = scr_unlock_get_name_long(data)
    var prize_text;
    if prize_tuple[1] {
        prize_text = "winner!";
    }else{
        prize_text = "try again!";
    }

    prizeData = scr_prompt_prize_create_data(s_v_themeswitcher_x2,4,
                    prize_text, prize_name, prize_noise, argument0, data, 0, "");

    
break;


}

// Spawn Prize Prompt and Pass Prize Data
scr_prompt_prize_spawn(prizeData);





#define scr_prompt_prize_spawn
///scr_prompt_prize_spawn(prizeData)

prizeData = argument0;

promptID = instance_create(GAME_MID_X,GAME_MID_Y,obj_subprompt_prize)
with (promptID) {
    prizeData = other.prizeData;
    dataLoaded = true;
    prize_wheel_active = false;
    
    
    // Play Try Again Sound
    if prizeData[4] == 0 {
        TweenAddCallback(mainTween,TWEEN_EV_FINISH,id, scr_sound,sd_bad_prize, 1, false)
    }
    // Play Cash Prize Sound
    else if prizeData[4] == 1{
        //TweenOnFinishAdd(mainTween,id, scr_sound,sd_cash_register, 1, false) //sd_catch_cash
        
        // Cash Prize Confetti
        scr_calculate_confetti(prizeData[6], id, 0);
    } 
    // Play New Unlock Sound
    else if prizeData[4] == 2 {
        TweenAddCallback(mainTween,TWEEN_EV_FINISH,id, scr_sound,sd_gameover_unlock, 1, false)
        
        // New Unlock Confetti
        scr_confetti_new_unlock(0);
    }
}
     

#define scr_prize_select_unlock_range
///scr_prize_select_unlock_range(string_of_types, use_queue)


var types = string_split_real(",",argument0);
var use_queue = argument1;



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
if new_prize_count > 0 and random(1) < newPrizeChance {

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
    with(obj_prize_button_spawner){
        ds_list_add(indexList, other.data);
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

#define scr_check_if_prizes_remaining
///scr_check_if_prizes_remaining(string_of_types)

var types = string_split_real(",",argument0);
var stillPrizes = false;


// For Each Type
var types_len, data;
types_len = array_length_1d(types);
for (var i = 0; i < types_len; i++){
    // For Each Unlock
    for (var j = 0; j < UNLOCKS_DATA_SIZES[types[i]]; j++ ){
        data = scr_unlock_get_data(types[i],j);
        // If Criteria is Prize Wheel
        if data[3] == 25 {
            // If Unlocked
            if data[1] <= 0 {
                stillPrizes = true;
                break;
            }
        } 
    }
}



return stillPrizes;

#define scr_slice_data_create
///scr_slice_data_create(slice_type)

var sliceData = noone;
    
switch argument0 {

// Empty Slice
case 0: 
    sliceData[0] = s_v_frown//sprite
    sliceData[1] = 2//color
break;

// Cash
case 1: 
    sliceData[0] = s_v_cash_circle//sprite
    sliceData[1] = 3//color
break;


// Features
case 2: 
    sliceData[0] = s_v_options//sprite
    sliceData[1] = 1//color
break;

// Themes
case 3: 
    sliceData[0] = s_v_themeswitcher//sprite
    sliceData[1] = 4//color
break;


}
    // Other Slice Data
    sliceData[2] = argument0//slice type
    sliceData[3] = instance_create(x,y,obj_prize_knob)//slice knob
    with (sliceData[3] ) {
        prizeWheel = other.id;
        flapper = other.flapper;
    }


return sliceData;

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

#define scr_prompt_prize_create_data
///scr_prompt_prize_create_data(sprite, color, top_text, bottom_text, noise, type, value, extra, extra) 

var prizeData = noone;

prizeData[0] = argument0//sprite
prizeData[1] = argument1; //color
prizeData[2] = argument2 //top message
prizeData[3] = argument3 //prize description
prizeData[4] = argument4; //prize noise type
prizeData[5] = argument5;  //prize type
prizeData[6] = argument6;  //prize value
prizeData[7] = argument7;  //extra data
prizeData[8] = argument8;  //long description


return prizeData;


/*
var prizeData = noone;
for (var i = 0, n = argument_count; i < n; i++) {
    prizeData[i] = argument[i];
}

#define scr_prize_flapper_collision
///scr_prize_flapper_collision()


//var inst = collision_point(x,y, flapper,true, true);
var inst = collision_circle(x,y, 2.5 * RMSPD_DELTA, flapper,true,true);

return inst;