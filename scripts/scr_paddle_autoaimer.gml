///scr_paddle_autoaimer(grabtheta)

///var grabtheta = argument[0]
nearestStar = noone;
//nearestStarTheta = undefined;
//For each star 
with(obj_star)
{
    
    //Skip if not in play or not in detection area
    if inFieldState != inFieldActive or 
       !gamecell_is_valid(gridXY[0],gridXY[1], railset+1)
       //And outside of the field
       //gamecell_is_valid(ax,ay,-1) and
       //But within reach of the paddle (railset) buffer zone
       //!gamecell_is_valid(ax,ay, railset+1)
    {
        continue
    }
    
    // Now we have only stars inPlay but going out of bounds
    else
    {   
        
        //If we haven't already calculated its intersection point
        if true //intersect[0] == false
        {

            // Grab the coordinates of its line of direction
            var star_pos = noone, line_dist =(fieldW+railset*3)*cellW; //(railset*2)*cellW
            star_pos[0] = x - dcos((direction))*cellW//line_dist/10
            star_pos[1] = y + dsin((direction))*cellW//line_dist/10 
            star_pos[2] = x + dcos((direction)) * line_dist
            star_pos[3] = y - dsin((direction)) * line_dist

                //NB to calculate the line moving in a certain direction we can just do the x/y + the cos/sin in the direction of movement. and for a far distance.
            
            
            //For each side of the rail, find an intersection for the line segments.
            for (i=0; i < 8; i++)
            {
                intersect = lines_intersect(star_pos[0],star_pos[1],star_pos[2],star_pos[3],
                            centerfieldx+vertx[i],centerfieldy+verty[i],
                            centerfieldx+vertx[(i+1) mod 8],
                            centerfieldy+verty[(i+1) mod 8],true)

                if intersect[0] == false{continue}
                else{ 
                   starTheta = angle_difference(NewMAFromCenter,darctan2(intersect[2]-centerfieldy,intersect[1]-centerfieldx));
                   //check if this is within paddle thetas of mouse angle
                   //!(leftTheta < starTheta < rightTheta) to activate autoaim
                   ls = paddle_id.padLTheta < starTheta
                   rs = starTheta < paddle_id.padRTheta
                   grabTheta = argument0//180//5;
                   lsg = paddle_id.padLTheta - grabTheta < starTheta
                   rsg = starTheta < paddle_id.padRTheta + grabTheta
                   break;
                }
            } 
            //show_message(str_debug('intersect after forloop',intersect[0]))
        }
        
        //If Malfunctioned in finding intersection between rail and star
        if intersect[0] == false
        {
            //show_message('check out my local vars in debugger: '+string(id))
            //image_blend = c_green
            continue
        }
        
        //If star if within specific reach argument
        if ((!rs and rsg) or (!ls and lsg))
        {
             //NewMAFromCenter -=  starTheta * attractFactor;
             //if is_undefined(obj_control_game.nearestStarTheta) or abs(starTheta) < abs(obj_control_game.nearestStarTheta)
             //If star if nearer than previous nearest star, save theta
             var dist_from_center = point_distance(x,y,centerfieldx,centerfieldy);
             if !is_array(obj_control_game.nearestStar) or obj_control_game.nearestStar[2] < dist_from_center
             {
                obj_control_game.nearestStar[0] = id;
                obj_control_game.nearestStar[1] = starTheta;
                obj_control_game.nearestStar[2] = dist_from_center;
             } 
        }
    }
}
if is_array(nearestStar)//!is_undefined(nearestStarTheta)
{
    //attractFactor = .4
    //NewMAFromCenter -=  min(abs(nearestStarTheta-paddle_id.padLTheta),abs(nearestStarTheta-paddle_id.padRTheta)) * 1.1 *sign(nearestStarTheta) //attractFactor;
    //NewMAFromCenter =  nearestStarTheta
    var starTheta = darctan2(nearestStar[0].y -centerfieldy, nearestStar[0].x - centerfieldx);
    //NewMAFromCenter = starTheta
    NewMAFromCenter = mouseangle + (starTheta - mouseangle) * .1
    prevAImouseangle = NewMAFromCenter;
}
else{
    NewMAFromCenter = prevAImouseangle;
}
    
