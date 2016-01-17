///scr_nearest_deflector_in_direction(gx, gy, searchDir)
//Dir are clockwise, not counter clockwise dur to how graphics coordinates work
//with their origin at the top left

var gX = argument0
var gY = argument1
var adjX = 0;
var adjY = 0;
var searchDir = (argument2+360) mod 360;
var returnArray = noone;

/// Set Search Unit Intervals
if searchDir = 0 {adjX = 1}
else if searchDir = 45 {adjX=1;adjY=1;}
if searchDir = 90 {adjY = 1}
else if searchDir = 135 {adjX=-1;adjY=1;}
if searchDir = 180 {adjX = -1}
else if searchDir = 225 {adjX=-1;adjY=-1;}
if searchDir = 270 {adjY = -1}
else if searchDir = 315 {adjX=1;adjY=-1;}

// Iterate in Search Direction
for(var i=1; true;i++){

    var checkX = gX+adjX*i;
    var checkY = gY+adjY*i;
    // If Out of Bounds
    if checkX >= fieldW or checkX < 0 or
       checkY >= fieldH or checkY < 0
    {
        //checkX = gX+adjX*(i-1);
        //checkY = gY+adjY*(i-1);
        returnArray = convertGridtoXY(checkX,checkY)
        returnArray[@ 2] = false;
        return returnArray;
    }
    else{
        // If Occupied Cell Found
        var currentCell = global.FIELD_OBJECTS[# checkX, checkY];
        if currentCell - DENSITY >= 0{
            returnArray = convertGridtoXY(checkX,checkY)
            returnArray[@ 2] = true;
            return returnArray;
        
        }
    }
    
}
