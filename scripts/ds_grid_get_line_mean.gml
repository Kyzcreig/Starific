///ds_grid_get_line_mean(id,x1,y1,x2,y2)
// RETURNS THE MEAN VALUE OF ALL GRID CELLS ALONG THE LINE (X1,Y1) - (X2,Y2)
var steep, x0, x1, y0, y1, ty, tmp, deltax, deltay, grid, error, ystep, a, result, items;
grid = argument0;
x0 = round(argument1);
y0 = round(argument2);
x1 = round(argument3);
y1 = round(argument4);
steep = (abs(y1 - y0) > abs(x1 - x0));
if(steep) {
    tmp = x0;
    x0 = y0;
    y0 = tmp;
    tmp = x1;
    x1 = y1;
    y1 = tmp;
}
if(x0 > x1) {
    tmp = x0;
    x0 = x1;
    x1 = tmp;
    tmp = y0;
    y0 = y1;
    y1 = tmp;
}
deltax = x1 - x0;
deltay = abs(y1 - y0);
error = deltax * 0.5;
ystep = 0;
ty = y0;
if(y0 < y1) {
    ystep = 1;
} else {
    ystep = -1;
}
result = 0;
items = 0;
for(a = x0; a <= x1; a += 1) {
    if(steep) {
        result += ds_grid_get(grid, ty, a);
    } else {
        result += ds_grid_get(grid, a, ty);
    }
    items += 1;
    error -= deltay;
    if(error < 0) {
        ty += ystep;
        error += deltax;
    }
}
return result / items;
