///scr_calculate_points(added)

var score_result, score_multipliers;

score_result = argument[0] / 16 //we're scaling all points down

//Set Multipliers
    //Combos and Level and Difficulty
score_multipliers = max(1,global.pComboCount) * level
    //Bonus/maluses
score_multipliers *= power(2, (POWER_pmulti[@ 0]) - (POWER_pdivis[@ 0])); //increase points by powers of 2
    //Scale for Rigor Bonus
score_multipliers *= RIGOR_MULTIPLIER;
    //Decreasing Gains on multipliers
var diminishReturnsThreshold = level * 5// 2.5;
if score_multipliers > diminishReturnsThreshold {
    // Apply Diminished Returns to multipliers past threshold
    score_multipliers = diminishReturnsThreshold + power(score_multipliers-diminishReturnsThreshold, .80);
}
/*
    //Decreasing Gains on multipliers
score_multipliers = power(score_multipliers, .80) 
    //Scale for Rigor Bonus
score_multipliers *= RIGOR_MULTIPLIER;
*/



//Apply Multipliers
score_result *= score_multipliers; 
//Bonus multiplier for moves mode
score_result *= (1*(MODE != MODES.MOVES) + 5*(MODE == MODES.MOVES));  // scaled up MOVES_LEFT mode points

//Diminish Returns: Divide by star count 
score_result = score_result / max(1,global.ActiveStarCount*.75);

//Return Rounded
//return round(score_result);
return ceil(score_result);
