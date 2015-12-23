#define scr_powers_data_init
////scr_powers_data_init()

globalvar  
POWER_ARRAY,
POWER_grow,
POWER_shrink, 
POWER_faster, 
POWER_slower,  
POWER_pmulti,
POWER_pdivis, 
POWER_mirror, 
POWER_freeze,
POWER_hugestar,
POWER_halfangle,
POWER_threehalfangle,
POWER_randomangle, 
POWER_reverseangle,
POWER_noangle,
POWER_diagturn,
POWER_slowpaddle,
POWER_multistar,
POWER_addgrow,
POWER_subshrink,
POWER_addslower,
POWER_subfaster,
POWER_longerpowerups,
POWER_shorterpowerdowns,
POWER_invertcontrols,
POWER_multibonus,
POWER_multimalus,
POWER_splitpaddle,
POWER_cashtap,
POWER_offsetpaddle,
POWER_cashx2,
POWER_density_doubler;


POWER_ARRAY = noone; //init var, so we can make it an array later
POWER_grow[0] = 0;
POWER_shrink[0] = 0;
POWER_faster[0] = 0;
POWER_slower[0] = 0;
POWER_pmulti[0] = 0;
POWER_pdivis[0] = 0;
POWER_mirror[0] = 0;
POWER_freeze[0] = 0;
POWER_hugestar[0] = 0;
POWER_halfangle[0] = 0;
POWER_threehalfangle[0] = 0;
POWER_randomangle[0] = 0;
POWER_reverseangle[0] = 0;
POWER_noangle[0] = 0;
POWER_diagturn[0] = 0;
POWER_slowpaddle[0] = 0;
POWER_multistar[0] = 0;
POWER_addgrow[0] = 0;
POWER_subshrink[0] = 0;
POWER_addslower[0] = 0;
POWER_subfaster[0] = 0;
POWER_longerpowerups[0] = 0;
POWER_shorterpowerdowns[0] = 0;
POWER_invertcontrols[0] = 0;
POWER_multibonus[0] = 0;
POWER_multimalus[0] = 0;
POWER_splitpaddle[0] = 0;
POWER_cashtap[0] = 0;
POWER_offsetpaddle[0] = 0;
POWER_cashx2[0] = 0;
POWER_density_doubler[0] = 0;




#define scr_powers_data_set
///scr_powers_data_set()


var i = -1;
//NB: Keep set in this order or the indexes for the jiggle icons will be off.


//Count    //Timer List     //Dur      //objIndex    ///Tapper Text      //Misc Value   // Jiggle Index
scr_new_power(POWER_grow,ds_list_create(), 0, obj_powerup_growpaddle, "",1,++i) 
scr_new_power(POWER_shrink,ds_list_create(), 0, obj_powerup_shrinkpaddle, "",1,++i) 
scr_new_power(POWER_faster,ds_list_create(), 0, obj_powerup_faster, "",1,++i) 
scr_new_power(POWER_slower,ds_list_create(), 0, obj_powerup_slower, "",1,++i) 
scr_new_power(POWER_pmulti,ds_list_create(), 0, obj_powerup_points, "",1,++i) 
scr_new_power(POWER_pdivis,ds_list_create(), 0, obj_powerup_antipoints, "",1,++i) 
scr_new_power(POWER_mirror,ds_list_create(), 0, obj_powerup_mirrorpaddle, "",-1,++i)  //NB: Misc value=-1
scr_new_power(POWER_freeze,ds_list_create(), 0, obj_powerup_freezepaddle, "tap to unfreeze#paddle",1,++i) 
scr_new_power(POWER_hugestar,ds_list_create(), 0, obj_powerup_bigstar, "",1,++i) 
scr_new_power(POWER_halfangle,ds_list_create(), 0, obj_powerup_halfangleturn, "",1,++i) 
scr_new_power(POWER_threehalfangle,ds_list_create(), 0, obj_powerup_threehalvesangle, "",1,++i) 
scr_new_power(POWER_randomangle,ds_list_create(), 0, obj_powerup_randomturn, "",1,++i) 
scr_new_power(POWER_reverseangle,ds_list_create(), 0, obj_powerup_reverseturn, "",1,++i) 
scr_new_power(POWER_noangle,ds_list_create(), 0, obj_powerup_pierce, "",1,++i) 
scr_new_power(POWER_diagturn,ds_list_create(), 0, obj_powerup_diagturn, "",1,++i) 
scr_new_power(POWER_slowpaddle,ds_list_create(), 0, obj_powerup_slowpaddle, "tap to unslow#paddle",1,++i) 
scr_new_power(POWER_multistar,ds_list_create(), 0, obj_powerup_multistar, "tap for#extra stars",1,++i) 
scr_new_power(POWER_addgrow,ds_list_create(), 0, obj_powerup_addgrow, "tap to grow#paddle",1,++i) 
scr_new_power(POWER_subshrink,ds_list_create(), 0, obj_powerup_subshrink, "tap to unshrink#paddle",1,++i) 
scr_new_power(POWER_addslower,ds_list_create(), 0, obj_powerup_addslower, "tap to slow#stars",1,++i) 
scr_new_power(POWER_subfaster,ds_list_create(), 0, obj_powerup_subfaster, "tap to unspeed#stars",1,++i) 
scr_new_power(POWER_longerpowerups,ds_list_create(), 0, obj_powerup_longerpowerups, "tap to make#uppers longer",1,++i) 
scr_new_power(POWER_shorterpowerdowns,ds_list_create(), 0, obj_powerup_shorterpowerdowns, "tap to make#downers shorter",1,++i) 
scr_new_power(POWER_invertcontrols,ds_list_create(), 0, obj_powerup_invertpaddle, "tap to fix#inverted controls", -1,++i) //NB: Misc value=-1
scr_new_power(POWER_multibonus,ds_list_create(), 0, obj_powerup_multibonus, "tap for extra#combos",1,++i) 
scr_new_power(POWER_multimalus,ds_list_create(), 0, obj_powerup_multimalus, "tap to enable#combos",1,++i)  
scr_new_power(POWER_splitpaddle,ds_list_create(), 0, obj_powerup_splitpaddle, "tap to unsplit#paddle",0,++i) //NB: Misc value=0
scr_new_power(POWER_cashtap,ds_list_create(), 0, obj_powerup_cash_tap, "tap for#cash",1, ++i)  
scr_new_power(POWER_offsetpaddle,ds_list_create(), 0, obj_powerup_offsetpaddle, "",0, ++i) //NB: Misc value=0 //"tap to reset#paddle"
scr_new_power(POWER_cashx2,ds_list_create(), 0, obj_powerup_cash_x2, "",1, ++i)  
scr_new_power(POWER_density_doubler,ds_list_create(), 0, obj_powerup_density_doubler, "",1, ++i)  

/* NB: Be sure to set the texture group for the power icon for EVERY configuration, GMS is silly like that.


*/



#define scr_deflector_data_init
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
DEFLECTOR_DATA_SIZES = ds_grid_create(6,6); //counts for each type/subtype
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
// object_index, obj_type, sub_type, power_array, spr_symbol, text_description, enabled

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
scr_new_deflector(obj_powerup_1up,1, 0, noone, spr_power_oneup,"one up", 0);//suvival#bonus
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


//Downers
    //No Timers
scr_new_deflector(obj_powerup_powerupsclear,2, 0, noone, spr_power_clear,"clear#uppers", 1); 
scr_new_deflector(obj_powerup_1down,2, 0, noone, spr_power_onedown,"one down", 0);//suvival#malus
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
scr_new_deflector(obj_powerup_mystery, 3, 2, noone, spr_symbol_mystery,"random", 0);
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

#define scr_powers_controler_init
///scr_powers_controler_init()


defaultPowerDuration =  (15 + 3 * GRID) * room_speed//25*room_speed
    //NB: Powers last longer on bigger grid sizes, I find this works better.
var mAdj = 1;
//If MOVES_LEFT mode
if MODE == MODES.MOVES{ mAdj = .75}


POWER_grow[@ 2] = defaultPowerDuration;
POWER_shrink[@ 2] = defaultPowerDuration;
POWER_faster[@ 2] = defaultPowerDuration
POWER_slower[@ 2] = defaultPowerDuration
POWER_mirror[@ 2] = defaultPowerDuration 
POWER_freeze[@ 2] = defaultPowerDuration * .2 
POWER_pmulti[@ 2] = defaultPowerDuration;
POWER_pdivis[@ 2] = defaultPowerDuration;
POWER_hugestar[@ 2] = defaultPowerDuration * .4
POWER_halfangle[@ 2] = defaultPowerDuration * .4 * sqr(mAdj)//10*room_speed;
POWER_threehalfangle[@ 2] = defaultPowerDuration * .4 * sqr(mAdj)//10*room_speed;
POWER_randomangle[@ 2] = defaultPowerDuration * .4 * sqr(mAdj)//10*room_speed;
POWER_reverseangle[@ 2] = defaultPowerDuration * .1 * mAdj//5*room_speed;
POWER_noangle[@ 2] = defaultPowerDuration * .1 * mAdj//5*room_speed;
POWER_diagturn[@ 2] = defaultPowerDuration * .4 * sqr(mAdj)//10*room_speed;
POWER_slowpaddle[@ 2] = defaultPowerDuration * .4;
POWER_multistar[@ 2] = defaultPowerDuration * .6; 
POWER_addgrow[@ 2] = defaultPowerDuration * .4;
POWER_subshrink[@ 2] = defaultPowerDuration * .4;
POWER_addslower[@ 2] = defaultPowerDuration * .4;
POWER_subfaster[@ 2] = defaultPowerDuration * .4;
POWER_longerpowerups[@ 2] = defaultPowerDuration * .6; 
POWER_shorterpowerdowns[@ 2] = defaultPowerDuration * .6;
POWER_invertcontrols[@ 2] = defaultPowerDuration * .4; 
POWER_multibonus[@ 2] = defaultPowerDuration * .6; 
POWER_multimalus[@ 2] = defaultPowerDuration * .6;
POWER_splitpaddle[@ 2] = defaultPowerDuration * .6;
POWER_cashtap[@ 2] = defaultPowerDuration * .6;
POWER_offsetpaddle[@ 2] = defaultPowerDuration * .4;
POWER_cashx2[@ 2] = defaultPowerDuration //* .6;
POWER_density_doubler[@ 2] = defaultPowerDuration * .4; //we probably don't want this to be too long
//30 total



jiggletime = 1.0*room_speed
for (var i=0, n = array_length_1d(POWER_ARRAY); i < n; i++){ //see STEP event highest j val to get accurate count
    for (j=0;j<4;j++){
        cd_jiggle[i,j] = 0;
    }
}

paddleScale = false;

modifyDur = 0;


tap_text_index = -1;
tap_timerval = 0;
tap_col = COLORS[0];
tap_text = "";




touchPadTap = false;
touchPadTapEase[0] = 1;
touchPadTapTween = noone;