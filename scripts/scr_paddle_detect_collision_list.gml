#define scr_paddle_detect_collision_list
///scr_paddle_detect_collision_list(object_index)
//returns collided object and sets rotation

//if MODE == 2 return noone
var object_type = argument[0];




//left side
for (cc=ds_list_size(spritestartx);cc>0;cc--){ //left bends
    rotAngle = rotML[0]  - 45*(cc)
    
    collision_line_list_combined(xL[cc],yL[cc],xL[cc-1], yL[cc-1], object_type);

}
//middle
    rotAngle = rotML[0] 
    //collision_line_list_combined(xL[0],yL[0],xR[0], yR[0]);
    collision_line_list_combined(xL[0],yL[0],xML[0], yML[0], object_type);
    
    rotAngle = rotMR[0] 
    collision_line_list_combined(xMR[0],yMR[0],xR[0], yR[0], object_type);
    

    
//right side
for (cc=0; cc<ds_list_size(spriteendx);cc++){ //right bends
    rotAngle = rotMR[0] + 45*(cc+1)
    
    collision_line_list_combined(xR[cc],yR[cc],xR[cc+1], yR[cc+1], object_type);
}

//Reactivate Collided Objects
var found;
for (var i = 0, n = ds_list_size(caughtList); i < n; ++i) {
  found = ds_list_find_value(caughtList, i);
  instance_activate_object(found[0]);
  //found = noone
}


return caughtList

#define collision_line_list_combined
///collision_line_list_combined(x1, y1, x2, y2, object)

//Front line
collision_line_list_paddle(argument0+dsin((rotAngle))*(-PADDLE_H*.4)*image_yscale,
                           argument1+dcos((rotAngle))*(-PADDLE_H*.4)*image_yscale,
                           argument2+dsin((rotAngle))*(-PADDLE_H*.4)*image_yscale,
                           argument3+dcos((rotAngle))*(-PADDLE_H*.4)*image_yscale,
                           argument4,false,false,caughtList,rotAngle, 0)
//Back line
collision_line_list_paddle(argument0+dsin((rotAngle))*(PADDLE_H/2)*image_yscale,
                           argument1+dcos((rotAngle))*(PADDLE_H/2)*image_yscale,
                           argument2+dsin((rotAngle))*(PADDLE_H/2)*image_yscale,
                           argument3+dcos((rotAngle))*(PADDLE_H/2)*image_yscale,
                           argument4,false,false,caughtList,rotAngle, 1)

#define scr_paddle_detect_collision_array
///scr_paddle_detect_collision_array(object_index)
//returns collided object and sets rotation

var object_type = argument[0];
var obj_count = instance_number(object_type);

//Init Collision Array
col_array = noone;
col_array[obj_count] = noone;
col_cursor = 0;

// left side
for (cc=ds_list_size(spritestartx);cc>0;cc--){ //left bends
    rotAngle = rotML[0]  - 45*(cc)
    
    collision_line_array_combined(xL[cc],yL[cc],xL[cc-1], yL[cc-1], object_type);

}
// middle
    rotAngle = rotML[0] 
    //collision_line_list_combined(xL[0],yL[0],xR[0], yR[0]);
    collision_line_array_combined(xL[0],yL[0],xML[0], yML[0], object_type);
    
    rotAngle = rotMR[0] 
    collision_line_array_combined(xMR[0],yMR[0],xR[0], yR[0], object_type);
    

    
// right side
for (cc=0; cc<ds_list_size(spriteendx);cc++){ //right bends
    rotAngle = rotMR[0] + 45*(cc+1)
    
    collision_line_array_combined(xR[cc],yR[cc],xR[cc+1], yR[cc+1], object_type);
}

// Set Null Terminator
col_array[col_cursor] = noone;

return col_array;

#define collision_line_list_paddle
///collision_line_list_paddle(x1, y1, x2, y2, object, prec, notme, list, paddle rotation, line_id):
/*var 
x1=argument0, 
y1=argument1, 
x2=argument2, 
y2=argument3, 
obj=argument4, 
prec=argument5, 
notme=argument6, 
list=argument7, 
rot=argument8
line_id = argument9;
//var ret=ds_list_create();
*/

var found; 
// Find First Collision
found = collision_line(argument[0], argument[1], argument[2], argument[3], 
                       argument[4], argument[5], argument[6]);
// Iterate Until No More Collisions
while (instance_exists(found)) {

    // Set Data Array          (id, rot, line_id) 
    var vals = scr_create_array(found, argument[8], argument[9]);
                                  
    // Add To Collision List
    ds_list_add(argument[7], vals);
    
    // Deactivate Object (To Avoid Double Count)
    instance_deactivate_object(found);
        //NB: We reactivate list higher up in the stack
    
    // Find Next Collision
    found = collision_line(argument[0], argument[1], argument[2], argument[3], 
                           argument[4], argument[5], argument[6]);
  
}

// Return List
return argument[7];

#define collision_line_array_combined
///collision_line_array_combined(x1, y1, x2, y2, object)

//Front line
collision_line_array_paddle(argument0+dsin((rotAngle))*(-PADDLE_H*.4)*image_yscale,
                            argument1+dcos((rotAngle))*(-PADDLE_H*.4)*image_yscale,
                            argument2+dsin((rotAngle))*(-PADDLE_H*.4)*image_yscale,
                            argument3+dcos((rotAngle))*(-PADDLE_H*.4)*image_yscale,
                            argument4,false,false,rotAngle, 0)
//Back line
collision_line_array_paddle(argument0+dsin((rotAngle))*(PADDLE_H*.5)*image_yscale,
                            argument1+dcos((rotAngle))*(PADDLE_H*.5)*image_yscale,
                            argument2+dsin((rotAngle))*(PADDLE_H*.5)*image_yscale,
                            argument3+dcos((rotAngle))*(PADDLE_H*.5)*image_yscale,
                            argument4,false,false,rotAngle, 1)

#define collision_line_array_paddle
///collision_line_array_paddle(x1, y1, x2, y2, object, prec, notme, paddle rotation, line_id):
/*
var 
x1=argument0, 
y1=argument1, 
x2=argument2, 
y2=argument3, 
obj=argument4, 
prec=argument5, 
notme=argument6,  
rot=argument7
line_id = argument8;
array = argument9;
cursor = argument10;
*/


// Iterate Through Objects
with (argument[4]) {
    // Continue if Object is Not In Play
    if inFieldState != 3{
        continue
    }
    
    // Get distance to collision line
    var dist = point_line_distance(x,y,argument[0], argument[1], argument[2], argument[3], 1);
    
    // If Within Sprite Distance
    if dist < oSize/4 + rangeBuffer {
        //NB: We use 1/4 to display a little more penetration. Especially for the pointy star
        
        // Add Data to Array
        other.col_array[@ other.col_cursor++] = scr_create_array(id, argument[7], argument[8]);
        
        // Flag As Not in Play Anymore
        inFieldState = 0;
    }
}
 
//return col_array;

#define collision_rectangle_list_paddle
///collision_rectangle_list_paddle(x1, y1, x2, y2, object, prec, notme, list, paddle rotation):
var 
x1=argument0, 
y1=argument1, 
x2=argument2, 
y2=argument3, 
obj=argument4, 
prec=argument5, 
notme=argument6, 
ret=argument7, 
rot=argument8;
//var ret=ds_list_create();
 
var found=collision_rectangle(x1, y1, x2, y2, obj, prec, notme);
while (instance_exists(found)) {
  var vals = noone;
  vals[0] = found; vals[1] = rot;
  ds_list_add(ret, vals);
  instance_deactivate_object(found);
  found=collision_rectangle(x1, y1, x2, y2, obj, prec, notme);
  
}
 
for (var p=0; p<ds_list_size(ret); ++p) {
  found=ds_list_find_value(ret, p);
  instance_activate_object(found[0]);
  found = noone
}
 
return ret;