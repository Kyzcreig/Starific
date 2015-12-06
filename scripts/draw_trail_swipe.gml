///draw_trail_swipe(x,y,length,width,color,Sprite,slim,alpha)
//Ex. draw_trail(32,32,c_white,-1,1,1)
var Length,Width,Color,Sprite,Slim,Alpha,AlphaT,Texture,Dir,Min,Height;
//Preparing variables
X_Coordinate = argument0;
Y_Coordinate = argument1;
Length = argument2; //How many previous coordinates will use the trail
Width = argument3; //How wide will the trail be
Color = argument4; //Which color will be used to tint the trail
Sprite = argument5; //Which sprite's texture must be used for the trail. Must have "Used for 3D" marked. -1 for no sprite 
Slim = argument6; //Whether the trail will slim down at the end
Alpha = argument7; //The alpha to draw the trail with (0-1), optional
ArrayTrail[0,0] = X_Coordinate;
ArrayTrail[0,1] = Y_Coordinate;
Height = array_height_2d(ArrayTrail);
//Getting distance between current and past coordinates
if (Height > 1) ArrayTrail[0,2] = point_distance(ArrayTrail[0,0],ArrayTrail[0,1],ArrayTrail[1,0],ArrayTrail[1,1]) + ArrayTrail[1,2];
else ArrayTrail[0,2] = 0;
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
  if (ArrayTrail[i,0] != ArrayTrail[i+1,0] || ArrayTrail[i,1] != ArrayTrail[i+1,1])
    Dir = point_direction(ArrayTrail[i,0],ArrayTrail[i,1],ArrayTrail[i+1,0],ArrayTrail[i+1,1]);
  var Len = Width / 2 - ((i + 1) / Min * Width / 2) * Slim;
  var XX = lengthdir_x(Len,Dir + 90); 
  var YY = lengthdir_y(Len,Dir + 90);
  AlphaT = clamp((Min - i) / (Min / 2) * Alpha,0,1);
  draw_vertex_texture_color(ArrayTrail[i,0] + XX,ArrayTrail[i,1] + YY,ArrayTrail[i,2] / Width,0,Color,AlphaT);
  draw_vertex_texture_color(ArrayTrail[i,0] - XX,ArrayTrail[i,1] - YY,ArrayTrail[i,2] / Width,1,Color,AlphaT);
}
draw_primitive_end();
//Replacing the coordinates positions within the array
Min = min(Height,Length);
for (var i = Min; i > 0; i--){
  ArrayTrail[i,0] = ArrayTrail[i - 1,0];
  ArrayTrail[i,1] = ArrayTrail[i - 1,1];
  ArrayTrail[i,2] = ArrayTrail[i - 1,2];
}
