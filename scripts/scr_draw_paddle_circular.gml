
var spr_launcher = s_v_background_solid;

var t;
t=sprite_get_texture(spr_launcher,0);

//draw_primitive_begin_texture(pr_trianglestrip,t);
draw_primitive_begin(pr_trianglestrip);

var r = (cellH * (fieldW*.5 + 2));
var a = (sprite_get_width(spr_launcher) / (2*pi*r)) * 360;
var quality = 10; //Arbitrarily chosen number, increase to increase quality
for (var i = 0; i <= quality; i ++)
{
    angleV = degtorad(mouseangle + (i / quality - 0.5) * a) 
    draw_vertex(centerfieldx + r*cos(angleV), 
                                       centerfieldy + r*sin(angleV));
    draw_vertex(centerfieldx + (r+sprite_height)*cos(angleV), 
                                       centerfieldy + (r+sprite_height)*sin(angleV));
}


draw_primitive_end();


draw_set_color(c_black);
draw_circle(centerfieldx,centerfieldy, r, 1)
