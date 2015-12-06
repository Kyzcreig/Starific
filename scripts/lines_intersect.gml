/// lines_intersect(x1,y1,x2,y2,x3,y3,x4,y4,segment)
//
//  Returns a vector multiplier (t) for an intersection on the
//  first line. A value of (0 < t <= 1) indicates an intersection 
//  within the line segment, a value of 0 indicates no intersection, 
//  other values indicate an intersection beyond the endpoints.
//
//      x1,y1,x2,y2     1st line segment
//      x3,y3,x4,y4     2nd line segment
//      segment         If true, confine the test to the line segments.
//
//  By substituting the return value (t) into the parametric form
//  of the first line, the point of intersection can be determined.
//  eg. x = x1 + t * (x2 - x1)
//      y = y1 + t * (y2 - y1)
//
/// GMLscripts.com/license
var L1x1,L1y1,L1x2,L1y2,L2x1,L2y1,L2x2,L2y2, _vals;
L1x1 = argument0
L1y1 = argument1
L1x2 = argument2
L1y2 = argument3
L2x1 = argument4
L2y1 = argument5
L2x2 = argument6
L2y2 = argument7
segment = argument8

_vals[0] = false; //return array

//We put lines in C = Ax+By form
var A1,B1,C1,A2,B2,C2
A1 = L1y2 - L1y1
B1 = L1x2 - L1x1
C1 = A1*L1x1 - B1*L1y1
A2 = L2y2 - L2y1
B2 = L2x2 - L2x1
C2 = A2*L2x1 - B2*L2y1

var det = A1*B2 - A2*B1 //tells us if it's paralell, using rise*run -rise*run
//Recall floats are derpy so we use epsilon conditions
if abs(det) < .01 {return _vals}

//X Val
_vals[1] = (B2*C1 - B1*C2)/det
//Y Val
_vals[2] = (A2*C1 - A1*C2)/det
/*
show_message('before segment '+
            str_debug('L1x1',L1x1)+
            str_debug('L1y1',L1y1)+
            str_debug('L1x2',L1x2)+
            str_debug('L1y2',L1y2)+
            str_debug('L2x1',L2x1)+
            str_debug('L2y1',L2y1)+
            str_debug('L2x2',L2x2)+
            str_debug('L2y2',L2y2)+
            str_debug('x intersect',_vals[1])+
            str_debug('y intersect',_vals[2]))*/

if segment
{
    //Check if inside vector X vals of line segment
    if !(_vals[1] - min(L1x1,L1x2) >= -5 and  -5 <= max(L1x1,L1x2) - _vals[1])
    {
       //show_message('premature exit 1')
       return _vals
    }
    if !(_vals[1] - min(L2x1,L2x2) >= -5 and  -5 <= max(L2x1,L2x2) - _vals[1])
    {
       //show_message('premature exit 2')
       return _vals
    }
    //show_message('after x check '+str_debug('x intersect',_vals[1])+str_debug('y intersect',_vals[2]))
    //Check if inside vector Y vals
    if !(_vals[2] - min(L1y1,L1y2) >= -5 and  -5 <= max(L1y1,L1y2) - _vals[2])
    {
       //show_message('premature exit 3')
       return _vals
    }
    if !(_vals[2] - min(L2y1,L2y2) >= -5 and  -5 <= max(L2y1,L2y2) - _vals[2])
    {
       //show_message('premature exit 4')
       return _vals
    }
    //I think i know the issue, it has to do with epsilon here.
    //show_message('after y check '+str_debug('x intersect',_vals[1])+str_debug('y intersect',_vals[2]))
}

//Returns aray where [0] = success/failure; [1] = x; [2] = y
_vals[0] = true
return _vals
