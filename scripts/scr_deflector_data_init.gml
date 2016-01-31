///scr_deflector_data_init()



globalvar 
DEFLECTOR_DATA, 
DEFLECTOR_DATA_SIZES, 
DEFLECTOR_DATA_KEYS, 
DEFLECTOR_PARENTS
DEFLECTOR_DISCOVERED,
DEFLECTOR_DISCOVERED_COUNT;
DEFLECTOR_DATA = ds_map_create();
DEFLECTOR_DATA_KEYS = ds_map_create(); //layer of abstraction in case we ever refactor object names
                                        //so we can keep stats
DEFLECTOR_DISCOVERED = false;
DEFLECTOR_DATA_SIZES = ds_grid_create(6,5); //counts for each type, subtype
ds_grid_clear(DEFLECTOR_DATA_SIZES,0);
/* Types:
        0 = basic
        1 = upper
        2 = downer
        3 = rounder
        4 = bomb
        5 = parent
   Subtypes:
        0 = instant effect
        1 = duration
        2 = special duration
        3 = tapper duration
        4 = misc
*/


ini_open("scores.ini");
    //NB: Keep this order for stat page reasons
    // object_index, obj_type, sub_type, power_array, spr_symbol, text_description, enabled (used here: scr_deflector_get_list)
    
    //Bssic Deflectors
    scr_new_deflector(obj_reflector_basic, 0, 0, noone, noone, "turn#either", 1);
    scr_new_deflector(obj_reflector_cwise, 0, 0, noone, noone, "turn#right", 1);
    scr_new_deflector(obj_reflector_ccwise, 0, 0, noone, noone, "turn#left", 1);
    //Bomb Deflectors
    scr_new_deflector(obj_powerup_bomb_line, 4, 0, noone, spr_bomb_hvline, "line", 1);
    scr_new_deflector(obj_powerup_bomb_rangle, 4, 0, noone, spr_bomb_Lbomb, "l-line", 1);
    scr_new_deflector(obj_powerup_bomb_diagonal, 4, 0, noone, spr_bomb_diagline, "diagonal", 1);
    scr_new_deflector(obj_powerup_bomb_t, 4, 0, noone, spr_bomb_Tbomb, "t-line", 1);
    scr_new_deflector(obj_powerup_bomb_v, 4, 0, noone, spr_bomb_Vbomb, "v-line", 1);
    scr_new_deflector(obj_powerup_bomb_x, 4, 0, noone, spr_bomb_Xbomb, "x-line", 1);
    scr_new_deflector(obj_powerup_bomb_checkers, 4, 0, noone,spr_bomb_checkers, "checkers", 1);
    scr_new_deflector(obj_powerup_bomb_circle, 4, 0, noone, spr_bomb_circle, "circle", 1);
    
    //Upper Powers
        //No Timers
    scr_new_deflector(obj_powerup_boardclear,1, 0, noone, spr_power_boardclear,"super#nova", 1);
    scr_new_deflector(obj_powerup_boardfill,1, 0, noone, spr_power_boardfill,"nova", 1);
    scr_new_deflector(obj_powerup_bigstar,1, 0, noone, spr_power_hugestar,"super#stars", 1);
    scr_new_deflector(obj_powerup_2balls,1, 0, noone, spr_power_doublestar,"double#star", 1);
    scr_new_deflector(obj_powerup_3balls,1, 0, noone, spr_power_triplestar,"triple#star", 1);
    scr_new_deflector(obj_powerup_4balls,1, 0, noone, spr_power_quadstar,"quad#star", 1);
    scr_new_deflector(obj_powerup_powerdownsclear,1, 0, noone, spr_power_clear,"clear#downers", 1); 
    scr_new_deflector(obj_powerup_staregg, 1, 0, noone, spr_power_staregg,"extra#staregg", 1); 
    scr_new_deflector(obj_powerup_bomb_detonate,1, 0, noone, spr_power_bomb_detonate,"detonate#bombs", 1); 
    scr_new_deflector(obj_powerup_1up,1, 0, noone, spr_power_oneup,"one up", 0);//suvival#bonus //DISABLED
    
    
        //Timers
    scr_new_deflector(obj_powerup_growpaddle,1, 1, POWER_grow, spr_power_grow,"grow#paddle", 1);
    scr_new_deflector(obj_powerup_slower,1, 1, POWER_slower, spr_power_slower,"slower#stars", 1);
    scr_new_deflector(obj_powerup_mirrorpaddle,1, 1, POWER_mirror, spr_power_mirror,"mirror#paddle", 1);
    scr_new_deflector(obj_powerup_points,1, 1, POWER_pmulti, spr_power_pmulti,"more#points", 1);
    scr_new_deflector(obj_powerup_density_doubler,1, 1, POWER_density_doubler, spr_power_density_doubler,"double#density", 1);
    
        //Tappers
    scr_new_deflector(obj_powerup_multistar,1, 3, POWER_multistar, spr_power_multistar,"multi#star", 1);
    scr_new_deflector(obj_powerup_addgrow,1, 3, POWER_addgrow, spr_power_addgrow,"multi#grow", 1);
    scr_new_deflector(obj_powerup_addslower,1, 3, POWER_addslower, spr_power_addslower,"multi#slower", 1);
    scr_new_deflector(obj_powerup_longerpowerups,1, 3, POWER_longerpowerups, spr_power_longerpowerups,"longer#uppers", 1);
    scr_new_deflector(obj_powerup_shorterpowerdowns,1, 3, POWER_shorterpowerdowns, spr_power_shorterpowerdowns,"shorter#downers", 1);
    scr_new_deflector(obj_powerup_multibonus,1, 3, POWER_multibonus, spr_power_multibonus,"extra#combos", 1);
    scr_new_deflector(obj_powerup_multidensity,1, 3, POWER_multidensity, spr_power_multidensity,"multi#density", 1);
    
    
    //Downers
        //No Timers
    scr_new_deflector(obj_powerup_powerupsclear,2, 0, noone, spr_power_clear,"clear#uppers", 1); 
    scr_new_deflector(obj_powerup_1down,2, 0, noone, spr_power_onedown,"one down", 0);//suvival#malus //DISABLED
        //Timers
    scr_new_deflector(obj_powerup_shrinkpaddle,2, 1, POWER_shrink, spr_power_shrink,"shrink#paddle", 1);
    scr_new_deflector(obj_powerup_faster,2, 1, POWER_faster, spr_power_faster,"faster#stars", 1);
    scr_new_deflector(obj_powerup_antipoints,2, 1, POWER_pdivis, spr_power_pdivis,"less#points", 1);
    scr_new_deflector(obj_powerup_offsetpaddle,2, 1, POWER_offsetpaddle, spr_power_offsetpaddle,"offset#paddle", 1);
        //Turn Modifiers
    scr_new_deflector(obj_powerup_halfangleturn,2, 2, POWER_halfangle , spr_power_45angle,"small#turns", 1);
    scr_new_deflector(obj_powerup_threehalvesangle,2, 2,POWER_threehalfangle , spr_power_135angle,"big#turns", 1);
    scr_new_deflector(obj_powerup_reverseturn,2, 2, POWER_reverseangle, spr_power_180angle,"reverse#turns", 1);
    scr_new_deflector(obj_powerup_pierce,2, 2, POWER_noangle, spr_power_0angle,"no#turns", 1);
    scr_new_deflector(obj_powerup_randomturn,2, 2, POWER_randomangle, spr_power_randomangle,"random#turns", 1);
    scr_new_deflector(obj_powerup_diagturn,2, 2, POWER_diagturn, spr_power_diagonalangle,"diagonal#turns", 1);
        //Tappers
    scr_new_deflector(obj_powerup_freezepaddle,2, 3, POWER_freeze, spr_power_freeze,"frozen#paddle", 1);
    scr_new_deflector(obj_powerup_slowpaddle,2, 3, POWER_slowpaddle, spr_power_slowpaddle,"slow#paddle", 1);
    scr_new_deflector(obj_powerup_subshrink,2, 3, POWER_subshrink, spr_power_subshrink,"multi#ahrink", 1);
    scr_new_deflector(obj_powerup_subfaster,2, 3, POWER_subfaster, spr_power_subfaster,"multi#faster", 1);
    scr_new_deflector(obj_powerup_invertpaddle,2, 3, POWER_invertcontrols, spr_power_invertpaddle,"inverted#paddle", 0);
    scr_new_deflector(obj_powerup_multimalus,2, 3, POWER_multimalus, spr_power_multimalus,"no#combos", 1);
    scr_new_deflector(obj_powerup_splitpaddle,2, 3, POWER_splitpaddle, spr_power_splitpaddle,"split#paddle", 1);
    
    //Rounders
        //No Timers
    scr_new_deflector(obj_powerup_cash_1,3, 0, noone, spr_cash_1,"+"+CASH_STR+"1", 1);
    scr_new_deflector(obj_powerup_cash_2,3, 0, noone, spr_cash_2,"+"+CASH_STR+"2", 1);
    scr_new_deflector(obj_powerup_cash_5,3, 0, noone, spr_cash_5,"+"+CASH_STR+"5", 1);
    scr_new_deflector(obj_powerup_cash_10,3, 0, noone, spr_cash_10,"+"+CASH_STR+"10", 1);
    scr_new_deflector(obj_powerup_cash_rng,3, 0, noone, spr_cash_1,"+"+CASH_STR+"1-15", 0);
    scr_new_deflector(obj_powerup_powersallclear,3, 0, noone, spr_power_clear,"clear#powers", 1);
        //Timers
    scr_new_deflector(obj_powerup_cash_x2,3, 1, POWER_cashx2, spr_cash_x2,"cash#doubler", 1);
        //Misc
    scr_new_deflector(obj_powerup_mystery, 3, 2, noone, spr_power_mystery,"random", 0);
        //Tappers
    scr_new_deflector(obj_powerup_cash_tap,3, 3, POWER_cashtap, spr_power_cash,"tap for#cash", 1);
    

    
    //Parents 
    scr_new_deflector(obj_reflector_parent, 5, 0, noone, noone,"deflector#parent", 1);
    scr_new_deflector(obj_reflector_parent_basic, 5, 0, noone, noone,"basic#parent", 1);
    scr_new_deflector(obj_reflector_special_parent, 5, 0, noone, noone,"special#parent", 1);
    scr_new_deflector(obj_powerup_parent_bomb, 5, 0, noone, noone,"bomb#parent", 1);
    scr_new_deflector(obj_powerup_projectile_parent, 5, 0, noone, noone,"projectile#parent", 1);
    scr_new_deflector(obj_powerup_parent_ups, 5, 0, noone, noone,"upper#parent", 1);
    scr_new_deflector(obj_powerup_parent_downs, 5, 0, noone, noone,"downer#parent", 1);
    scr_new_deflector(obj_powerup_parent_neutral, 5, 0, noone, noone,"rounder#parent", 1);
    scr_new_deflector(obj_powerup_parent_cash, 5, 0, noone, noone,"cash#parent", 1);

    
    var i = -1;
    DEFLECTOR_PARENTS = ds_list_create();
    ds_list_add(DEFLECTOR_PARENTS,obj_reflector_parent);
    ds_list_add(DEFLECTOR_PARENTS,obj_reflector_parent_basic);
    ds_list_add(DEFLECTOR_PARENTS,obj_reflector_special_parent);
    ds_list_add(DEFLECTOR_PARENTS,obj_powerup_parent_bomb);
    ds_list_add(DEFLECTOR_PARENTS,obj_powerup_projectile_parent);
    ds_list_add(DEFLECTOR_PARENTS,obj_powerup_parent_ups);
    ds_list_add(DEFLECTOR_PARENTS,obj_powerup_parent_downs);
    ds_list_add(DEFLECTOR_PARENTS,obj_powerup_parent_neutral);
    ds_list_add(DEFLECTOR_PARENTS,obj_powerup_parent_cash);


ini_close();
