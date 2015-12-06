///draw_circle_texture(x, y, radius, background, circle precision, repeat)

//Draws a textured circle.
//Does not work on HTML5
//draw_circle_texture(60,60,40,bkg_sign,30,false);
var ax = argument0;
var ay = argument1;
var r = argument2;
var bkg = argument3;
var prec = argument4;
var arepeat = argument5;

var axscale = 1; var ayscale = 1;
if (arepeat) {
    var axscale = (r*2)/background_get_width(bkg);
    var ayscale = (r*2)/background_get_height(bkg);
}

var tex = background_get_texture(bkg);

draw_set_color(c_white);
texture_set_repeat(true);
draw_primitive_begin_texture(pr_trianglefan, tex);
for(var i = 0; i <= 360; i += 360/prec) {
    draw_vertex_texture(
        ax+lengthdir_x(r, i), 
        ay+lengthdir_y(r, i), 
        (ax+lengthdir_x(r, i))/(r*2)*axscale, 
        (ay+lengthdir_y(r, i))/(r*2)*ayscale
    );
}
draw_primitive_end();
