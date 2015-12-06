///scr_nearest_deflector_in_direction(gx, gy, dir)
//Dir are clockwise, not counter clockwise dur to how graphics coordinates work
//with their origin at the top left

var gX = argument0
var gY = argument1
var Dir = argument2;
var adjX = 0;
var adjY = 0;
var returnArray = noone;

//Check right
if Dir == 0{
   adjX = 1;
}
//Check down
else if Dir == 1{
   adjY = 1;
}
//Check left
else if Dir == 2{
   adjX = -1;
}
//Check up
else if Dir == 3{
   adjY = -1;
}


for(var i=1; true;i++){

    var checkX = gX+adjX*i;
    var checkY = gY+adjY*i;
    if checkX >= fieldW or checkX < 0
    or checkY >= fieldH or checkY < 0
    {
        //checkX = gX+adjX*(i-1);
        //checkY = gY+adjY*(i-1);
        returnArray = convertGridtoXY(checkX,checkY)
        returnArray[@ 2] = false;
        return returnArray;
    }
    else{
        var currentCell = global.FIELD_OBJECTS[# checkX, checkY];
        if currentCell - DENSITY >= 0{
            returnArray = convertGridtoXY(checkX,checkY)
            returnArray[@ 2] = true;
            return returnArray;
        
        }
    
    
    }
    
    
    
    
    
    
    
    
}
