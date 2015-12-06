///draw_arrow_width(x1,y1,x2,y2,size,thickness,color)
var i=-1;
var xA1 = argument[++i];
var yA1 = argument[++i];
var xA2 = argument[++i];
var yA2 = argument[++i];
var arrow_size = argument[++i];
var line_thickness = argument[++i];
var arrow_col = argument[++i];



//Calculate percentage out of whole line for the thick line
var vX = xA2-xA1//x difference
var vY = yA2-yA1//y difference
//Subtract arrow size from line to calculate thick line length
var vM = sqrt(sqr(vX)+sqr(vY)) //- arrow_size//*.9 //length of thick line
if vM != 0{
    var vP1 = max(0,(vM - arrow_size)/vM) //start point for arrow
    var vP2 = max(0,(vM - arrow_size/2)/vM) //ratio of thickline to whole line
}
else{
    var vP1 = 1  //start point for arrow
    var vP2 = 1 //ratio of thickline to whole line
}

draw_line_width_sprite(xA1, yA1, xA1+vX*vP2, yA1+vY*vP2,line_thickness,arrow_col, 1, scr_return_solid_sprite(1))


var line_angle = darctan2(vY,vX);
var triangle_halfside = arrow_size*dtan(20);
var side_angle = line_angle+90
var xSAdj = dcos(side_angle)*triangle_halfside;
var ySAdj = dsin(side_angle)*triangle_halfside;

var xS1 = xA1+vX*vP1 +xSAdj;
var yS1 = yA1+vY*vP1 +ySAdj;
var xS2 = xA1+vX*vP1 -xSAdj;
var yS2 = yA1+vY*vP1 -ySAdj;

var t = PADDLE_TEXTURES[0];
draw_primitive_begin_texture(pr_trianglestrip,t);
    draw_vertex_texture_colour(xA2,yA2,.5,0,arrow_col,1)
    draw_vertex_texture_colour(xS1,yS1,0,1,arrow_col,1)
    draw_vertex_texture_colour(xS2,yS2,1,1,arrow_col,1)
draw_primitive_end()

//draw_triangle(xS1,yS1,xA2,yA2,xS2,yS2,false);

   
