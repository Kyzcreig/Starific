#define scr_grid_collision
///scr_grid_collision(ax,ay)
var gX = argument0;
var gY = argument1;
//Check if Grid Location is Valid
if gamecell_is_valid(gX,gY,rangeBuffer)
{

    var cellValue = global.FIELD_OBJECTS[# gX,gY];
    if (cellValue - DENSITY) >= 0 and instance_exists(cellValue){
        _collidedwith = cellValue //intentionally defined here
        
        if !_hasTurned{
            //Random turn mod
            if starModifiers[4] {starModifiers[0] = choose(0,.5,1,1.5,2)}
            //Diagonal turn mod
            else if starModifiers[5]{
                 if sdir mod 90 != 0 starModifiers[0] = 1;
                 else starModifiers[0] = .5;
            }
            //Cardinalize direction
            else if starModifiers[0] == 1 and sdir mod 90 != 0{
                 starModifiers[0] = .5;
                 sdir -=_collidedwith.rdir*.5;
            } 
            //Set New Shooter Motion
            motion_set(direction + _collidedwith.rdir*(starModifiers[0]),speed);
            _hasTurned = true;
        }
    
        // Set Last Touch
        lastTouched = _collidedwith.object_index;
        
        //Destroy collided object
        with (_collidedwith){
             destroyer = other.id
             event_perform(ev_other, ev_user0);
             //instance_destroy();
        }
        
        // Update Stats
        scr_grid_collision_update_stats(); 
    }  
}

#define scr_grid_collision_update_stats
///scr_grid_collision_update_stats()

addmulti += 1;
careerReflects += 1 //maybe these should only be one for the whole 3x3?
lastReflects += 1
lastRPD += 1  

#define scr_out_of_bounds_destroy
///scr_out_of_bounds_destroy()

if x < GAME_X or 
   x > GAME_X + GAME_W or 
   y < GAME_Y or
   y > oy + cellH*(fieldH + railset*2){
   instance_destroy()
}