///scr_create_star_marker(foundList)


var foundList = argument0;

for (i=0;i<ds_list_size(foundList);i++){
    // Get Grid Coordinates
    var gridXY = foundList[| i];
    // Convert To Field Coordinates
    var fieldXY = noone; //NB: This is initialized to clear the array for html bugs
    fieldXY = convertGridtoXY(gridXY[0],gridXY[1]);
    
    //var markerType;
    
    //if !TUTORIAL_ENABLED markerType = obj_star_marker;
    //else markerType = obj_star_marker_tutorial;
    
    
    //Create star marker
    with (instance_create(fieldXY[0], fieldXY[1], bMStarType)){
        //Creator_ID = other.id;
    }

    
}
