#define scr_prompt_share_preview_init
///scr_prompt_share_preview_init()

share_reward = false;
share_button_id = -1;

// Destroy Inherited Tween
TweenDestroy(mainTween)
// Create New Tween
mainTweenDur = .30;
mainTween = TweenFire(id, mainEase, EaseLinear, TWEEN_MODE_ONCE, true, 0, mainTweenDur, mainEase[0], 1);

//Schedule Share Init
TweenAddCallback(mainTween, TWEEN_EV_FINISH, id, 
                scr_prompt_share_preview_schedule_intent, 2.5);


// Save Screenshot
sprite_save(spr_temp, 0, "ss_gameover.png")
//scr_screenshot_highdef_file("ss_gameover.png",0);

// Create Gameover Sprite
spr_gameplay = SHARE_SCREEN_SPR;//sprite_add("ss_gameplay.png", 1, false, false, 0, 0);

/* NB (Crashes): We got a crash on this code I think. 
    If we get more crashes I'm going to suggest trying to pass in a sprite rather than turning the file into a sprite.
    Probably also try some conditionals on the existance of sprites 
*/


// Set Screenshot Scale
preview_scale = .5;


// Set Start Coordinates
start_x = x;
start_y = y;
// Set End Coordinates 
end_x = GAME_MID_X;
end_y = GAME_MID_Y;
// Set Start Dimensions
start_w = 0;
start_h = 0;
// Set End Dimensions
end_w = preview_scale * VIEW_W ;
end_h = preview_scale * VIEW_H ;



#define scr_prompt_share_preview_step
///scr_prompt_share_preview_step()


// Draw Header with no Title
scr_prompt_step_head_no_title(false);

// Set Coordinates
rect_x = lerp(start_x, end_x, subEase[0]);
rect_y = lerp(start_y, end_y, subEase[0]);
// Set Dimensions (Frame)
rect_w = lerp(start_w, end_w, subEase[0]);
rect_h = lerp(start_h, end_h, subEase[0]);

    
    
// Draw Gameplay Screen Frame
var frame_scale = 1.25; //EVALUATE ME
draw_sprite_stretched_ext(s_v_background_solid_menu,0,
    rect_x-rect_w/2*frame_scale, 
    rect_y-rect_h/2*frame_scale, 
    rect_w*frame_scale, 
    rect_h*frame_scale, COLORS[7], 1);
    
    /*
var frame_w = rect_h * .125; //EVALUATE ME
draw_sprite_stretched_ext(s_v_background_solid_menu,0,
    rect_x-rect_w/2-frame_w, 
    rect_y-rect_h/2-frame_w, 
    rect_w+frame_w*2, 
    rect_h+frame_w*2, COLORS[7], 1);
    
    */
    
// Draw Gameplay Screen Border
var border_w = 2 * subEase[0];
draw_sprite_stretched_ext(s_v_background_solid_menu,0,
    rect_x-rect_w/2-border_w, 
    rect_y-rect_h/2-border_w, 
    rect_w+border_w*2, 
    rect_h+border_w*2, COLORS[0], 1);
 
// Draw Gameplay Screen
if sprite_exists(spr_gameplay) {
    var screen_scale = preview_scale * subEase[0];
    draw_sprite_ext(spr_gameplay, 0, 
        rect_x-rect_w/2,
        rect_y-rect_h/2, 
        screen_scale, 
        screen_scale, 0, c_white, 1);
}
    

// If Screen Tapped    
if mouse_check_button_pressed(mb_left) and !TweenExists(mainTween) {
    // Skip to the Scheduled Share Intent
    if ScheduleExists(mainSchedule) {
        ScheduleFinish(mainSchedule)
    }    
    // Exit Tween
    mainTween = TweenFire(id, mainEase, EaseLinear, TWEEN_MODE_ONCE, true, 0, mainTweenDur, mainEase[0], 0);
    TweenAddCallback(mainTween, TWEEN_EV_FINISH, id, Destroy, id);
    

}





#define scr_prompt_share_preview_schedule_intent
///scr_prompt_share_preview_schedule_intent(duration)


mainSchedule = ScheduleScript(id, true, argument0, scr_share_mobile, 
                                false, true, scr_share_message_gameover());


#define scr_prompt_share_preview_cleanup
///scr_prompt_share_preview_cleanup()


if SHARE_SCREEN_SPR != spr_gameplay and sprite_exists(spr_gameplay){
    sprite_delete(spr_gameplay);   
}

//Schedule Share Reward
if share_reward {
    ScheduleScript(obj_control_main, false, 3, 
                    scr_share_reward_callback, share_button_id);
}

#define scr_share_reward_callback
///scr_share_reward_callback(share_button_id)


// CaLlback obj checks if share suceeded on iOS
with (instance_create(x,y, obj_share_callback) ) {
    share_button_id = argument0;
}