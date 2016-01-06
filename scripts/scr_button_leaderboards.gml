///scr_button_leaderboards()

analytics_button_counter("leaderboards");

if achievement_available(){
    achievement_show_leaderboards();
}
//Else error message
else{
    txt_font = fnt_menu_bn_26_italic//fnt_menu_bn_40_bold;//fnt_game_bn_30_black; 
    txt_text = "not connected to leaderboards!"; //tap rate to unlock
    draw_set_font(txt_font)
    txt_height = string_height(txt_text)/2;
    text_x = u_txt_x;
    text_y = (u_txt_y + (GAME_Y + GAME_H))/2
    scr_popup_text_field_static(text_x,text_y,
         txt_text,COLORS[3],txt_font,true,5*room_speed)
}
