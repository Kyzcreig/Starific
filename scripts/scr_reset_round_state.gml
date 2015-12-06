///scr_reset_round_state()


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
