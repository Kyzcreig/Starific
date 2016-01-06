#define scr_menu_draw_stats
///scr_menu_draw_stats()


    


//Enable Scrolling
scr_page_scroll_begin(ScrollStartY, ScrollEndY)

ScrollDrawH = scr_menu_draw_stats_body(ScrollStartY-ScrollOffset) - ScrollStartY;


//Draw Blackout Margins
scr_page_scroll_margins(0);

//Draw Header 
ScrollStartY = scr_menu_draw_stats_header();
ScrollEndY = GAME_Y+GAME_H;

//Draw Scroll Surface
scr_page_scroll_end(ScrollDrawH, GAME_X, ScrollStartY, ScrollDisplayW, ScrollDisplayH);



//Page Footer
scr_settings_page_footer();





#define scr_menu_draw_stats_header
///scr_menu_draw_stats_header()

// SubEasers
if true {//TweenExists(mainTween) {///and TweenIsPlaying(mainTween) {
    // Tween Title
    subEase[0] = EaseOutBack(clamp(mainEase[0], 0, 1), 0, 1, 1);
    //Tween Lines
    subEase[1] = EaseInBack(clamp(mainEase[0] - .5, 0, 1), 0, 1, 1);
    subEase[11] = clamp(mainEase[0] - 1, 0, 1) * 4.5;
    for (var i = 2; i < 4; i++){
        subEase[i] = EaseInBack(clamp(subEase[11] -.5*i, 0, 1), 0, 1, 1);
    }
    //Tween Array 
    for (var i = 4; i < 11; i++){
        //NB: we use increments of .5 so tweens feel 
        //continuous rather than sequential
        subEase[i] = clamp(subEase[11] - .5*(i-4), 0, 1);
    }
}



/// Stats Header
scr_settings_page_header(subEase[0], subEase[1], 0)



//Draw Menu Choices
var choices_x, choices_y, title_height = string_height(s_menu[0])
for(i = 1; i < array_length_1d(s_menu);i++)
{
    
    //Draw Stat Choice Underline
    titleEndY = scr_draw_title_underline(line_y + title_from_top, subEase[i+1], 0);
 
    
    //Sets Coords for Text
    choices_x = GAME_MID_X//GAME_X +75  +(600)*(1-subEase[i]);
    choices_y  = line_y -75/2 -5//GAME_Y+10 + title_height + 120 + 95*(i-1)
                       
    
    //Draw Stat Choice Filters Text
    draw_set_font(fnt_menu_bn_40_bold);
    if i == 1
    {
        draw_text_ext_transformed_colour(choices_x, choices_y, 
        s_Modes[s_CurrentMode], -1, -1, 1, 1, 0, 
        COLORS[s_CurrentMode+1], COLORS[s_CurrentMode+1], 
        COLORS[s_CurrentMode+1], COLORS[s_CurrentMode+1], subEase[i+1]);
        //Set Current array for modulus 
        c_array = noone;
        c_array = s_Modes;
    }
    else if i ==2
    {
        draw_text_ext_transformed_colour(choices_x, choices_y, 
        s_Size[s_CurrentSize], -1, -1, 1, 1, 0, 
        COLORS[0], COLORS[0], 
        COLORS[0], COLORS[0], subEase[i+1]);
        //Set Current array for modulus 
        c_array = noone;
        c_array = s_Size;
    }
    
    //Draw < Arrows >

    for (j = -1; j < 2; j+=2){
        
        arrowScl = 1;
        //Scale Up ON HOVER AND SELCTION
        arrowW = sprite_get_width(s_v_leftarrow) * 1;
        arrowH = sprite_get_height(s_v_leftarrow) *.75;//2;
        arrowX = choices_x + (150 + arrowW/2) *j; 
        arrowY = choices_y+7;
        arrowHover = point_in_rectangle(mouse_x,mouse_y,arrowX - arrowW, arrowY - arrowH,arrowX + arrowW, arrowY + arrowH);
        
        var arrowSpr;
        //Draw < Arrows >
        if j == -1{
            arrowSpr = s_v_leftarrow 
        }
        else if j == 1{
            arrowSpr = s_v_rightarrow
        }
        
        
        //Selecting Left Arrows
        if arrowHover and s_selected[0] == noone and 
        (!touchPad or mouse_check_button(mb_left)) and 
        (!TweenExists(mainTween))
        {
            arrowScl = 1.25; 
            //On Select of Menu Choice
            if mouse_check_button_pressed(mb_left) and s_selected[1] == true
            {
                //Call Switch Code for this menu choice
                s_selected[1] = false 
                
                if j == -1{ //we set the s_adj here (not with arrowSpr) because we need it only set on button press
                    s_adj = array_length_1d(c_array)-1
                }
                else if j == 1{
                    s_adj = 1
                }
                
                
                ScheduleScript(id,1,.20 ,scr_delayed_selection,s_selected,i)
                scr_sound(sd_menu_click,1,false);
                //event_user(0);
                
            }
        } 
        //Draw < Arrows >
        draw_sprite_ext(arrowSpr, 0,arrowX,arrowY,
        arrowScl,arrowScl,0,COLORS[0],subEase[i+2])
        
    }

}

return titleEndY+4*RU






#define scr_menu_draw_stats_body
//scr_menu_draw_stats_body(start_y)




//Sets Coords for Text
draw_set_font(fnt_menu_bn_40_bold);
//s_titles_y  = 50 - string_height("S")/2  //distance from line_y
row_y = argument0//s_titles_y - ScrollOffset;
//Draw Stat Group Titles
draw_set_color(COLORS[0])
for(i = 0; i < array_length_1d(s_group);i++)
{
    
    //NB: For added efficieny we could lower the batch count if we drew all the category titles, then all the text.
    //Maybe by putting x and y coords in the arrays for stats too.

    // Add Bottom Margin Space After Each Subsequent Section (Not First)
    row_y += 75*min(i,1);  
    
    //Draw Backcoloring
    s_backlight_w = (GAME_W*14/32)*2 *subEase[i+4];
    s_backlight_h = 56//64;
    s_backlight_x = GAME_MID_X-s_backlight_w/2;
    s_backlight_y = row_y// -s_backlight_h/2
    s_backlight_spr = s_v_background_solid_menu;
    s_backlight_xscale = s_backlight_w/sprite_get_width(s_backlight_spr);
    s_backlight_yscale = s_backlight_h/sprite_get_height(s_backlight_spr);
    //s_backlight_col = merge_colour(COLORS[0],COLORS[6],.95);
    s_backlight_col = COLORS[0];
    s_backlight_alpha = subEase[i+4] * .5;
    draw_sprite_stretched_ext(s_backlight_spr,0,s_backlight_x,s_backlight_y,s_backlight_w, 
                    s_backlight_h,s_backlight_col,  s_backlight_alpha);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_menu_bn_40_bold);
    //Draw Stat Group Headings
    s_titles_txt = s_group[i];
    s_titles_h = string_height("S");
    s_titles_x = 40  +(600)*(1-subEase[i+4]) +35; //slide in from right
    s_titles_y = row_y + s_titles_h * .4;
    draw_text(s_titles_x, s_titles_y,s_titles_txt);
    
    /*  It would be so much better to load in the arrays into memory once and then select them here
        as opposed to doing all this memory assignment constantly
    
    
    */              
    
    //Setup stats array
    var stat_label = noone, stat_value = noone;
    k = -1;
    if i == 0 //Best/High Stats
    {
        stat_label[++k] = 'High Score';
        stat_value[k] = highScore[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Best Level';
        stat_value[k] = highLevel[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Longest Playtime';
        stat_value[k] = formatted_longestPlaytime[s_CurrentMode,s_CurrentSize]
        stat_label[++k] = 'Best Combo';
        stat_value[k] = highestBestCombo[s_CurrentMode,s_CurrentSize]
        stat_label[++k] = 'Most Stars Per Game';
        stat_value[k] = highestStars[s_CurrentMode,s_CurrentSize]
        //Omit irrelevanet stats for each mode
        if s_CurrentMode != 2-1{ // 1 == moves mode
            stat_label[++k] = 'Best Star Save Percent';
            stat_value[k] = formatted_highestStarsSaved[s_CurrentMode,s_CurrentSize] //maybe format this in stats load
            stat_label[++k] = 'Most Deflector Catches';
            stat_value[k] = highestDCatches[s_CurrentMode,s_CurrentSize]
            stat_label[++k] = 'Most Star Rebounds';
            stat_value[k] = highestSCatches[s_CurrentMode,s_CurrentSize]
        }
        stat_label[++k] = 'Most Points Per Death';
        stat_value[k] = highestPPD[s_CurrentMode,s_CurrentSize]
        stat_label[++k] = 'Most Deflects';
        stat_value[k] = highReflects[s_CurrentMode,s_CurrentSize]
        stat_label[++k] = 'Most Deflects Per Death';
        stat_value[k] = highestRPD[s_CurrentMode,s_CurrentSize]
        /*
        stat_label[++k] = 'Longest Star Streak';
        stat_value[k] = longestStreak[s_CurrentMode,s_CurrentSize]
        */
        
        //Deflectors Destroyed by type;  We can decide to add this later if we like
        //stat_label[++k] = 'Most Basic Deflectors Destroyed Per Game';
        //stat_value[k] = highestStarsSaved[s_CurrentMode,s_CurrentSize+0*4] //*4 is used to compress 3d array into 2d
        

    
    }
    if i == 1 //Last Game Stats
    {

        stat_label[++k] = 'Last Score';
        stat_value[k] = lastScore[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Last Level';
        stat_value[k] = lastLevel[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Last Playtime';
        stat_value[k] = formatted_lastPlaytime[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Last Best Combo';
        stat_value[k] = lastBestCombo[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Last Stars Per Game';
        stat_value[k] = lastStars[s_CurrentMode,s_CurrentSize]
        //Omit irrelevanet stats for each mode
        if s_CurrentMode != 2-1{ // 1 == moves mode
            stat_label[++k] = 'Last Star Save Percent';
            stat_value[k] = formatted_lastStarsSaved[s_CurrentMode,s_CurrentSize] //maybe format this in stats load
            stat_label[++k] = 'Last Deflector Catches';
            stat_value[k] = lastDCatches[s_CurrentMode,s_CurrentSize]
            stat_label[++k] = 'Last Star Rebounds';
            stat_value[k] = lastSCatches[s_CurrentMode,s_CurrentSize]
        }
        stat_label[++k] = 'Last Deflects';
        stat_value[k] = lastReflects[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Last Deflects Per Death';
        stat_value[k] = lastRPD[s_CurrentMode,s_CurrentSize];
        /*
        stat_label[++k] = 'Last Best Star Streak';
        stat_value[k] = lastLongestStreak[s_CurrentMode,s_CurrentSize];
        */

    }
    if i == 2 //Career/Total Stats
    {
        stat_label[++k] = 'Games Played';
        stat_value[k] = gamesPlayed[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Career Playtime';
        stat_value[k] = formatted_careerPlaytime[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Career Score';
        stat_value[k] = careerScore[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Career Level';
        stat_value[k] = careerLevel[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Stars Seen All-time';
        stat_value[k] = careerStars[s_CurrentMode,s_CurrentSize]
        //Omit irrelevanet stats for each mode
        if s_CurrentMode != 2-1{ // 1 == moves mode
            stat_label[++k] = 'Career Star Save Percent';
            stat_value[k] = formatted_careerStarsSaved[s_CurrentMode,s_CurrentSize] //maybe format this
            stat_label[++k] = 'Deflector Catches All-time';
            stat_value[k] = careerDCatches[s_CurrentMode,s_CurrentSize]
            stat_label[++k] = 'Star Catches All-time';
            stat_value[k] = careerSCatches[s_CurrentMode,s_CurrentSize]
        }
        stat_label[++k] = 'Career Deflects';
        stat_value[k] = careerReflects[s_CurrentMode,s_CurrentSize];

        

    }
    if i == 3 //Average/Per Unit Stats
    {
    
        stat_label[++k] = 'Average Score';
        stat_value[k] = averageScore[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Average Level';
        stat_value[k] = averageLevel[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Average Playtime';
        stat_value[k] = formatted_averagePlaytime[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Average Stars Per Game';
        stat_value[k] = careerStars[s_CurrentMode,s_CurrentSize]
        //Omit irrelevanet stats for each mode
        if s_CurrentMode != 2-1{ // 1 == moves mode
            stat_label[++k] = 'Average Star Save Percent';
            stat_value[k] = formatted_averageStarsSaved[s_CurrentMode,s_CurrentSize] //maybe format this
            stat_label[++k] = 'Average Deflector Catches';
            stat_value[k] = averageDCatches[s_CurrentMode,s_CurrentSize]
            stat_label[++k] = 'Average Star Rebounds';
            stat_value[k] = averageSCatches[s_CurrentMode,s_CurrentSize]
        }
        stat_label[++k] = 'Average Points Per Death';
        stat_value[k] = averagePPD[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Average Deflects';
        stat_value[k] = averageReflects[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Average Deflects Per Death';
        stat_value[k] = averageRPD[s_CurrentMode,s_CurrentSize];
        stat_label[++k] = 'Average Best Combo';
        stat_value[k] = averageBestCombo[s_CurrentMode,s_CurrentSize];
        /*
        stat_label[++k] = 'Average Best Star Streak';
        stat_value[k] = averageLongestStreak[s_CurrentMode,s_CurrentSize];
        */
    }
    
    
    //COLORS[i+1],COLORS[i+1],COLORS[i+1],COLORS[i+1],1);
    // Ease in Scores From Right
    s_scores_x = GAME_W - 40 -35  +(600)*(1-subEase[i+4]); 
    row_y += 56//50 
    row_h = 36 * RU; //arbitrary
    
    row_text_y_adj = row_h * .45;
    
    //Draw Stats Backlighting
    back_h = row_h - 4             // so we shrunk the backlight height
    back_w = s_backlight_w * subEase[i+6]//line_w*2;
    for (s = 0; s <= k; s++){
        if s mod 2{
            back_y = row_y + row_h * s + 2 //We made the colored rows thinner
            draw_stats_background(back_y, back_w, back_h, COLORS[0], subEase[i+6])
        }
    }
    //Set Alpha
    draw_set_alpha(subEase[i+6])  //Alphas in after above heading slides in
        //Draw Stats Labels and Values
        for (s =0; s<=k;s++){
            label_x = s_titles_x;
            label_y = row_y + row_text_y_adj// ;
            value_x = s_scores_x;
            value_y = row_y + row_text_y_adj //;
            draw_stats_text(label_x,label_y,stat_label[s],fnt_menu_calibri_24_bold, fa_left) //draw label
            draw_stats_text(value_x,value_y,stat_value[s],fnt_menu_calibri_22_bold, fa_right) //draw value
            
            if s!=k {row_y += row_h}
            
        }
    //Unset Alpha
    draw_set_alpha(1)
    
} 
// Add End of Page Margin
row_y += 50 * RU;

return row_y;