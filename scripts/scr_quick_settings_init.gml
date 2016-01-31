#define scr_quick_settings_init
///scr_quick_settings_init()


title_txt = "";


//Delete Original Tween
TweenDestroy(mainTween); 
// Make New Tween
mainTween = TweenFire(id, mainEase, EaseLinear, TWEEN_MODE_ONCE, true, 0, .25, mainEase[0], 1);



quick_page_goto[0] = noone;

reset_room = true;

//NB: We set this when we create the object


#define scr_quick_settings_draw
///scr_quick_settings_draw()


// SubEases
subEase[0] = clamp(mainEase[0],0,1)

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
        room_persistent = true;
        //Take us to options page
        // Go to The Selected Settings Page
        ScheduleScript(obj_control_main, 0, 1, scr_room_goto, rm_options);
        // Schedule Processing on Return
        ScheduleScript(id, 0, 5, scr_quick_settings_return);
        
    }
}

#define scr_quick_settings_destroy
///scr_quick_settings_destroy()


// Set Global Settings State
//SETTINGS_ROOM = 0;
// Set Room Restart Stuff
if reset_room {
    scr_restart_game_init();
} else {
    //Depersist Room
    room_persistent = false
    // Set Last Room
    LAST_ROOM = rm_menu 
}

#define scr_quick_settings_return
///scr_quick_settings_return()


if reset_room {
    instance_destroy();
} else {
    scr_prompt_exit(.50)
}