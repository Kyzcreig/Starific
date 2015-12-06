///draw_rectangle_cd_clock(x1, y1, x2, y2, value,sprite)
var v, x1, y1, x2, y2, xm, ym, vd, vx, vy, vl sprite=0;
v = argument4 //0-1 value 
if (v <= 0) return 0 // nothing to be drawn
x1 = argument0; y1 = argument1; // top-left corner
x2 = argument2; y2 = argument3; // bottom-right corner
if (v >= 1) {
    draw_rectangle(x1, y1, x2, y2, false) // entirely filled
    return 0;
}


sprite = argument5
draw_roundrect_color(x1, y1, x2, y2, COLORS[0], COLORS[0], 0);
draw_sprite_ext(sprite,0,x1+16,y1+16,1.6,1.6,0,c_white,1)



var surf = surface_create(x2-x1, y2-y1)
surface_set_target(surf)
draw_set_alpha(.75)
draw_roundrect_color(0, 0, x2-x1, y2-y1, COLORS[6], COLORS[6], 0);
xm = (x2-x1) / 2; ym = (y2 - y1) / 2; // middle point
draw_set_blend_mode(bm_subtract)
var cd_rad = (y1-y2)/2
draw_circle_color(xm,ym,cd_rad,c_white,c_white,0)
draw_set_blend_mode(bm_normal)
var cd_rad_used = cd_rad*(16/20)
//draw_circle_color(xm,ym,cd_rad_used,COLORS[6],COLORS[6],0)

//draw_set_blend_mode(bm_subtract)
//draw_set_color(c_white)
draw_set_color(c_black)
draw_primitive_begin(pr_trianglefan)
draw_vertex(xm, ym); //this draws middle
//draw_vertex(xm + cos(2.5*pi)*cd_rad_used, ym + sin(2.5*pi)*cd_rad_used) //draws top
// calculate angle & vector from value:
vd = pi * (v * 2 )//- 0.5)
vx = cos(vd)
vy = sin(vd)
var quality = 64
//for (i=2*pi; i>(2*pi-vd); i-=2*pi/quality)
for (i=0; i<vd; i+=2*pi/quality)
{
draw_vertex(xm + cos(i+.5*pi)*cd_rad_used, ym + sin(i+.5*pi)*cd_rad_used)
}
draw_vertex(xm + cos(vd+.5*pi)*cd_rad_used, ym + sin(vd+.5*pi)*cd_rad_used)
draw_primitive_end()
surface_reset_target()
draw_set_alpha(1);
//draw_set_blend_mode(bm_normal);
draw_surface(surf,x1,y1)
surface_free(surf)
