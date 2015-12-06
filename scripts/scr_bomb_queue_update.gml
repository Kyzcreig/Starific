///scr_bomb_queue_update()
 
var dataXY;

//Trigger Delayed Destruction
var listSize = ds_list_size(global.DEATH_TIMERS_LIST);
for (var i = listSize-1; i >= 0; i--){
    // Get Data
    dataXY = global.DEATH_TIMERS_LIST[| i];
    
    // Decrement value
    dataXY[@ 2]--;
    
    // Process Detonation
    if dataXY[2] <= 0 {
       // Deonate Cell 
       scr_bomb_detonate_delayed(dataXY)
       // Clear Data from List
       ds_list_delete(global.DEATH_TIMERS_LIST, i);
       // Clear Data from Grid
       global.DEATH_TIMERS_GRID[# dataXY[0], dataXY[1]] = noone;
        /* NB: We do have a minor issue in that another bomb could be queue for this 
                same cell a few miliseconds later.
            But i think we can live with it.
         
        */
    }
}
/*
for (var gx = 0; gx < fieldW ; gx++){
    for (var gy = 0; gy < fieldH ; gy++){
    
        //Continue on invalid
        if global.DEATH_TIMERS_GRID[# gx, gy] == noone continue;
        
        //Decrement value
        global.DEATH_TIMERS_GRID[# gx, gy] -= 1;
        
        //Clear Timer and Detonate
        if global.DEATH_TIMERS_GRID[# gx, gy] <= 0 {
           scr_bomb_delayed(gx,gy)
           global.DEATH_TIMERS_GRID[# gx, gy] = noone;
           // Decrement Count
           global.DEATH_TIMERS_COUNT--;
        }
    }
}*/

