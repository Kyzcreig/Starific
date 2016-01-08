#define scr_share_screen_init
///scr_share_screen_init()

// Screenshot Stuff for Taking a Cool Shareable SS
globalvar 
SHARE_SCREEN_METRIC,
SHARE_SCREEN_SPR;
//SHARE_SCREEN_FLAG;



SHARE_SCREEN_SPR = noone;
SHARE_SCREEN_METRIC = noone;
//SHARE_SCREEN_FLAG = false;

#define scr_share_screen_reset
///scr_share_screen_reset()

if sprite_exists(SHARE_SCREEN_SPR){
    sprite_delete(SHARE_SCREEN_SPR); 
}

SHARE_SCREEN_SPR = noone;
SHARE_SCREEN_METRIC = noone;
//SHARE_SCREEN_FLAG = false;



#define scr_share_screen_make_combined
///scr_share_screen_make_combined(screen1, screen2, save_name)


var image1 = argument0;
var image2 = argument1;
var save_name = argument2;

var spr_exists1 = sprite_exists(image1);
var spr_exists2 = sprite_exists(image2);

// Make Super Surface
var surf = surface_create(VIEW_W*(spr_exists1+spr_exists2), VIEW_H);
surface_set_target(surf);
draw_clear_alpha(COLORS[6],0);

if spr_exists1 {
    draw_sprite(image1, 0, 0, 0); //gameplay screen
}
if spr_exists2 {
    draw_sprite(image2, 0, VIEW_W * spr_exists1, 0); //gameover screen
}


//draw_sprite(image1, 0, 0, 0);
//draw_sprite(image2, 0, VIEW_W, 0);
// Get Sprite From Image1
//var tmp_spr = sprite_add(image1, 1, false, false, 0, 0);
// Draw Image1
//draw_sprite(tmp_spr, 0, 0, 0);
// Delete Sprite1
//sprite_delete(tmp_spr);

// Get Sprite From Image2
//var tmp_spr = sprite_add(image2, 1, false, false, 0, 0);
// Draw Image2
//draw_sprite(tmp_spr, 0, VIEW_W, 0);
// Delete Sprite2
//sprite_delete(tmp_spr);


// Make New Image
surface_save(surf, save_name);

// Cleanup
surface_reset_target();
surface_free(surf);


return save_name;



#define scr_share_screen_gameplay_make
///scr_share_screen_gameplay_make()

// Decide Whether to Take a SS Each Second
//if FULL_SECOND_INTERVAL and
//if TENTH_SECOND_INTERVAL and
if ALTERNATE_STEP_INTERVAL and 
   (SHARE_SCREEN_GAMEOVER == 2) and
   !sprite_exists(SHARE_SCREEN_SPR) and
   (scr_great_game_check())
{
    //NB: IF this is laggy we can try a bigger interval.
    
    var newSSMEtric = 0;

    // Measure Star Count
    //newSSMEtric += logn(1.75, global.ActiveStarCount);
    newSSMEtric += logn(2.25, global.ActiveStarCount);
    
    // Measure Bomb Force
    newSSMEtric += logn(2.25, global.BOMB_FORCE);
    
    // Measure Queued Bomb Count
    var bombQueuedCount = ds_list_size(global.DEATH_TIMERS_LIST);
    newSSMEtric += -4 * (bombQueuedCount / BOARD_TOTAL);//penalize big explosions, too unreadable
    
    // Measure Particle Count (For Field Layer)
    var detonationCount = scr_particle_explosion_number();
    if detonationCount + bombQueuedCount > BOARD_TOTAL * .4 {
        newSSMEtric += -5 * (detonationCount / BOARD_TOTAL); //penalize big explosions, too unreadable
    } else {
        newSSMEtric += 5 * (detonationCount / BOARD_TOTAL); //bonus for a few bombs
    }
  
        
    // Measure Queued Bomb Count
    //newSSMEtric += -4.0 * (bombQueuedCount / BOARD_TOTAL);//penalize big explosions, too unreadable
    /*if bombQueuedCount / (BOARD_TOTAL) > fieldDensity * .25 {
        newSSMEtric += -.20 * (bombQueuedCount / BOARD_TOTAL / fieldDensity);//penalize big explosions, too unreadable
    } */

    
    // Measure Deflector Count
    var defCount = instance_number(obj_reflector_parent);
    if defCount / BOARD_TOTAL < fieldDensity * 1.5 {
        newSSMEtric += 2.0 * (defCount / BOARD_TOTAL); //bonus for good map coverage
    }
    
    
    // Measure Falling Powers
    var fallCount = instance_number(obj_powerup_falling);
    newSSMEtric +=  -2.0 * (fallCount / BOARD_TOTAL ); //penalty for too many projectiles
    
    // Measure Board Wide Effects
    if boardFilledTimer > 0 or boardClearedTimer > 0 {
        newSSMEtric -= 2; //penalty for board wide effects
    
    }
    
    
    //If Higher than Cached Metric
    var metricDelta = newSSMEtric - SHARE_SCREEN_METRIC;
    //var reqBaseMetric = 1.5 + .5 * GRID // 1.5
    var reqBaseMetric = 2.5 + .5 * GRID // EVALUATE ME: maybe higher?
    //if metricDelta > 0 or SHARE_SCREEN_METRIC == noone 
    if (metricDelta > 1) and (newSSMEtric >= reqBaseMetric)
    {
        //Cache New Metric
        SHARE_SCREEN_METRIC = newSSMEtric;
        //show_message(string(SHARE_SCREEN_METRIC)); 
        
        /*
        // Take Screenshot
        if sprite_exists(SHARE_SCREEN_SPR) {
            sprite_delete(SHARE_SCREEN_SPR);
        }
        SHARE_SCREEN_SPR = scr_screenshot_highdef_sprite(1);
        */
        /* NB: I found this method WAY too laggy on Android.
        
        */
        
        // Schedule Screenshot
        scr_share_screen_gameplay_delayed_init();
        /* NB: This method is better, but still too laggy.
        
        */
        
    }   

} 

#define scr_share_screen_gameover_make
///scr_share_screen_gameover_make()

// If Screenshot Sharing
if SHARE_SCREEN_GAMEOVER > 0 or SHARE_ALWAYS_OVERRIDE {
    // If No Screenshot
    if !sprite_exists(SHARE_SCREEN_SPR) and 
        scr_great_game_check()
    {
        // Take Screenshot of the very end
        scr_share_screen_gameplay_delayed_init();
        SHARE_SCREEN_METRIC = 0; //Marked as shareable but not high metric
        
        //ScheduleScript(obj_control_main, true, .1, scr_share_screen_gameplay_delayed_init);
            /* The falling powerups can look like their symbol is missing because they are destroyed and only the particles remain.
            
            */
    }
}

#define scr_share_screen_gameplay_save
///scr_share_screen_gameplay_save()

if SHARE_SCREEN_GAMEOVER > 0 or SHARE_ALWAYS_OVERRIDE{
    if sprite_exists(SHARE_SCREEN_SPR){
    
        // Create Surface
        var surf = surface_create(VIEW_W,VIEW_H);
        // Set Target
        surface_set_target(surf);
        // Draw Background
        draw_clear_alpha(COLORS[6],0);
        
        // Set Blend Mode
        draw_set_blend_mode_ext(bm_one, bm_zero);
        
        // Draw Gameplay Sprite
        draw_sprite(SHARE_SCREEN_SPR,0,0,0);
        
        // Set Blend Mode
        draw_set_blend_mode( bm_add );
        
        // Fix Alpha Channel
        draw_sprite_stretched_ext(s_v_background_solid,0, 0,0,VIEW_W,VIEW_H, c_black, 1);
        //draw_sprite_stretched_ext(s_v_background_solid,0, 0,0,PORT_W,PORT_H, c_black, 1);
        
        // Reset Blend Mode
        draw_set_blend_mode( bm_normal);
    
        // Delete Sprite
        //sprite_delete(SHARE_SCREEN_SPR); 
        // Overwrite Sprite
        SHARE_SCREEN_SPR = sprite_create_from_surface(surf, 0, 0, VIEW_W, VIEW_H, false, false, 0, 0);
        
        // Save Surface
        surface_save(surf,"ss_gameplay.png");
        
        // Cleanup Surface
        surface_reset_target();
        surface_free(surf);
        
        
        /*
        // Save Sprite
        sprite_save(SHARE_SCREEN_SPR, 0, "ss_gameplay.png");
        // Delete Sprite
        sprite_delete(SHARE_SCREEN_SPR); 
        //show_message(string(SHARE_SCREEN_METRIC));
        */
        
    } 
}

#define scr_share_screen_gameplay_delayed_init
///scr_share_screen_gameplay_delayed_init()

// Schedule Screenshot
ScheduleScript(id,false,1,scr_share_screen_gameplay_delayed);
// Enabled App Surface
draw_enable_drawevent(1); //in case of frameskipper
application_surface_enable(1);
surface_resize(application_surface, VIEW_W, VIEW_H);

#define scr_share_message_gameover
///scr_share_message_gameover()

return "Just scored "+string(score_p1)+"! Beat that!";
#define scr_share_screen_gameplay_delayed
///scr_share_screen_gameplay_delayed()


/*NB:  It is possible that things can go WRONG if our temporary appsurface is enabled right before pause.
    But I guess it would be corrected on the next game anyway.
*/

//Take Screenshot
if sprite_exists(SHARE_SCREEN_SPR) {
    sprite_delete(SHARE_SCREEN_SPR);
}
//SHARE_SCREEN_SPR = scr_screenshot_highdef_sprite(1);
SHARE_SCREEN_SPR = scr_screenshot_app_surf();
//show_message(SHARE_SCREEN_METRIC)
// NB: Maybe add a cooldown after a screenshot? Because a lot in a row can lag.
// Too bad surfaces lag like fuck on android.
