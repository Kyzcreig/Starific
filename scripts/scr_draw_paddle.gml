#define scr_draw_paddle
///scr_draw_paddle(color)



var color = argument0//c_white; colorc = c_white
var alpha = pad_alpha; //NB: decreasing alpha might be a cool effect?

//scr_draw_smoothing(false)
var t = PADDLE_TEXTURES[0];
draw_primitive_begin_texture(pr_trianglestrip,t);

var xtex1, ytex1, xtex2, ytex2, distcorner;
xtex1 = 0; ytex1 = 0; xtex2=xtex1; ytex2=1;


for (cc=ds_list_size(spritestartx);cc>0;cc--){ //left bends
     //start of left side
     rotAngle = rotML[0] - 45*(cc)
     draw_vertex_texture_colour(xL[cc]+dsin(rotAngle)*(-PADDLE_H/2)*image_yscale,
                                yL[cc]+dcos(rotAngle)*(-PADDLE_H/2)*image_yscale,xtex1,ytex1,color,alpha);
     draw_vertex_texture_colour(xL[cc]+dsin(rotAngle)*(PADDLE_H/2)*image_yscale,
                                yL[cc]+dcos(rotAngle)*(PADDLE_H/2)*image_yscale, xtex2,ytex2,color,alpha);
     
     //end the left side
     sSX_array = spritestartx[| cc-1]
     xtex1 = sSX_array[0]/PADDLE_W; ytex1 = 0; xtex2=xtex1; ytex2=1;
     draw_vertex_texture_colour(xL[cc-1] +dsin(rotAngle)*(-PADDLE_H/2)*image_yscale,
                                yL[cc-1] +dcos(rotAngle)*(-PADDLE_H/2)*image_yscale, xtex1,ytex1,color,alpha);
     draw_vertex_texture_colour(xL[cc-1] +dsin(rotAngle)*(PADDLE_H/2)*image_yscale,
                                yL[cc-1] +dcos(rotAngle)*(PADDLE_H/2)*image_yscale, xtex2,ytex2,color,alpha);

     //corner vertex
     rotAngle = rotML[0] - 45*(cc-.5)
     distcorner = (PADDLE_H*image_yscale)/dsin((67.5))
     draw_vertex_texture_colour(xL[cc-1] +dsin(rotAngle)*(-distcorner/2),
                                yL[cc-1] +dcos(rotAngle)*(-distcorner/2), xtex1,ytex1,color,alpha);
     draw_vertex_texture_colour(xL[cc-1] +dsin(rotAngle)*(distcorner/2),
                                yL[cc-1] +dcos(rotAngle)*(distcorner/2),xtex2,ytex2,color,alpha);
}


//begin middle
rotAngle = rotML[0]
draw_vertex_texture_colour(xL[0] +dsin(rotAngle)*(-PADDLE_H/2)*image_yscale,
                           yL[0] +dcos(rotAngle)*(-PADDLE_H/2)*image_yscale, xtex1,ytex1,color,alpha);
draw_vertex_texture_colour(xL[0] +dsin(rotAngle)*(PADDLE_H/2)*image_yscale,
                           yL[0] +dcos(rotAngle)*(PADDLE_H/2)*image_yscale, xtex2,ytex2,color,alpha);
 

//If Split Paddle, split paddle in two                               
if POWER_splitpaddle[7] != 0 {

    
    if ds_list_size(spriteendx) > 0{sEX_array = spriteendx[| 0];lenR=sEX_array[0];}
    else{lenR = PADDLE_W}
    xtex1 = lenR/PADDLE_W/2; ytex1 = 0; xtex2=xtex1; ytex2=1   //half way between                
    draw_vertex_texture_colour(xML[0] +dsin(rotAngle)*(-PADDLE_H/2)*image_yscale,
                               yML[0] +dcos(rotAngle)*(-PADDLE_H/2)*image_yscale, xtex1,ytex1,color,alpha);
    draw_vertex_texture_colour(xML[0] +dsin(rotAngle)*(PADDLE_H/2)*image_yscale,
                               yML[0] +dcos(rotAngle)*(PADDLE_H/2)*image_yscale, xtex2,ytex2,color,alpha);

    draw_primitive_end();
    
    draw_primitive_begin_texture(pr_trianglestrip,t);
    
    
    rotAngle = rotMR[0]        
    draw_vertex_texture_colour(xMR[0] +dsin(rotAngle)*(-PADDLE_H/2)*image_yscale,
                               yMR[0] +dcos(rotAngle)*(-PADDLE_H/2)*image_yscale, xtex1,ytex1,color,alpha);
    draw_vertex_texture_colour(xMR[0] +dsin(rotAngle)*(PADDLE_H/2)*image_yscale,
                               yMR[0] +dcos(rotAngle)*(PADDLE_H/2)*image_yscale, xtex2,ytex2,color,alpha);
}


//end middle
if ds_list_size(spriteendx) > 0{sEX_array = spriteendx[| 0];lenR=sEX_array[0];}
else{lenR = PADDLE_W}
xtex1 = lenR/PADDLE_W; ytex1 = 0; xtex2=xtex1; ytex2=1
draw_vertex_texture_colour(xR[0] +dsin(rotAngle)*(-PADDLE_H/2)*image_yscale,
                           yR[0] +dcos(rotAngle)*(-PADDLE_H/2)*image_yscale, xtex1,ytex1,color,alpha);
draw_vertex_texture_colour(xR[0] +dsin(rotAngle)*(PADDLE_H/2)*image_yscale,
                           yR[0] +dcos(rotAngle)*(PADDLE_H/2)*image_yscale, xtex2,ytex2,color,alpha);

                       
for (cc=0; cc<ds_list_size(spriteendx);cc++){ //right bends
     //corner vertex             
     rotAngle = rotMR[0]  + 45*(cc+.5)              
     distcorner = (PADDLE_H*image_yscale)/dsin(67.5)
     draw_vertex_texture_colour(xR[cc] +dsin(rotAngle)*(-distcorner/2),
                                yR[cc] +dcos(rotAngle)*(-distcorner/2), xtex1,ytex1,color,alpha);
     draw_vertex_texture_colour(xR[cc] +dsin(rotAngle)*(distcorner/2),
                                yR[cc] +dcos(rotAngle)*(distcorner/2),xtex2,ytex2,color,alpha);;
        
     
     //begin right bend
     rotAngle = rotMR[0]  + 45*(cc+1)                                  
     draw_vertex_texture_colour(xR[cc] +dsin(rotAngle)*(-PADDLE_H/2)*image_yscale,
                                yR[cc] +dcos(rotAngle)*(-PADDLE_H/2)*image_yscale, xtex1,ytex1,color,alpha);
     draw_vertex_texture_colour(xR[cc] +dsin(rotAngle)*(PADDLE_H/2)*image_yscale,
                                yR[cc] +dcos(rotAngle)*(PADDLE_H/2)*image_yscale,xtex2,ytex2,color,alpha); 
           
     
     //end right bend
     if cc+1 >= ds_list_size(spriteendx){xtex1=1}
     else{sEX_array = spriteendx[| cc+1];xtex1 = sEX_array[0]/PADDLE_W;}
     ytex1 = 0; xtex2=xtex1; ytex2=1;
     draw_vertex_texture_colour(xR[cc+1] +dsin(rotAngle)*(-PADDLE_H/2)*image_yscale,
                                yR[cc+1] +dcos(rotAngle)*(-PADDLE_H/2)*image_yscale, xtex1,ytex1,color,alpha);
     draw_vertex_texture_colour(xR[cc+1] +dsin(rotAngle)*(PADDLE_H/2)*image_yscale,
                                yR[cc+1] +dcos(rotAngle)*(PADDLE_H/2)*image_yscale,xtex2,ytex2,color,alpha);
     
}

draw_primitive_end();

#define scr_paddle_set_coordinates
///scr_paddle_set_coordinates(xML, yML, xMR, yMR)
//var rotAngle = image_angle;


//Jiggle Paddle and Set Middle coordinates
if id == paddle_id {scr_paddle_jiggle();}
xML[0] = argument0;
yML[0] = argument1; 
xMR[0] = argument2;
yMR[0] = argument3;
//  Add jiggle
if cd_jiggle[0,0] > 0 {
    xML[0] += cd_jiggle[0,1];
    yML[0] += cd_jiggle[0,2];
    xMR[0] += cd_jiggle[0,1];
    yMR[0] += cd_jiggle[0,2];
}


// Get length to first left corner vertex
var sSX_array,sEX_array, scl;
if ds_list_size(spritestartx) > 0{
   sSX_array = spritestartx[| 0]
   //if sSX_array[1] > 1 { scl = 1} else{scl = 1.4142135623731;} 
   lenL=(PADDLE_W / 2 - sSX_array[0])*sSX_array[1]
   //draw_text(padcenterx+30,padcentery-32,'lenL,sSX0,scl='+string(lenL)+', '+string(sSX_array[0])+', '+string(sSX_array[1]))
}
else{
     if rotML[0] mod 90 != 0 {scl = 1.4142135623731}else{scl =  1}
     lenL = (PADDLE_W / 2 - 0)*scl
}


// Get length to first right corner vertex
if ds_list_size(spriteendx) > 0{
   sEX_array = spriteendx[| 0]
   //if sEX_array[1] > 1 { scl = 1} else{scl = 1.4142135623731;} 
   lenR=(PADDLE_W / 2 - sEX_array[0])*sEX_array[1]
   //draw_text(padcenterx+30,padcentery+32,'lenR,sEX0,scl='+string(lenR)+', '+string(sEX_array[0])+', '+string(sEX_array[1]))
}
else{
     if rotMR[0] mod 90 != 0 {scl = 1.4142135623731}else{scl =  1}
     lenR = (PADDLE_W / 2 - PADDLE_W)*scl
}



//yscaleadjx = dsin((image_angle))*PADDLE_H*((1-image_yscale)/2)//this is for the velocity stretch
//yscaleadjy = dcos((image_angle))*PADDLE_H*((1-image_yscale)/2)//this is for the velocity stretch
xL[0] = xML[0] - dcos((rotML[0]))*(lenL)*image_xscale //+yscaleadjx//left main x
yL[0] = yML[0] + dsin((rotML[0]))*(lenL)*image_xscale //+yscaleadjy//left main y
xR[0] = xMR[0] - dcos((rotMR[0]))*(lenR)*image_xscale //+yscaleadjx//right main x
yR[0] = yMR[0] + dsin((rotMR[0]))*(lenR)*image_xscale //+yscaleadjy//right main y

/*
draw_set_color(c_blue)
draw_set_font(fnt_small)
draw_text(padcenterx+30,padcentery,'x,y='+string(x)+','+string(y))
draw_text(padcenterx+30,padcentery-16,'xL,yL='+string(xL[0])+','+string(yL[0]))
draw_text(padcenterx+30,padcentery+16,'xR,yR='+string(xR[0])+','+string(yR[0]))
*/
                                                                   
for (cc=0;cc<ds_list_size(spritestartx);cc++){
    sSX_array = spritestartx[| cc]
    if sSX_array[1] > 1 { scl = 1} else{scl = 1.4142135623731;} 
    lenL = sSX_array[0]*scl
    if cc+1 < ds_list_size(spritestartx){
       sSX_array2 = spritestartx[| cc+1]
       lenL-=sSX_array2[0]*scl//sSX_array[1]//change array[1] ->array2[1]
    }
    xL[cc+1] = xL[cc] - dcos((rotML[0] -45*(cc+1)))*(lenL)*image_xscale //+yscaleadjx//- dsin((image_angle -45))*4 
    yL[cc+1] = yL[cc] + dsin((rotML[0] -45*(cc+1)))*(lenL)*image_xscale //+yscaleadjy//- dcos((image_angle -45))*4
    //draw_set_font(fnt_small)
    //draw_text(padcenterx-60,padcentery-16*(cc+3),'xL'+string(cc+1)+',yL'+string(cc+1)+'='+string(xL[cc+1])+','+string(yL[cc+1])
    //+', spritestartx['+string(cc)+']='+string(spritestartx[| cc])+', lenL='+string(lenL))
}

for (cc=0;cc<ds_list_size(spriteendx);cc++){
    sEX_array = spriteendx[| cc]
    if sEX_array[1] > 1 { scl = 1} else{scl = 1.4142135623731;} 
    lenR = sEX_array[0]*scl//sEX_array[1]
    if cc+1 < ds_list_size(spriteendx){
       sEX_array2 = spriteendx[| cc+1]
       lenR-=sEX_array2[0]*scl//sEX_array[1] ///change array[1] ->array2[1]
    }
    else lenR -= PADDLE_W*scl//sEX_array[1]
    xR[cc+1] = xR[cc] - dcos((rotMR[0] +45*(cc+1)))*(lenR)*image_xscale //+yscaleadjx//- dsin((image_angle -45))*4 
    yR[cc+1] = yR[cc] + dsin((rotMR[0] +45*(cc+1)))*(lenR)*image_xscale //+yscaleadjy//- dcos((image_angle -45))*4
    //draw_text(padcenterx+30,padcentery+16*(cc+3),'xR'+string(cc+1)+',yR'+string(cc+1)+'='+string(xR[cc+1])+','+string(yR[cc+1]))
}

// Calculate Thetas of Paddle Ends
padLenL = ds_list_size(spritestartx)
padLTheta = angle_difference(mouseangle,darctan2(yL[padLenL]-centerfieldy,xL[padLenL]-centerfieldx));

padLenR = ds_list_size(spriteendx)
padRTheta = angle_difference(mouseangle,darctan2(yR[padLenR]-centerfieldy,xR[padLenR]-centerfieldx));


//DEBUG
/*
for (var z = 0, m = array_length_1d(xL); z < m; z++){
    //if x is less than view x or max or same for y
    if xL[z] < GAME_X || xL[z] > GAME_X + GAME_W{
        show_message("not good xL");
    }
    if yL[z] < GAME_Y || yL[z] > GAME_Y + GAME_H{
        show_message("not good yL");
    }

}
for (var z = 0, m = array_length_1d(xR); z < m; z++){
    //if x is less than view x or max or same for y
    if xR[z] < GAME_X || xR[z] > GAME_X + GAME_W{
        show_message("not good xR");
    }
    if yR[z] < GAME_Y || yR[z] > GAME_Y + GAME_H{
        show_message("not good yR");
    }

}*/

#define scr_paddle_set_offsets
///scr_paddle_set_offsets(mouseangle)


var s = 4;//Threshold for bending
var scl = 1.4142135623731; //Scale Factor for diagonals
var pHalf = (( (PADDLE_W) * image_xscale) / 2) - s;

// Recall we're going anti-clockwise when we add angles but 
// since the y is reversed we're going clockwise when we add angles.

//Get starting points
if POWER_splitpaddle[7] != 0{ // or gap ease exists...
    var LRailLoc = scr_paddle_set_location(argument0 + POWER_splitpaddle[7]);
    xML[0] = LRailLoc[1];
    yML[0] = LRailLoc[2];
    vML[0] = LRailLoc[3];
    rotML[0] = LRailLoc[0];
    var RRailLoc = scr_paddle_set_location(argument0 - POWER_splitpaddle[7]);
    xMR[0] = RRailLoc[1];
    yMR[0] = RRailLoc[2];
    vMR[0] = RRailLoc[3];
    rotMR[0] = RRailLoc[0];
}
else{
    rotML[0] = image_angle;
    xML[0] = x;
    yML[0] = y;
    vML[0] = vIndex;
    rotMR[0] = image_angle;
    xMR[0] = x;
    yMR[0] = y;
    vMR[0] = vIndex;
}

// Loop through left corner bends until you run out of scaled paddle width 
var v = vML[0];
var nearestLCorner = point_distance(xML[0],yML[0],centerfieldx+tvertx[v mod 8],centerfieldy+tverty[v mod 8])
if (v mod 8)  mod 2 == 1 {
    nearestLCorner /= scl
}
var lHalf = pHalf; //+ gapSize;
lHalf -= nearestLCorner
//If lHalf is greater than 0 then we hit a corner, add it to list
while lHalf > 0{
    ds_list_add(dtocornerL,nearestLCorner);
    nearestLCorner = point_distance(centerfieldx+tvertx[v mod 8],centerfieldy+tverty[v mod 8],
                                    centerfieldx+tvertx[(v+1) mod 8],centerfieldy+tverty[(v+1) mod 8])
    if ((v+1) mod 8) mod 2 == 1 {
        nearestLCorner /= scl
        //different modulo because no change in V
    } 
    lHalf -= nearestLCorner
    //increment angle array by 1 for next corner
    v +=1
}

//For each corner we hit, calculate its distance from center of paddle
var d2cL = 0
for (var cc=0; cc<ds_list_size(dtocornerL); cc+=1)
{
    var armLength, armScale = 1, vals = noone; //To hold diagonal scaling data
    d2cL += dtocornerL[| cc]
    armLength = PADDLE_W / 2 - (d2cL) / image_xscale;
    if (rotML[0]+cc*1) mod 2 == 1 {armScale = scl}
    vals[0] = armLength; vals[1] = armScale;
    ds_list_add(spritestartx,vals)//PADDLE_W / 2 - (d2cL) / image_xscale)
}
ds_list_clear(dtocornerL)



//Loop through right corner bends until you run out of scaled paddle width 
var v = (vMR[0]+7) //start angle to right
var nearestRCorner = point_distance(xMR[0],yMR[0],centerfieldx+tvertx[v mod 8],centerfieldy+tverty[v mod 8]);
if (v mod 8) mod 2 == 0{
    nearestRCorner /= scl
}
var rHalf = pHalf; //+ gapSize;
rHalf -= nearestRCorner;
//If rHalf is greater than 0 then we hit a corner, add it to list
while rHalf > 0{
      ds_list_add(dtocornerR,nearestRCorner)
      nearestRCorner = point_distance(centerfieldx+tvertx[v mod 8],centerfieldy+tverty[v mod 8],
                                      centerfieldx+tvertx[(v+7) mod 8],centerfieldy+tverty[(v+7) mod 8])
      if ((v+7) mod 8) mod 2 == 0{
        nearestRCorner /= scl
      }
      rHalf -= nearestRCorner
      //increment angle array by 7, equivalent to -1, but GMS has fucked negative modulus
      v +=7
}
//For each corner we hit, calculate its distance from center of paddle
var d2cR = 0
for (var cc=0; cc<ds_list_size(dtocornerR); cc+=1)
{
    var armLength, armScale = 1, vals = noone; //To hold diagonal scaling data
    d2cR += dtocornerR[| cc]
    armLength = PADDLE_W / 2 + (d2cR) / image_xscale;
    if ((rotMR[0]+7)+cc*7) mod 2 == 0 {armScale = scl}
    vals[0] = armLength; vals[1] = armScale;
    ds_list_add(spriteendx,vals)//PADDLE_W / 2 + (d2cR) / image_xscale) 
}
ds_list_clear(dtocornerR)
//sin/cos to center the paddle on the rail


#define scr_paddle_placement
///scr_paddle_placement(mouseangle);

//if ds_list_size(dtocornerL)>1 ds_list_clear(dtocornerL)
//if ds_list_size(dtocornerR)>1 ds_list_clear(dtocornerR)



ds_list_clear(spritestartx) //represent lengths of the left paddle sections
ds_list_clear(spriteendx) //represent lengths of the right side paddle sections
//PADDLE_W = sprite_get_width(sprite_index)


//Calculate Paddle Coordinates
railLoc = scr_paddle_set_location(argument0);
x = railLoc[1]; 
y = railLoc[2];
vIndex = railLoc[3];
image_angle = railLoc[0];
scr_paddle_set_offsets(argument0);
scr_paddle_set_coordinates(xML[0], yML[0], xMR[0], yMR[0]);


#define scr_paddle_set_location
///scr_paddle_set_location(mouseangle)

//Recall we're going anti-clockwise when we add angles but since the y is reversed we're going clockwise when we add angles.
angle = startangle
for (i=0;i<8;i++){
    //Check to see if argument0 is below angle and above angle minus 1 increment
    if((argument0 > angle-RAIL_ANGLES[i mod 2] && argument0 <= angle) || 
        (argument0 > 360-RAIL_ANGLES[0]/2 && angle == startangle)){
        //Carefyk with >=  here, it causes multiple dtocorner code to fire.
        //show_message('i, angle, argument0, cos, sin: '+string(i)+','+string(angle)+','+string(argument0)+','+string(dcos((angle)))+','+string(dsin((angle))))
        //show_message('vertx[7]]:'+string(vertx[7]))
        //show_message('i, i-1mod8:'+string(i)+','+string(-1 % 8))
        //show_message('vertx,vertx[i-1]:'+string(vertx[(((i-1) mod 8)+1)]))
        if(floor(tvertx[i])==floor(tvertx[(i+7) mod 8])){  
            mx = (pradiusx+PADDLE_H/2)*dcos((angle));
            my = (pradiusy+PADDLE_H/2)*dsin((argument0));
            
            if argument0 >= startangle + RAIL_ANGLES[1] * 2 + RAIL_ANGLES[0] and
             argument0 <= startangle + RAIL_ANGLES[1] * 2 + RAIL_ANGLES[0] * 2{railLoc[0] = 270}//left
            else{railLoc[0] = 90}//right
       
        }
        else if(floor(tverty[i])==floor(tverty[((i+7) mod 8)])){
            mx = (pradiusx+PADDLE_H/2)*dcos((argument0));
            my = (pradiusy+PADDLE_H/2)*dsin((angle));
            
            if argument0 >= startangle + RAIL_ANGLES[1] * 1 + RAIL_ANGLES[0] * 0 and
             argument0 <= startangle + RAIL_ANGLES[1] * 1 + RAIL_ANGLES[0] * 1{railLoc[0] = 0}//bottom
            else{railLoc[0] = 180}//top
   
        }
        else{  
            langle= angle-RAIL_ANGLES[i mod 2]; //angle of previous iteration - last angle //you may need to use the array system here [i-1]
            perc = angle-langle; //perc is the percentage of the angle at which mouse angle is //in this STEP we put things in terms of a proportion between 0 and 1
            perc = (argument0-langle)/perc; //so this is the proportion of the angle distance travelled from the langle (0) to the angle (1)
    
            mx = tvertx[(i+7) mod 8]+(tvertx[i]-tvertx[(i+7) mod 8])*(perc) //+ dcos((railLoc[0] - 90))*0; //(px-ly) is the delta between the last vertex and the current vertex
            my = tverty[(i+7) mod 8]+(tverty[i]-tverty[(i+7) mod 8])*(perc) //- dsin((railLoc[0] - 90))*0; //then we multiply this delta difference by the perc percentage which is the argument0 proportion
            //then we just add that percentage of delta X,Y to the lx and ly which is the previous vertex
            //now we decide the image angle accordingly
            
            if argument0 >= startangle + RAIL_ANGLES[1] * 0 + RAIL_ANGLES[0] * 0 and 
             argument0 <= startangle + RAIL_ANGLES[1] * 1 + RAIL_ANGLES[0] * 0{ railLoc[0] = 45}
            else if argument0 >= startangle + RAIL_ANGLES[1] * 1 + RAIL_ANGLES[0] * 1 and
             argument0 <= startangle + RAIL_ANGLES[1] * 2 + RAIL_ANGLES[0] * 1{ railLoc[0] = 315}
            else if argument0 >= startangle + RAIL_ANGLES[1] * 2 + RAIL_ANGLES[0] * 2 and
             argument0 <= startangle + RAIL_ANGLES[1] * 3 + RAIL_ANGLES[0] * 2{ railLoc[0] = 225}
            else if argument0 >= startangle + RAIL_ANGLES[1] * 3 + RAIL_ANGLES[0] * 3 and
             argument0 <= startangle + RAIL_ANGLES[1] * 4 + RAIL_ANGLES[0] * 3{ railLoc[0] = 135}
            
        }  
        
        // Orient over centerfield
        railLoc[1] = centerfieldx + mx;
        railLoc[2] = centerfieldy + my;
        railLoc[3] = i;
        
        return railLoc;
        
        break;

    
    }
angle+=RAIL_ANGLES[(i+1) mod 2];
}

#define scr_paddle_jiggle
///scr_paddle_jiggle()

// Jiggle Adjustments
if cd_jiggle[0,0] > 0{
    cd_jiggle[0,0] -= 1;
    
    var jiggle_strength = 6;
    cd_jiggle[0,1] = random(1)*jiggle_strength;
    cd_jiggle[0,2] = random(1)*jiggle_strength;
}
/*else {
    cd_jiggle[0,1] = 0;
    cd_jiggle[0,2] = 0;
}

#define scr_paddle_init
///scr_paddle_init()

// Paddle Launcher Here
if object_index == obj_launcher {
    //debug_array[0] = 1*PADDLE_SCALE  //For some reason this needs to be above pad_xscale for HTML to export
    pad_xscale[0] = 1*PADDLE_SCALE
    
    //Reset Split Paddle
    POWER_splitpaddle[@ 7] = 0;
    
    padLTheta = 0
    padRTheta = 0
    
    // Tween In
    scaleTweener = scr_paddle_tween_in()
    // Enables PADDLE_MOTION (only in obj_launcher)
    if !TUTORIAL_ENABLED{
        TweenAddCallback(scaleTweener,TWEEN_EV_FINISH,id,scr_set_paddleMovement, 1);
    }
    
    // Set Paddle Color Timer Array
    padColorTimers = scr_create_array(0,0,0);
    
    //sprite_index = sp_launcher_white
    image_angle = 0//global.paddle.image_angle - 180
    image_xscale = 1
    image_yscale = 1
    image_index = 0
    image_speed = 0
    newyscale = 1
    oldx = x
    oldy = y
    
    // Arrow Vars
    xx1 = 0
    yy1 = 0
    xx2 = 0
    yy2 = 0
    axx = 0
    ayy = 0
    newxx2=0
    newyy2=0
    //oldxx2=0
    //oldyy2=0
    axx1 = 0
    ayy1 = 0
    
    //Paddle Jiggle
    jiggletime = .5*room_speed;
    cd_jiggle[0,0] = 0;
    cd_jiggle[0,1] = 0;
    cd_jiggle[0,2] = 0;


} else if object_index == obj_launcher_mirror {
    //alarm[0] = 10
    inversion = 0
    marker_color = c_white
    depth = paddle_id.depth
    
    
    startangle = paddle_id.startangle; //this is just my cardinal side angle divided by 2, since it starts at 0
    
    
    //This is 1 instead of *PADDLE_SCALE because it is dependent on the paddle_id already
    pad_xscale[0] = 1//*PADDLE_SCALE//paddle_id.pad_xscale[0]
    // Tween In
    scaleTweener = scr_paddle_tween_in()
    
    
    //sprite_index = paddle_id.sprite_index
    image_angle = paddle_id.image_angle
    image_xscale = paddle_id.image_xscale
    image_yscale = paddle_id.image_yscale
    
    tweeningOut = false;
    
    
    //Paddle Jiggle
    jiggletime = paddle_id.jiggletime
    cd_jiggle = paddle_id.cd_jiggle;

}

// Draw Params for Paddle
pad_alpha = 1;
padColor[0] = COLORS[0];
mirrorColorDeath = false;



// Data Structures for Coordinate Calculations
spritestartx = ds_list_create()
spriteendx = ds_list_create()
dtocornerL = ds_list_create()
dtocornerR = ds_list_create()

// List For Collisions
caughtList = ds_list_create();



// Alloc Memory for Coordinates
xML[0] = 0
yML[0] = 0
xMR[0] = 0
yMR[0] = 0
rotML[0] = 0;
rotMR[0] = 0;
xL[0] = 0;
yL[0] = 0;
xR[0] = 0;
yR[0] = 0;


// Angle Vars
startangle = RAIL_ANGLES[0]/2////22.5
angle = startangle



birthStep = STEP;
railLoc = noone; //array for rail location params



//2 angles back
/*

v0-v1 bigside 
v1-v2 diagonal





v2-v3 diagonal
v3-v4 bigside
v4-v5 diagonal
v5-v6 bigside
v6-v7 diagonal
v7-v0 bigside