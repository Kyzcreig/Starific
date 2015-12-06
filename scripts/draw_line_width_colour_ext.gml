#define draw_line_width_colour_ext
///draw_line_width_colour_ext(x1, y1, x2, y2, w, c1, alpha)

var x1, x2, y1, y2, half_w, c1, alph, ang;
x1 = argument0;
y1 = argument1;
x2 = argument2;
y2 = argument3;
half_w = argument4/2;
c1 = argument5;
alph = argument6;
ang = point_direction(x1, y1, x2, y2);

var pos_xw, neg_xw, pos_yw, neg_yw;
pos_xw = dcos(ang+90) * half_w;
pos_yw = -dsin(ang+90) * half_w;
neg_xw = dcos(ang-90) * half_w;
neg_yw = -dsin(ang-90) * half_w;
var Vx, Vy;
Vx[0] = x1 + pos_xw
Vy[0] = y1 + pos_yw
Vx[1] = x1 + neg_xw
Vy[1] = y1 + neg_yw
Vx[2] = x2 + pos_xw
Vy[2] = y2 + pos_yw
Vx[3] = x2 + neg_xw
Vy[3] = y2 + neg_yw

draw_primitive_begin(pr_trianglestrip)

    draw_vertex_colour(Vx[0],Vy[0],c1, alph);
    draw_vertex_colour(Vx[1],Vy[1],c1, alph);
    draw_vertex_colour(Vx[2],Vy[2],c1, alph);
    draw_vertex_colour(Vx[3],Vy[3],c1, alph);

draw_primitive_end()

#define draw_rectangle_outline_width_ext
///draw_rectangle_outline_width_ext(x1,y1,x2,y2,width, color, alpha, texture_page)
var x1, x2, y1, y2, width, color, alpha;
x1 = argument0
y1 = argument1
x2 = argument2
y2 = argument3
width = argument4
color = argument5;
alpha = argument6;
texture_page = argument7;


//Used Corner Connecting
var w = width/2;

//Draw Lines
draw_line_width_sprite(x1-w,y1,x2+w,y1,width, color, alpha,scr_return_solid_sprite(texture_page)) //top-left to top-right
draw_line_width_sprite(x1-w,y2,x2+w,y2,width, color, alpha,scr_return_solid_sprite(texture_page)) //bottom-left to bottom-right
draw_line_width_sprite(x1,y1-w,x1,y2+w,width, color, alpha,scr_return_solid_sprite(texture_page)) //top-left to bottom-left
draw_line_width_sprite(x2,y1-w,x2,y2+w,width, color, alpha,scr_return_solid_sprite(texture_page)) //top-right to bottom-right

/*
//Draw Vertexes
draw_line_width_colour_ext(x1-width/2,y1-width/2,x1-width/2,y1-width/2,width, color, alpha)
draw_line_width_colour_ext(x1-width/2,y2+width/2,x1-width/2,y2+width/2,width, color, alpha)
draw_line_width_colour_ext(x2+width/2,y1-width/2,x2+width/2,y1-width/2,width, color, alpha)
draw_line_width_colour_ext(x2+width/2,y2+width/2,x2+width/2,y2+width/2,width, color, alpha)

#define draw_line_width_sprite
///draw_line_width_sprite(x1, y1, x2, y2, w, col, alpha, sprite)
/*  
    More efficient than conventional draw_line_width functions, it takes a simple 128x128 solid white sprite.
    Caveat: Use a sprite that corresponds to whatever texture page/group you're optimizing for.
    I use separate texture pages for pure menu pages and this keeps batch count down.
*/

var x1, x2, y1, y2, w, col, alpha, rot;
x1 = argument0;
y1 = argument1;
x2 = argument2;
y2 = argument3;
w = argument4;
col = argument5;
alpha = argument6;
spr = argument7 //should be 128x128 solid white sprite on your favorite texture page
ang = point_direction(x1, y1, x2, y2);

spr_w = point_distance(x1, y1, x2, y2);
spr_h = w;
spr_xscale = spr_w / sprite_get_width(spr);
spr_yscale = spr_h / sprite_get_height(spr);
spr_x = x1 + dcos(ang+90) * w/2;
spr_y = y1 - dsin(ang+90) * w/2;

// Draw Line
draw_sprite_ext(spr, 0, spr_x, spr_y, spr_xscale, spr_yscale, ang, col, alpha); 