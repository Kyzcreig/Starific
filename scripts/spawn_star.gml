#define spawn_star
///spawn_star(direction,x,y)

// Spawn Star
var obj = instance_create(argument[1],argument[2],obj_star);
with (obj){
    //if sdir mod 90 == 0 {direction = other.ndir + 180;}//sdir - rdir
    //else{direction = sdir+(sdir-direction)//clever way to-double add the difference}
    direction = argument[0];
    
    // If Set Starmodifiers
    if object_is_ancestor(other.object_index, obj_powerup_falling)//obj_reflector_parent){ 
    {
        //multiplier = other.multiplier;
        starModifiers = other.starModifiers;
        starModifiers[1] = false; //ballMod_on color
        starModifiers[3] = false; //bigStar_on
        //this allows the new star to toggle on its scale and color
    }
    
    // If Not in Field
    if !scr_star_inPlay_location_is_valid(gridXY[0],gridXY[1],rangeBuffer) {
        /*
        // If Not Heading Towards Field
        if !scr_star_inPlay_direction_is_valid() {
            // Flag as Hittable
            inPlay = 2;
        }*/
        // Assert Valid Direction to be Moving Towards Field
        scr_star_assert_inPlay_direction();
    }
    //inPlay = 0;
    //inField = false;
}

#define scr_reflector_init_star_modifiers
///scr_reflector_init_star_modifiers()


//NB: Background Array Declation
starModifiers[5] = false //turnCardinal 
starModifiers[4] = false //turnRandom 
starModifiers[3] = false //bigStar_is_on
starModifiers[2] = false //bigStar
starModifiers[1] = false //ballMod_on
starModifiers[0] = 1 //turnMultiple