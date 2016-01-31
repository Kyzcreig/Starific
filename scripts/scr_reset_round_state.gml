#define scr_reset_round_state
///scr_reset_round_state()


if !TUTORIAL_ENABLED {
    // Cache Round TIme
    if MOVE_COUNT == 1 {
        lastFewPlaytimes[0] = min(EXPECTED_MINIMUM_PLAYTIME,roundPlaytime);
            //NB: We use this to evaluate user performance, for paddle length boost, for bad kids
            //NB: We use 75 seconds as the max because after that I think is acceptable
    }
    //Increment Round Count
    MOVE_COUNT += 1;
}

//Reset time keepers and round state
roundPlaytime = 0;
MOVE_READY = false;
SPAWN_COUNTER = 0;
MOVE_ACTIVE = false;
SHAKE_TIME = -1


//Reset board nuke cooldowns
scr_board_wide_effects_clear();

//Destroy Text popups and projectiles
with (obj_text_generic){instance_destroy()}//is parent of other text objects
with (obj_powerup_falling){instance_destroy()}

#define scr_calculate_performance_metric
///scr_calculate_performance_metric()

// Set Expected Minimum Playtime
EXPECTED_MINIMUM_PLAYTIME = 60 * 60 * 1.00; //EVALUATE ME
    ///NB: We can always make this bigger.

var performance_metric, lastPlaytime_metric, careerPlaytime_metric;

// Get Perfomance Metrics
lastPlaytime_metric = averageLastFewPlaytimes / EXPECTED_MINIMUM_PLAYTIME;
careerPlaytime_metric = clamp(careerPlaytimeTotal / (60 * 60 * 5), 0, 1) 
                            //NB: Cut off after career playtime >= 5 minutes
// Average Metrics
performance_metric = mean(lastPlaytime_metric, careerPlaytime_metric);

return performance_metric;