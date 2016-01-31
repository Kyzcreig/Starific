///tutorial_arcade(frame_index)


switch argument0{
    
    case 0:
        
        draw_set_valign(fa_middle);
        draw_set_halign(fa_left);
        //Draw first line text
        //frame_text = "Stars move around, don't#let them escape!"; 
        //frame_text = "When all stars escape#it's gameover. Block them#with the paddle!"; 
        frame_text = "If all stars escape it's gameover.#Block them with the paddle!"; 
        text_w = string_width(frame_text);
        text_h = string_height(frame_text);
        sprite_w = 32//50;
        sprite_gap = 8//10;
        //text_x = title_x - text_w/2 + (sprite_w*3+sprite_gap*3)/2;  //60 = sprite width; 10=padding
        text_x = title_x - text_w/2 + (sprite_w*1+sprite_gap*2)/2;  //60 = sprite width; 10=padding
        text_y = text_start_y+ text_h/2 + text_line_gap;//50 = distance from title
        draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
        
        //Draw star sprite
        sprite_x = text_x - (sprite_w*1+sprite_gap*1);
        //sprite_x = text_x - (sprite_w*1.5+sprite_gap*2);
        sprite_y = text_y;
        sprite_spr =  object_get_sprite(obj_star);
        sprite_w = 40//50;
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = COLORS[0];
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        
        
        
        //Create dummy scene
        if !instance_exists(tutorial_dummy) and TUTORIAL_STARTED[0] and !TutorialEnding
        {
           tutorial_dummy = instance_create(GAME_MID_X,GAME_MID_Y,obj_block_dummy);
           
           //pass these in for scene top and bottom
           scene_top = text_y + text_h/2 + sprite_gap;
           scene_bottom = (dots_y-dot_height)//GAME_Y+GAME_H;
           
           //Set params for scene
           with (tutorial_dummy){
                scene_top = other.scene_top;
                scene_bottom = other.scene_bottom;
                paddle_y = scene_bottom -60;
                proj_start_y = scene_top + proj_spr_h/2
                proj_end_y = proj_start_y//
                proj_speed = (paddle_y - proj_start_y) / durProjEnter //positive
           }
        }

    
    
        break;
 
        
    case 1:
          
        //Draw first line text
        draw_set_valign(fa_middle);
        draw_set_halign(fa_left);
        // If Paddle Example less than 100% complete
        if paddleMovePercent < 100 {
            //frame_text = "Touch anywhere and move in a   #circle to rotate the paddle:   ";
            frame_text = "Touch joystick and drag in a#circle to move the paddle.";
            
            if !TOUCH_ENABLED {frame_text = "Move the cursor around#to rotate the paddle.";}
        } else {
            //frame_text = "Touch anywhere and drag in#a circle to move the paddle.";
            frame_text = "Learn how to adjust controls#at the Options->Game.";
            
            if !TOUCH_ENABLED {frame_text = "Move the cursor around#to rotate the paddle.";}
        
        }
            
        
        text_w = string_width(frame_text);
        text_h = string_height(frame_text);
        text_x = title_x - text_w/2;
        text_y = text_start_y+ text_h/2 + text_line_gap;//50 = distance from title
        draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);

    //var sub_text = "Adjust at Options->Game."//"virtual joystick"
        

        //Calcualte % paddle movement
        if !TweenExists(TweenTutorialText) and !TweenExists(TweenTitle){
           //Enable Paddle Movement and Reset paddle theta counter
            if PADDLE_MOTION == 0{
                PADDLE_MOTION = 1;
                obj_control_game.tutorialPaddleMovePercent = 0;
                tutorialAdvance = -2; // flag to not advance tutorial
            }
            var spins = 2;//1; //two full circles 
            paddleMovePercent = abs(obj_control_game.tutorialPaddleMovePercent) * 100 / (360*spins); 
            //Tutorial Can be advanced
            if paddleMovePercent >= 100{
               if tutorialAdvance == -2 and !SWIPE{
                  tutorialAdvance = 0; //flag to advance
                  //show_message("debug")
               }
            }
        }
        
        //Create hand pointer dummy
        if !instance_exists(tutorial_dummy) and TUTORIAL_STARTED[0] and !TutorialEnding
        {
           tutorial_dummy = instance_create(GAME_MID_X,GAME_MID_Y,obj_touch_pointer);
           
           //Calculate circle radius
           sprite_y_offset = sprite_get_yoffset(s_v_pointer);
           sprite_h = sprite_get_height(s_v_pointer);
           sprite_circle_top = (text_y + text_h/2 + sprite_y_offset);
           sprite_circle_bottom = (/*GAME_Y+GAME_H*/(dots_y-dot_height)-(sprite_h - sprite_y_offset));
           if !touchPad{
               sprite_circle_top = oy+cellH/2
               sprite_circle_bottom = oy+cellH/2+fieldH*cellH;
           
           }
           sprite_center_y = (sprite_circle_top+sprite_circle_bottom)/2;
           sprite_circle_rad = sprite_center_y - sprite_circle_top;
           
           //Set circle radius
           with (tutorial_dummy){
                 sprite_circle_top = other.sprite_circle_top;
                 sprite_circle_bottom = other.sprite_circle_bottom;
                 sprite_center_y = other.sprite_center_y;
                 sprite_circle_rad = other.sprite_circle_rad;
                 
                 ///Set Touchpad
                 with (obj_control_game){
                      dummy_mx = other.sprite_center_x; 
                      dummy_my = other.sprite_center_y;
                      
                      oldMX = dummy_mx
                      oldMY = dummy_my
                  }
                  //Tween In Touchpad
                  scr_touch_pad_tween_in();
           }
                                        
        }    
    
    
        break;
        
    case 2:
     
        draw_set_valign(fa_middle);
        draw_set_halign(fa_left);
        //Draw first line text
        //frame_text = "Stars move around, don't#let them escape!"; 
        //frame_text = "When all stars escape#it's gameover. Block them#with the paddle!"; 
        //frame_text = "Deflectors give points and#make stars turn left or right.";
        frame_text = "Deflectors give points and#make stars turn left or right#with equal chance.";
        text_w = string_width(frame_text);
        text_h = string_height(frame_text);
        sprite_w = 32//50;
        sprite_gap = 8//10;
        text_x = title_x - text_w/2 + (sprite_w*3+sprite_gap*3)/2;  //60 = sprite width; 10=padding
        text_y = text_start_y+ text_h/2 + text_line_gap;//50 = distance from title
        draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
        
        min_gap = 1.5;
        //Draw deflector sprites
        sprite_x = text_x - (sprite_w*2 + sprite_gap*(min_gap+1));
        sprite_y = text_y -(sprite_w+sprite_gap)/2;
        sprite_spr = object_get_sprite(obj_reflector_parent_basic);
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(0,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        //Draw deflector sprites
        sprite_x = text_x - (sprite_w*1 + sprite_gap*(min_gap));
        sprite_y = text_y -(sprite_w+sprite_gap)/2;
        sprite_spr = object_get_sprite(obj_powerup_parent_bomb);
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(4,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        //Draw deflector sprites
        sprite_x = text_x - (sprite_w*2.5 + sprite_gap*(min_gap+1.5));
        sprite_y = text_y +(sprite_w+sprite_gap)/2;
        sprite_spr = object_get_sprite(obj_powerup_parent_ups);
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(1,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        //Draw deflector sprites
        sprite_x = text_x - (sprite_w*1.5 + sprite_gap*(min_gap+.5));
        sprite_y = text_y +(sprite_w+sprite_gap)/2;
        sprite_spr = object_get_sprite(obj_powerup_parent_neutral);
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(3,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        //Draw deflector sprites
        sprite_x = text_x - (sprite_w*.5 + sprite_gap*(min_gap-.5));
        sprite_y = text_y +(sprite_w+sprite_gap)/2;
        sprite_spr = object_get_sprite(obj_powerup_parent_downs);
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(2,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
          
        
        
        //Create dummy scene
        if !instance_exists(tutorial_dummy) and TUTORIAL_STARTED[0] and !TutorialEnding
        {
           tutorial_dummy = instance_create(GAME_MID_X,GAME_MID_Y,obj_turn_dummy);
           
           //pass these in for scene top and bottom
           scene_top = text_y + text_h/2 + sprite_gap*3;
           scene_bottom = (dots_y-dot_height)//GAME_Y+GAME_H;
           
           //Set params for scene
           with (tutorial_dummy){
                scene_top = other.scene_top;
                scene_bottom = other.scene_bottom -proj_spr_h;
                deflector_y = scene_top +deflector_h/2;
                proj_start_y = scene_bottom-proj_spr_h/2
                proj_y = proj_start_y;
                proj_speed = (deflector_y - proj_start_y) / durProjEnter 
                
                
           }
        }
    
    
        break;
        
    case 3:
     
        draw_set_valign(fa_middle);
        draw_set_halign(fa_left);
        //Draw first line text
        //frame_text = "When a deflector touches#the paddle it activates.";
        //frame_text = "Activate deflectors by catching#them with the paddle.";
        //frame_text = "Catch deflectors#to activate them.";
        frame_text = "Catch deflectors for#points and powers.";
        text_w = string_width(frame_text);
        text_h = string_height(frame_text);
        sprite_w = 32//40;
        sprite_gap = 8//10;
        text_x = title_x - text_w/2 + (sprite_w*2+sprite_gap)/2;  //60 = sprite width; 10=padding
        text_y = text_start_y+ text_h/2 + text_line_gap;//50 = distance from title
        draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
        
        //Draw upgrade sprite
        min_gap = 1//1.5;
        sprite_x = text_x - (sprite_w*1.5+sprite_gap*(min_gap+1));
        sprite_y = text_y - (sprite_w*.5+sprite_gap*.5);
        sprite_spr =  object_get_sprite(obj_powerup_parent_ups);;
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(1,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        
        //Draw downgrade sprite
        sprite_x = text_x - (sprite_w*.5+sprite_gap*(min_gap));
        sprite_y = text_y - (sprite_w*.5+sprite_gap*.5);
        sprite_spr = object_get_sprite(obj_powerup_parent_downs);
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(2,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        
        //Draw sidegrad sprite
        sprite_x = text_x - (sprite_w*1+sprite_gap*(min_gap+.5));
        sprite_y = text_y + (sprite_w*.5+sprite_gap*.5);
        sprite_spr = object_get_sprite(obj_powerup_parent_neutral);
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(3,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        
        
        
        //Create dummy scene
        if !instance_exists(tutorial_dummy) and TUTORIAL_STARTED[0] and !TutorialEnding
        {
           tutorial_dummy = instance_create(GAME_MID_X,GAME_MID_Y,obj_projectile_dummy);
           
           //pass these in for scene top and bottom
           scene_top = sprite_y + sprite_w/2 //+sprite_gap;
           scene_bottom = (dots_y-dot_height)//GAME_Y+GAME_H;
           proj_start_y = scene_top + obj_control_game.pFallingSize/2;
           
           //Set params for scene
           with (tutorial_dummy){
                scene_top = other.scene_top;
                scene_bottom = other.scene_bottom;
                paddle_y = scene_bottom - 150;
                proj_start_y = other.proj_start_y;
                proj_speed = (paddle_y-proj_start_y) / durProjectile
                cooldown_y = ((paddle_y + paddle_h)+scene_bottom)/2 -16;
           }
                              
        }
    
    
        break;
        
    case 4:
    
    
        draw_set_valign(fa_middle);
        draw_set_halign(fa_left);
        //Draw first line text
        //frame_text = "Bombs blow up other#deflectors.";
        //frame_text = "Bombs blow up deflectors.";
        frame_text = "Bombers chain react.";
        text_w = string_width(frame_text);
        text_h = string_height(frame_text);
        sprite_w = 32//40;
        sprite_gap = 8//10;
        text_x = title_x - text_w/2 + (sprite_w+sprite_gap)/2;  //60 = sprite width; 10=padding
        text_y = text_start_y+ text_h/2 + text_line_gap;//50 = distance from title
        draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
        
        //Draw bomb sprite
        sprite_x = text_x - (sprite_w+sprite_gap*2)/2;
        sprite_y = text_y;
        sprite_spr =  object_get_sprite(obj_powerup_parent_bomb);;
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(4,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        
        
        
        //Create dummy scene
        if !instance_exists(tutorial_dummy) and TUTORIAL_STARTED[0] and !TutorialEnding
        {
           tutorial_dummy = instance_create(GAME_MID_X,GAME_MID_Y,obj_bomb_dummy);
           
           //pass these in for scene top and bottom
           scene_top = text_y + text_h/2 + sprite_gap;
           scene_bottom = scene_top+40 +sprite_gap
           
           //Set params for scene
           with (tutorial_dummy){
                scene_top = other.scene_top;
                scene_bottom = other.scene_bottom;
                deflector_y  = (scene_top + scene_bottom)/2
                
                
                
           }
                              
        }
        
        text_y += 40 + sprite_gap;
        //Draw second line text
        //frame_text = "Upgrades make it#easier.";
        //frame_text = "Upgrades make it easier.";
        frame_text = "Uppers make it easier.";
        text_w = string_width(frame_text);
        text_h = string_height(frame_text);
        //text_x = title_x - text_w/2 + (sprite_w+sprite_gap)/2;  //40 = sprite width; 10=padding
        //may want to finesse this and the other text x to line it up like mockup with the pyramid
        text_y = text_y + text_h/2 + text_line_gap; //50 = distance from title
        draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
        
        //Draw upgrade sprite
        //sprite_x = text_x - (sprite_w+sprite_gap)/2;
        sprite_y = text_y;
        sprite_spr = object_get_sprite(obj_powerup_parent_ups);
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(1,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        
        
        //Draw third line text
        //frame_text = "Downgrades make it#harder.";
        //frame_text = "Downgrades make it harder.";
        frame_text = "Downers make it harder.";
        text_w = string_width(frame_text);
        text_h = string_height(frame_text);
        //text_x = title_x - text_w/2 + (sprite_w+sprite_gap)/2;  //40 = sprite width; 10=padding
        //may want to finesse this and the other text x to line it up like mockup with the pyramid
        text_y = text_y + text_h/2 + text_line_gap; //50 = distance from title
        draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
        
        //Draw downgrade sprite
        //sprite_x = text_x - (sprite_w+sprite_gap)/2;
        sprite_y = text_y;
        sprite_spr = object_get_sprite(obj_powerup_parent_downs);
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(2,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        
        
        //Draw fourth line text
        //frame_text = "Sidegrades make it#silly.";
        //frame_text = "Sidegrades can do either.";
        //frame_text = "Rounders give cash.";
        frame_text = "Rounders do neither.";
        text_w = string_width(frame_text);
        text_h = string_height(frame_text);
        //text_x = title_x - text_w/2 + (sprite_w+sprite_gap)/2;  //40 = sprite width; 10=padding
        //may want to finesse this and the other text x to line it up like mockup with the pyramid
        text_y = text_y + text_h/2 + text_line_gap; //50 = distance from title
        draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
        
        //Draw sidegrad sprite
        //sprite_x = text_x - (sprite_w+sprite_gap)/2;
        sprite_y = text_y;
        sprite_spr = object_get_sprite(obj_powerup_parent_neutral);
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(3,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        
        
        
    
        break;
        
    case 5:
    
            
        draw_set_valign(fa_middle);
        draw_set_halign(fa_left);
        //Draw first line text
        frame_text = "Use coins to unlock prizes#at the wheel on gameover."
        text_w = string_width(frame_text);
        text_h = string_height(frame_text);
        sprite_w = 40//50;
        sprite_gap = 8//10;
        text_x = title_x - text_w/2 + (sprite_w*1+sprite_gap)/2;  //60 = sprite width; 10=padding
        text_y = text_start_y+ text_h/2 + text_line_gap;//50 = distance from title
        draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
        
        //Draw Cash sprite
        sprite_x = text_x - (sprite_w*.5+sprite_gap*1);
        sprite_y = text_y;
        sprite_spr =  object_get_sprite(obj_powerup_parent_neutral);
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(3,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        // Draw Cash Symbol
        sprite_spr =  spr_power_cash;
        sprite_col = COLORS[6];
        sprite_scale = sprite_scale * 40/60;
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,1);
        
        
        
        //Create dummy scene
        if !instance_exists(tutorial_dummy) and TUTORIAL_STARTED[0] and !TutorialEnding
        {
           tutorial_dummy = instance_create(GAME_MID_X,GAME_MID_Y,obj_prizewheel_dummy);
           
           //pass these in for scene top and bottom
           scene_top = text_y + text_h/2;//+ sprite_gap;
           scene_bottom = (dots_y-dot_height)//GAME_Y+GAME_H;
           
           //Set params for scene
           with (tutorial_dummy){
                scene_top = other.scene_top ;//+ proj_spr_h;
                scene_bottom = other.scene_bottom;
                
                wheel_y = (scene_top+scene_bottom)/2
           }
                              
        }
    
    
        break;
        
        
    case 6:
        draw_set_valign(fa_middle);
        draw_set_halign(fa_left);
        //Draw first line text
        frame_text = "Complete quests to unlock#new modes and options."
        text_w = string_width(frame_text);
        text_h = string_height(frame_text);
        sprite_w = 40//50;
        sprite_gap = 8//10;
        text_x = title_x - text_w/2 + (sprite_w*1+sprite_gap)/2;  //60 = sprite width; 10=padding
        text_y = text_start_y+ text_h/2 + text_line_gap;//50 = distance from title
        draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
        
        //Draw Cash sprite
        sprite_x = text_x - (sprite_w*.5+sprite_gap*1);
        sprite_y = text_y;
        sprite_spr =  s_v_options_game;
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = power_type_colors(-1,0);
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
   
        
        
        //Create dummy scene
        if !instance_exists(tutorial_dummy) and TUTORIAL_STARTED[0] and !TutorialEnding
        {
           tutorial_dummy = instance_create(GAME_MID_X,GAME_MID_Y,obj_newOptions_dummy);
           
           //pass these in for scene top and bottom
           scene_top = text_y + text_h/2;//+ sprite_gap;
           scene_bottom = (dots_y-dot_height)//GAME_Y+GAME_H;
           
           //Set params for scene
           with (tutorial_dummy){
                scene_top = other.scene_top ;//+ proj_spr_h;
                scene_bottom = other.scene_bottom;
                
                center_y = (scene_top+scene_bottom)/2
           }
                              
        }
    
    
        break;
        
    case 7:
    
            
        draw_set_valign(fa_middle);
        draw_set_halign(fa_left);
        //Draw first line text
        frame_text = "Each level it gets harder,#how far can you get?"
        //frame_text = "Each level the stars get faster#and the paddle gets smaller."//#Take aim and tap to begin!";
        //Mzybe we display tap to begin when tutorial isn't active
        text_w = string_width(frame_text);
        text_h = string_height(frame_text);
        sprite_w = 40//50;
        sprite_gap = 8//10;
        text_x = title_x - text_w/2 + (sprite_w*1+sprite_gap)/2;  //60 = sprite width; 10=padding
        text_y = text_start_y+ text_h/2 + text_line_gap;//50 = distance from title
        draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
        
        //Draw upgrade sprite
        sprite_x = text_x - (sprite_w*.5+sprite_gap*1);
        sprite_y = text_y;
        sprite_spr =  object_get_sprite(obj_star);
        sprite_scale = sprite_w/sprite_get_width(sprite_spr);
        sprite_col = COLORS[0];
        draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        
        
        
        //Create dummy scene
        if !instance_exists(tutorial_dummy) and TUTORIAL_STARTED[0] and !TutorialEnding
        {
           tutorial_dummy = instance_create(GAME_MID_X,GAME_MID_Y,obj_launch_dummy);
           
           //pass these in for scene top and bottom
           scene_top = text_y + text_h + sprite_gap;
           scene_bottom = (dots_y-dot_height)//GAME_Y+GAME_H;
           
           //Set params for scene
           with (tutorial_dummy){
                scene_top = other.scene_top + proj_spr_h;
                scene_bottom = other.scene_bottom;
                paddle_y = scene_bottom -60;
                proj_start_y = paddle_y+paddle_h/2;
                proj_end_y = scene_top - proj_spr_h;
                proj_speed = (proj_end_y - proj_start_y) / durProjectile //negative
           }
                              
        }
    
    
        break;
        
        
    default:
        break;


















}
