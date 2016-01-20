#define scr_prompt_loading_init
///scr_prompt_loading_init()


//Delete Original Tween
TweenDestroy(mainTween); 
// Make New Tween
mainTween = TweenFire(id, mainEase, EaseLinear, TWEEN_MODE_ONCE, true, 0, .25, mainEase[0], 4);


load_sprite = spr_loading_spinner;
load_number = sprite_get_number(load_sprite);

image_index = 0;
image_speed = load_number / room_speed;

load_destroy[0] = false;


#define scr_prompt_loading_step
///scr_prompt_loading_step()



// Prompt Head
scr_prompt_step_head_blank();

// Draw Loading Sprite
load_scale = mainEase[0] * .25; // Max = 1
draw_sprite_ext(load_sprite, image_index, GAME_MID_X, GAME_MID_Y, 
                load_scale, load_scale, 0, COLORS[0], clamp(load_scale,0,1)); 


// Exit
if (load_destroy[0] or SWIPE_TAP or 
    iap_status() == iap_status_available) and 
    !TweenExists(mainTween) 
{
    // Make New Tween
    scr_prompt_exit(.25);
    
}