#define scr_draw_title
///scr_draw_title(top_y, ease_title)


start_y = argument[0]
ease_title = argument[1];



// Draw Title
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_font(title_font);
title_from_top = 75;
title_y = start_y + title_from_top - 400*(1-ease_title);
draw_text_color(GAME_MID_X + 8*RU, title_y, title_txt, COLORS[0], COLORS[0],COLORS[0],COLORS[0], 1);





#define scr_draw_title_underline
///scr_draw_title_underline(line_y, ease, texture_page)



// Get Line Sprite for This Texture Page
// Get Back Button Sprite for This Texture Page
if argument_count > 2{
    texture_page = argument[2];
} else {
    texture_page = 0; //default is menu texture page == 0

}
line_spr = scr_return_solid_sprite(texture_page);


ease_line = argument[1];
line_y = argument[0];
line_w = GAME_W*(14/32) * ease_line 
line_c = merge_color(COLORS[6],COLORS[0],.5)
draw_line_width_sprite(GAME_MID_X - line_w, line_y, GAME_MID_X + line_w, line_y, 8, line_c, 1, line_spr);
draw_line_width_sprite(GAME_MID_X - line_w, line_y, GAME_MID_X + line_w, line_y, 6, COLORS[0], 1, line_spr);


return line_y;

#define scr_return_solid_sprite
///scr_return_solid_sprite(texture_page_id)


switch argument0 {
    case 0: 
        return s_v_background_solid_menu  //menu page
    break;
    
    case 1:
        return s_v_background_solid  //game page
    break; 
   
} 





#define scr_return_arrow_sprite
///scr_return_arrow_sprite(arrow_id, texture_page_id)


/* NB: For the not implemented arrow sprites, we only need to copy the sprite and set its texture page to game.
        I find this isn't necessary right now though so why waste texture page space.

*/


switch argument0 {
case 0: 
    switch argument1 {
    
    case 0:
        return s_v_backarrow //menu page
    
    break;
    case 1:
        return s_v_backarrow_game //game page
    
    break;
    
    }
break;

case 1:
    switch argument1 {
    
    case 0:
        return s_v_leftarrow //menu page
    
    break;
    case 1:
        return s_v_leftarrow_game //game page 
    
    break;
    
    }
break; 

case 2:
    switch argument1 {
    
    case 0:
        return s_v_rightarrow //menu page
    
    break;
    case 1:
        return s_v_rightarrow_game //game page
    
    break;
    
    }
break; 

case 3:
    switch argument1 {
    
    case 0:
        return s_v_leftarrow_small //menu page
    
    break;
    case 1:
        return s_v_leftarrow_small //game page //NOT IMPLEMENTED
    
    break;
    
    }
break; 

case 4:
    switch argument1 {
    
    case 0:
        return s_v_rightarrow_small //menu page
    
    break;
    case 1:
        return s_v_rightarrow_small //game page //NOT IMPLEMENTED
    
    break;
    
    }
break; 
   
} 





#define scr_draw_menu_choice_backline
///scr_draw_menu_choice_backline(x, y, show_w, hide_w, col, accent_col, alpha, texture_page, hover)

var i, xm, ym, show_w, hide_w, col, acc_col, alpha, texture_page;
i = -1;
xm = argument[++i];
ym = argument[++i];
show_w = argument[++i];
hide_w = argument[++i];
col = argument[++i];
acc_col = argument[++i];
alpha = argument[++i];
tex_page = argument[++i];
hover = argument[++i];

if show_w > hide_w {
    if hover {
        //Draw left
        draw_line_width_sprite(xm-show_w,ym, xm-hide_w,ym,5,col,1,scr_return_solid_sprite(tex_page));
        //Draw Right
        draw_line_width_sprite(xm+hide_w,ym, xm+show_w,ym,5,col,1,scr_return_solid_sprite(tex_page));
    } else {
        //Draw left
        draw_line_width_sprite(xm-show_w,ym, xm-hide_w,ym,4,acc_col,1,scr_return_solid_sprite(tex_page));
        draw_line_width_sprite(xm-show_w,ym, xm-hide_w,ym,2,col,1,scr_return_solid_sprite(tex_page));
        //Draw Right
        draw_line_width_sprite(xm+hide_w,ym, xm+show_w,ym,4,acc_col,1,scr_return_solid_sprite(tex_page));
        draw_line_width_sprite(xm+hide_w,ym, xm+show_w,ym,2,col,1,scr_return_solid_sprite(tex_page));
    
    }
}