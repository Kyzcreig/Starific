/*
    point_bounds(pointX, pointY, x1, y1, x2, y2);
    
    x1, y1 ----------------------+
       |                         |
       |                         |
       |    (pointX, pointY)     |
       |                         |
       |                         |
       +--------------------- x2, y2
    
    Checks whether or not given coordinates are within a given rectangle.
*/

//Check the mouse position against the arguments given
if (argument0 > argument2) && (argument1 > argument3) && (argument0 < argument4) && (argument1 < argument5)
{
    return true;
}
else
{
    return false;
}
