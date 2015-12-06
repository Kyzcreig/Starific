#define scr_check_and_save_unlocks
///scr_check_and_save_unlocks(is_gameover, is_relock)

var is_gameover = argument0;  //is this gameover?
var is_relock = argument1;  //will we relock unearned achievements?
    //NB: I could image a time when we make this conditional based on if you've played a new update or not, when we add new oontent.
    
    
/// Check all Achievements
scr_check_and_save_unlocks_type("5",is_gameover, is_relock);
/// Check Everything Else (Some Depend on Achievements)
scr_check_and_save_unlocks_type("0,1,2,3,4",is_gameover, is_relock);

/*
//NB:  Using our string type pattern to do the unlocks in any order we like e.g. achievements first = "5,0,1,2,3,4" might be useful later    
var size, key;
size = ds_map_size(UNLOCKS_DATA)
key = ds_map_find_first(UNLOCKS_DATA)
for (var i = 0; i < size ; i++){
    //Pull Data
    data = UNLOCKS_DATA[? key];
    
    scr_check_criteria(data,is_gameover,is_relock);
    
    
    //If Gameover (Not Pause Screen)
    if is_gameover{
        //Mark New Unlocks as Seen
        with (obj_control_gameover){
            //NB: We do this because stats are checked and saved even when you exit via pause screen.
            //if ds_list_size(go_sp_dialogues) <= dialogue_max_display{
            if other.data[1] == 1{
                other.data[@ 1] += 1; //data[1]==2 means we've seen the unlock on gameover
            } 
        }
    }
    
    //Save unlock
    ini_write_real("UNLOCKS_DATA",key+"-status",data[1])
    ini_write_real("UNLOCKS_DATA",key+"-views",data[2])
    
    //Iterate to next key.
    key = ds_map_find_next(UNLOCKS_DATA, key); 
}



/*
//Debug: Force Displays unlock text in spite of no unlocks
if is_gameover{
    with obj_control_gameover{
   
        if 1 {
            scr_go_queue_button(scr_unlock_get_data(0,2));
            scr_go_queue_button(scr_unlock_get_data(1,2));
            scr_go_queue_button(scr_unlock_get_data(2,2));
            scr_go_queue_button(scr_unlock_get_data(3,10));
        }
        if 0 {
            repeat(10) {
                //Add a test dialogue text object to list for display
                scr_gameover_add_dialogue( -1);
                unlock_count[0]++;
            }
        }
        
    }
}






#define scr_check_and_save_unlocks_type
///scr_check_and_save_unlocks_type(type_string,is_gameover, is_relock)


var types = string_split_real(",",argument0);
var is_gameover = argument1;  //is this gameover?
var is_relock = argument2;  //will we relock unearned achievements?

// For Each Type
var types_len, prefix, key, keyType;
types_len = array_length_1d(types);
for (var i = 0; i < types_len; i++){

    // For Each Unlock
    for (var j = 0; j < UNLOCKS_DATA_SIZES[types[i]]; j++ ){
        
        //Pull Data
        data = scr_unlock_get_data(types[i],j);
        
        scr_check_criteria(data,is_gameover,is_relock);
        
        
        //If Gameover (Not Pause Screen)
        if is_gameover{
            //Mark New Unlocks as Seen
            if data[1] == 1{
                  data[@ 1] += 1; //data[1]==2 means we've seen the unlock on gameover
            } 
            /*
            with (obj_control_gameover){
                //NB: We do this because stats are checked and saved even when you exit via pause screen.
                //if ds_list_size(go_sp_dialogues) <= dialogue_max_display{
                if other.data[1] == 1{
                    other.data[@ 1] += 1; //data[1]==2 means we've seen the unlock on gameover
                } 
            }*/
        }
        // Get Key
        key = scr_unlock_get_key(data[0],data[7]);
        //Save unlock
        ini_write_real("UNLOCKS_DATA",key+"-status",data[1]);
        ini_write_real("UNLOCKS_DATA",key+"-views",data[2]);
    }
}


#define scr_check_criteria
///scr_check_criteria(data, is_gameover?, is_relock?)

data = argument0;
var is_gameover = argument1;
var is_relock = argument2;

// Skip Certain Unlocks
if (data[1] >= 2 and !is_relock) or //skip unlocks if relock is off
    data[3] < 0 { //skip negative criteria_types
   exit;
}



//Check stat if unlocked or "unseen" yet
if compare_stats_to_criteria(data) {
    if data[1] < 2{
        //data[@ 1] = 1; // Mark as Unlocked (but not yet seen)
        data[@ 1] = 2; // Mark as Unlocked 
        data[@ 2] = max(data[2], 0); // Mark As Viewable
        
        //Set display in gameover
        if is_gameover and data[0] != 5{ //Presently Achievements do not show up on gameover
            with (obj_control_gameover){
                data = other.data;
                unlock_count[0]++;
                
                
                //Add appropriate dialogue text
                scr_gameover_add_dialogue( 4);
                // Add Appropriate buttons
                scr_go_queue_button(data);//longer time to allow tweens to happen
                            //NB: It might be better if we just call this stuf in the gameover area like we used to.
                            //One way to do that would be to change these parms to booleans and run standard durations
                            //then still call the theme changer in the gameover step code like we used to.
                            //but also pass in a true bool, in the buttonspawner prize wheel obj.
                            
                // Track Unlock Event
                analytics_send_unlock(data,gamesPlayedTotal)
                
            }
        }
    }
} 
//Else Mark as Locked
else if is_relock{
    data[@ 1] = 0;
    data[@ 2] = 0;
}