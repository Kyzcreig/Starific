///scr_menu_draw_themes()



// SubEasers
scr_menu_draw_set_easers_simple();






// Page Body
 
//Enable Scrolling
scr_page_scroll_begin(ScrollStartY, ScrollEndY)

//Draw Themes
ScrollDrawH = scr_themes_draw(line_w*.9, ScrollStartY-ScrollOffset, subEase[2]) - ScrollStartY;

//Draw Scroll Surface
scr_page_scroll_end( ScrollDrawH, GAME_X, ScrollStartY, ScrollDisplayW, ScrollDisplayH);

//Draw Blackout Margins
scr_page_scroll_margins(0);

//Draw Counts
ScrollEndY = scr_settings_page_counts(unlockCounts[1],unlockCounts[0], unlockCounts[2], COLORS[SKIN_NAME_INDEX], subEase[1], 0); //

//Page Header (Order reverse for Line_Y's to be right
ScrollStartY = scr_settings_page_header(subEase[0], subEase[1]);


//Page Footer
scr_settings_page_footer();
