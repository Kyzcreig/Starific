#define scr_boardclear
//scr_boardclear()

//Iterate through each cell and destroy deflector
var dur = 1*room_speed;
var obj, i, j, params;
if (MOVE_ACTIVE == true){
   for (i = 0; i < fieldW; i += 1){
       for (j = 0; j < fieldH; j += 1){
            scr_bomb_set_delay(i,j,Array(irandom(dur), true))//x,y,[duration,boardclear]
        }
   }
}
//Screen Shake
scr_shake_add(room_speed,6);
boardWideEffectTimer += boardWideEffectTimerMax;
boardClearedTimer = dur;
//obj_control_game.boardWipe = true;

#define scr_detonate_bombs
///scr_detonate_bombs()


//Iterate through each cell and destroy bombs
var dur = 1*room_speed;
var cellValue, i, j, params;
if (MOVE_ACTIVE == true){
   for (i = 0; i < fieldW; i += 1){
       for (j = 0; j < fieldH; j += 1){
            // Get Cell Value
            cellValue = global.FIELD_OBJECTS[# i, j];
            // If Instance Exists and Is Bomb Object
            if instance_exists(cellValue) and object_is_ancestor(cellValue.object_index, obj_powerup_parent_bomb) {
                // Queue Self Destruct
                scr_bomb_set_delay(i,j,Array(irandom(dur), false))//x,y,[duration,boardclear]            
            }
        }
   }
}
// Add Screen Shake
scr_shake_add(room_speed,6);