#define scr_game_data_init
///scr_game_data_init()



globalvar TUTORIAL_ENABLED, GRID, MODE, RIGOR, STAR_CASH;
globalvar MODES, RIGORS, GRIDS;
globalvar QUEST_DATA, EASY_SPINS, QUICK_PAGE_CONTROLLER;//, QUEST_COUNT;

// Init Enumerations
scr_game_data_init_enums()

//Debugging new scores ini
//file_delete("scores.ini"); show_message("stats deleted") //DISABLE ME
    //You can also use method 1 on the unlocks init if you just want to test that
    
// Debugging New File
//file_delete("scores.ini"); //NB: we use the method 1 on load data instead of this
    
// Fix for Android Null Leaderboards
if os_type == os_android {
    // Check if Fix has Run
    var fixFlagFile = working_directory + "/android_null_score_fix.txt"
    if !file_exists(fixFlagFile)  {
        // Check for Cache File
        var cacheFile = "playerachievementcache.dat";
        if file_exists(cacheFile) {
            // Delete Cache
            file_delete(cacheFile);
        }
        // Create Flag File
        var fhand = file_text_open_write(fixFlagFile);
        file_text_close(fhand); 
    }
    /* NB: After they  patch in a fix for this we can remove this code.
    
    */
}

ini_open("scores.ini")

    //SETTINGS
    MODE = 0;
    GRID = 0; 
    RIGOR = 0;
    STAR_CASH = ini_read_real("misc", "STAR_CASH", 100); //start users off with 100;
    TUTORIAL_ENABLED = 0;//ini_read_real("misc", "TUTORIAL_ENABLED", 0);
    QUICK_PAGE_CONTROLLER = noone; //used in quick settings room switcher
    
    
    //Quest Stuff
    QUEST_DATA[0] = ini_read_real("misc", "QUEST_TYPE", -1);
    QUEST_DATA[1] = ini_read_real("misc", "QUEST_CRITERIA", 1);
    QUEST_DATA[2] = ini_read_real("misc", "QUEST_PROGRESS", 0);
    QUEST_DATA[3] = ini_read_real("misc", "QUEST_DURATION", 0);
    QUEST_DATA[4] = ini_read_real("misc", "QUEST_COUNT", 0);
    

    
    //Read in unlocks
    var unlock_method = 2 
    scr_unlocks_init(unlock_method)
    /* methods require file stream open
     * 0 = load unlocks as last saved
     * 1 = load unlocks as new user default
     * 2 = load unlocks then check criteria
     * 3 = unlock all
     */
    /* NB: I use method 2 because it keeps all the stats straight 
        even if they're temporarily unlocked.
           
    */
    
    
    //Global Var to Guarantee Easy Spins
    EASY_SPINS = false; //true
    //NB: You can manually modify the runner save file for specific unlockables 
    
ini_close();

    

#define scr_game_data_init_enums
///scr_game_data_init_enums()



enum MODES {

ARCADE = 0,
MOVES,
TIME,
SANDBOX

}
enum GRIDS {

SMALL = 0,
MEDIUM,
LARGE,
GIANT

}
enum RIGORS {

EASY = 0,
MEDIUM,
HARD,
INSANE

}