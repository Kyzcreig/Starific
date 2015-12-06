//scr_boardclear()

//Iterate through each cell and destroy deflector
var dur = 1*room_speed;
var obj, i, j, params;
if (MOVE_ACTIVE == true){
   for (i = 0; i < fieldW; i += 1){
       for (j = 0; j < fieldH; j += 1){
            scr_bomb_set_delay(i,j,scr_create_array(irandom(dur), 1))//x,y,[duration,boardclear]
        }
   }
}
//Screen Shake
scr_shake_add(room_speed,6);
boardWideEffectTimer += boardWideEffectTimerMax;
boardClearedTimer = dur;
//obj_control_game.boardWipe = true;
