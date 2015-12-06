///scr_draw_padbuttons(outerpadrad)



//I might be using excessive precision here//65
//var outerpadrad = argument[0] //((GAME_Y + GAME_H)-padcentery-5)
//var innerpadrad = max(0,outerpadrad - 80)
//var firepad = max(0,innerpadrad - 20)

if !MOVE_ACTIVE and lives>0 {//and os_device{
    //draw_circle_color(x,y,firepad,COLORS[0],COLORS[0],false)
    draw_sprite_ext(s_v_padcircle,0,x,y,
    2*firepad/sprite_get_width(s_v_padcircle),
    2*firepad/sprite_get_width(s_v_padcircle), 0,COLORS[0],1)
    draw_set_font(fnt_field)
    draw_set_halign(fa_center)
    draw_set_valign(fa_middle)
    /*if os_type == os_ios {draw_text_color(x,y,'fire!',
    COLORS[0],COLORS[0],COLORS[0],COLORS[0],1)}*/
}
/*
//Draw booster button and cooldown
else if MOVE_ACTIVE and sBooster != noone{
    //could also do some hover text color changing
    switch sBooster{
        case 1://Dark green
            draw_sprite_ext(s_v_padcircle,0,x,y,
            2*firepad/sprite_get_width(s_v_padcircle),
            2*firepad/sprite_get_width(s_v_padcircle), 0,COLORS[0],1)
            draw_set_font(fnt_field)
            draw_set_halign(fa_center)
            draw_set_valign(fa_middle)
            draw_text_color(x,y,'grow!',
            COLORS[0],COLORS[0],
            COLORS[0],COLORS[0],1)
            break;
        case 2://Dark gray            
            draw_sprite_ext(s_v_padcircle,0,x,y,
            2*firepad/sprite_get_width(s_v_padcircle),
            2*firepad/sprite_get_width(s_v_padcircle), 0,COLORS[0],1)
            draw_set_font(fnt_field)
            draw_set_halign(fa_center)
            draw_set_valign(fa_middle)
            draw_text_color(x,y,'sight!',
            COLORS[0],COLORS[0],
            COLORS[0],COLORS[0],1)
            break;
    }
    
    //draw cooldown shading
    var cdVal = bCooldown
    cdMax = max(cdVal,cdMax)
    draw_booster_cd(x-firepad,y-firepad,x+firepad,y+firepad,cdVal/cdMax)  //may need to fix this so it's not using surfaces and stuff
    //decrease batch calls and so on
     
}
