#define scr_star_inPlay_direction_is_valid
///scr_star_inPlay_direction_is_valid()

var _ret = false;

// Grab the coordinates of its line of direction
var star_pos = noone, line_dist =(gridSize/2)*cellSize; //(railset*2)*cellW
star_pos[0] = x - dcos((direction))*cellSize/2//line_dist/10
star_pos[1] = y + dsin((direction))*cellSize/2//line_dist/10 
star_pos[2] = x + dcos((direction)) * line_dist
star_pos[3] = y - dsin((direction)) * line_dist
    //NB to calculate the line moving in a certain direction we can just do the x/y + the cos/sin in the direction of movement. and for a far distance.


//For each side of the rail, find an intersection for the line segments.
for (var i=0; i < 8; i++)
{
    // Find Intersection With Field
    intersect = lines_intersect(star_pos[0],star_pos[1],star_pos[2],star_pos[3],
                                centerfieldx+innerVertx[i],
                                centerfieldy+innerVerty[i],
                                centerfieldx+innerVertx[(i+1) mod 8],
                                centerfieldy+innerVerty[(i+1) mod 8],true)
    // Found Intersection
    if intersect[0] == true {
       // Mark As Hittable
       //inPlay = 2;
       _ret = true; 
       break;
    }
} 

return _ret;


#define scr_star_inPlay_location_is_valid
///scr_star_inPlay_location_is_valid(gridX,gridY,buffer)

var gX = argument0;
var gY = argument1;
var buf = argument2;
var ret = false;

if gamecell_is_valid(gX,gY,buf)//.5)//5
{
    ret = true;
    intersect[0] = false; //Used for the autoaimer script
}


return ret;

#define scr_star_assert_inPlay_direction
///scr_star_assert_inPlay_direction()

// If Not Heading Back Into Play
if !scr_star_inPlay_direction_is_valid() {
    // Flag As Hittable Still
    //inPlay = 2;
    // Modify Trajectory Direction
    //direction += choose(-90,90); //choose(-2,-1,1,2)*45
    direction = real_roundto(point_direction(x,y,centerfieldx,centerfieldy),45);//90
    //direction += choose(-2,-1,1,2)*45
} 