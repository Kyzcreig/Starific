#define scr_menu_draw_gameover
///scr_menu_draw_gameover()



///GameOver Sequence
if GAMEOVER
{
    //Draw fade out sequence
    //draw_sprite_stretched_ext(s_v_background_solid_menu,0,GAME_X,GAME_Y,
    //GAME_W,GAME_H,COLORS[7],go_FadeTween[0]);
        //NB: Removed because it was fucking up our screenshot function for gameover.
    
    //Draw gameover screen slide down 
    rect_x = GAME_X
    rect_y = GAME_MID_Y - GAME_H*(1- go_FadeTween[0])//go_SlideTween1[0])
    rect_h = GAME_H * .5;
    // Adjust y coordinate of Gameover Menu for dialogue texts
    draw_set_font(dialogue_font);
    // Set Height of 1 Dialogue
    dialogue_line_h = string_height("##")/2; //string_height("S#S")/2//2;//2 /4; //height of 1 line
    //Easer for the Dialogue Count
    dialogue_count_adj += (ds_list_size(go_dialogue_txt) - dialogue_count_adj) * .1;
    // Set Location of Gameover Menu based on Dialogue Height
    rect_y = max(GAME_Y+rect_h/2,rect_y - dialogue_line_h * min(dialogue_max_display,dialogue_count_adj));  
    //draw_sprite_stretched_ext(s_v_background_solid,0,rect_x,rect_y - rect_h/2/2,GAME_W,rect_h/2,COLORS[7],1)

                     
    // Draw Title
    scr_draw_title(rect_y-rect_h/2, go_SlideTween2[0]);
    // Draw Title Underline
    scr_draw_title_underline(start_y + title_from_top * 2, go_SlideTween2[0], 0);    

    
    //So if i==1 then I draw the score stuff and have its own special thing
    //Draw Menu Choices
    choices_start_y = line_y+100*RU;
    choices_gap_y = 95;
    for(var i = 1; i < array_length_1d(go_menu);i++)
    {
        //Alternate sign/direction of tween
        draw_set_font(fnt_menu_buttons);
        draw_set_valign(fa_middle);
        draw_set_halign(fa_center);
        var tweenSign = (i mod 2);
        if tweenSign == 0 {tweenSign = -1}
        
        //Coordinates
        choices_x = centerfieldx  -tweenSign*600*(1-go_SlideTween2[0]);
        choices_y  = choices_start_y + choices_gap_y*(i-1); //probably use percentages here for varying resolutions
        choices_w = (GAME_W*11/32);
        choices_h = string_height("H")/2;
        
        //Text Data
        text_text = go_menu[i];
        text_w = string_width(text_text);
        text_h = string_height(text_text);
        text_scale = 1;
    
        text_color = COLORS[i];
        text_color_accent = merge_color(COLORS[6],text_color,.5);
        bold_line = false;
        
        
        //Draw Score Slider
        if i == 1{
            //Draw < Arrows >
            for (j=-1;j<2;j+=2)
            {
                
                // Set Each Arrow's Coordinates
                    //Offset the X plus or minus
                arrow_scale = 1 * go_SlideTween3[0]; 
                arrow_w = sprite_get_width(s_v_leftarrow)//*arrow_scale;
                arrow_h = sprite_get_height(s_v_leftarrow)//*arrow_scale;
                arrow_x = choices_x + j * (choices_w * go_SlideTween3[0]  - arrow_w/2);
                arrow_y = choices_y + choices_h * 2 * .15;
                arrow_hover = point_in_rectangle(mouse_x,mouse_y,
                                arrow_x-arrow_w,arrow_y-arrow_h,
                                arrow_x+arrow_w,arrow_y+arrow_h)
                arrow_color = text_color;
                
                //Draw < Arrows >
                if j == -1{
                    arrow_spr = s_v_leftarrow 
                }
                else if j == 1{
                    arrow_spr = s_v_rightarrow
                }
            
                //Scale Up ON HOVER AND SELCTION
                if arrow_hover and go_selected[0] == noone and
                (!touchPad or mouse_check_button(mb_left)) and 
                (!TweenExists(go_TweenSlide3))
                {
            
                    arrow_scale *= 1.25//
                    arrow_color = text_color_accent;
                    
                    //On Select of Menu Choice
                    if mouse_check_button_pressed(mb_left) and go_selected[1] == true
                    {
                        //Call Switch Code for this menu choice
                        if j == -1{
                            index_adjust = array_length_1d(go_display_score)-1; 
                        }
                        else if j == 1{
                            index_adjust = 1
                        }
                        go_selected[1] = false;
                        ScheduleScript(id,1,.20 ,scr_delayed_selection,go_selected,i)
                        scr_sound(sd_menu_click,1,false);
                        
                    }
                    
                }   
                //Draw < Arrows >
                draw_sprite_ext(arrow_spr, 0,arrow_x,arrow_y,
                arrow_scale,arrow_scale,0,arrow_color,go_SlideTween3[0]);//COLORS[0]
                    
            }
        }
        else {
            //Check if Text is Hovered/Selected
            text_hover = point_in_rectangle(mouse_x,mouse_y,choices_x-choices_w,choices_y-choices_h,choices_x+choices_w,choices_y+choices_h);
            
            
            if text_hover and go_selected[0] == noone and (!touchPad or  mouse_check_button(mb_left)) and !TweenExists(go_TweenSlide2)
            {
                //Update Line and Text Data
                text_scale *= 1.2
                bold_line = true;
                text_color = text_color_accent;
        
                
                //On Select of Menu Choice
                if mouse_check_button_pressed(mb_left) and (go_selected[1] == true) and (i != 1)
                {
                    //Call Switch Code for this menu choice
                    ScheduleScript(id,1,.25 ,scr_delayed_selection,go_selected,i)
                    go_selected[1] = false;
                    scr_sound(sd_menu_click,1,false);
                }
            }
        }
        
    
        //Draw Score Slider
        if i == 1{
        
            //Get Score Display Data
            data = go_display_score[go_display_index];
            // Set Text
            label_text = data[0];
            value_text = data[1];
            score_text = label_text + string(value_text);
            
            //Keep scale of score_text clamped
            score_text_width = string_width(score_text);
            score_text_width_max = choices_w * 2 - arrow_w * 3
            score_text_xscale = min(1,score_text_width_max/score_text_width) * text_scale;
            score_text_h = string_height("H") * text_scale;
            score_text_w_scaled = string_width(score_text) * score_text_xscale;
            
            // Draw Score Text
            draw_text_ext_transformed_colour(choices_x, choices_y, score_text, 
            -1, -1, score_text_xscale, text_scale, 0, text_color, text_color, text_color, text_color,1);
            
        
        
            //Draw  Score SubText
            // Set Text
            label_text = data[2];
            value_text = data[3];
            //If Cash Index
            if go_display_index == array_length_1d(go_display_score)-1{
                // Set Updated Cash
                value_text = CASH_STR+string(STAR_CASH);
            }
            sub_text = label_text + string(value_text);
        
            // Place Tiny Rating Text
            var sub_text_x = choices_x - score_text_w_scaled / 2;
            var sub_text_y = choices_y + score_text_h * .65;
            
            //Draw rating text
            draw_set_font(fnt_gui_options7)
            draw_set_halign(fa_left)
            draw_text_ext_transformed_colour(sub_text_x, sub_text_y, sub_text, 
            -1, -1, text_scale, text_scale, 0, text_color,text_color,text_color,text_color,go_SlideTween3[0]);
                
            
            // If NewBest or Good Score
            if data[4] or gameover_text_index > -1 {//array_length_1d(gameover_text) / 2 {
                
                // Set Text
                if data[4] {
                    rating_text = "new best!";
                    //If Flag set for Earned Cash, then let's call attention to it
                    if go_display_index == array_length_1d(go_display_score)-1{
                        rating_text = "rapacity!"
                    }
                }
                else if gameover_text_index > -1//array_length_1d(gameover_text) / 2
                    //and go_display_index == 0
                {
                    rating_text = gameover_text[gameover_text_index];
                }
                /*
                else {
                    rating_text = ""
                }*/
            
                // Place Tiny Rating Text
                rating_x = choices_x - score_text_w_scaled / 2;
                rating_y = choices_y - score_text_h *.5;
                
                //Draw rating text
                draw_set_font(fnt_gui_options7)
                draw_set_halign(fa_left)
                
                rating_col = COLORS[scr_flashing_color_index(10)]//COLORS[4]; //

                draw_text_ext_transformed_colour(rating_x, rating_y, rating_text, 
                -1, -1, text_scale, text_scale, 0, rating_col,rating_col,rating_col,rating_col,go_SlideTween3[0]);
            } 
        }
        
        
        // Draw Menu Options Text
        line_w = choices_w * text_scale * go_SlideTween3[0]; //needed because line_w is overwritten between loops
        hideline_w = text_w/2 * 1.2 * text_scale; //or arbitrary pixel length
        if i > 1 {
            scr_draw_menu_choice_backline(choices_x, choices_y+10, line_w, hideline_w, text_color,text_color_accent, 1, 0, bold_line)
            
            // Draw Text
            draw_text_ext_transformed_colour(choices_x, choices_y, text_text, -1, -1, 
            text_scale, text_scale, 0, text_color, text_color, text_color, text_color,1);
          
        }
    } 
    
    //DRAW UNLOCKS TEXT AND EFFECTS
    var n, dialogue_count, dialogue_str, dialogue_total_h, 
        dialogue_str_x, dialogue_str_y, dialogue_alpha;
    n = ds_list_size(go_dialogue_txt);
    if n > 0{ 
        
        draw_set_font(dialogue_font);
        draw_set_valign(fa_middle);
        draw_set_halign(fa_center);
        dialogue_count = 0; dialogue_str = "";
        
        //Set Coordinates for Dialogue Text
        //dialogue_str_h = string_height("##")/2;
        dialogue_total_h = n*dialogue_line_h;
        dialogue_str_x = choices_x;
        dialogue_str_y = choices_y+ choices_gap_y + dialogue_line_h/2; //+ dialogue_line_h/2;
        
        var dialogue_max_index = min(n,dialogue_max_display);
        for (var i = 0; i < dialogue_max_index; i++){
            dialogue_obj = go_dialogue_txt[| i];
            
            //If not first line, add line break
            //if dialogue_str != "" { dialogue_str += "#"; }
            // Grab text from list
            dialogue_str = dialogue_obj[0];
            dialogue_alpha = clamp(go_SlideTweenText[0] -.5*i, 0, 1);
            
            //Draw normal styling
            if dialogue_obj[1] == 0 {
                draw_text_colour(dialogue_str_x, dialogue_str_y+dialogue_line_h*i, dialogue_str, 
                COLORS[4], COLORS[4], COLORS[4],COLORS[4],dialogue_alpha);
            }
            //Draw strikethrough styling
            else if dialogue_obj[1] == 1 {
            
                draw_text_colour_strikethrough(dialogue_str_x, dialogue_str_y+dialogue_line_h*i, dialogue_str, 
                COLORS[4], COLORS[4], COLORS[4],COLORS[4],dialogue_alpha, fa_middle, fa_center );
            
            }
            
        
        }
        
    }
    
    //Fireworks effect for unlocks and newbest
    if (playHighScoreSound or unlock_count[0] > 0){
       //TO DO: The Share Screenshot +photo sound thing from Crossy Road would be cool here
       
       
       //Play unlock sound after fade tween finishes
       if unlock_sound[0] > 0 and go_FadeTween[0] == 1{
           scr_sound(sd_gameover_unlock,1,false)
           unlock_sound[0] = -1;
           
           /*
           //If ThemeSwitcher exists, increment it to new theme
           if scr_go_is_button(10) != -1{
                ScheduleScript(id,false,.25 * room_speed,scr_delayed_selection,go_selected,10)
                go_selected[1] = false
           }*/
       }
    }
    

    //Shortcut key 'vk_backspace' Restart Game
    if keyboard_check_released(vk_backspace){
                go_selected[1] = false
                ScheduleScript(id,1,.25 ,scr_delayed_selection,go_selected,2)
                scr_sound(sd_menu_click,1,false);
    }
        

    //DRAW SPRITE BUTTON Icons       
    draw_set_font(fnt_menu_buttons)
    draw_set_valign(fa_middle)
    draw_set_halign(fa_center)
    //Draw Sprite Buttons 
    n = ds_list_size(go_sp_buttons);
    
    sp_size = 60;
    sp_gap_whole = (GAME_W*11/32)*2 - sp_size; //NB: I don't use line_w so position is fixed and not easing
    sp_gap = max(sp_size * 1.1, min(sp_gap_whole / (max(1,n)) * (n-1), sp_gap_whole / (max(1,n-1))))
    sp_end_y = GAME_Y + GAME_H * .85;
    
    for(var i=0; i < n ; i++)
    {
        // Grab Button data
        sp_data = go_sp_buttons[| i];
        // Ease Coordinates
        //sp_data[@ 4] += ((sp_start_x + sp_gap*i) - sp_data[4]) * .1;          //ease x coordinate
        sp_data[@ 4] += ((GAME_MID_X + sp_gap * (i - (n-1)/2)) - sp_data[4]) * .1 * RMSPD_DELTA;          //ease x coordinate
        sp_data[@ 5] +=  (sp_end_y - sp_data[@ 5]) * .1;   //ease y coordinate
        // Set Coordinates
        sp_x = sp_data[4]; // set x coordinate
        sp_y = sp_data[5]; // set y coordinate
        sp_count =  sp_data[6]  //set indicator count
        // Set Button Alpha
        if sp_data[3] == 0 { //check button metadata
            // Normal 
            sp_alpha = 1;
        }
        else if sp_data[3] == 1 {
            // Flashing
            sp_alpha = lerp(.2,.8,FULL_SECOND_SINE);//FULL_SECOND_LERP);
        }
        else if sp_data[3] < 0 { 
            // Dim
            sp_alpha = .6; //.5
        }
        // Scale by Easer
        sp_alpha *= go_SlideTween3[0];
        
        // Set wiggle 
        if wiggle_index == i{ //go_wiggle_toggle[i+1] {
            wig_str = 4; //4
            wig_x = random_range(-1,1)*wig_str;
            wig_y = random_range(-1,1)*wig_str;
            
            sp_x += wig_x;
            sp_y += wig_y;
        
        }
        
        // Set Size and Scale
        sp_scale = 1;
        sp_resize = sp_size / sprite_get_width(sp_data[0]);
        
        
        //Check if mouse over icon
        if point_in_rectangle(mouse_x,mouse_y,sp_x-sp_size/2*1.25,sp_y-sp_size/2*1.25,
                              sp_x+sp_size/2*1.25,sp_y+sp_size/2*1.25) and go_selected[0] == noone 
                              and (!touchPad or  mouse_check_button(mb_left)) 
                              //and (!touchPad or touchPad and mouse_check_button(mb_left)) 
        {
        
            //Interupt and disable wigglers if mouseover
            scr_wiggle_reset(-1, 8*room_speed);

            
            // increase scale when hovered/clicked
            sp_scale = 1.25;
            
            //On Social Text Press
            if mouse_check_button_pressed(mb_left) and 
                go_selected[1] == true and 
                sp_data[3] != -1 // check button meta data
            {
                //Call Switch Code for this menu choice
                mouse_clear(mb_left);
                go_selected[1] = false
                ScheduleScript(id,1,.25 ,scr_delayed_selection,go_selected,sp_data[2])
                //go_selected = 6+i; //6,7
                scr_sound(sd_menu_click,1,false);
                    
            }
       }
        
        //Draw Button Icon
        draw_sprite_ext(sp_data[0], 0,sp_x, sp_y,sp_resize*sp_scale,sp_resize*sp_scale,0, COLORS[8], sp_alpha);
        //Draw Button Text
        draw_set_valign(fa_top);
        draw_set_font(fnt_gui_options7);
        draw_text_ext_colour(sp_x, sp_y + sp_size/2*sp_scale+12,
                             sp_data[1], -1, 90, COLORS[8], COLORS[8], 
                             COLORS[8], COLORS[8], sp_alpha);
                             
        //Draw Button Notification Indicator
        if sp_count > 0 {
            sp_note_text = string(min(sp_count,9)) //NB: Capped at 9 for aesthetics
            sp_note_size = sp_size * .5; //make notification 4x smaller size
            sp_resize = sp_note_size / sprite_get_width(s_v_solid_circle_60); // maybe tweak this size
            sp_x = sp_x + sp_scale * (sp_size / 2) // - sp_note_size / 2 
            sp_y = sp_y - sp_scale * (sp_size / 2) //+ sp_note_size / 2
            // Draw Circle
            draw_sprite_ext(s_v_solid_circle_60, 0,sp_x,sp_y,sp_resize,sp_resize,0,COLORS[0],sp_alpha)  //COLORS[8], 
            // Draw Notifcation Count
            draw_set_font(fnt_gui_options9); 
            draw_set_valign(fa_middle);
            draw_set_halign(fa_center);
            var note_height_adj = string_height("0") * .15;
            draw_text_colour(sp_x, sp_y - note_height_adj, sp_note_text, COLORS[6],COLORS[6],COLORS[6],COLORS[6],sp_alpha)
        }
    
    }


   // Wiggle Buttons if Nothing Selected
   if go_selected[0] == noone{
        scr_wiggle_timer(n, 1.5*room_speed, 8*room_speed);
   }

    
    
    //If Fading In Complete
    if go_SlideTween3[0] == 1{
        //Delayed Button Calls
        for (var i = 0, n = array_length_1d(delayed_button_calls); i < n; i++ ){
            //If Timer Active
            if delayed_button_calls[i] > 0 {
                // Decrement Button Timer
                delayed_button_calls[@ i] -= 1;
                //If Timer Finished
                if delayed_button_calls[i] <= 0 {
                    //Call button
                    go_selected[1] = false
                    ScheduleScript(id,1,.25 ,scr_delayed_selection,go_selected,i);
                }
            }
        }
    }
    

}     

#define scr_wiggle_timer
///scr_wiggle_timer(max_index, wiggle_time, cd_time)

var max_index = argument0;

// If wiggle duration finished
if wiggle_timer < 0 {
    // Advance current wiggle index to next index.
    wiggle_index = (++wiggle_index) mod (max_index+1);
    
    if wiggle_index == max_index {
         // Set Wiggle index to -1
         wiggle_index = -1; //NB: So that when we add buttons to N position they don't wiggle
         wiggle_timer = argument2;
    } else {
        // set wiggle for button
         wiggle_timer = argument1;
    }
    
}
//else decrement wiggle timer
else{
    wiggle_timer-=1;
}
/*

    NB: When we add buttons they can be stuck wiggling, so you can reset the wiggler for this.  
    Or change the wiggle index to be offset by 1, where cooldown index is 0.

#define scr_wiggle_reset
///scr_wiggle_reset(max_index, cd_time);


//Interupt and disable wigglers if mouseover
wiggle_index = argument[0];
wiggle_timer = argument[1];



#define scr_wiggle_init
///scr_wiggle_init(start_index, start_time)


wiggle_index = argument0;
wiggle_timer = argument1;