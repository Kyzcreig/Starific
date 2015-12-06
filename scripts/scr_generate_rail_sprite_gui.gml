#define scr_generate_rail_sprite_gui
///scr_generate_rail_sprite_gui()


//delete old sprite
if sprite_exists(spr_rail){sprite_delete(spr_rail)}

return scr_generate_rail_sprite(pradius, PADDLE_H, RAIL_ANGLES, centerfieldx, centerfieldy)

#define scr_generate_rail_sprite
///scr_generate_rail_sprite(radius, paddle_height, angle_array, centerx, centery)

var fieldRad = argument0;
var padH = argument1;
var ang_array = argument2;
var centerX = argument3;
var centerY = argument4;
var fieldVertX = noone;
var fieldVertY = noone;

var startangle = ang_array[0]/2////22.5
var angle = startangle
for (i=0;i<8;i++){
    fieldVertX[i] = (fieldRad+padH/2)*dcos((angle));
    fieldVertY[i] = (fieldRad+padH/2)*dsin((angle));
    angle += ang_array[(i+1) mod 2];
}


var surf_rail = surface_create(GAME_W, GAME_H)
surface_reset_target()
surface_set_target(surf_rail)
draw_clear_alpha(COLORS[6],0)

//draw_set_alpha(1);
//Draw in loop to alias colors
for (var k=4;k>0;k--)//0
{
    //Draw Rail Lines with aliasing colors
    //var c_rail = merge_color(COLORS[0],COLORS[6],.2*(k - 1))
    draw_set_alpha(1 - .1*(k-1))
    for (var i=0;i<8;i++)
    {
        draw_line_width_sprite(centerX + fieldVertX[i] -GAME_X, centerY + fieldVertY[i] -GAME_Y, 
                              centerX + fieldVertX[(i+7) mod 8] -GAME_X, centerY + fieldVertY[(i+7) mod 8] -GAME_Y,
                              k,c_white,1, scr_return_solid_sprite(1))
    
    }
}

draw_set_alpha(1);
//Save Rail and Touchpad as sprite for efficient drawing
var spr_rail = sprite_create_from_surface(surf_rail, 0, 0, GAME_W, GAME_H, false, false, 0, 0);
surface_reset_target()
surface_free(surf_rail);

return spr_rail;