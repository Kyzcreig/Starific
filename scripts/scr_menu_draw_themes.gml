///scr_menu_draw_themes()




// SubEasers
if true {//TweenExists(mainTween) {//and TweenIsPlaying(mainTween) {
    subEase[0] = EaseOutBack(clamp(mainEase[0],0,1), 0, 1, 1)
    subEase[1] = clamp(mainEase[0]-0.5,0,1)
    subEase[2] = EaseOutBack(clamp(mainEase[0]-1.0,0,1), 0, 1, 1);
}







// Page Body
 
//Enable Scrolling
scr_page_scroll_begin(ScrollStartY, ScrollEndY)

//Draw Themes
    //NB: maybe start a little lower than scroll offset e.g. 4 -ScrollOffset
    //so we have space for the selection rectangle/stroke
    //we could probably do the same for the inner_width
    //making it line_w - 4;
//draw_set_blend_mode_ext( bm_one, bm_zero );
ScrollDrawH = scr_themes_draw(line_w*.9, ScrollStartY-ScrollOffset, subEase[2]) - ScrollStartY;
//draw_set_blend_mode(bm_normal);


//Draw Scroll Surface
scr_page_scroll_end( ScrollDrawH, GAME_X, ScrollStartY, ScrollDisplayW, ScrollDisplayH);

//Draw Blackout Margins
scr_page_scroll_margins(0);


//Draw Counts
ScrollEndY = scr_settings_page_counts(unlockCounts[1],unlockCounts[0], unlockCounts[2], COLORS[SKIN_NAME_INDEX], subEase[1], 0); //

///Page Header (Order reverse for Line_Y's to be right
ScrollStartY = scr_settings_page_header(subEase[0], subEase[1]);


//Page Footer
scr_settings_page_footer();
