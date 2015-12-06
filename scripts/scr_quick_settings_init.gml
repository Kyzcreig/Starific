#define scr_quick_settings_init
///scr_quick_settings_init()


title_txt = "";

quick_settings_state[0] = -1;

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
if quick_settings_state[0] > -1 {

    // When Tween Complete
    if !TweenExists(mainTween){

        // Set Global Settings State
        SETTINGS_ROOM = quick_settings_state[0];
        // Flag Quick Settings State as Done
        quick_settings_state[0] = -2;
        
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