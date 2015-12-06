#define scr_bomb_type_script_execute
//scr_bomb_type_script_execute(object_index, newDir, oldDir, script, arg0, ...)

var type_id = argument[0];
var startX = argument[1];
var startY = argument[2];
var newDir = argument[3];
var oldDir = argument[4];
var effect_script = argument[5]
var params; 

//Load other parameters
for (var i = argument_count - 6; i >= 1; i--){
    params[i] = argument[i+5];
    //NB: Backwards declare for efficiency
}
//NB: Somewhat unnecessary now but I'll keep it.
// Init Bomb Timer Data
params[0] = 0 // reserved for implicit delta data


switch type_id{

// Line 
case obj_powerup_bomb_line: 
    if (newDir == 90 or newDir == 270) or 
    (newDir == 45 or newDir == 135){//could use oldDir here -90 -90
        for (i = 1; i < fieldW; i += 1){//horizontal
            var _break = 0;
            params[0] = i * BOMB_DELAY_SCALAR 
            
            if startX+i < fieldW{script_execute(effect_script,startX+i,startY,params)}
            else{_break += 1}
            if startX-i >= 0{script_execute(effect_script,startX-i,startY,params)}
            else{_break += 1}
            
            if _break > 1{break}
            
        }
        //show_message('moving horizontal')
    }
    else {
        for (i = 1; i < fieldH; i += 1){//vertical
            var _break = 0;
            params[0] = i * BOMB_DELAY_SCALAR
            
            if startY+i < fieldH{script_execute(effect_script,startX,startY+i,params)}
            else{_break += 1}
            if startY-i >= 0{script_execute(effect_script,startX,startY-i,params)}
            else{_break += 1}
            
            if _break > 1{break}
        }
        //show_message('moving vertical')
    }
break;
// Right Angle 
case obj_powerup_bomb_rangle: 
    if (newDir == 180 or oldDir == 0 or newDir == 225 or newDir == 135) {
        for (i = 1; i < fieldW; i += 1){ //going right from startX
            var _break = 0;
            params[0] = i * BOMB_DELAY_SCALAR
            
            if startX+i < fieldW{script_execute(effect_script,startX+i,startY,params)}
            else{_break += 1}
            
            if _break > 0{break}
        }
    }
    else if (newDir == 0 or oldDir == 180 or newDir == 45 or newDir == 315){
        for (i = 1; i <= fieldW; i += 1){ //going left from startX
            var _break = 0;
            params[0] = i * BOMB_DELAY_SCALAR
            
            if startX-i >= 0{script_execute(effect_script,startX-i,startY,params)}
            else{_break += 1}
            
            if _break > 0{break}
        }
    }
    if (newDir == 90 or oldDir == 270 or newDir == 45 or newDir == 135){
        for (i = 1; i < fieldH; i += 1){ //going down from startY
            var _break = 0;
            params[0] = i * BOMB_DELAY_SCALAR
            
            if startY+i < fieldH{script_execute(effect_script,startX,startY+i,params)}
            else{_break += 1}
            
            if _break > 0{break}
        }
    }
    else if (newDir == 270 or oldDir == 90 or newDir == 225 or newDir == 315){
        for (i = 1; i < fieldH; i += 1){ //going up from startY
            var _break = 0;
            params[0] = i * BOMB_DELAY_SCALAR
            
            if startY-i >= 0{script_execute(effect_script,startX,startY-i,params)}
            else{_break += 1}
            
            if _break > 0{break}
        }
    }


break;
// T-Line 
case obj_powerup_bomb_t: 
    if (newDir == 90 or newDir == 270) or (newDir == 45 or newDir == 135){
        for (i = 1; i < fieldW; i += 1){//horizontal
            var _break = 0;
            params[0] = i * BOMB_DELAY_SCALAR
            
            if startX+i < fieldW{script_execute(effect_script,startX+i,startY,params)}
            else{_break += 1}
            if startX-i >= 0{script_execute(effect_script,startX-i,startY,params)}
            else{_break += 1}
            
            if _break > 1{break}
        }
        if newDir == 90 or newDir == 45{
            for (i = 1; i < fieldH; i += 1){ //going down from startY
                var _break = 0;
                params[0] = i * BOMB_DELAY_SCALAR
                
                if startY+i < fieldH{script_execute(effect_script,startX,startY+i,params)}
                else{_break += 1}
                
                if _break > 0{break}
            }
        }
        else if newDir == 270 or newDir == 135{
            for (i = 1; i < fieldH; i += 1){ //going up from startY
                var _break = 0;
                params[0] = i * BOMB_DELAY_SCALAR
                
                if startY-i >= 0{script_execute(effect_script,startX,startY-i,params)}
                else{_break += 1}
                
                if _break > 0{break}
            }
        }
    }
    else {
        for (i = 1; i < fieldH; i += 1){//vertical
            var _break = 0;
            params[0] = i * BOMB_DELAY_SCALAR
            
            if startY+i < fieldH{script_execute(effect_script,startX,startY+i,params)}
            else{_break += 1}
            if startY-i >= 0{script_execute(effect_script,startX,startY-i,params)}
            else{_break += 1}
            
            if _break > 1{break}
        }
        if newDir == 180 or newDir == 225{
            for (i = 1; i < fieldW; i += 1){ //going right from startX
                var _break = 0;
                params[0] = i * BOMB_DELAY_SCALAR
                
                if startX+i < fieldW{script_execute(effect_script,startX+i,startY,params)}
                else{_break += 1}
                
                if _break > 0{break}
            }
        }
        else if newDir == 0 or newDir == 315{
            for (i = 1; i < fieldW; i += 1){ //going left from startX
                var _break = 0;
                params[0] = i * BOMB_DELAY_SCALAR
                
                if startX-i >= 0{script_execute(effect_script,startX-i,startY,params)}
                else{_break += 1}
                
                if _break > 0{break}
            }
        }
    }

break;
// Diagonal Line 
case obj_powerup_bomb_diagonal:
  if (newDir == 45 or newDir == 225) or (newDir mod 90 == 0 and ((startX < fieldW*.5 and startY < fieldH*.5) or 
     (startX > fieldW*.5 and startY > fieldH*.5))){ //if in upper left or bottom right quadrants
    for (i = 1; i < fieldW; i += 1){//going right down and up left \\
        var _break = 0;
        params[0] = i * BOMB_DELAY_SCALAR
        
        if startX+i < fieldW and startY+i < fieldH{script_execute(effect_script,startX+i,startY+i,params)}
        else{_break += 1}
        if startX-i >= 0 and startY-i >= 0{script_execute(effect_script,startX-i,startY-i,params)}
        else{_break += 1}
        
        if _break > 1{break}
    }
  }
  else{
    for (i = 1; i < fieldW; i += 1){//going right up and down left //
        var _break = 0;
        params[0] = i * BOMB_DELAY_SCALAR
        
        if startX+i < fieldW and startY-i >= 0{script_execute(effect_script,startX+i,startY-i,params)}
        else{_break += 1}
        if startX-i >= 0 and startY+i < fieldH{script_execute(effect_script,startX-i,startY+i,params)}
        else{_break += 1}
        
        if _break > 1{break}
    }
  }

break;

// V-Line 
case obj_powerup_bomb_v:
    if (oldDir == 0 and (startX < fieldW*.5))
       or (oldDir == 180 and (startX < fieldW*.5))
       or newDir == 135{
        for (i = 1; i < fieldW-startX and i <= startY; i += 1){//moving up and right ^>
            params[0] = i * BOMB_DELAY_SCALAR
            script_execute(effect_script,startX+i,startY-i,params)
        }
        for (i = 1; i < fieldW-startX and i < fieldH-startY; i += 1){//moving down and right v>
            params[0] = i * BOMB_DELAY_SCALAR
            script_execute(effect_script,startX+i,startY+i,params)
        }   
    }           
    else if (oldDir == 0 or oldDir == 180) or newDir == 315{ 
        for (i = 1; i <= startX and i < fieldH-startY; i++){//moving down and left <v
            params[0] = i * BOMB_DELAY_SCALAR
            script_execute(effect_script,startX-i,startY+i,params)
        }  
        for (i = 1; i <= startX and i <= startY; i += 1){//moving up and left <^
            params[0] = i * BOMB_DELAY_SCALAR
            script_execute(effect_script,startX-i,startY-i,params)
        }              
    
    }
    if (oldDir == 90  and (startY > fieldH*.5))
       or (oldDir == 270 and (startY > fieldH*.5))
       or newDir == 225{
        for (i = 1; i < fieldW-startX and i <= startY; i += 1){//moving up and right ^>
            params[0] = i * BOMB_DELAY_SCALAR
            script_execute(effect_script,startX+i,startY-i,params)
        }
        for (i = 1; i <= startX and i <= startY; i += 1){//moving up and left <^
            params[0] = i * BOMB_DELAY_SCALAR
            script_execute(effect_script,startX-i,startY-i,params)
        } 
    }           
    else if (oldDir == 90 or oldDir == 270) or newDir == 45{ 
        for (i = 1; i <= startX and i < fieldH-startY; i++){//moving down and left <v
            params[0] = i * BOMB_DELAY_SCALAR
            script_execute(effect_script,startX-i,startY+i,params)
        }              
        for (i = 1; i < fieldW-startX and i < fieldH-startY; i += 1){//moving down and right v>
            params[0] = i * BOMB_DELAY_SCALAR
            script_execute(effect_script,startX+i,startY+i,params)
        }    
    }

break;

// X-Cross 
case obj_powerup_bomb_x:
    if newDir mod 90 == 0
    {
        for (i = 1; i < gridSize; i += 1){//going X directions
            var _break = 0;
            params[0] = i * BOMB_DELAY_SCALAR
            
            if startX+i < fieldW and startY+i < fieldH{script_execute(effect_script,startX+i,startY+i,params)}
            else{_break += 1}
            if startX-i >= 0 and startY-i >= 0{script_execute(effect_script,startX-i,startY-i,params)}
            else{_break += 1}
            if startX+i < fieldW and startY-i >= 0{script_execute(effect_script,startX+i,startY-i,params)}
            else{_break += 1}
            if startX-i >= 0 and startY+i < fieldH{script_execute(effect_script,startX-i,startY+i,params)}
            else{_break += 1}
            
            if _break > 3{break}
        }
    }
    else
    {
        for (i = 1; i < gridSize; i += 1){//going + directions
            var _break = 0;
            params[0] = i * BOMB_DELAY_SCALAR
            
            if startX+i < fieldW {script_execute(effect_script,startX+i,startY,params)}
            else{_break += 1}
            if startX-i >= 0{script_execute(effect_script,startX-i,startY,params)}
            else{_break += 1}
            if startY-i >= 0{script_execute(effect_script,startX,startY-i,params)}
            else{_break += 1}
            if startY+i < fieldH{script_execute(effect_script,startX,startY+i,params)}
            else{_break += 1}
            
            if _break > 3{break}
        }
    }

break;

// Checkers Pattern 
case obj_powerup_bomb_checkers:
    var regionSize = round(gridSize * .33) 
    startX1 = startX - regionSize//left bound of region
    startX2 = startX + regionSize//right bound of  region
    if startX1 < 0{
        startX2 -= startX1 //add the overflow to the right bound
        startX1 = 0 //bound the left at 0
    }
    if startX2 >= fieldW{
        startX1 -= (startX2-(fieldW-1)) //add the overflow to the left bound
        startX2 = (fieldW-1) //bound the right at fieldW-1
    }
    startY1 = startY - regionSize //top bound of relative DENSITY region
    startY2 = startY + regionSize //bottom bound of relative DENSITY region
    if startY1 < 0{
        startY2 -= startY1 //add the overflow to the bottom bound
        startY1 = 0 //bound the top at 0
    }
    if startY2 >= fieldH{
        startY1 -= (startY2-(fieldH-1)) //add the overflow to the top bound
        startY2 = (fieldH-1) //bound the bottom at fieldH-1
    }
    for (i = startX1; i <= startX2; i += 2){
        for (j = startY1; j <= startY2; j += 2){
            params[0] = random(room_speed*.5);
            script_execute(effect_script,i,j,params)
        }
    }

break;

// Circle Outline Pattern 
case obj_powerup_bomb_circle:

    var bRad = round(gridSize/4); //2 + 2*(gridSize/5 - 3)
    var dOff = newDir;//irandom_range(0,360);
    
    
    params[0] = 0;
    startXp = 0;
    startYp = 0;
    for (d = 0; d < 180; d += 1){
    
        //Next coordinates
        startXn = round(dcos(d+dOff)*bRad)
        startYn = round(dsin(d+dOff)*bRad)
        
        if startXn != startXp or startYn != startYp{
            script_execute(effect_script,startX+startXn,startY+startYn,params)
            script_execute(effect_script,startX-startXn,startY-startYn,params)
            //script_execute(effect_script,startX-startXn,startY+startYn,params)
            //script_execute(effect_script,startX+startXn,startY-startYn,params)
            params[0] += 1 * BOMB_DELAY_SCALAR
            startXp = startXn;
            startYp = startYn;
            
        }
    }
    
break;




}

#define scr_bomb_type_script_wrapper
///scr_bomb_type_script_wrapper(object_index)

scr_bomb_type_script_execute(argument0, gridXY[0], gridXY[1], ndir, odir, scr_bomb_set_delay, boardClear)

//Increment Bomb Force
scr_bomb_force_add();
/* NB: we pass in the direction parameters to make integration with the bomb calculator script easier
but we still need to reference the original ndir/odir in object scope when we use with(shooter) commands
*/