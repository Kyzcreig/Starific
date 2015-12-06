#define scr_death_timers_init
///scr_death_timers_init();
/* 
  Init Array for our delayed deflector death timers.

*/


ds_grid_resize(global.DEATH_TIMERS_GRID, fieldW, fieldH);
scr_death_timers_clear();

/*


global.DEATHTIMERS = noone;

for (var gx = 0; gx < fieldW ; gx++){
    for (var gy = 0; gy < fieldH; gy++){
        global.DEATHTIMERS[# gx, gy] = noone;
    }
}
global.DEATHTIMECOUNT = 0;

#define scr_death_timers_clear
///scr_death_timers_clear()

ds_grid_clear(global.DEATH_TIMERS_GRID, noone);
ds_list_clear(global.DEATH_TIMERS_LIST);


#define scr_death_timers_count
///scr_death_timers_count();
/* 
  Init Array for our delayed deflector death timers.

*/

return ds_list_size(global.DEATH_TIMERS_LIST);

//return global.DEATH_TIMERS_COUNT;