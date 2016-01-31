#define scr_calculate_points
///scr_calculate_points(added)

var score_result, score_multipliers;

score_result = argument[0] / 16; //we're scaling all points down

//Set Multipliers
    //Combos and Level and Difficulty
score_multipliers = max(1,global.pComboCount) * level;
    //Bonus/maluses
score_multipliers *= power(2, (POWER_pmulti[@ 0]) - (POWER_pdivis[@ 0])); //increase points by powers of 2
    //Scale for Rigor Bonus
score_multipliers *= RIGOR_MULTIPLIER;
    //Scale for Double Points Debuff
if scr_gamemod_get_index("double_points", 8) > 0 {
    score_multipliers *= scr_gamemod_get_index("double_points", 10);
}
    //Scale for Half Points Debuff
if scr_gamemod_get_index("half_points", 8) > 0 {
    score_multipliers *= scr_gamemod_get_index("half_points", 10);
}
    //Scale for No Points Debuff
if scr_gamemod_get_index("no_points", 8) > 0 {
    score_multipliers *= scr_gamemod_get_index("no_points", 10);
}
    //Decreasing Gains on multipliers
var diminishReturnsThreshold = level * 5// 2.5;
if score_multipliers > diminishReturnsThreshold {
    // Apply Diminished Returns to multipliers past threshold
    score_multipliers = diminishReturnsThreshold + power(score_multipliers-diminishReturnsThreshold, .80);
}
    //Diminish Returns: Divide by star count 
score_multipliers /= max(1,global.ActiveStarCount*.75);
    //Bonus multiplier for moves mode
score_multipliers *= (1*(MODE != MODES.MOVES) + 5*(MODE == MODES.MOVES));  // scaled up MOVES_LEFT mode points


//Apply Multipliers
score_result *= score_multipliers; 

//Return Ceil'd result (to avoid 0 points)
return ceil(score_result);

#define scr_raw_score_add
//scr_raw_score_add(value)

var val = argument0;

// Levels You Up Faster
if scr_gamemod_get_index("auto_didact", 8) > 0 {
    val *= scr_gamemod_get_index("auto_didact", 10);
}
// Levels You Up Slower
if scr_gamemod_get_index("lacka_daisical", 8) > 0 {
    val *= scr_gamemod_get_index("lacka_daisical", 10);
}

RAW_SCORE += val; //we don't need to ceil this because nobody sees it