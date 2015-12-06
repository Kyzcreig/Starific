#define scr_unlocks_init
///scr_unlocks_init(method)
/* methods require file stream open
 * 0 = load unlocks as last saved
 * 1 = load unlocks as new user default
 * 2 = load unlocks then check criteria
 * 3 = unlock all
 */

globalvar UNLOCKS_DATA, UNLOCKS_DATA_SIZES;

UNLOCKS_DATA = ds_map_create();

//One Index for Each Unlock Type
UNLOCKS_DATA_SIZES[0] = 0 ; //grids
UNLOCKS_DATA_SIZES[1] = 0 ; //modes
UNLOCKS_DATA_SIZES[2] = 0 ; //rigors
UNLOCKS_DATA_SIZES[3] = 0 ; //themes
UNLOCKS_DATA_SIZES[4] = 0 ; //miscs
UNLOCKS_DATA_SIZES[5] = 0 ; //achieves


var method = argument0;
var load_as_new;
if method == 1 {
    load_as_new = true;
} else {
    load_as_new = false;
}


//Grids
scr_new_unlock(0, 3, load_as_new, -1, 0,  "small") 
scr_new_unlock(0, 0, load_as_new, 25, 1*2,  "medium")//1 
scr_new_unlock(0, 0, load_as_new, 25, 3*2,  "large")  //3
scr_new_unlock(0, 0, load_as_new, 25, 7*2,  "giant")  //7
//Modes
scr_new_unlock(1, 3, load_as_new, -1, 0,  "arcade") 
scr_new_unlock(1, 0, load_as_new, 25, 4*2,  "moves") //4 
scr_new_unlock(1, 0, load_as_new, 25, 6*2,  "time")  //6
scr_new_unlock(1, 0, load_as_new, 25, 9*2,  "sandbox") //9
//Rigors 
scr_new_unlock(2, 3, load_as_new, -1, 0,  "easy") //beginner
scr_new_unlock(2, 0, load_as_new, 25, 2*2,  "normal")  //amateur //2
scr_new_unlock(2, 0, load_as_new, 25, 5*2,  "hard")  //expert //5
scr_new_unlock(2, 0, load_as_new, 25, 8*2,  "chaos")  //master //8
//Misc
//scr_new_unlock(4, 0, load_as_new, 25, 8,  "song ticker")

//Themes
var i = -1
scr_new_unlock(3, 3, load_as_new, -1, 0,  mColors[SKIN_NAME_INDEX,++i])
scr_new_unlock(3, 0, load_as_new, 27, 0,  mColors[SKIN_NAME_INDEX,++i]) //cover entire board with paddle
scr_new_unlock(3, 0, load_as_new, 27, 1,  mColors[SKIN_NAME_INDEX,++i]) // control 4 paddles
scr_new_unlock(3, 0, load_as_new, 28, 100,  mColors[SKIN_NAME_INDEX,++i]) // lose a game with at most 100 points
scr_new_unlock(3, 0, load_as_new, 28, 1,  mColors[SKIN_NAME_INDEX,++i]) // lose a game with at most 1 points
scr_new_unlock(3, 0, load_as_new, 14, 1,  mColors[SKIN_NAME_INDEX,++i]) // share a highscore!
    //Iterate Rest of Skins in Pattern:
var criteria_type, criteria_quantity; 
var size_of_pattern = 5;
var quest_criteria_interval = 3; //5; // criteria is multiple of this
var theme_index = 3; 
        /* NB: We use this var as an offset on the index
            to keep the order from shuffling if we add other skins before these.
            We have 2 prize skins before the first quest skin.
        */
var theme_prize_index = 0;
while ( i < SKIN_COUNT-1 ) {
    questTheme = (theme_index mod size_of_pattern) == 0;
    // Repeat Pattern of Criteria Iteratively
    if questTheme {
        criteria_type = 24;
        criteria_quantity = (theme_index div size_of_pattern) * quest_criteria_interval; 
    }
    // Else Draw From Prize Wheel 
    else {
        criteria_type = 25;
        //criteria_quantity = theme_index + 9; 
        theme_prize_index ++;
        criteria_quantity = theme_prize_index 
    }
    scr_new_unlock(3, 0, load_as_new, criteria_type, criteria_quantity,  mColors[SKIN_NAME_INDEX,++i])
    //Increment Theme Criteria Pattern Index
    theme_index++;

}


//Achievements
var i = -1;
scr_new_unlock(5, 0, load_as_new, 27, ++i,  "coverage")
scr_new_unlock(5, 0, load_as_new, 27, ++i,  "multifaceted")
//NB: I do think "it's a secret" themes are a good idea.
//NB: an everyplay share achievement would be good, eventually.






//Method 2: Update Unlocks According to Stats   
if method == 2{
    scr_check_and_save_unlocks(0, 1);

}
//Method 3: unlock everything
else if method == 3{

    //Only Unlock Sizes/Modes/Rigors
    scr_unlocks_set_status_types("0,1,2");
    
    /*
    var size, key;
    size = ds_map_size(UNLOCKS_DATA)
    key = ds_map_find_first(UNLOCKS_DATA)
    //NB: Another way to do this might be by type.
    //Iterate over each key
    for (var i = 0; i < size ; i++){
        //Pull Data
        data = UNLOCKS_DATA[? key];
        
        //If Locked
        if data[1] == 0 {
            //Unlock it Temporarily
            data[@ 1] = -2; //negative means ignore it on gameover for derivative unlocks e.g. achievements
        }
        
        
        //Iterate to next key.
        key = ds_map_find_next(UNLOCKS_DATA, key); 
    }*/
}








    

#define scr_unlocks_set_status_types
///scr_unlocks_set_status_types(types_string)


var types = string_split_real(",",argument0);


// For Each Type
var types_len, data;
types_len = array_length_1d(types);
for (var i = 0; i < types_len; i++){
    // For Each Unlock
    for (var j = 0; j < UNLOCKS_DATA_SIZES[types[i]]; j++ ){
        data = scr_unlock_get_data(types[i],j);
        // Set Status to Temp Unlocked
        if data[1] == 0 {
            scr_unlock_set_status(data[0], data[7], -2, false);
            //negative means ignore it on gameover for derivative unlocks e.g. achievements
        }
    }
}