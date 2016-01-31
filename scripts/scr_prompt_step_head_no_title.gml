///scr_prompt_step_head_no_title(draw_rect)

/*
scr_assert_menuSurface_exists();
surface_set_target(global.menuSurface);
draw_clear_alpha(COLORS[7],0);  // 0 alpha makes drawing screenshots easier?
*/

var draw_rect = argument0;

// SubEases
subEase[0] = clamp(mainEase[0],0,1)
subEase[1] = clamp(mainEase[0]-1,0,1)
subEase[2] = clamp(mainEase[0]-2,0,1)
subEase[3] = clamp(mainEase[0]-3,0,1)

// Draw Screenshot in Background
scr_draw_background_screenshot(1);

// Draw Mask over Background
scr_draw_background_mask(subEase[0] * .75, 0);

// Draw Containing Rect
if draw_rect {
    rect_y = GAME_MID_Y -1400*(1-subEase[1]) - rect_h/2
    draw_sprite_stretched_ext(s_v_background_solid_menu,0,rect_x, rect_y, rect_w, rect_h,COLORS[7],1)
}


// Draw Prompt Title
//scr_draw_title_and_line(rect_y, subEase[2], subEase[2]);

title_from_top = 75;
line_y = rect_y + title_from_top;
line_w = GAME_W*(14/32);

