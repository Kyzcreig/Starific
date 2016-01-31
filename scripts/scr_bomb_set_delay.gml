#define scr_bomb_set_delay
///scr_bomb_set_delay(ax,ay,params)
    //params = [delay,boardClear]
var params = argument[2];
var dataXY;// = noone; //  HTLML5 CLEAR
// Reverse Declare Array For Efficient
dataXY[3] = params[1]; //particle density (boardClear)
dataXY[2] = params[0]; //duration
dataXY[1] = argument[1] //gridY
dataXY[0] = argument[0] //gridX

// Check if Cell is Valid
if gamecell_is_valid(dataXY[0],dataXY[1])
{
    // Check Death Grid for Data
    var deathDataXY = global.DEATH_TIMERS_GRID[#dataXY[0],dataXY[1]];
    
    // If No Detonation Exists for This Cell
    if !is_array(deathDataXY) {
        // Add it to data structures
        global.DEATH_TIMERS_GRID[#dataXY[0],dataXY[1]] = dataXY;
        ds_list_add(global.DEATH_TIMERS_LIST,dataXY);
    }
    // Else if Another Detonation Exists
    else {
        // Compare Durations
        if deathDataXY[2] > dataXY[2] {
            // Use Sooner Duration 
            deathDataXY[@ 2] = dataXY[2];
            // Overwrite Particle Effect Status too 
            deathDataXY[@ 3] = dataXY[3]; 
        }
        // Else Exit
        else {
            exit;    
            /* NB: In essence we will set object data anytime new data
                  is written to the data structures.
            */   
        }
            
    }
    
    // Set Death Data in Object
    var obj = global.FIELD_OBJECTS[# dataXY[0],dataXY[1]];
    if (obj > DENSITY){
        //Set Bomb Vars for Bomb Chain Pattern Calculations
        obj.boardClear = dataXY[3];
        obj.bomber = id;
        obj.destroyer = destroyer;
        obj.bomb_ndir = ndir;
        obj.bomb_odir = odir;
        // Additional Processing for Bomb Direction Adjustments
        with (obj){
            scr_set_reflector_vars_from_shooter(false,false);
        }
    }
}

#define gamecell_is_valid
///gamecell_is_valid(gx,gy,[buffer])
var gX,gY,buffer;
gX = argument[0]
gY = argument[1]
if argument_count > 2{
    buffer = argument[2]
}
else buffer = 0;

if (gX+buffer >= 0 and gX-buffer <= (fieldW-1) and //left and right
    gY+buffer >= 0 and gY-buffer <= (fieldH-1) and //top and bottom
   (gY+buffer > corner - 1 - gX and //top left corner
    gY-buffer < fieldH - corner + gX and //bottom left corner
    gY+buffer > -fieldW + corner + gX and //top right corner
    gY-buffer < fieldW + fieldH - corner - 1 - gX))//bottom right corner
    {
        return true;
    }
    
    return false

#define gamecell_is_on_grid
///gamecell_is_on_grid(gX,gY,buffer)
var gX,gY,buffer;
gX = argument[0]
gY = argument[1]
if argument_count > 2 buffer = argument[2]
else buffer = 0;

if (gX+buffer >= 0 and gX-buffer <= (fieldW-1) and //left and right
    gY+buffer >= 0 and gY-buffer <= (fieldH-1)) //top and bottom
    {
        return true;
    }
    
    return false
#define scr_set_reflector_vars_from_shooter
///scr_set_reflector_vars_from_shooter(bombed,streak)

// Set Data When Deflector Dies

var wasBombed = argument0;
var wasStreak = argument1;
var destroyerExists = instance_exists(destroyer) and destroyer.object_index == obj_star;

// If Deflector Was Not Bombed and Star Exists
if !wasBombed and destroyerExists{
    ndir = destroyer.direction;
    odir = destroyer.sdir;
    spe = starSpeedNoDelta;//destroyer.speed;
    starModifiers = destroyer.starModifiers;
    if wasStreak {
       // Streak Add 1
        destroyer.streak++;
    }
    /*
    with(destroyer){
       //other.multiplier = multiplier
       other.ndir = direction
       other.odir = sdir
       other.spe = speed
       other.starModifiers = starModifiers
       if wasStreak streak += 1;
    }*/
}
// Else if It Was Bombed derive from Bomb Data
else if bomb and bomber != noone 
{

/* NB: This won't fire in bomb_set_delay, it happens at runtime
  I do this so that bombs don't go off in the direction of a piercing shooter
  Also so that a bomb-triggered pierce doesn't undo the direction of a shooter.
  This minimizes redundant bomb-pierce overlap

*/

    odir = bomb_ndir//+= 90
    ndir = (bomb_ndir + rdir + 360) mod 360 //adds +90 or -90
        //NB: We do this so bombs don't all have the same direciton
    if destroyerExists{
        if wasStreak {
           // Streak Add 1
            destroyer.streak++;
        }
        /*
       with(destroyer){
           //streak add 1
           if wasStreak streak += 1;
       }*/
    }
}
// Else Choose Random Direction/Speed
else{
    //multiplier = 1
    ndir = irandom(3) * 90
    odir = ndir - 90
    spe = 0;
    //We set the ballmodifier code in the reflectorparent create event
}