#define scr_bomb_chain_estimator
///scr_bomb_chain_estimator(instance, already bombed list, new dir, old dir)

var currentBomb = argument[0]
var bombedList = argument[1]
var newDir = (argument[2] + 360) mod 360
var oldDir = (argument[3] + 360) mod 360
var effect_script = scr_bomb_chain_checker;
var startX = currentBomb.gridXY[0];
var startY = currentBomb.gridXY[1];


switch currentBomb.object_index
{
    case obj_powerup_bomb_line:
    case obj_powerup_bomb_rangle:
    case obj_powerup_bomb_t:
    case obj_powerup_bomb_diagonal:
    case obj_powerup_bomb_x:
    case obj_powerup_bomb_checkers:
    case obj_powerup_bomb_circle:
         scr_bomb_type_script_execute(currentBomb.object_index, 
                        startX, startY, newDir, oldDir, effect_script, bombedList, newDir, oldDir)
    break;

}

#define scr_bomb_chain_checker
///scr_bomb_chain_checker(grid X, grid Y, params) //bombedList,newDir,oldDir)
var gX = argument[0]
var gY = argument[1]
var params = argument[2];
//NB: params[0] is the delay data
var bombedList = params[1]; 
var newDir = params[2];
var oldDir = params[3];

//Check if grid cell already in bombedlist
if ds_list_find_index(bombedList,gX+gY*fieldW) == -1
{
     //If not add it to list
     ds_list_add(bombedList, gX+gY*fieldW)
     //show_message(str_debug('ds_list_size',ds_list_size(bombedList))+str_debug('newdir',newDir)+str_debug('olddir',oldDir))
     var currentObject = global.FIELD_OBJECTS[# gX,gY]
     //Check if it's an object
     if  currentObject > DENSITY
     {   //If so check if bomb
         if object_is_ancestor(currentObject.object_index, obj_powerup_parent_bomb)
         { 
             scr_bomb_chain_estimator(currentObject,bombedList,
                                newDir+currentObject.rdir, newDir)
         }
     }
}
#define scr_bomb_force_add
///scr_bomb_force_add()

var params = noone;

params[0] = .5 * room_speed;
params[1] = scr_bomb_force_get_value(object_index);
params[2] = object_index;
global.BOMB_FORCE += params[1]
ds_list_add(global.ACTIVE_BOMB_TIMERS,params);


//Set Bomb Screen Shake
scr_bomb_force_add_shake();

#define scr_bomb_force_update
///scr_bomb_force_update()

var _l = global.ACTIVE_BOMB_TIMERS
var _d;
// Iterate from End to Front
for (var i = ds_list_size(_l) - 1; i >= 0 ; i--){
    // Get Data
    _d = _l[| i];
    // Update Timer
    _d[@ 0] -= 1;
    
    if _d[@ 0] <= 0 {
        // Update Bomb Force
        global.BOMB_FORCE -= _d[@ 1];
        // Delete Finished Timers
        ds_list_delete(_l, i);
    }
    

}




#define scr_bomb_force_get_value
//scr_bomb_force_get_value(object_index)

var val = 0;

switch argument0{

// Line 
case obj_powerup_bomb_line:  
    val = 1;
break;
// Right Angle 
case obj_powerup_bomb_rangle: 
    val = 1;

break;
// T-Line 
case obj_powerup_bomb_t: 
    val = 1.5;
break;
// Diagonal Line 
case obj_powerup_bomb_diagonal:
    val = 1.25;

break;

// V-Line 
case obj_powerup_bomb_v:
    val = 1.25;

break;

// X-Cross 
case obj_powerup_bomb_x:
    val = 2;

break;

// Checkers Pattern 
case obj_powerup_bomb_checkers:
    val = 2;

break;

// Circle Outline Pattern 
case obj_powerup_bomb_circle:
    val = 1.5;

    
break;
}


return val;


#define scr_bomb_force_add_shake
///scr_bomb_force_shake()


if global.BOMB_FORCE > 3.5{
    scr_shake_add( .5* room_speed, 4);
}




#define scr_bomb_force_clear
///scr_bomb_force_clear()

// Set Bomb Stuff
global.BOMB_FORCE = 0;
ds_list_clear(global.ACTIVE_BOMB_TIMERS)