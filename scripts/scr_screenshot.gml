#define scr_screenshot
///scr_screenshot(draw_particles, draw_self, drawInDepthOrder)

draw_enable_drawevent(1); //in case of frameskipper
//scr_draw_smoothing(0)
    //NB: We do this to keep the text on surfaces from getting artifacts
var drawParticles = argument0;
var drawInDepthOrder = argument2;


// Create a Surface for screenshot
var surf = surface_create(VIEW_W,VIEW_H);//GAME_W, GAME_H);//i can fix this by making x wider
surface_set_target(surf);

// Clear Surface
draw_clear_alpha(COLORS[6], 0);


// If Using Gameplay Draw Order
if drawInDepthOrder {
    //Use Order loosely based off object depths
    with (obj_control_rail){event_perform(ev_draw, 0)}
    with (obj_control_game){event_perform(ev_draw, 0)}
    with (obj_control_modifiers){event_perform(ev_draw, 0)}
    with (obj_control_tutorial){event_perform(ev_draw, 0)}
    with (obj_parent_dummy){event_perform(ev_draw, 0)}
    with (obj_reflector_parent_basic){draw_self()}
    with (obj_reflector_special_parent){event_perform(ev_draw, 0);}
    // Draw Particles
    if drawParticles {
        part_system_drawit(PSYS_FIELD_LAYER);
    }
    //with (obj_star_outline){event_perform(ev_draw, 0)} //NB: Not good in screenshots
    with (obj_launcher){event_perform(ev_draw, 0);}
    // Draw Particle Systems
    if drawParticles {
        part_system_drawit(PSYS_SUBSTAR_LAYER);
    }
    with (obj_powerup_falling){event_perform(ev_draw, 0);}
    // Draw Particle Systems
    if drawParticles {
        part_system_drawit(PSYS_STAR_LAYER);
    }
    
    with (obj_star_marker){event_perform(ev_draw, 0)}
    with (obj_star){draw_self()}
    // Text Is Highest
    with (obj_text_generic){event_perform(ev_draw, 0);}
    with (obj_control_powerups){event_perform(ev_draw, 0)}
    
    //NB: If you change how things are drawn or add things you'll need to update this...
}
// Else Draw Everything Indiscriminately
else {
    // Draw Everything to Surface
    with (all)
    {
        if (id != other.id or argument1) and visible // except self
        {   
            // Call Draw Event
            event_perform(ev_draw, 0);
            if sprite_index >= 0 {draw_self()}
            
        }
    }
    // Draw Particle Systems
    if drawParticles {
        part_system_drawit(PSYS_FIELD_LAYER);
        part_system_drawit(PSYS_SUBSTAR_LAYER);
        part_system_drawit(PSYS_STAR_LAYER);
    }
    

}


// Preclear
/*
draw_set_colour( c_black );
draw_set_blend_mode( bm_add );
draw_rectangle( 0, 0, VIEW_W - 1, VIEW_H - 1, false );
draw_set_blend_mode( bm_normal );
*/
// Set Alpha of All Pixels to 1 (so it's not transparent/blurry)
draw_set_blend_mode( bm_add );
draw_sprite_stretched_ext(s_v_background_solid,0, 0,0,VIEW_W,VIEW_H, c_black, 1);
draw_set_blend_mode( bm_normal );


//Take a screenshot
var spr_temp = sprite_create_from_surface(surf, 0, 0, VIEW_W, VIEW_H, false, false, 0, 0);

// Cleanup
surface_reset_target();
surface_free(surf);

return spr_temp




#define scr_screenshot_highdef_file
///scr_screenshot_highdef_file(fname, game_order)

var fname = argument0;
var game_order = argument1;

// Take Screenshot on 0 Opacity Background
var spr_temp = scr_screenshot(1,1, game_order);
    /*NB: VERY IMPORTANT for this to come out without artifaces
    that none of the objects being drawn are drawing a background 
    e.g. like the rectangle on Gameover object had or pause has.
    */

// Save Sprite
sprite_save(spr_temp,0, fname);
// Delete Sprite
sprite_delete(spr_temp);
 
// Return Fname
return fname; 
 


#define scr_screenshot_highdef_sprite
///scr_screenshot_highdef_sprite(game_order)

var game_order = argument0;

// Take Screenshot on 0 Opacity Background
var spr_temp = scr_screenshot(1,1, game_order);
    /*NB: VERY IMPORTANT for this to come out without artifaces
    that none of the objects being drawn are drawing a background 
    e.g. like the rectangle on Gameover object had or pause has.
    */
  
 


// Return Sprite
return spr_temp; 



#define scr_screenshot_app_surf
///scr_screenshot_app_surf()

/* NB: Problem, this is coming out too dark because the alpha of surfaces works differently from display buffer


*/


draw_enable_drawevent(1); //in case of frameskipper

//draw_sprite_stretched_ext(s_v_background_solid,0, 0,0,VIEW_W,VIEW_H, c_black, 1);
//draw_set_blend_mode( bm_normal ); 


//Take a screenshot
var spr_temp = sprite_create_from_surface(application_surface, 0, 0, VIEW_W, VIEW_H, false, false, 0, 0);

// Disable App Surface
application_surface_enable(0);

return spr_temp




#define scr_deactivate_everything_else
///scr_deactivate_everything_else()

//draw_enable_drawevent(1);

deactivated_object_list = ds_list_create()

//Deactivate everything
with (all){ //with (obj_persistent_parent) //could work
    if id == other.id or
       object_index == obj_SharedTweener or
       object_index == obj_SharedScheduler or
       object_index == obj_frame_skip_custom or//TMC_FrameSkip_obj or
       object_is_ancestor(object_index,obj_persistent_parent)
    {
       continue 
    }
    else{
        ds_list_add(other.deactivated_object_list,id);
        instance_deactivate_object(id);
        
    }
}
//instance_deactivate_all(true);

#define scr_draw_still_screen
///scr_draw_still_screen(sprite, alpha)
/*
    NB: Sometimes the Draw code fires before the Step code and you have a flicker when pause is pressed.
    We resolve this by drawing the new sprite background to the screen once.
*/

/*
// Set Surface Target
scr_assert_menuSurface_exists();
surface_set_target(global.menuSurface);
draw_clear_alpha(COLORS[7],0);
*/


//Draw Sprite to Surface
//draw_clear_alpha(COLORS[7],0);
draw_sprite_ext(argument0, 0, GAME_X, GAME_Y, 1, 1, 0, c_white, argument1);

/*
// Reset Target
surface_reset_target();

#define scr_assert_menuSurface_exists
///scr_assert_menuSurface_exists()

/*
//Check that surface exists:
if !surface_exists(global.menuSurface){
    global.menuSurface = surface_create(room_width,room_height);
}

#define scr_pause_effects
///scr_pause_effects()

//PAUSE effect create above/below default effects
part_system_automatic_update(0, false);
part_system_automatic_draw(0, false);
part_system_automatic_update(1, false);
part_system_automatic_draw(1, false);
//PAUSE custom effects
part_system_automatic_update(PSYS_SUBSTAR_LAYER, false);
part_system_automatic_draw(PSYS_SUBSTAR_LAYER, false);
part_system_automatic_update(PSYS_FIELD_LAYER, false);
part_system_automatic_draw(PSYS_FIELD_LAYER, false);
part_system_automatic_update(PSYS_STAR_LAYER, false);
part_system_automatic_draw(PSYS_STAR_LAYER, false);

audio_pause_all();
MUSIC_ACTIVE = false;

shaking = false
if SHAKE_TIME > -2{
    shaken_xview = view_xview[0]
    shaken_yview = view_yview[0]
    shaking = true
}

#define scr_resume_effects
///scr_resume_effects()

// RESUME SFX
if !sfx_sound[1] {
   for (i=0;i<ds_list_size(sfx_list);i++){
       audio_stop_sound(sfx_list[| i])
   }
} else {
   for (i=0;i<ds_list_size(sfx_list);i++){
       audio_resume_sound(sfx_list[| i])
       audio_sound_gain(sfx_list[| i],sfx_sound[0],0);
   }
}
// RESUME MUSIC
if audio_exists(CURRENT_SONG) {
   audio_resume_sound(CURRENT_SONG)
   audio_sound_gain(CURRENT_SONG,music_sound[0]*music_sound[1],0);
                                // NB: Volume * Mute
}
/*
if !music_sound[1] {
   for (i=0;i<ds_list_size(music_list);i++){
       audio_resume_sound(music_list[| i])
       audio_sound_gain(music_list[| i],0,0);
   }
} else {
   for (i=0;i<ds_list_size(music_list);i++){
       audio_resume_sound(music_list[| i])
       audio_sound_gain(music_list[| i],music_sound[0],0);
   }
}
*/
//audio_resume_all();


//unpause effect create zbove/below default effects
part_system_automatic_update(0, true);
part_system_automatic_draw(0, true);
part_system_automatic_update(1, true);
part_system_automatic_draw(1, true);
//unpause custom effects
part_system_automatic_update(PSYS_SUBSTAR_LAYER, true);
part_system_automatic_draw(PSYS_SUBSTAR_LAYER, true);
part_system_automatic_update(PSYS_FIELD_LAYER, true);
part_system_automatic_draw(PSYS_FIELD_LAYER, true);
part_system_automatic_update(PSYS_STAR_LAYER, true);
part_system_automatic_draw(PSYS_STAR_LAYER, true);


if shaking{
   view_xview[0] = shaken_xview
   view_yview[0] = shaken_yview
}

#define instance_activate_list
///instance_activate_list(list)


var deactivated_object_list = argument0;
//instance_activate_all();
for (var i = 0, n = ds_list_size(deactivated_object_list); i < n; i++){
    instance_activate_object(deactivated_object_list[| i]);
}
ds_list_destroy(deactivated_object_list)