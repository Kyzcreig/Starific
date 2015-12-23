#define scr_menu_draw_tutorial
///scr_menu_draw_tutorial()

//If ingame and game hasn't started
if GAME_ACTIVE{ 
    // Set Blend Mode for Nice Text
    //draw_set_blend_mode_ext( bm_one, bm_zero );
    scr_menu_draw_tutorial_helper()  
    //draw_set_blend_mode(bm_normal)
}    
else{
    instance_destroy();
}

#define scr_menu_draw_tutorial_helper
///scr_menu_draw_tutorial_helper()

if !TUTORIAL_ENABLED{


    draw_set_font(button_font);
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);
    var n = 2; //set number of buttons;
    for (var i = 0; i < n; i++) {
    
        data = text_buttons[i];
        text_text = data[0];
        text_id = data[1];
        text_w = string_width(text_text) * 1.25;
        text_h = string_height(text_text) * 1.25; //may need a /2 here if it's too big an area
    
        //Set Button Data
        if i == 0 {
            text_x = GAME_X+GAME_W - (10 + text_w/2) +100 * (1 -helpTween[0])
            
        } else if i == 1 {
            text_x = GAME_X + (10+text_w/2) - 100 * (1 -helpTween[0])
            
        }
        text_y = GAME_Y+GAME_H -20 -text_h/2 +100* (1 -helpTween[0]);
        intro_text_y = text_y; //cache pre-wiggle coordinates
        
        // Set wiggle 
        if wiggle_index = i {
            wig_str = 6; //4
            wig_x = random_range(-1,1)*wig_str;
            wig_y = random_range(-1,1)*wig_str;
            
            text_x += wig_x;
            text_y += wig_y;
        
        }
        
        
        text_color = COLORS[0];
        text_scale = 1;
        
        //Check for Mouse Hover
        text_hover = point_in_rectangle(mouse_x,mouse_y,text_x-text_w,text_y-text_h,text_x+text_w,text_y+text_h) 
        
        //Prevent touchpad from moving to a button
        if text_hover{ tp_on_button[0] = 2}
            
        if text_hover and help_selected[0] == noone and 
        (!touchPad or mouse_check_button(mb_left)) and (!TweenExists(TweenHelp))
        {
            //Interupt and disable wigglers if mouseover
            scr_wiggle_reset(-1, 8*room_speed);
            
            
            //Grow and alt color on hover
            text_scale *= 1.2
            text_color = merge_colour(text_color,COLORS[6],.5);
        
            
            //On Clicking Text
            if mouse_check_button_pressed(mb_left) and help_selected[1] == true
            {
            
                SWIPE = false; // disable other clicks
                mouse_clear(mb_left);
                  
                if text_id == 0{
                    //Set Flag tutorial active
                    TUTORIAL_STARTED[0] = true;
                }
                
                ScheduleScript(id,0,.25,scr_delayed_selection,help_selected,text_id)
                
                help_selected[1] = false
              
            
                //click sound
                scr_sound(sd_menu_click,1,false);
                
            } 
            
        }
        // Draw Help Text
        draw_text_ext_transformed_colour(text_x, text_y, text_text, -1, -1, 
        text_scale, text_scale, 0, text_color,text_color,text_color,text_color,1);
    }
    
    
    // If nothing selected, cue button wiggles
    if help_selected[0] == noone{
         scr_wiggle_timer(n, 1.5*room_speed, 8*room_speed);
    }

  
    

        
    //TWEEN OUT IF GAME STARTS
    if MOVE_ACTIVE and helpTween[0] != 0 and !TweenExists(TweenHelp){
    
        TweenHelp = TweenFire(id,helpTween,guiEaseReverse,
                           TWEEN_MODE_ONCE, 1, 0,.5,1,0)
        TweenAddCallback(TweenHelp,TWEEN_EV_FINISH,id,Destroy,id)
    }
    


}  



/////////////Active tutorial stuff//////////////////////////////////////////////////////  

if TUTORIAL_ENABLED{

   //Tween for Tutorial Title :how to play"
    if tutorialTitleTween[0] == 0 and !TweenExists(TweenTitle) {
       TweenTitle = TweenFire(id,tutorialTitleTween,guiEase,
                           TWEEN_MODE_ONCE, 1, 0,.5,0,1); //we can play with the ease later guiEase
    
    }
        
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);
    draw_set_font(fnt_menu_in_game);
    title_text = "how to play"
    title_w = string_width(title_text);
    title_h = string_height(title_text);
    title_x = GAME_X+GAME_W/2
    title_y = obj_control_game.fieldEndY + 10 +title_h/2
    
    title_scale = tutorialTitleTween[0];
    
    text_color = COLORS[0];
    text_color_accent = merge_color(COLORS[6],text_color,.5)
    
    line_w = (GAME_W* 11/32) * title_scale//(GAME_W/2 +title_w)/2 * title_scale
    hideline_w = title_w/2 * title_scale; //*1.2
    // Draw Backline
    scr_draw_menu_choice_backline(title_x, title_y+10, line_w, hideline_w, text_color,text_color_accent, 1, 1, 0)
  
            
    //Draw tutorial title text
    draw_text_ext_transformed_colour(title_x+4, title_y, title_text, 
    -1, -1, title_scale, title_scale, 0, text_color,text_color,text_color,text_color,1);
    
    
    
    
    
    
    
    //SKIP TUTORIAL
    draw_set_font(button_font);
    //Tween help button in
    text_text = "skip";
    text_w = string_width(text_text) * 1.25;
    text_h = string_height(text_text) * 1.25; //may need a /2 here if it's too big an area
    
    //make help jiggle periodically also
    text_x = GAME_X+GAME_W -10 -text_w/2 +(100 -100*tutorialTitleTween[0]);
    text_y = GAME_Y+GAME_H -20 -text_h/2 +(100 -100*tutorialTitleTween[0]);
    
    //check if Text Hovered Over
    text_w = string_width(text_text) * 1.25;
    text_h = string_height(text_text) * 1.25; //may need a /2 here if it's too big an area
        
    skip_hover = point_in_rectangle(mouse_x,mouse_y,text_x-text_w,text_y-text_h,text_x+text_w,text_y+text_h) 
    
    if skip_hover{
        //To prevent TP from moving to a button
        tp_on_button[0] = 2
    }
    
    // Click Skip Button
    if skip_hover and 
       help_selected[0] == noone and 
       (!touchPad or mouse_check_button(mb_left)) and 
       (!TweenExists(TweenTitle))// or !TweenIsPlaying
    {
        //Grow and alt color on hover
        text_scalar = 1.2
        text_color = merge_colour(text_color,COLORS[6],.5);
    
        draw_text_ext_transformed_colour(text_x, text_y, text_text, 
        -1, -1, text_scalar, text_scalar, 0, text_color,text_color,text_color,text_color,1);
        
        //On Clicking help
        if mouse_check_button_pressed(mb_left) and help_selected[1] == true
        {
        
            SWIPE = false; 
            // disable other clicks, this works 
            //provided this spawned before other click checkers
            mouse_clear(mb_left);
            
            ScheduleScript(id,1,.25,scr_delayed_selection,help_selected,1)
            help_selected[1] = false
            
            //Set Flag tutorial inactive
            TUTORIAL_STARTED[0] = false;

            //click sound
            scr_sound(sd_menu_click,1,false);
            
        }
        
    }
    //Else draw normally
    else{
        draw_text_colour(text_x,text_y,text_text,
        text_color,text_color,text_color,text_color,1);
    }
    
    
    //TUTORIAL DOTS indicator STUFF
    
    //Draw bottom of page frame indicator
    dots_x = GAME_X+GAME_W/2;
    dots_y = text_y;
    dot_height = 8;
    dot_width = 32
    dots_alpha = 1//tutorialTitleTween[0];//tutorialTextTween[0];
    for (i = 0; i<frameCount; i++){
        dot_x = dots_x + (-frameCount/2 + i+.5) * dot_width; 
        draw_sprite_ext(s_v_framedot_outline,0,dot_x,dots_y,1,1,0,COLORS[0],dots_alpha);
        if i ==  tutorialFrame[0]{
           draw_sprite_ext(s_v_framedot_solid,0,dot_x,dots_y,1,1,0,COLORS[0],dots_alpha);
        }
    }
    //Draw Arrows
    for(i=-1; i<=1;i+=2){
    
        // Set Scale
        arrowScale = .75;
        
        // Set Sprite
        if i == -1 {
            arrowSpr = scr_return_arrow_sprite(1,1);
        } else if i == 1 {
            arrowSpr = scr_return_arrow_sprite(2,1);
            // Oscillate Scale on Right Arrow
            if tutorialAdvance != -2 {
                arrowScale *= lerp(.85,1.15,FULL_SECOND_SINE);
            }
        }
        
        arrowW = sprite_get_width(arrowSpr)*arrowScale*1.0;
        arrowH = sprite_get_height(arrowSpr)*arrowScale*.75;
        
        arrowX = dots_x + (frameCount/2 +.5)*i * dot_width + i*arrowW/2
        arrowY = dots_y
        
        arrowHover = point_in_rectangle(mouse_x,mouse_y,arrowX-arrowW,arrowY-arrowH,arrowX+arrowW,arrowY+arrowH);
        isPressed = (!touchPad or mouse_check_button(mb_left));
         
         //Advance Tutorial Detection 
         if  TUTORIAL_STARTED[0]{ 
             //To prevent TP from moving to a button
             if arrowHover{
                 tp_on_button[0] = 2
             }
             //Tap Selection
             if ( ( (i == 1 or arrowHover) and isPressed) )
             {
                 if arrowHover {
                    arrowScale *= 1.25; 
                 }
                 if mouse_check_button_pressed(mb_left) and tutorialTextTween[0] == 1 //and !TweenExists(TweenTutorialText)
                 {
                      //Frame Press Select
                      if tutorialAdvance != -2 and !MOVE_ACTIVE{
                         tutorialAdvance = i;
                         scr_sound(sd_menu_click,1,false);
                         //mouse_clear(mb_left);
                      } else {
                        // Clear Board Modifer Warning Text In Case It's Preventing Advance
                        bMtext[array_length_1d(bMtext)-1] = 0;
                      }
                      mouse_clear(mb_left);
                  }
              }   
         }
         //Draw < Arrows >
         draw_sprite_ext(arrowSpr, 0,arrowX,arrowY,
         arrowScale,arrowScale,0,COLORS[0],dots_alpha)
    }
    
    
    //Tween for Tutorial Text
    if tutorialTextTween[0] == 0 and tutorialTitleTween[0] == 1 and TUTORIAL_STARTED[0]
    and !TweenExists(TweenTutorialText)
    {
       TweenTutorialText = TweenFire(id,tutorialTextTween,EaseLinear,
                                   TWEEN_MODE_ONCE, 1, 0,.5,0,1); 
    
    }
    
    //Draw Tutorial Frame Text
    draw_set_font(fnt_gui_tutorial)
    text_color = COLORS[0];
    text_start_y = title_y +title_h/8; 
    text_line_gap = 40;
    
    //Display Tutorial Frame
    tutorial_frame( tutorialFrame[0] );
 
    
           
    //Swipe to go to next or previous frame
    if (tutorialAdvance != 0 and tutorialAdvance != -2 and !TweenExists(TweenTutorialText) and TUTORIAL_STARTED[0])
    {
       //Swiped Left
       if tutorialAdvance == 1 {
       
          //Go to next frame
          if tutorialFrame[0] < frameCount-1{
          
              //outro tween text alpha
              TweenTutorialText = TweenFire(id,tutorialTextTween,EaseLinear,
                                       TWEEN_MODE_ONCE, true, 0, .5, 1, 0);
              //increment tutorialFrame[0] on tweenfinish
              TweenAddCallback(TweenTutorialText,TWEEN_EV_FINISH,
                                        id, array_set_value, tutorialFrame,tutorialFrame[0]+1);
              //Destroy dummy objects
              with(obj_parent_dummy){
                 TweenAddCallback(other.TweenTutorialText,TWEEN_EV_FINISH,
                                        other.id, Destroy,id);
              }
              
              //Disable Paddle Movement
              if PADDLE_MOTION != 0{
                 PADDLE_MOTION = 0;
                 //Reset paddle movement counters
                 obj_control_game.tutorialPaddleMovePercent = -1; //negative is so it doesn't fire in obj_control_game
                 
                 //Tween In Touchpad
                 scr_touch_pad_tween_out();
              }
              
              //scr_sound(sd_menu_click,1,false);
          }
          //End Tutorial if on last frame
          if tutorialFrame[0] >= frameCount-1{
          
               ScheduleScript(id,1, .25,scr_delayed_selection,help_selected,2)
               //Set Flag tutorial inactive
               TutorialEnding = true;
               //TUTORIAL_STARTED[0] = false;
               //scr_sound(sd_menu_click,1,false);
            
          }
       }
       //Swiped Right; Go to Previous Frame
       if (tutorialAdvance == -1) and tutorialFrame[0] > 0{
              //outro tween text alpha
              TweenTutorialText = TweenFire(id,tutorialTextTween,EaseLinear,
                                       TWEEN_MODE_ONCE, 1, 0,.5,1,0);
              //increment tutorialFrame[0] on tweenfinish
              TweenAddCallback(TweenTutorialText,TWEEN_EV_FINISH,
                                        id, array_set_value, tutorialFrame,tutorialFrame[0]-1);
              //Destroy All Dummy Objects
              with(obj_parent_dummy){
                 TweenAddCallback(other.TweenTutorialText,TWEEN_EV_FINISH,
                                        other.id, Destroy,id);
              }
              
              //Disable Paddle Movement
              if PADDLE_MOTION != 0{
                 PADDLE_MOTION = 0;
                 //Reset paddle movement counters
                 obj_control_game.tutorialPaddleMovePercent = -1; //negative is so it doesn't fire in obj_control_game
                 
                 //Tween In Touchpad
                 scr_touch_pad_tween_out();
              }
              //scr_sound(sd_menu_click,1,false);
       }
       
       
       //Reset Tutorial Advance
       tutorialAdvance = 0;
    }

}
