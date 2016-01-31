///scr_collision_paddle(rot)]


//Round GridXY so we don't get off axis after changing direction e.g. on diagonals.
gridXY = intGridXY;

// Set Rotation/Direction
rot = argument[0];
// Round Direction
//rot = real_roundto(rot,45);
rot = (rot + 360) mod 360;
// Round Direction
//direction = real_roundto(direction, 45); //Maybe the issue on the lane spawn thing is direction?
// Cache Star Direction
olddir = direction 
// Calculate New Direction
direction = ((2*(rot) - direction) + 360) mod 360 //- 180

// If Not Going a 180 Degree Turn
if ((olddir+180) mod 360) != direction//direction mod 90 == 0
{
   //  Then Calculate Exception Cases Where we keep star in proper lane 
   if gridXY[0] < 0 and direction == 90 {direction = olddir + 180}//0}//olddir + 180 //bottom left wrongly turning up, corrects to rigt
   else if gridXY[1] >= fieldH and direction == 0 {direction =  olddir + 180}//} //bottom left wrongly turns right, corrects up
   else if gridXY[0] < 0 and direction == 270 {direction =  olddir + 180}//0}//top left wrongly turning down, corrects right
   else if gridXY[1] < 0 and direction == 0 {direction =  olddir + 180}//270} //top left wrongly turning right, corrects down
   else if gridXY[1] < 0 and direction == 180 {direction =  olddir + 180}//270} //top right wrongly turning left, corrects down 
   else if gridXY[0] >= fieldW and direction == 270 {direction =  olddir + 180}//180}//top right wrongly turning down, corrects left
   else if gridXY[1] >= fieldH and direction == 180 {direction =  olddir + 180}//90}//bottom right wrongly turning left, corrects up
   else if gridXY[0] >= fieldW and direction == 90 {direction =  olddir + 180}//180} //bottom right wrongly turning up, corrects left
   
   
   //For the diagonals it would make sense to-do a 180 i think.
   //We check if they're on the corner line.
   //We may need to fix some of these other ones if we encounter any bugs.
   if (gridXY[1] < -fieldW + corner + gridXY[0] + 1) and direction == 135{direction =olddir +180} //top right
   else if (gridXY[1] < -fieldW + corner + gridXY[0] + 1) and direction == 315{direction =olddir +180}
   else if (gridXY[1] < corner - gridXY[0] + 0) and direction == 45{direction =olddir +180}// top left
   else if (gridXY[1] < corner - gridXY[0] + 0) and direction == 225{direction  =olddir +180}
   else if (gridXY[1] > fieldH - corner + gridXY[0] -1) and direction == 135{direction =olddir +180} // bottom left
   else if (gridXY[1] > fieldH - corner + gridXY[0] -1) and direction == 315{direction  =olddir +180}
   else if (gridXY[1] > fieldW + fieldH - corner - gridXY[0] -2) and direction == 225{direction =olddir +180} //bottom right
   else if (gridXY[1] > fieldW + fieldH - corner - gridXY[0] -2) and direction == 45{direction  =olddir +180}
   
   fieldXY = convertGridtoXY(gridXY[0],gridXY[1]);
   x = fieldXY[0];
   y = fieldXY[1];

}

// Check that Speed isn't Negative
if speed < 0{
    // If So Invert Direction
    direction*=-1
}

// Update Play State
inFieldState = 0;
// Correct Direction if Not Heading Into Field
scr_star_assert_inPlay_direction();
    /* NB: Changes direction to head toward field if it isn't.
    
    */
    
// Play Sound
scr_sound(sd_collide_with_paddle, 1, false);

// Set sdir param
sdir = direction;

// Check Last Touch
var force_spawn = false;
// If Paddle
if lastTouched == obj_launcher {
    // Flag Force Spawn
    force_spawn = true;
}
// Set Last Touch
lastTouched = obj_launcher;

// Spawn Cell if Empty Lane (so it's not boring)
scr_spawner_lane(gridXY, direction, 1, force_spawn);


//alarm[1] = 5 //this alarm will reset reflect
addmulti = 0;
if streak > lastLongestStreak {lastLongestStreak = streak}
streak = 0;


//Spawn Paddle Collision Effect
//part_type_direction(p_impact,sdir-50,sdir+50,0,0);
part_type_direction(p_impact,0,359,0,0);
part_type_gravity(p_impact,.075*RMSPD_DELTA,rot+90);//.09
part_particles_create_color(PSYS_SUBSTAR_LAYER, x, y,p_impact,c_trail, 100);//



//Increment pCombo
scr_increment_combo(0)



//Add points for successful hit
var added = 5;
scr_raw_score_add(added);
// Update Stats
added = scr_calculate_points(added);
score_p1 += added;
lastPPD += added;
lastSCatches += 1
time_left += added//level;



//Tween Star scale up on collision
scr_star_scale(EaseLinear,scaleTweenDur, auxScale, auxScaleMax, auxScaleTween);

