///draw_rectangle_texture(x, y, x2, y2, background, repeat)

//Draws a textured circle.
//Does not work on HTML5
//draw_rectangle_texture(60,360,160,500,bkg_sign_new,false);
var ax = argument0;
var ay = argument1;
var ax2 = argument2;
var ay2 = argument3;
var bkg = argument4;
var arepeat = argument5;

draw_set_color(c_white);
texture_set_repeat(true);

var axscale = 1; var ayscale = 1;
if (arepeat) {
    var axscale = (ax2-ax)/background_get_width(bkg);
    var ayscale = (ay2-ay)/background_get_height(bkg);
}

var tex = background_get_texture(bkg);

draw_primitive_begin_texture(pr_trianglefan, tex);
draw_vertex_texture(ax,ay,0,0);
draw_vertex_texture(ax2,ay,1*axscale,0);
draw_vertex_texture(ax2,ay2,1*axscale,1*ayscale);
draw_vertex_texture(ax,ay2,0,1*ayscale);
draw_primitive_end();
