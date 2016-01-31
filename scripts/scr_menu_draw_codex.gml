///scr_menu_draw_codex()





// SubEasers
scr_menu_draw_set_easers_simple();



// Page Body

//Enable Scrolling
scr_page_scroll_begin(ScrollStartY, ScrollEndY)

//Draw Codex
ScrollDrawH = scr_codex_draw(codex_categories, line_w*.9, ScrollStartY-ScrollOffset, 0, subEase[2]) - ScrollStartY
    //Returns the end y coordinate which we use to calculate the draw height of the scroll page.


//Draw Scroll Surface
scr_page_scroll_end(ScrollDrawH, GAME_X, ScrollStartY, ScrollDisplayW, ScrollDisplayH);

//Draw Blackout Margins
scr_page_scroll_margins(1);

//Draw Counts
ScrollEndY = scr_settings_page_counts(unlockCounts[1],unlockCounts[0], unlockCounts[2], "", subEase[1], 1);

///Page Header (Order reverse for Line_Y's to be right
ScrollStartY = scr_settings_page_header(subEase[0], subEase[1], 1);


//Page Footer
scr_settings_page_footer();
