///shooter_nearest_valid(x,y)

var fieldX = argument[0];
var fieldY = argument[1];

var found = false;
var foundObject = instance_nearest(fieldX,fieldY,obj_star)

while !found{
    obj = instance_nearest(fieldX,fieldY,obj_star)
    if obj == noone {break;}
    else{
        if gamecell_is_valid(obj.gridXY[0],obj.gridXY[1]){found = true; foundObject = obj;}
        else instance_deactivate_object(obj)
    }
}

instance_activate_object(obj_star)
return foundObject;
