#define scr_spawner_chance_init
///scr_spawner_chance_init()

// Declare Vars
var weight, out;



////////////////////////////////////////////////

// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;


//Set Weights and Outcomes
// Cash Deflectors
if VC_ENABLED{
    // Default Cash Weight
    //weight[w] = .0050;//.01; //.02
        /* NB: I think let's keep cash this common again.
            Just add more stuff to win.
        
        */
    weight[w] = .0075;//.01; //.02
    switch MODE {
        case MODES.MOVES:
            // Scale Up Moves Mode Cash
            weight[w] *= 1.5;
            break;
        case MODES.SANDBOX:
            // Scale Down Sandbox Cash
            weight[w] *= .5;//.5
                /* NB: Not sure I like that sandbox gives less money in general.
                   Well maybe that's not so bad, you can't lose after all.
                
                */
            break;
    }
    out[w++] = 0;
}
    // Power Deflectors
weight[w] = powerDensity;
out[w++] = 1
    // Basic Deflectors
weight[w] = (1 -array_sum_1d(weight)); //it takes up the rest to add up to 100%
out[w++] = 2


//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "deflector_types", scr_spawner_chance_array(weight, out))



////////////////////////////////////////////////

// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
var pCash = scr_cash_chance();
weight[w] = pCash[0];    out[w++] = obj_powerup_cash_1;
weight[w] = pCash[1];    out[w++] = obj_powerup_cash_2;
weight[w] = pCash[2];    out[w++] = obj_powerup_cash_5;
weight[w] = pCash[3];    out[w++] = obj_powerup_cash_10; 
weight[w] = pCash[3];    out[w++] = obj_powerup_cash_x2;
//weight[w] = pCash[3];    out[w++] = obj_powerup_cash_rng;
if MODE != MODES.MOVES {
    weight[w] = pCash[2];    out[w++] = obj_powerup_cash_tap; 
}

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "cash", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights of objects
weight[w] = 1;    out[w++] = obj_reflector_basic;
weight[w] = 1;    out[w++] = obj_reflector_cwise;
weight[w] = 1;    out[w++] = obj_reflector_ccwise;


//Add to Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "basic", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .4;    out[w++] = 0; //bombs (chain effects)
weight[w] = .15;   out[w++] = 1;  //powerups (instant effects)
weight[w] = .45;    out[w++] = 2;  //powerups (cumulative effects)

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "special_types_moves", scr_spawner_chance_array(weight, out))



//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .40;    out[w++] = 0; //bombs (chain effects)
weight[w] = .10;   out[w++] = 1;  //powerups (instant effects)
weight[w] = .50;    out[w++] = 2;  //powerups (cumulative effects)

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "special_types_tier_1", scr_spawner_chance_array(weight, out))



//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .40;    out[w++] = 0; //bombs (chain effects)
weight[w] = .10;   out[w++] = 1;  //powerups (instant effects)
weight[w] = .50;    out[w++] = 2;  //powerups (cumulative effects)

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "special_types_tier_2", scr_spawner_chance_array(weight, out))



//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .40;    out[w++] = 0; //bombs (chain effects)
weight[w] = .15;   out[w++] = 1;  //powerups (instant effects)
weight[w] = .45;    out[w++] = 2;  //powerups (cumulative effects)

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "special_types_tier_3", scr_spawner_chance_array(weight, out))



//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .45;    out[w++] = 0; //bombs (chain effects)
weight[w] = .15;   out[w++] = 1;  //powerups (instant effects)
weight[w] = .40;    out[w++] = 2;  //powerups (cumulative effects)
//weight[w] = .50;    out[w++] = 2;  //powerups (cumulative effects)
    //NB: I wonder if it'll be better with more bombs/instant effects relative powerups.
    // We do want it to be chaotic later.. but controlled you know.

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "special_types_tier_4", scr_spawner_chance_array(weight, out))



//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;


//Set Weights and Outcomes
weight[w] = .4;    out[w++] = obj_powerup_bomb_line;
weight[w] = .25;   out[w++] = obj_powerup_bomb_v;
weight[w] = .10;   out[w++] = obj_powerup_bomb_diagonal;
weight[w] = .05;   out[w++] = obj_powerup_bomb_rangle;
weight[w] = .05;   out[w++] = obj_powerup_bomb_t;
weight[w] = .025;  out[w++] = obj_powerup_bomb_x;
weight[w] = .025;  out[w++] = obj_powerup_bomb_circle;
weight[w] = .025;  out[w++] = obj_powerup_bomb_checkers;



//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "bombs_moves", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;


//Set Weights and Outcomes
weight[w] = .70;    out[w++] = obj_powerup_bomb_line;
weight[w] = .20;   out[w++] = obj_powerup_bomb_v;
weight[w] = .05;   out[w++] = obj_powerup_bomb_diagonal;
weight[w] = .05;   out[w++] = obj_powerup_bomb_rangle;
weight[w] = .05;   out[w++] = obj_powerup_bomb_t;
weight[w] = .01;  out[w++] = obj_powerup_bomb_x;
weight[w] = .01;  out[w++] = obj_powerup_bomb_circle;
weight[w] = .00;  out[w++] = obj_powerup_bomb_checkers;



//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "bombs_tier_1", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;


//Set Weights and Outcomes
weight[w] = .60;    out[w++] = obj_powerup_bomb_line;
weight[w] = .20;   out[w++] = obj_powerup_bomb_v;
weight[w] = .10;   out[w++] = obj_powerup_bomb_diagonal;
weight[w] = .05;   out[w++] = obj_powerup_bomb_rangle;
weight[w] = .10;   out[w++] = obj_powerup_bomb_t;
weight[w] = .025;  out[w++] = obj_powerup_bomb_x;
weight[w] = .025;  out[w++] = obj_powerup_bomb_circle;
weight[w] = .010;  out[w++] = obj_powerup_bomb_checkers;



//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "bombs_tier_2", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;


//Set Weights and Outcomes
weight[w] = .50;    out[w++] = obj_powerup_bomb_line;
weight[w] = .20;   out[w++] = obj_powerup_bomb_v;
weight[w] = .15;   out[w++] = obj_powerup_bomb_diagonal;
weight[w] = .05;   out[w++] = obj_powerup_bomb_rangle;
weight[w] = .15;   out[w++] = obj_powerup_bomb_t;
weight[w] = .05;  out[w++] = obj_powerup_bomb_x;
weight[w] = .05;  out[w++] = obj_powerup_bomb_circle;
weight[w] = .025;  out[w++] = obj_powerup_bomb_checkers;



//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "bombs_tier_3", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;


//Set Weights and Outcomes
weight[w] = .40;    out[w++] = obj_powerup_bomb_line;
weight[w] = .20;   out[w++] = obj_powerup_bomb_v;
weight[w] = .15;   out[w++] = obj_powerup_bomb_diagonal;
weight[w] = .05;   out[w++] = obj_powerup_bomb_rangle;
weight[w] = .15;   out[w++] = obj_powerup_bomb_t;
weight[w] = .05;  out[w++] = obj_powerup_bomb_x;
weight[w] = .05;  out[w++] = obj_powerup_bomb_circle;
weight[w] = .025;  out[w++] = obj_powerup_bomb_checkers;



//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "bombs_tier_4", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////

// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .80 - gridSize*.01;    out[w++] = obj_powerup_2balls;
weight[w] = .25 - gridSize*.005;   out[w++] = obj_powerup_3balls;
weight[w] = .075;                   out[w++] = obj_powerup_4balls;
weight[w] = .005;                  out[w++] = obj_powerup_powersallclear;
weight[w] = .005;                  out[w++] = obj_powerup_powerupsclear;
weight[w] = .005;                  out[w++] = obj_powerup_powerdownsclear; 
weight[w] = .05;                  out[w++] = obj_powerup_staregg;


//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "instant_moves_onCD", scr_spawner_chance_array(weight, out))



//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .01;                out[w++] = obj_powerup_boardclear; 
//weight[w] = .01;                out[w++] = obj_powerup_boardfill; 
   //NB: Board fill is just too OP it's like an extra life. 


 
//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "instant_moves_offCD", 
                 scr_spawner_chance_combine(
                     SPAWNER_CHANCE_DATA[? "instant_moves_onCD"], 
                     scr_spawner_chance_array(weight, out)
                     )
                );



//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .55;                    out[w++] = obj_powerup_2balls;
weight[w] = .10;                   out[w++] = obj_powerup_3balls;
weight[w] = .025;                   out[w++] = obj_powerup_4balls;
weight[w] = .00;                    out[w++] = obj_powerup_powersallclear; 
weight[w] = .00;                    out[w++] = obj_powerup_powerupsclear; 
weight[w] = .00;                    out[w++] = obj_powerup_powerdownsclear; 
//weight[w] = .015;                 out[w++] = obj_powerup_1down;
//weight[w] = .015;                out[w++] = obj_powerup_1up; 
    /*NB: Lives stuff would work better if it checked on effect rather than on spawn.  
           That would be more elegant than a bunch of conditionals here
    */


//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "instant_onCD_tier_1", scr_spawner_chance_array(weight, out))



//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
//if boardWipeCD <= 0 { 
weight[w] = .025;                out[w++] = obj_powerup_boardclear;
weight[w] = .025;                out[w++] = obj_powerup_boardfill;
//.025

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "instant_offCD_tier_1", 
                 scr_spawner_chance_combine(
                     SPAWNER_CHANCE_DATA[? "instant_onCD_tier_1"], 
                     scr_spawner_chance_array(weight, out)
                     )
                );


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .50;                    out[w++] = obj_powerup_2balls;
weight[w] = .15;                   out[w++] = obj_powerup_3balls;
weight[w] = .025;                   out[w++] = obj_powerup_4balls;
weight[w] = .005;                    out[w++] = obj_powerup_powersallclear; 
weight[w] = .005;                    out[w++] = obj_powerup_powerupsclear; 
weight[w] = .005;                    out[w++] = obj_powerup_powerdownsclear; 
//weight[w] = .015;                 out[w++] = obj_powerup_1down;
//weight[w] = .015;                out[w++] = obj_powerup_1up; 



//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "instant_onCD_tier_2", scr_spawner_chance_array(weight, out))



//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
//if boardWipeCD <= 0 { 
weight[w] = .030;                out[w++] = obj_powerup_boardclear; 
weight[w] = .030;                out[w++] = obj_powerup_boardfill; 


//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "instant_offCD_tier_2", 
                 scr_spawner_chance_combine(
                     SPAWNER_CHANCE_DATA[? "instant_onCD_tier_2"], 
                     scr_spawner_chance_array(weight, out)
                     )
                );


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .40;                    out[w++] = obj_powerup_2balls;
weight[w] = .20;                   out[w++] = obj_powerup_3balls;
weight[w] = .05;                   out[w++] = obj_powerup_4balls;
weight[w] = .005;                    out[w++] = obj_powerup_powersallclear; 
weight[w] = .005;                    out[w++] = obj_powerup_powerupsclear; 
weight[w] = .005;                    out[w++] = obj_powerup_powerdownsclear; 
//weight[w] = .015;                 out[w++] = obj_powerup_1down;
//weight[w] = .015;                out[w++] = obj_powerup_1up; 



//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "instant_onCD_tier_3", scr_spawner_chance_array(weight, out))



//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
//if boardWipeCD <= 0 { 
weight[w] = .035;                out[w++] = obj_powerup_boardclear; 
weight[w] = .035;                out[w++] = obj_powerup_boardfill; 


//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "instant_offCD_tier_3", 
                 scr_spawner_chance_combine(
                     SPAWNER_CHANCE_DATA[? "instant_onCD_tier_3"], 
                     scr_spawner_chance_array(weight, out)
                     )
                );


//////////////////////////////////////////////////

// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .40;                    out[w++] = obj_powerup_2balls;
weight[w] = .20;                   out[w++] = obj_powerup_3balls;
weight[w] = .10;                   out[w++] = obj_powerup_4balls;
weight[w] = .005;                    out[w++] = obj_powerup_powersallclear; 
weight[w] = .005;                    out[w++] = obj_powerup_powerupsclear; 
weight[w] = .005;                    out[w++] = obj_powerup_powerdownsclear; 
//weight[w] = .015;                 out[w++] = obj_powerup_1down;
//weight[w] = .015;                out[w++] = obj_powerup_1up; 



//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "instant_onCD_tier_4", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
//if boardWipeCD <= 0 { 
weight[w] = .04;                out[w++] = obj_powerup_boardclear; 
weight[w] = .04;                out[w++] = obj_powerup_boardfill; 


//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "instant_offCD_tier_4", 
                 scr_spawner_chance_combine(
                     SPAWNER_CHANCE_DATA[? "instant_onCD_tier_4"], 
                     scr_spawner_chance_array(weight, out)
                     )
                );


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .05;                   out[w++] = obj_powerup_faster;
weight[w] = .05;                   out[w++] = obj_powerup_slower;
weight[w] = .05;                   out[w++] = obj_powerup_points;
weight[w] = .05;                   out[w++] = obj_powerup_antipoints;
var cTurn = .0025;
weight[w] = cTurn;                  out[w++] = obj_powerup_pierce;
weight[w] = cTurn;                  out[w++] = obj_powerup_reverseturn;
weight[w] = cTurn;                  out[w++] = obj_powerup_halfangleturn;
weight[w] = cTurn;                  out[w++] = obj_powerup_threehalvesangle;
weight[w] = cTurn;                  out[w++] = obj_powerup_randomturn;
weight[w] = .025;                   out[w++] = obj_powerup_bigstar;

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "duration_moves_tier_1", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .05;                   out[w++] = obj_powerup_faster;
weight[w] = .05;                   out[w++] = obj_powerup_slower;
weight[w] = .05;                   out[w++] = obj_powerup_points;
weight[w] = .05;                   out[w++] = obj_powerup_antipoints;
var cTurn = .0050;
weight[w] = cTurn;                  out[w++] = obj_powerup_pierce;
weight[w] = cTurn;                  out[w++] = obj_powerup_reverseturn;
weight[w] = cTurn;                  out[w++] = obj_powerup_halfangleturn;
weight[w] = cTurn;                  out[w++] = obj_powerup_threehalvesangle;
weight[w] = cTurn;                  out[w++] = obj_powerup_randomturn;
weight[w] = .025;                   out[w++] = obj_powerup_bigstar;

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "duration_moves_tier_2", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .05;                   out[w++] = obj_powerup_faster;
weight[w] = .05;                   out[w++] = obj_powerup_slower;
weight[w] = .05;                   out[w++] = obj_powerup_points;
weight[w] = .05;                   out[w++] = obj_powerup_antipoints;
var cTurn = .0075;
weight[w] = cTurn;                  out[w++] = obj_powerup_pierce;
weight[w] = cTurn;                  out[w++] = obj_powerup_reverseturn;
weight[w] = cTurn;                  out[w++] = obj_powerup_halfangleturn;
weight[w] = cTurn;                  out[w++] = obj_powerup_threehalvesangle;
weight[w] = cTurn;                  out[w++] = obj_powerup_randomturn;
weight[w] = .025;                   out[w++] = obj_powerup_bigstar;

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "duration_moves_tier_3", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
weight[w] = .05;                   out[w++] = obj_powerup_faster;
weight[w] = .05;                   out[w++] = obj_powerup_slower;
weight[w] = .05;                   out[w++] = obj_powerup_points;
weight[w] = .05;                   out[w++] = obj_powerup_antipoints;
var cTurn = .0100;
weight[w] = cTurn;                  out[w++] = obj_powerup_pierce;
weight[w] = cTurn;                  out[w++] = obj_powerup_reverseturn;
weight[w] = cTurn;                  out[w++] = obj_powerup_halfangleturn;
weight[w] = cTurn;                  out[w++] = obj_powerup_threehalvesangle;
weight[w] = cTurn;                  out[w++] = obj_powerup_randomturn;
weight[w] = .025;                   out[w++] = obj_powerup_bigstar;

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "duration_moves_tier_4", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
//weight[w] = .20;    out[w++] = obj_powerup_mystery; 
weight[w] = .25;    out[w++] = obj_powerup_growpaddle;
weight[w] = .25;    out[w++] = obj_powerup_shrinkpaddle;
weight[w] = .25;    out[w++] = obj_powerup_faster;
weight[w] = .25;    out[w++] = obj_powerup_slower;
weight[w] = .01;   out[w++] = obj_powerup_points;
weight[w] = .01;   out[w++] = obj_powerup_antipoints;

weight[w] = .05; /*.025*/  out[w++] = obj_powerup_mirrorpaddle; 
//NB: it's better to start out slower with fewer mirrors
    //Or maybe not people get really low scores man
weight[w] = .05;    out[w++] = obj_powerup_bigstar; 

weight[w] = .05;    out[w++] = obj_powerup_pierce; 
weight[w] = .025;    out[w++] = obj_powerup_reverseturn; 
weight[w] = .00;    out[w++] = obj_powerup_halfangleturn; 
weight[w] = .00;    out[w++] = obj_powerup_threehalvesangle;
weight[w] = .00;    out[w++] = obj_powerup_randomturn;
weight[w] = .00;    out[w++] = obj_powerup_diagturn;

weight[w] = .0050;   out[w++] = obj_powerup_freezepaddle; 
weight[w] = .0025;   out[w++] = obj_powerup_slowpaddle;
weight[w] = .0025;    out[w++] = obj_powerup_splitpaddle; 
weight[w] = .0025;    out[w++] = obj_powerup_offsetpaddle; 

weight[w] = .0025;    out[w++] = obj_powerup_multistar; 
weight[w] = .0025;    out[w++] = obj_powerup_density_doubler;

weight[w] = .000;    out[w++] = obj_powerup_addgrow; 
weight[w] = .000;    out[w++] = obj_powerup_subshrink; 
weight[w] = .000;    out[w++] = obj_powerup_addslower; 
weight[w] = .000;    out[w++] = obj_powerup_subfaster; 

weight[w] = .000;    out[w++] = obj_powerup_longerpowerups; 
weight[w] = .000;    out[w++] = obj_powerup_shorterpowerdowns; 
//weight[w] = .000;    out[w++] = obj_powerup_invertpaddle; //NB: This downer is NOT fun
weight[w] = .000;    out[w++] = obj_powerup_multibonus; 
weight[w] = .000;    out[w++] = obj_powerup_multimalus;

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "duration_tier_1", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
//weight[w] = .20;    out[w++] = obj_powerup_mystery; 
weight[w] = .25;    out[w++] = obj_powerup_growpaddle;
weight[w] = .275;    out[w++] = obj_powerup_shrinkpaddle;
weight[w] = .275;    out[w++] = obj_powerup_faster;
weight[w] = .25;    out[w++] = obj_powerup_slower;
weight[w] = .025;   out[w++] = obj_powerup_points;
weight[w] = .025;   out[w++] = obj_powerup_antipoints;

weight[w] = .050;   out[w++] = obj_powerup_mirrorpaddle; 
weight[w] = .075;    out[w++] = obj_powerup_bigstar; 

weight[w] = .050;    out[w++] = obj_powerup_pierce; 
weight[w] = .025;    out[w++] = obj_powerup_reverseturn; 
weight[w] = .00;    out[w++] = obj_powerup_halfangleturn; 
weight[w] = .00;    out[w++] = obj_powerup_threehalvesangle;
weight[w] = .00;    out[w++] = obj_powerup_randomturn;
weight[w] = .00;    out[w++] = obj_powerup_diagturn;

weight[w] = .0100;   out[w++] = obj_powerup_freezepaddle; 
weight[w] = .0050;   out[w++] = obj_powerup_slowpaddle;
weight[w] = .0050;    out[w++] = obj_powerup_splitpaddle; 
weight[w] = .0050;    out[w++] = obj_powerup_offsetpaddle;  

weight[w] = .0025;    out[w++] = obj_powerup_multistar; 
weight[w] = .0025;    out[w++] = obj_powerup_density_doubler;

weight[w] = .0010;    out[w++] = obj_powerup_addgrow; 
weight[w] = .0010;    out[w++] = obj_powerup_subshrink; 
weight[w] = .0010;    out[w++] = obj_powerup_addslower; 
weight[w] = .0010;    out[w++] = obj_powerup_subfaster; 

weight[w] = .0025;    out[w++] = obj_powerup_longerpowerups; 
weight[w] = .0025;    out[w++] = obj_powerup_shorterpowerdowns; 
//weight[w] = .0010;    out[w++] = obj_powerup_invertpaddle; 
weight[w] = .0010;    out[w++] = obj_powerup_multibonus; 
weight[w] = .0010;    out[w++] = obj_powerup_multimalus; 

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "duration_tier_2", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
//weight[w] = .20;    out[w++] = obj_powerup_mystery; 
weight[w] = .225;    out[w++] = obj_powerup_growpaddle;
weight[w] = .275;    out[w++] = obj_powerup_shrinkpaddle;
weight[w] = .275;    out[w++] = obj_powerup_faster;
weight[w] = .225;    out[w++] = obj_powerup_slower;
weight[w] = .025;   out[w++] = obj_powerup_points;
weight[w] = .025;   out[w++] = obj_powerup_antipoints;

weight[w] = .075;   out[w++] = obj_powerup_mirrorpaddle; 
weight[w] = .100;    out[w++] = obj_powerup_bigstar; 

weight[w] = .025;    out[w++] = obj_powerup_pierce; 
weight[w] = .025;    out[w++] = obj_powerup_reverseturn; 
weight[w] = .010;    out[w++] = obj_powerup_halfangleturn; 
weight[w] = .010;    out[w++] = obj_powerup_threehalvesangle;
weight[w] = .010;    out[w++] = obj_powerup_randomturn;
weight[w] = .010;    out[w++] = obj_powerup_diagturn;

weight[w] = .0250;   out[w++] = obj_powerup_freezepaddle; 
weight[w] = .0250;   out[w++] = obj_powerup_slowpaddle;
weight[w] = .0250;    out[w++] = obj_powerup_splitpaddle;
weight[w] = .0250;    out[w++] = obj_powerup_offsetpaddle;   

weight[w] = .0075;    out[w++] = obj_powerup_multistar; 
weight[w] = .0075;    out[w++] = obj_powerup_density_doubler;

weight[w] = .0050;    out[w++] = obj_powerup_addgrow; 
weight[w] = .0050;    out[w++] = obj_powerup_subshrink; 
weight[w] = .0050;    out[w++] = obj_powerup_addslower; 
weight[w] = .0050;    out[w++] = obj_powerup_subfaster; 

weight[w] = .0050;    out[w++] = obj_powerup_longerpowerups; 
weight[w] = .0050;    out[w++] = obj_powerup_shorterpowerdowns; 
//weight[w] = .0050;    out[w++] = obj_powerup_invertpaddle; 
weight[w] = .0050;    out[w++] = obj_powerup_multibonus; 
weight[w] = .0050;    out[w++] = obj_powerup_multimalus; 

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "duration_tier_3", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////


// Clear Vars and Realloc Memory
weight = noone; out = noone; w = 0;

//Set Weights and Outcomes
//weight[w] = .20;    out[w++] = obj_powerup_mystery; 
weight[w] = .20;     out[w++] = obj_powerup_growpaddle;
weight[w] = .25;     out[w++] = obj_powerup_shrinkpaddle;
weight[w] = .25;     out[w++] = obj_powerup_faster;
weight[w] = .20;     out[w++] = obj_powerup_slower;
weight[w] = .025;    out[w++] = obj_powerup_points;
weight[w] = .025;    out[w++] = obj_powerup_antipoints;

weight[w] = .100;    out[w++] = obj_powerup_mirrorpaddle; 
weight[w] = .100;    out[w++] = obj_powerup_bigstar; 

weight[w] = .025;    out[w++] = obj_powerup_pierce; 
weight[w] = .025;    out[w++] = obj_powerup_reverseturn; 
weight[w] = .025;    out[w++] = obj_powerup_halfangleturn; 
weight[w] = .025;    out[w++] = obj_powerup_threehalvesangle;
weight[w] = .025;    out[w++] = obj_powerup_randomturn;
weight[w] = .025;    out[w++] = obj_powerup_diagturn;

weight[w] = .0500;   out[w++] = obj_powerup_freezepaddle; 
weight[w] = .0500;   out[w++] = obj_powerup_slowpaddle;
weight[w] = .0500;   out[w++] = obj_powerup_splitpaddle; 
weight[w] = .0500;    out[w++] = obj_powerup_offsetpaddle;  

weight[w] = .0150;    out[w++] = obj_powerup_multistar; 
weight[w] = .0150;    out[w++] = obj_powerup_density_doubler; 

weight[w] = .0075;    out[w++] = obj_powerup_addgrow; 
weight[w] = .0075;    out[w++] = obj_powerup_subshrink; 
weight[w] = .0075;    out[w++] = obj_powerup_addslower; 
weight[w] = .0075;    out[w++] = obj_powerup_subfaster; 

weight[w] = .0075;    out[w++] = obj_powerup_longerpowerups; 
weight[w] = .0075;    out[w++] = obj_powerup_shorterpowerdowns; 
//weight[w] = .0075;    out[w++] = obj_powerup_invertpaddle; 
weight[w] = .0075;    out[w++] = obj_powerup_multibonus; 
weight[w] = .0075;    out[w++] = obj_powerup_multimalus; 

//Add to DS Map
ds_map_add_value(SPAWNER_CHANCE_DATA, "duration_tier_4", scr_spawner_chance_array(weight, out))


//////////////////////////////////////////////////

















#define scr_spawner_chance_array
///scr_spawner_chance_array(chance_array, outcome_array)

/* Returns an array holding the chance_array, outcome_array, 
    sum of chance_array and total number of outcomes
*/


var weight = argument0;
var outcome = argument1;
var chance_sum = array_sum_1d(weight);
var outcome_count = array_length_1d(outcome);

var chances;
chances[0] = weight;
chances[1] = outcome;
chances[2] = chance_sum;
chances[3] = outcome_count;


return chances;

#define scr_spawner_outcome
///scr_spawner_outcome(chance_key, [optional_keys...])

var chances, w, weight, outcome;

// Load Chance and Outcome Arrays
chances = SPAWNER_CHANCE_DATA[? argument[0]];
// Set Params
weight = chances[0];
outcome = chances[1];

// Set Chance Params
// Calculate Outcome
rng = random(chances[2]);
// Peal Chances with RNG
for(w = 0; rng > weight[w]; w++) rng -= weight[w];

// Set Outcome
return outcome[w];

#define scr_spawner_set_power_flag
///scr_spawner_set_power_flag()



// Failsafe to Keep Special Deflectors Common
var totalDefs = instance_number(obj_reflector_parent);
if totalDefs > 5 {
    // Calculate what 75% of power ratio is
    var pMinRatio = powerDensity *.75;
    var pRatio = instance_number(obj_reflector_special_parent) / totalDefs;
    //If We fall below 75% of Power Ratio
    if pRatio < pMinRatio {
        // Set Spawn Flag to Power Deflector
        return 1;
    }
}


return 0;

#define scr_spawner_chance_combine
///scr_spawner_chance_combine(array1, array2...)
var chances, w, weight, outcome, chance_sum, outcome_count;

// Load Chance and Outcome Arrays
chances = argument[0];
// Set Params
weight = chances[0];
outcome = chances[1];
chance_sum = chances[2];
outcome_count = chances[3];

// Add Additional Chances here
if argument_count > 1{
    for (var i = 1; i < argument_count; i++){
        var opt_chances, opt_weight, opt_outcome, opt_chance_sum, opt_outcome_count;
        // Load Optional Arrays
        opt_chances = argument[i];
        // Set Optional Params
        opt_weight = opt_chances[0];
        opt_outcome = opt_chances[1];
        opt_chance_sum = opt_chances[2];
        opt_outcome_count = opt_chances[3];
        w = 0;
        // Combine Chance Data
        while (w < opt_chances[3]) {
            // Copies Data and Increments Counts
            weight[outcome_count] = opt_weight[w];
            outcome[outcome_count++] = opt_outcome[w++];
        }
        // Sum Chance Values
        chance_sum += opt_chance_sum;
        
        /*NB:  A cleaner way to do optional arrays might have been down below
          Scale the probability by all the array chances summed
          And have a while loop that checks if the first array is out of values
          Then it'd move on to the next one
        */
    }
}

var combined;

combined[0] = weight;
combined[1] = outcome;
combined[2] = chance_sum;
combined[3] = outcome_count;

return combined;