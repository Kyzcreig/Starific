#define scr_gamemods_init
///scr_gamemods_init()


globalvar 
GAMEMOD_DATA, 
GAMEMOD_DATA_SIZES, 
GAMEMOD_DATA_KEYS;

GAMEMOD_DATA = ds_map_create();
GAMEMOD_DATA_KEYS = ds_map_create(); //layer of abstraction in case we ever refactor mod names
GAMEMOD_DATA_SIZES = ds_grid_create(3,2); //counts for each type, subtype
ds_grid_clear(GAMEMOD_DATA_SIZES,0);
/* Types:
        0 = upper
        1 = downer
        2 = rounder
   Subtypes:
        0 = basic
        1 = iap
*/


ini_open("scores.ini");
    //NB: Keep this order for stat page reasons
    
    // mod_name, mod_type, sub_type, duration (seconds), mod_chance, mod_symbol, mod_icon_text, mod_description, enabled
    var base_dur = 60*60;
    
                    
    // BUFF MODS
        //Basic
    scr_new_gamemod("double_coins", 0, 0, base_dur, 1.0, spr_cash_x2, 
                    "double#coins", "coins are worth double", 2, true); 
    scr_new_gamemod("double_points", 0, 0, base_dur, 1.0, spr_power_pmulti, 
                    "double#points", "earn points 2x as fast", 2, true); 
    scr_new_gamemod("binary_stars", 0, 0, base_dur, 1.0, spr_power_multistar, 
                    "binary#stars", "spawn 2x as many stars", 2, true); 
    scr_new_gamemod("extra_coins", 0, 0, base_dur/2, 1.0, spr_cash_plus,
                    "extra#coins", "+500% more coins spawn", 5, true); 
    scr_new_gamemod("extra_bombs", 0, 0, base_dur, 1.0, spr_power_extra_bombs,
                    "extra#bombs", "+10% bombs", 1.10, true); 
    scr_new_gamemod("extra_powers", 0, 0, base_dur, 1.0, spr_power_longerpowerups,
                    "extra#powers", "+10% uppers, downers, and rounders", 1.10, true); 
    scr_new_gamemod("extra_density", 0, 0, base_dur, 1.0, spr_power_density_doubler,
                    "extra#density", "+5% board deflectors", 1.05, true);
    scr_new_gamemod("ultra_points", 0, 0, base_dur, 1.0, spr_power_oneup,
                    "ultra#points", "+400% more points from destroying deflectors", 4, true); 
    scr_new_gamemod("auto_didact", 0, 0, base_dur, 1.0, spr_power_learn,
                    "auto#didact", "level up twice as fast", 2, true); 
    scr_new_gamemod("downer_exile", 0, 0, base_dur, 1.0, spr_power_clear,
                    "downer#exile", "no duration downers on board", 0, true); 
    scr_new_gamemod("downer_immunity", 0, 0, base_dur, 1.0, spr_power_immunity,
                    "downer#immunity", "50% chance that downers have no effect", .5, true);
    scr_new_gamemod("double_duration", 0, 0, base_dur, 1.0, spr_power_duration,
                    "double#duration", "double duration on uppers, downers and rounders", 2, true);  
    scr_new_gamemod("coin_catcher", 0, 0, base_dur, 1.0, spr_power_cash,
                    "coin#catcher", "automatically collect coins", 0, true); 
    scr_new_gamemod("upper_catcher", 0, 0, base_dur, 1.0, spr_power_longerpowerups,
                    "upper#catcher", "automatically activate uppers", 0, true); 
    scr_new_gamemod("star_division", 0, 0, base_dur/2, 1.0, spr_power_staregg,
                    "star#division", "stars have a random chance to split in two", 1/50, true); 
    scr_new_gamemod("pulsar_stars", 0, 0, base_dur, 1.0, spr_power_hugestar,
                    "pulsar#stars", "stars have a random chance to grow large", 1/25, true); 
    scr_new_gamemod("extra_life", 0, 0, base_dur, 1.0, spr_power_oneup,
                    "extra#life", "an extra life, moves or max time", 0, true); 
    scr_new_gamemod("money_bombs", 0, 0, base_dur, 1.0, spr_power_cash_bomb,
                    "money#bombs", "coins are also bombs", 0, true); 
                   
        //TO IMPLEMENT
        // DISABLED
        
        
    // DEBUFF MODS
        //Basic
    scr_new_gamemod("no_coins", 1, 0, base_dur*2, 1.0, spr_cash_minus, 
                    "no#coins", "coins are worth nothing", 0, true);
    scr_new_gamemod("no_points", 1, 0, base_dur, 1.0, spr_power_onedown, 
                    "no#points", "no points", 0, true);
    scr_new_gamemod("half_coins", 1, 0, base_dur*4, 1.0, spr_cash_div, 
                    "half#coins", "coins are worth half as much", .5, true);
    scr_new_gamemod("half_points", 1, 0, base_dur*2, 1.0, spr_power_pdivis, 
                    "half#points", "earn points half as fast", .5, true);
    scr_new_gamemod("lacka_daisical", 1, 0, base_dur*2, 1.0, spr_power_learn, 
                    "lacka#daisical", "level up half as fast", .5, true);
    scr_new_gamemod("upper_exile", 1, 0, base_dur*2, 1.0, spr_power_clear,
                    "upper#exile", "no duration uppers on board", 0, true); 
    scr_new_gamemod("upper_immunity", 1, 0, base_dur*4, 1.0, spr_power_immunity,
                    "upper#immunity", "50% chance that uppers have no effect", .5, true);
    scr_new_gamemod("half_duration", 1, 0, base_dur*2, 1.0, spr_power_duration,
                    "half#duration", "half duration on uppers, downers and rounders", .5, true); 
    scr_new_gamemod("downer_catcher", 1, 0, base_dur, 1.0, spr_power_shorterpowerdowns,
                    "downer#catcher", "automatically activate downers", 0, true);
    scr_new_gamemod("fickle_stars", 1, 0, base_dur*2, 1.0, spr_power_randomangle,
                    "fickle#stars", "stars have a random chance to turn any direction", 1/25, true); 
    scr_new_gamemod("long_effects", 1, 0, base_dur*4, 1.0, spr_power_duration,
                    "long#effects", "extra long particle effects", 1.5, true);
    scr_new_gamemod("twinkle_effects", 1, 0, base_dur*2, 1.0, spr_power_twinkle,
                    "twinkle#effects", "stars and paddles flicker", Array(.2,.8), true); 
    scr_new_gamemod("mystery_powers", 1, 0, base_dur*2, 1.0, spr_power_mystery,
                    "mystery#powers", "all power deflectors are a mystery", 0, true); 
    scr_new_gamemod("hidden_icons", 1, 0, base_dur*2, 1.0, spr_power_hidden,
                    "hidden#icons", "all deflector icons are hidden", 0, true); 
        
        //TO IMPLEMENT
        //DISABLED

ini_close();

#define scr_gamemod_step_decrement
///scr_gamemod_step_decrement()

var types = Array(0,1,2)
var sub_types = Array(0);
var enabled_only = true;
var types_len, sub_types_len, index_len;
var mod_data, mod_key;

types_len = array_length_1d(types);
sub_types_len = array_length_1d(sub_types);
// For Each Type
for (var i = 0; i < types_len; i++){
    // For Each SubType
    for (var j = 0; j < sub_types_len; j++ ){
        index_len = GAMEMOD_DATA_SIZES[# types[i], sub_types[j]];
        // For Each Index
        for (var k = 0; k < index_len; k++ ){
            mod_data = scr_gamemod_get_data(types[i], sub_types[j], k);
            // If Enabled_Only Flagged but Not Enabled
            if enabled_only and mod_data[12] == false{
                // Continue
                continue
            }
            // If Active Count
            else if mod_data[8] > 0 {
                // Decrement
                mod_data[@ 9] -= 1*RMSPD_DELTA 
                
                // If time runs out
                if mod_data[9] <= 0 {
                    // Decrement Count
                    mod_data[@ 8] -= 1;
                    // If Count Remaining
                    if mod_data[8] > 0 {
                        // Reset Timer to Max Dur
                        mod_data[@ 9] = mod_data[3];
                    } 
                    // Else Process Deactivation of Gamemod 
                    else {
                        // Look Up Mod Name
                        switch mod_data[0] {
                            case "extra_coins": 
                                // Reset Coin Spawn Percentage
                                scr_spawner_chance_init("deflector_types");                                
                                break;
                        
                            case "extra_bombs": 
                                // Reset Bomb Spawn Percentage
                                scr_spawner_chance_init("deflector_types"); 
                                scr_spawner_chance_init("special_types");   
                                                             
                                break;
                            case "extra_powers": 
                                // Reset Power Spawn Percentage
                                scr_spawner_chance_init("deflector_types");
                                scr_spawner_chance_init("special_types");                                
                                break;
                            case "downer_exile": 
                                scr_spawner_chance_init("special_types"); 
                                scr_spawner_chance_init("duration");                                 
                                break;
                            case "upper_exile": 
                                scr_spawner_chance_init("special_types");  
                                scr_spawner_chance_init("duration");                                
                                break;
                        
                            case "extra_density":
                                // Rescale Field Density
                                fieldDensity /= scr_gamemod_get_index("extra_density", 10);
                                break;
                                
                            case "long_effects":
                                // Reset Long Effects
                                with (obj_control_game){
                                    scr_part_types_set();
                                    scr_part_systems_set_depth();                    
                                    scr_part_types_adjust_for_game();
                                }
                                with (obj_star) {
                                    scr_part_star_set(particleStarTrail);
                                }
                                break;
                                
                            case "mystery_powers":
                                // Reset Aesthetics
                                scr_reset_aesthetics();
                                break;
                                
                            case "hidden_icons":
                                // Reset Aesthetics
                                scr_reset_aesthetics();
                                break;
                        }
                    
                    }
                }
            }
        } 
    }
}










