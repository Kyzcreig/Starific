///draw_rectangle_cd(x1, y1, x2, y2, value,sprite)
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
draw_rectangle_color(x1, y1, x2, y2, COLORS[0], COLORS[0], COLORS[0], COLORS[0], 0);
draw_sprite_ext(sprite,0,x1+16,y1+16,1.6,1.6,0,c_white,1)


xm = (x1 + x2) / 2; ym = (y1 + y2) / 2; // middle point
draw_set_color(c_black)
draw_set_alpha(.5)
draw_primitive_begin(pr_trianglefan)
draw_vertex(xm, ym); draw_vertex(xm, y1) //thiss draws middle and 12o'clock
// draw corners:
if (v >= 0.125) draw_vertex(x2, y1)
if (v >= 0.375) draw_vertex(x2, y2)
if (v >= 0.625) draw_vertex(x1, y2)
if (v >= 0.875) draw_vertex(x1, y1)
// calculate angle & vector from value:
vd = pi * (v * 2 - 0.5)
vx = cos(vd)
vy = sin(vd)
// normalize the vector, so it hits -1+1 at either side:
vl = max(abs(vx), abs(vy))
if (vl < 1) {
    vx /= vl
    vy /= vl
}
draw_vertex(xm + vx * (x2 - x1) / 2, ym + vy * (y2 - y1) / 2)
draw_primitive_end()
draw_set_color(c_white)
draw_set_alpha(1)
