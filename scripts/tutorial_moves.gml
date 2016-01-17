///tutorial_moves(frame_index)


switch argument0{
    
    case 0:

               draw_set_valign(fa_middle);
               draw_set_halign(fa_left);
               //Draw first line text
               frame_text = "Make great moves by#making quick decisions!";
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               sprite_w = 40//50;
               sprite_gap = 8//10;
               text_x = title_x - text_w/2 + (sprite_w*1+sprite_gap)/2;  //60 = sprite width; 10=padding
               text_y = text_start_y+ text_h/1.0 + text_line_gap;//50 = distance from title
               draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
               
               //Draw shooter sprite
               sprite_x = text_x - (sprite_w*.5+sprite_gap*1);
               sprite_y = text_y;
               sprite_spr =  object_get_sprite(obj_star);
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(-1,0);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        
               
               //Draw second line text
               //frame_text = "When you run out of#MOVES_LEFT it's gameover.";
               //frame_text = "If time runs out#you lose a move!" //And there's something else...";
               frame_text = "When you run out of#moves it's gameover." //And there's something else...";
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               //text_x = title_x - text_w/2 + (sprite_w+sprite_gap)/2;  //40 = sprite width; 10=padding
               //may want to finesse this and the other text x to line it up like mockup with the pyramid
               text_y = text_y + text_h + text_line_gap; //text_h/2
               draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
               
               //Draw shooter sprite
               //sprite_x = text_x - (sprite_w+sprite_gap)/2;
               sprite_y = text_y;
               sprite_spr = object_get_sprite(obj_star);
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(-1,0);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               
               
               //Pickup Any Stars that were placed pre-tutorial
               if instance_exists(obj_star_marker){
                    with (obj_star_marker){
                        if !TweenExists(TweenMarker){
                            pickup_star_marker(false);
                        }
                    }
               }
               

    
        break;
    
    case 1:

               draw_set_valign(fa_middle);
               draw_set_halign(fa_left);
               //Draw first line text
               frame_text = "You've got 10 moves but#no paddle. If time runs#out you lose a move.";
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               sprite_w = 40//50;
               sprite_gap = 8//10;
               text_x = title_x - text_w/2 + (sprite_w*1+sprite_gap)/2;  //60 = sprite width; 10=padding
               text_y = text_start_y+ text_h/1.5 + text_line_gap;//50 = distance from title
               draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
               
               //Draw shooter sprite
               sprite_x = text_x - (sprite_w*.5+sprite_gap*1);
               sprite_y = text_y;
               sprite_spr =  object_get_sprite(obj_star);
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(-1,11);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        
               
               //Draw third line text
               //frame_text = "When you run out of#MOVES_LEFT it's gameover.";
               frame_text = "Next move doesn't count,#so try anything!" //And there's something else...";
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               //text_x = title_x - text_w/2 + (sprite_w+sprite_gap)/2;  //40 = sprite width; 10=padding
               //may want to finesse this and the other text x to line it up like mockup with the pyramid
               text_y = text_y + text_h + text_line_gap; //text_h/2
               draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
               
               //Draw shooter sprite
               //sprite_x = text_x - (sprite_w+sprite_gap)/2;
               sprite_y = text_y;
               sprite_spr = object_get_sprite(obj_star);
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(-1,11);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               

    
        break;
        
    case 2:
        draw_set_valign(fa_middle);
               draw_set_halign(fa_center);
               //Draw first line text
               frame_text = "H#H"//"Please select a board modifier.";
               text_w = line_w*2//string_width(frame_text);
               text_h = string_height(frame_text);
               text_x = title_x// - text_w/2;
               text_y = text_start_y+ text_h + text_line_gap;//50 = distance from title
               
               //Don't draw text while board modifier selected
                if (bMSelected[0] == noone) and 
                    bMtext[array_length_1d(bMtext)-1] <= 0 and 
                    !ScheduleExists(bMScheduler)
                {
                    modifiers_mutex = 0;
                }
                else{
                    modifiers_mutex = 1;
                
                }
               
               //Set appropriate text after player has used a modifier
               if (!modifiers_mutex) {
                  if bMCount[0] >= 1{
                      frame_text = "Select additional modifiers or tap anywhere to continue.";
                      /*if !touchPad{
                        frame_text = "Select additional modifiers or select next to continue.";
                      }*/
                      draw_text_ext_transformed_colour(text_x,text_y,frame_text,-1,text_w,
                      1,1,0,text_color,text_color,text_color,text_color,tutorialTextTween[0]); //*!TweenExists(MixersTween)
                  
                  }
                  else{
                      frame_text = "Board modifiers can transform deflectors. Please select one.";
                      draw_text_ext_transformed_colour(text_x,text_y,frame_text,-1,text_w,
                      1,1,0,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
                  }
               }
               
               
               
               //Init boardmodifier count
               if !TweenExists(TweenTutorialText) and !TweenExists(TweenTitle){
               
                   if tutorialAdvance == 0{
                        tutorialAdvance = -2; // flag to not advance tutorial
                   }
                   if !modifiers_mutex 
                   {
                       //Tutorial Can be advanced after 1 board modifer use
                       if bMCount[0] >= 1 and tutorialAdvance == -2{
                           tutorialAdvance = 0; //flag to advance
                       }
                   }
               }
               
               //Create board modifier dummy
               if TUTORIAL_STARTED[0] and !TutorialEnding
               {
               
                  if !MOVE_ACTIVE and MixersEase[0] == 0 and !TweenExists(MixersTween){
                        //Set scene dimensions
                        scene_top = text_y + text_h ;
                        scene_bottom = (dots_y-dot_height)
                        
                        //Set Inventory
                        //Grab Mixers Inventory
                        for (var z = 1, n = array_height_2d(boardMixers); z < n; z ++){
                             boardMixers[z,0] = bMStartInventory
                        }
                        //Set Stars to 0;
                        boardMixers[0,0] = 0;
                        
                        bMResetInventory = 1; //flag to reset inventory after tutorial
                        
                        
                        with (obj_control_modifiers){
                            
                            //Set position vars
                            mixers_x[1] = centerfieldx - 2.5*90-15/2;//obj_control_game.mixers_x;
                            mixers_y[1] = other.scene_bottom-105; ///90
                           
                            dialogue_x[1] = other.text_x;
                            dialogue_y[1] = other.text_y;
                            dialogue_w[1] = other.text_w; 
                            
                            //Tween In
                            MixersTween = TweenFire(id,MixersEase,EaseLinear,
                                               TWEEN_MODE_ONCE,1,0,1,MixersEase[0],1); 
                            
                            
                        }
                      
                  }
                  else if tutorialTextTween[0] != 1 and !TweenExists(MixersTween){
                        // Reset Count
                        bMCount[@ 0] = 0;
                        //Tween Out
                        MixersTween = TweenFire(id,MixersEase,EaseLinear,
                                             TWEEN_MODE_ONCE,1,0,1,MixersEase[0],0); 
                        TweenAddCallback(MixersTween,TWEEN_EV_FINISH,id,array_set_index_1d,bMCount,0,0);
                  }
               }
    
    
        break;
        
    case 3:
            
               draw_set_valign(fa_middle);
               draw_set_halign(fa_center);
               //Draw first line text
               frame_text = "H#H"//"Please select a board modifier.";
               text_w = line_w*2//string_width(frame_text);
               text_h = string_height(frame_text);
               text_x = title_x// - text_w/2;
               text_y = text_start_y+ text_h + text_line_gap;//50 = distance from title
               
               //Don't draw text while board modifier selected
               var modifiers_mutex, dummy_star_exists;
               dummy_star_exists = instance_exists(obj_star_marker)
               //Don't draw text while board modifier selected
               if (bMSelected[0] == noone) and 
                    bMtext[array_length_1d(bMtext)-1] <= 0 and 
                    !ScheduleExists(bMScheduler)
               {
                    modifiers_mutex = 0;
               }
               else{
                    modifiers_mutex = 1;
               }
                
               
               //Is Star Egg Selected?
               sMSelected = false;
               if dummy_star_exists{
                    with (obj_star_marker){
                         if selected[0]{
                            other.sMSelected = true; 
                            break;
                         }
                    }
               }
  
               
               
               
               if !modifiers_mutex and !sMSelected and !MOVE_ACTIVE{
               
                  if dummy_star_exists{//tutorial_dummy.bMCount[0] >= 1{
                      frame_text = "Tap anywhere to launch or tap star to pick it up.";
                      draw_text_ext_transformed_colour(text_x,text_y,frame_text,-1,text_w,
                      1,1,0,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
                  
                  }
                  else if bMCount[0] >= 1{
                      //frame_text = "Tap next to continue.";
                      frame_text = "Place another star or tap anywhere to continue.";
                      if !touchPad{
                        frame_text = "Place another star or tap anywhere to continue.";
                        //frame_text = "Place another star or select next to continue.";
                  
                      }
                      draw_text_ext_transformed_colour(text_x,text_y,frame_text,-1,text_w,
                      1,1,0,text_color,text_color,text_color,text_color,tutorialTextTween[0]); //*MixersEase[0]
                  }
                  else{
                      frame_text = "Star eggs will hatch a star.  Please select a star egg.";
                      draw_text_ext_transformed_colour(text_x,text_y,frame_text,-1,text_w,
                      1,1,0,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
                  }
               }
               
               
               
               //Init boardmodifier count
               if !TweenExists(TweenTutorialText) and !TweenExists(TweenTitle){
                   if tutorialAdvance == 0 tutorialAdvance = -2; // flag to not advance tutorial
                   if !modifiers_mutex and !dummy_star_exists{
                       //Tutorial Can be advanced after 1 board modifer use
                       if bMCount[0] > 0 and tutorialAdvance == -2{
                           tutorialAdvance = 0; //flag to advance
                       }
                   }
               }
               
               //Create board modifier dummy
               if TUTORIAL_STARTED[0] and !TutorialEnding{
                  
                  
                  if !MOVE_ACTIVE and MixersEase[0] == 0 and !TweenExists(MixersTween){
                  
                       //Set Inventories to 0;
                       for (var z = 1, n = array_height_2d(boardMixers); z < n; z ++){
                           boardMixers[z,0] = 0;
                       }
                       boardMixers[0,0] = 1;
                       
                   
                       //Tween In
                       MixersTween = TweenFire(id,MixersEase,EaseLinear,
                                        TWEEN_MODE_ONCE,1,0,1, MixersEase[0],1); 
                  }
                  else if tutorialTextTween[0] != 1 and !TweenExists(MixersTween){
                        //Tween Out
                        MixersTween = TweenFire(id,MixersEase,EaseLinear,
                                          TWEEN_MODE_ONCE,1,0,1, MixersEase[0],0); 
                        TweenAddCallback(MixersTween,TWEEN_EV_FINISH,id,array_set_index_1d,bMCount,0,0);
                  }
                  
               }
    
    
        break;
        
    case 4:
       draw_set_valign(fa_middle);
               draw_set_halign(fa_left);
               //Draw first line text
               frame_text = "Modifiers replenish by#destroying the same#shaped deflectors.";
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               sprite_w = 32//50;
               sprite_gap = 8//10;
               text_x = title_x - text_w/2 + (sprite_w*3+sprite_gap*3)/2;  //60 = sprite width; 10=padding
               text_y = text_start_y+ text_h/1.5 + text_line_gap;//50 = distance from title
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
          
               
               //Draw second line text
               //frame_text = "You've still got 10 lives,#that didn't count :)";
               frame_text = "Stars replenish each#move or from uppers.";
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               //text_x = title_x - text_w/2 + (sprite_w+sprite_gap)/2;  //40 = sprite width; 10=padding
               //may want to finesse this and the other text x to line it up like mockup with the pyramid
               text_y = text_y + text_h + text_line_gap; //text_h/2
               draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
               
               //Draw shooter sprite
               sprite_w = 40;
               sprite_x = text_x - (sprite_w*.5+sprite_gap);
               sprite_y = text_y;
               sprite_spr =  object_get_sprite(obj_star);
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(-1,0);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
         
    
    
        break;
        
    case 5:
    
    
    
        break;
        
    case 6:
    
    
    
        break;
        
        
    default:
        break;







}
