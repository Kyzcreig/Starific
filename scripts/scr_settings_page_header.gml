#define scr_settings_page_header
///scr_settings_page_header(title_ease, line_ease, texture_page)

/*
scr_assert_menuSurface_exists();
surface_set_target(global.menuSurface);
//draw_clear_alpha(c_black,0);  
draw_clear_alpha(COLORS[7],1);  
*/

    //1 alpha makes text more legible, because full alpha and normal blend mode

// Get Back Button Sprite for This Texture Page
if argument_count > 2{
    texture_page = argument[2];
} else {
    texture_page = 0;

}

// Draw Title
scr_draw_title(GAME_Y, argument[0])
// Draw Title Underline
titleEndY = scr_draw_title_underline(start_y + title_from_top * 2, argument[1], texture_page);


// Get Back Button Sprite for This Texture Page
backButtonSpr = scr_return_arrow_sprite(0,texture_page);


//Draw Back Button
backButtonScale = 1;
backButtonW = sprite_get_width(backButtonSpr)*1.00;
backButtonH = sprite_get_height(backButtonSpr) *.75;
backButtonX = GAME_X+70 - 300*(1-subEase[0]) - backButtonW/2;
backButtonHover = point_in_rectangle(mouse_x,mouse_y,backButtonX-backButtonW,
                                title_y+9-backButtonH,backButtonX+backButtonW,
                                title_y+9+backButtonH);
//Scale Back Button on Hover
if  ((backButtonHover and (!touchPad or mouse_check_button(mb_left))) or
    keyboard_check_pressed(vk_backspace)) and !TweenExists(mainTween) 
{
    backButtonScale = 1.2; 
    
    //On Select of Back Button
    if (mouse_check_button_pressed(mb_left) or keyboard_check_pressed(vk_backspace))
        and !ScheduleExists(mainSchedule)
    {   
        //Schedule Page Exit
        scr_schedule_exit_page();
        scr_sound(sd_menu_click,1,false);
        //Destroy Text Prompts
        with(obj_text_generic){
            instance_destroy();
        }
    }
}   
//Draw Back Button
draw_sprite_ext(backButtonSpr, 0,backButtonX,title_y+9,backButtonScale,backButtonScale,0,COLORS[0],1);   


return titleEndY + 4*RU;

#define scr_settings_page_footer
///scr_settings_page_footer()


/*
//Page Footer
surface_reset_target()

#define scr_settings_page_counts
//scr_settings_page_counts(progress, total, new, name, ease, texture_page)


var prog_count = argument0;
var total_count = argument1;
var new_count = argument2;
var name_text = argument3;
var ease = argument4;
var tex_page = argument5;


//Draw Left Text
draw_set_valign(fa_middle);
draw_set_halign(fa_left);
draw_set_font(counts_font);//fnt_menu_bn_26_black);
count_text = string(prog_count)+"/"+string(total_count);
if new_count > 0 {
    //count_text += " new "+string(new_count);
    count_text += " +"+string(new_count);
}
count_h = string_height("S") 
count_x = GAME_MID_X - line_w;
count_y = GAME_Y + GAME_H - count_h * 1.2;
count_scale = ease;
draw_text_ext_transformed_colour(count_x, count_y, count_text, 
                        -1,-1,count_scale,count_scale,0,
                        COLORS[0],COLORS[0],COLORS[0],COLORS[0],1)

//Draw Right Text
if name_text != "" {
    draw_set_halign(fa_right);
    nsmr_x = GAME_MID_X + line_w;
    name_y = count_y;
    name_w = string_width(name_text);
    name_max_w = line_w;
    name_xscale = min(count_scale, name_max_w / name_w);
    name_yscale = count_scale;
    draw_text_ext_transformed_colour(nsmr_x, name_y, name_text, 
                            -1,-1,name_xscale,name_yscale,0,
                            COLORS[0],COLORS[0],COLORS[0],COLORS[0],1)

}




//Draw Line
endLine_y = count_y - count_h
//make this a script and use it in various places
scr_draw_title_underline(endLine_y, ease, tex_page)


return endLine_y - 4*RU;