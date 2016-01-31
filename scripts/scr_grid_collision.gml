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
            
            //Random Chance for Star Divide
            if scr_gamemod_get_index("star_division", 8) > 0 {
                if random(1) < scr_gamemod_get_index("star_division", 10) {
                    // Create Another Star
                    var copyFieldXY = convertGridtoXY(intGridXY[0], intGridXY[1]);
                    spawn_star(direction +180,copyFieldXY[0],copyFieldXY[1]);
                    scr_popup_text_field_moving(x,y,'star division!',power_type_colors(1, 0));
                }
            }
            
            //Random Chance for Star Pulse
            if scr_gamemod_get_index("pulsar_stars", 8) > 0 {
                if random(1) < scr_gamemod_get_index("pulsar_stars", 10) {
                    // Activate Star Pulse Timer
                    if starModifiers[6] <= 0 {
                        starModifiers[6] = 5*60; //60FPS, we decrement RMSPD_DELTA 
                        scr_popup_text_field_moving(x,y,'pulsar!',power_type_colors(1, 0));
                    }
                }
            }
            
            //Random Chance for Star Fickle
            if scr_gamemod_get_index("fickle_stars", 8) > 0 {
                if random(1) < scr_gamemod_get_index("fickle_stars", 10) {
                    // Activate Star Pulse Timer
                    if starModifiers[7] <= 0 {
                        starModifiers[7] = 5*60; //60FPS, we decrement RMSPD_DELTA 
                        scr_popup_text_field_moving(x,y,'fickle star!',power_type_colors(2, 0));
                    }
                }
            }
        }
    
        // Set Last Touch
        lastTouched = _collidedwith.object_index;
        
        //Destroy collided object
        with (_collidedwith){
             destroyer = other.id;
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