///scr_draw_rail()

// Draw Low Res Rail
for (var i=0;i<8;i++)
{
    draw_line_width_sprite(centerfieldx + tvertx[i] /*-GAME_X*/, centerfieldy + tverty[i] /*-GAME_Y*/, 
                          centerfieldx + tvertx[(i+7) mod 8] /*-GAME_X*/, centerfieldy + tverty[(i+7) mod 8] /*-GAME_Y*/,
                          4,COLORS[0],1, s_v_background_blend_game)
}

/*
// Draw High Res Rail
if false{
    for (k=4;k>3;k--)//0
    {
        
        for (i=0;i<8;i++)
        {
            var c_rail = merge_color(COLORS[0],COLORS[6],0)//.2*(k - 1))
            draw_line_width_sprite(centerfieldx + tvertx[i] , centerfieldy + tverty[i] , 
                                  centerfieldx + tvertx[(i+7) mod 8] , centerfieldy + tverty[(i+7) mod 8] ,
                                  k,c_rail,scr_return_solid_sprite(1))
        }
    }
}
