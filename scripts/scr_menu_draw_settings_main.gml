#define scr_menu_draw_settings_main
///scr_menu_draw_settings_main()




// SubEasers
if true {//TweenExists(mainTween) {// and TweenIsPlaying(mainTween) {
    subEase[0] = EaseOutBack(clamp(mainEase[0],0,1), 0, 1, 1)
    subEase[1] = clamp(mainEase[0]-0.5,0,1);
    subEase[2] = clamp(mainEase[0]-1.0,0,1);
    //subEase[0] = clamp(mainEase[0],0,1)
    //subEase[1] = clamp(mainEase[0]-1.0,0,1)
}
///Page Header
scr_settings_page_header(subEase[0], subEase[1]);



// Page Body

//Draw Sprite Buttons
var n = array_length_1d(buttonSprite);
var sp_size = 150 * RU; //we use RU root units instead of pure pixels
var sp_rescale = .75; //we assume we're using 200px sprites
var sp_upscale = 1.2;
var sp_gap = (line_w*1.8 - sp_size*sp_upscale) * .5 // .5 //we pack it a little tighter for aesthetics
var row_size = 2;
//var sp_start_y = (GAME_H - (line_y - GAME_Y)) / 2 + line_y - sp_gap;
var sp_start_y = (GAME_H) / 2 - sp_gap*1.5//+ line_y - sp_gap;
//Iterate over buttons
for(var i = 0; i < n; i++)
{
    // Sprite Get Data
    sp_data = buttonSprite[i];
        
    //Sprite Coordinates
    row_index = (i mod row_size) * 2 - 1 //starts at -1
    col_index = (i div row_size) * 2
    sp_x = GAME_MID_X + sp_gap * row_index;
    sp_y = sp_start_y + sp_gap * col_index;
    sp_col = COLORS[0];

    sp_scale =  subEase[2];
    //Check if mouse over icon
    if point_in_rectangle(mouse_x,mouse_y,sp_x-sp_size/2,sp_y-sp_size/2,
                          sp_x+sp_size/2,sp_y+sp_size/2) 
                          and (!touchPad or mouse_check_button(mb_left)) 
                          and !TweenExists(mainTween)
    {
        //Disable increase scale when hovered/clicked
        sp_scale *= sp_upscale;
        //On Button Press
        if mouse_check_button_pressed(mb_left) and !ScheduleExists(mainSchedule)
        {
            //Set Next Page
            nextPage = sp_data[1];
            nextPageAnalytic = sp_data[3];
            //Schedule Page Exit
            scr_schedule_exit_page();
            
            //Click Sound
            scr_sound(sd_menu_click,1,false)
        }
       
    }
    
    //Draw Button Sprite 
    draw_sprite_ext(sp_data[0], 0, sp_x, sp_y, sp_rescale*sp_scale, sp_rescale*sp_scale, 0,sp_col, 1 )//subEase[1]) 
    
    
    // Draw Button Text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_menu_bn_26_black); 
    sp_txt = sp_data[3];
    sp_txt_scale = subEase[2];//
    sp_txt_h_adj = string_height("S") * sp_scale * 1.2 ;
    sp_txt_x = sp_x
    sp_txt_y = sp_y + sp_size * sp_scale * sp_rescale / 2 + sp_txt_h_adj
    draw_text_ext_transformed_colour(sp_txt_x, sp_txt_y, sp_txt, 
                            -1,-1,sp_txt_scale,sp_txt_scale,0,
                            sp_col,sp_col,sp_col,sp_col,1)
    
    // Draw Button Notification
    if sp_data[2] > 0 {
        //draw_set_valign(fa_middle);
        //draw_set_halign(fa_center);
        //draw_set_font(fnt_menu_bn_26_black);
        sp_note_size = 50*RU//sp_size / 3;
        sp_note_scale = .5 * subEase[2]; //we assume we're using 100px sprites
        sp_note_x = sp_x + sp_size/2 * sp_scale
        sp_note_y = sp_y - sp_size/2 * sp_scale 
        // Draw Note Circle
        draw_sprite_ext(s_v_solid_circle, 0,sp_note_x,sp_note_y,sp_note_scale,sp_note_scale,0,COLORS[0],1)   //COLORS[8], 
        
        // Draw Note Text
        sp_note_txt = string(sp_data[2]);
        sp_note_y_adj = sp_note_scale * string_height("S") * .15;
        draw_text_ext_transformed_colour(sp_note_x, sp_note_y - sp_note_y_adj, sp_note_txt, -1, -1, 
        sp_txt_scale, sp_txt_scale, 0, COLORS[6],COLORS[6],COLORS[6],COLORS[6],1)
    }
}



    







//Page Footer
scr_settings_page_footer();

#define scr_schedule_exit_page
///scr_schedule_exit_page()


mainSchedule = ScheduleScript(id,1,.2, scr_exit_page, .60);