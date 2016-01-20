#define scr_quick_settings_init
///scr_quick_settings_init()


title_txt = "";

quick_page_goto[0] = noone;

//NB: We set this when we create the object


#define scr_quick_settings_draw
///scr_quick_settings_draw()


// SubEases
subEase[0] = clamp(mainEase[0]/4,0,1)

// Draw Screenshot in Background
scr_draw_background_screenshot(1);

// Draw Mask over Background
scr_draw_background_mask(subEase[0] * 1, 0);


// If State is Set
if object_exists(quick_page_goto[0]) {

    // When Tween Complete
    if !TweenExists(mainTween){

        // Set Global Settings State
        QUICK_PAGE_CONTROLLER = quick_page_goto[0];
        // Flag Quick Settings State as Done
        quick_page_goto[0] = noone;
        
        //select_menu_choice(rm_options,true,true)
        // Set Up Room Persistence
        LAST_ROOM = room  
        room_persistent = true
        //Take us to options page
        //scr_room_goto( rm_options);
        ScheduleScript(obj_control_main, 0, 1, scr_room_goto, rm_options);
        // Schedule Self Destruct (Persistent Room)
        ScheduleScript(id, 0, 3, Destroy, id);
        
    }
}