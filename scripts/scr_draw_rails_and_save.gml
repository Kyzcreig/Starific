#define scr_draw_rails_and_save
///scr_draw_rails_and_save(gridSz)

// Get Field Data for Grid Size
var gridSz = argument0;
var cellSz = scr_field_calc_cellSize(gridSz)
var padH = scr_paddle_calc_height(cellSz)
var railBuf = scr_field_calc_railBuffer(gridSz);
var cornerSz = scr_field_calc_cornerSize(gridSz);
var fieldRad = scr_field_calc_radius(gridSz, cellSz, railBuf, cornerSz);
var angles_array = scr_field_calc_angles(gridSz, cornerSz);
var origin = scr_field_calc_origin(gridSz, cellSz);
var center = scr_field_calc_center(origin[0], origin[1], gridSz, cellSz)


spr_rail = scr_generate_rail_sprite(fieldRad, padH, angles_array, center[0], center[1]);
var spr_rail_filename = "spr_rail_gui_"+string(convert_grid_to_index(gridSz))+".png"
sprite_save(spr_rail,0,spr_rail_filename)

#define scr_field_calc_radius
///scr_field_calc_radius(gridSize, cellSize, railBuffer, cornerSize)

var gridSz = argument0;
var cellSz = argument1;
var railBuf = argument2
var cornerSz = argument3;
var a = 3; //adjustor, NB: Used to keep 15x15 rail in bounds
var rad =((cellSz * (sqrt(sqr((gridSz + (railBuf+0)*2)*.5) + sqr((gridSz - cornerSz*2)*.5))))-a);
    /*  NB: This is nothing fancy, just the pythagorean theorum for the distance in grid coordinates
        from the center to a corner vertex.  Since it's the same for all of them we can calculate it
        once.  Then scale by cellSize    
    
    
    */


return rad;


#define scr_field_calc_rail_len
//scr_field_calc_rail_len(radius, angle_array)

var rad = argument0;
var angle_array = argument1;

var straightLengths = dsin(angle_array[0]/2)*rad*2*4;
var diagonalLengths = dsin(angle_array[1]/2)*rad*2*4/sqrt(2);//root2 for diagonals;

return straightLengths + diagonalLengths 

#define scr_field_calc_railBuffer
///scr_field_calc_railBuffer(gridSize)

return floor(argument0 *.15)//floor(gridSize / 7)//2//3


#define scr_field_calc_cornerSize
///scr_field_calc_cornerSize(gridSize)

return floor(argument0 * .27)//4//6//7




#define scr_paddle_calc_height
///scr_paddle_calc_height(cellSize)


return argument0+4;

#define scr_field_calc_cellSize
///scr_field_calc_cellSize(gridSize)


return ceil(GAME_W*.75 / argument0)

#define scr_field_calc_angles
///scr_field_calc_angles(gridSz, cornerSz)

var gridSz = argument0;
var cornerSz = argument1;
var angles_array = noone;


angles_array[0] = 90 * ((gridSz - (cornerSz * 1.5)) / gridSz)
angles_array[1] = 90 - angles_array[0];

return angles_array ;

#define scr_field_calc_origin
///scr_field_calc_origin(gridSize, cellSize)
var gridSz = argument0;
var cellSz = argument1;
var coords = noone;

coords[0] = GAME_X+(GAME_W - cellSz * (gridSz - 0))*.5; //x
coords[1] = GAME_Y+(GAME_W - cellSz * (gridSz - 0))*.5 + 38*RU; //y //offset by 38 pixels

return coords;


#define scr_field_calc_center
///scr_field_calc_center(ox, oy, gridSize, cellSize)


var origin_x = argument0;
var origin_y = argument1;
var gridSz = argument2;
var cellSz = argument3;
var coords = noone;

coords[0] = origin_x + gridSz*cellSz/2; //x //GAME_X+GAME_W*.5
coords[1] = origin_y + gridSz*cellSz/2; //y  // GAME_Y+(GAME_H*2/3)*.5 +40


return coords;
#define scr_calc_rail_and_paddle_lengths
///scr_calc_rail_and_paddle_lengths(GRID)

// Get Field Data for Grid Size
var gridSz = convert_index_to_grid(argument0);
var cellSz = scr_field_calc_cellSize(gridSz)
var padH = scr_paddle_calc_height(cellSz)
var railBuf = scr_field_calc_railBuffer(gridSz);
var cornerSz = scr_field_calc_cornerSize(gridSz);
var fieldRad = scr_field_calc_radius(gridSz, cellSz, railBuf, cornerSz);
var railAngles = scr_field_calc_angles(gridSz, cornerSz);
var origin = scr_field_calc_origin(gridSz, cellSz);
var center = scr_field_calc_center(origin[0], origin[1], gridSz, cellSz)
var railLen = scr_field_calc_rail_len(fieldRad, railAngles)

//PADDLE_W = ((2)*gridSize+80)*2//1.5//*.75
//PADDLE_W = ((10)*gridSize)
var pad_w;
var padRigAdj = 0;
pad_w[0] = (180+padRigAdj) //-20//+20;
pad_w[1] = (225+padRigAdj) //-20//+20;
pad_w[2] = (250+padRigAdj) //-20//+20;
pad_w[3] = (250+padRigAdj) //-20//+20; // if we make this bigger then padsize must be smaller


rail_pad_start_ratio[argument0] = pad_w[argument0] / railLen;

return rail_pad_start_ratio[argument0];
