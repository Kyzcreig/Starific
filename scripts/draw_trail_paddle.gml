#define draw_trail_paddle
///draw_trail_paddle(x,y,length,width,color,sprite,slim,alpha)
//Ex. draw_trail(32,32,c_white,-1,1,1)
var Length,Width,Color,Sprite,Slim,Alpha,AlphaT,Texture,Dir,Min,Height;
//Preparing variables
Length = argument2; //How many previous coordinates will use the trail
Width = argument3; //How wide will the trail be
Color = argument4; //Which color will be used to tint the trail
Sprite = argument5; //Which sprite's texture must be used for the trail. Must have "Used for 3D" marked. -1 for no sprite 
Slim = argument6; //Whether the trail will slim down at the end
Alpha = argument7; //The alpha to draw the trail with (0-1), optional
ArrayTrail[0,0] = argument0;
ArrayTrail[0,1] = argument1;
ArrayTrail[0,3] = Width; //save what width was at this STEP
Height = array_height_2d(ArrayTrail); //height is first dimension

if (Height > 1){
    while true{
          if !dtp_helper(ArrayTrail,Height,Length,Width){break} //Could cause infinite loops watch out
    }
    

    //Getting distance between current and past coordinates
    ArrayTrail[0,2] = point_distance(ArrayTrail[0,0],ArrayTrail[0,1],ArrayTrail[1,0],ArrayTrail[1,1]) + ArrayTrail[1,2]; //doesn't run first pass
    //The sub2 values are like a cumulative running total used for calculate the texture coords

}
else {ArrayTrail[0,2] = 0;} //does run first pass; array[i,2] is used for texture placement


//Setting the texture
if (Sprite >= 0) Texture = sprite_get_texture(Sprite,0);
else Texture = -1;
texture_set_repeat(1);


//Drawing the primitive
draw_primitive_begin_texture(pr_trianglestrip,Texture);
AlphaT = 1;
Dir = 0;
Min = min(Height - 1,Length);
for(var i = 0; i < Min; i++){

  Width = Width//ArrayTrail[i,3]
  if (ArrayTrail[i,0] != ArrayTrail[i+1,0] || ArrayTrail[i,1] != ArrayTrail[i+1,1])
    Dir = point_direction(ArrayTrail[i,0],ArrayTrail[i,1],ArrayTrail[i+1,0],ArrayTrail[i+1,1]);
  var Len = Width / 2 - ((i + 1) / Min * Width / 2) * Slim;
  var XX = lengthdir_x(Len,Dir + 90); 
  var YY = lengthdir_y(Len,Dir + 90);
  AlphaT = (Min - i) / (Min / 2) * Alpha;
  draw_vertex_texture_colour(ArrayTrail[i,0] +XX, ArrayTrail[i,1] +YY, ArrayTrail[i,2] / Width, 0, Color, AlphaT);
  draw_vertex_texture_colour(ArrayTrail[i,0] -XX, ArrayTrail[i,1] -YY, ArrayTrail[i,2] / Width, 1, Color, AlphaT);
}
draw_primitive_end();

//Replacing the coordinates positions within the array
Min = min(Height,Length);
for (var i = Min; i > 0; i--){
  ArrayTrail[i,0] = ArrayTrail[i - 1,0];
  ArrayTrail[i,1] = ArrayTrail[i - 1,1];
  ArrayTrail[i,2] = ArrayTrail[i - 1,2];
  ArrayTrail[i,3] = ArrayTrail[i - 1,3];
  //Ok so this just pushing up all the values 1 index.  And next STEP we overwrite the 0 index.
}

#define dtp_helper
///dtp_helper(array,height,length,width)
var hArrayTrail = argument0;
var hHeight = argument1;
var hLength = argument2;
var hWidth = argument3;


//Find Thetas of New Point and Last
var PointTheta = (darctan2(hArrayTrail[0,1]-centerfieldy,hArrayTrail[0,0]-centerfieldx) +360) mod 360
var LastPointTheta = (darctan2(hArrayTrail[1,1]-centerfieldy,hArrayTrail[1,0]-centerfieldx) +360) mod 360
//Find Nearest Corner Vertexes
angle = startangle
for (var v=0;v<8;v++){
    if((LastPointTheta>=angle-RAIL_ANGLES[v mod 2] && LastPointTheta<=angle) || (LastPointTheta>=360-RAIL_ANGLES[0]/2 && angle==startangle)){break}
angle+=RAIL_ANGLES[(v+1) mod 2];
}
var V1Theta = angle //vertex clockwise to the last point
var V2Theta = (angle-RAIL_ANGLES[v mod 2]+360) mod 360 //vertex anti-clockwise to the last point
//Recall we're going anti-clockwise when we add angles but since the y scale is reverse we're going clockwise when we add now

//Find Relative Distances in Degrees
var ADV1 = angle_difference(V1Theta,LastPointTheta); //should be a positive value
var ADV2 = angle_difference(V2Theta,LastPointTheta); //should be a negative value
var ADP = angle_difference(PointTheta,LastPointTheta); //check if it's greater positive or greater negative

//If DDistance Greater than Vertex1 Theta
if ADP > ADV1{
   //Push all other array values one index up in array
   dtp_arraypusher(hArrayTrail,argument1,argument2,1)
   //Set vertex point as last point in array
   hArrayTrail[@1,0] = tvertx[v mod 8]+centerfieldx
   hArrayTrail[@1,1] = tverty[v mod 8]+centerfieldy
   hArrayTrail[@1,2] = point_distance(hArrayTrail[1,0],hArrayTrail[1,1],hArrayTrail[2,0],hArrayTrail[2,1]) + hArrayTrail[2,2];
   hArrayTrail[@1,3] = hWidth;
   
   dtp_arraypusher(hArrayTrail,argument1,argument2,1)
   //Add interpolating point for iteration
   var ADV1 = angle_difference(PointTheta,V1Theta); //should be a positive value
   var ADVV = angle_difference(V1Theta+RAIL_ANGLES[(v+1) mod 2],V1Theta); //should be a positive value
   if ADV1 > ADVV{
       hArrayTrail[@1,0] = (hArrayTrail[2,0]+tvertx[(v+1) mod 8]+centerfieldx)/2
       hArrayTrail[@1,1] = (hArrayTrail[2,1]+tverty[(v+1) mod 8]+centerfieldy)/2
       hArrayTrail[@1,2] = point_distance(hArrayTrail[1,0],hArrayTrail[1,1],hArrayTrail[2,0],hArrayTrail[2,1]) + hArrayTrail[2,2];
       hArrayTrail[@1,3] = hWidth;
   }
   else{
       hArrayTrail[@1,0] = (hArrayTrail[2,0]+hArrayTrail[0,0])/2
       hArrayTrail[@1,1] = (hArrayTrail[2,1]+hArrayTrail[0,1])/2
       hArrayTrail[@1,2] = point_distance(hArrayTrail[1,0],hArrayTrail[1,1],hArrayTrail[2,0],hArrayTrail[2,1]) + hArrayTrail[2,2];
       hArrayTrail[@1,3] = hWidth;
   }
   
   
   return true;
   
}
//ElIf DDistance Greater than Vertex2 Theta
else if ADP < ADV2{
   //Push all other array values one index up in array
   dtp_arraypusher(hArrayTrail,argument1,argument2,1)
   //Set vertex point as last point in array
   hArrayTrail[@1,0] = tvertx[(v+7) mod 8]+centerfieldx
   hArrayTrail[@1,1] = tverty[(v+7) mod 8]+centerfieldy
   hArrayTrail[@1,2] = point_distance(hArrayTrail[1,0],hArrayTrail[1,1],hArrayTrail[2,0],hArrayTrail[2,1]) + hArrayTrail[2,2];
   hArrayTrail[@1,3] = hWidth;
   dtp_arraypusher(hArrayTrail,argument1,argument2,1)
   
   //Add interpolating point for iteration
   var ADV2 = angle_difference(PointTheta,V2Theta); //should be a negative value
   var ADVV = angle_difference(V2Theta-RAIL_ANGLES[(v+1) mod 2],V2Theta); //should be a negative value
   if ADV2 < ADVV{
       hArrayTrail[@1,0] = (hArrayTrail[2,0]+tvertx[(v+7+7) mod 8]+centerfieldx)/2
       hArrayTrail[@1,1] = (hArrayTrail[2,1]+tverty[(v+7+7) mod 8]+centerfieldy)/2
       hArrayTrail[@1,2] = point_distance(hArrayTrail[1,0],hArrayTrail[1,1],hArrayTrail[2,0],hArrayTrail[2,1]) + hArrayTrail[2,2];
       hArrayTrail[@1,3] = hWidth;
   }
   else{
       hArrayTrail[@1,0] = (hArrayTrail[2,0]+hArrayTrail[0,0])/2
       hArrayTrail[@1,1] = (hArrayTrail[2,1]+hArrayTrail[0,1])/2
       hArrayTrail[@1,2] = point_distance(hArrayTrail[1,0],hArrayTrail[1,1],hArrayTrail[2,0],hArrayTrail[2,1]) + hArrayTrail[2,2];
       hArrayTrail[@1,3] = hWidth;
   }
   
   return true;

}

return false;

#define dtp_arraypusher
///dtp_arraypusher(array,height,length,stopindex)
var hArrayTrail = argument0;
var hHeight = argument1;
var hLength = argument2;
var hStop = argument3;

//Push all other array values one index up in array
Min = min(hHeight,hLength);
for (var i = Min; i > hStop; i--){
   hArrayTrail[@i,0] = hArrayTrail[i - 1,0];
   hArrayTrail[@i,1] = hArrayTrail[i - 1,1];
   hArrayTrail[@i,2] = hArrayTrail[i - 1,2];
   hArrayTrail[@i,3] = hArrayTrail[@i - 1,3];
}