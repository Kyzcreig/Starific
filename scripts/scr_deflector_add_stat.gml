#define scr_deflector_add_stat
///scr_deflector_add_stat(objData, statIndex)

var objData = argument0;
var statIndex = argument1;
// Increment Specific Object Deaths
objData[@ statIndex] += 1;

var parentData, size;
size = ds_list_size(DEFLECTOR_PARENTS);
//Increment Parent Deaths
for (var i = 0; i < size; i++) {
    if object_is_ancestor(objData[0], DEFLECTOR_PARENTS[| i]) {
        parentData = scr_deflector_get_data(DEFLECTOR_PARENTS[| i])
        parentData[@ statIndex]++;
    }
}

#define scr_deflector_get_direct_parent
///scr_deflector_get_direct_parent(objType)


switch argument0 {

case 0:
    return obj_reflector_parent_basic;
break;
case 1:
    return obj_powerup_parent_ups;
break;
case 2:
    return obj_powerup_parent_downs;
break;
case 3:
    return obj_powerup_parent_neutral;
break;
case 4:
    return obj_powerup_parent_bomb;
break;

//parent
case 5:
    return object_index;
break;




}

#define scr_deflector_set_draw_type
///scr_deflector_set_draw_type(objData)

    
    
var data = argument0;

switch data[1] {

case 0:
case 1:
case 2:
case 3:
case 4:
    return data[1];
break;

//parent
case 5:
    return scr_deflector_get_child_type(data[0]);
break;




}

#define scr_deflector_get_child_type
///scr_deflector_get_child_type(obj_index)



switch argument0 {

case obj_reflector_parent:
case obj_reflector_parent_basic:
case obj_reflector_special_parent:
case obj_powerup_projectile_parent:
    return 0;
break;
case obj_powerup_parent_ups:
    return 1;
break;
case obj_powerup_parent_downs:
    return 2;
break;
case obj_powerup_parent_neutral:
case obj_powerup_parent_cash:
    return 3;
break;
case obj_powerup_parent_bomb:
    return 4;
break;





}