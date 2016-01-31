#define scr_prompt_blank_init
///scr_prompt_blank_init()

rect_x = 0
rect_y = 0;
rect_h = 0;
rect_w = 0;

//Delete Original Tween
TweenDestroy(mainTween); 
// Set Eases
mainEase[0] = 1;
subEase[0] = 1;


//ScheduleScript(id, true, 60, Destroy, id);



#define scr_prompt_blank_step
///scr_prompt_blank_step()



// Draw Screenshot in Background
scr_draw_background_screenshot(1);

// Prompt Foot
//scr_prompt_step_foot(true);
/*
// Exit
if (load_destroy[0] or SWIPE_TAP or 
    iap_status() == iap_status_available) and 
    !TweenExists(mainTween) 
{
    // Make New Tween
    scr_prompt_exit(.25);
    
}