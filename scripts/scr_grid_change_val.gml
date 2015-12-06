///scr_grid_change_val(grid id,gX,gY,value)
var grid = argument0;
var gX = argument1;
var gY = argument2;
var val = argument3;

ds_grid_set(grid,gX,gY,val);

if instance_exists(val) and val - DENSITY >= 0{
   with(val){
       gridXY[0] = argument1;
       gridXY[1] = argument2;
   }
}
//return grid[# gX, gY] = val;
