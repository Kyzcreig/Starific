///tutorial_time(frame_index)


switch argument0{
    
    case 0:
    
    
               draw_set_valign(fa_middle);
               draw_set_halign(fa_left);
               //Draw first line text
               //frame_text = "Time ticks down."; 
               frame_text = "If time runs out and all#stars escape you lose."; 
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
               sprite_col = power_type_colors(-1,9);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               
               
               
               //Create dummy scene
               if !instance_exists(tutorial_dummy) and TUTORIAL_STARTED[0] and !TutorialEnding
               {
                  tutorial_dummy = instance_create(padcenterx,padcentery,obj_timer_dummy);
                  
                  //pass these in for scene top and bottom
                  scene_top = text_y + text_h*1.0 + sprite_gap;
                  scene_bottom = scene_top+40 +sprite_gap
                  
                  //Set params for scene
                  with (tutorial_dummy){
                       scene_top = other.scene_top;
                       scene_bottom = other.scene_bottom;
                       tim_y  = (scene_top + scene_bottom)/2 - tim_h/2
                       tim_x = centerfieldx
                       
                  }
                                            
               }
               
               text_y += 40 + sprite_gap;
               //Draw second line text
               //frame_text = "Upgrades make it#easier.";
               frame_text = "But you can't lose while#there's still time!";
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
               sprite_col = power_type_colors(-1,10);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               
               
    
        break;
        
    case 1:
    
    
               draw_set_valign(fa_middle);
               draw_set_halign(fa_left);
               //Draw first line text
               frame_text = "Catch deflectors or#stars to get time."; ; 
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               sprite_w = 32;
               sprite_gap = 8//10;
               text_x = title_x - text_w/2 + (sprite_w*2+sprite_gap)/2;  //60 = sprite width; 10=padding
               text_y = text_start_y+ text_h + text_line_gap;//50 = distance from title
               draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
               
               
               //Draw shooter sprite
               min_gap = 1//1.5;
               sprite_x = text_x - (sprite_w*1.5+sprite_gap*(min_gap+1));
               sprite_y = text_y - (sprite_w*.5+sprite_gap*.5);
               sprite_spr =  object_get_sprite(obj_star);;
               sprite_scale = 40/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(-1,0);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               
               //Draw upgrade sprite
               sprite_x = text_x - (sprite_w*.5+sprite_gap*(min_gap));
               sprite_y = text_y - (sprite_w*.5+sprite_gap*.5);
               sprite_spr = object_get_sprite(obj_powerup_parent_ups);
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(1,0);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               
               //Draw downgrade sprite
               sprite_x = text_x - (sprite_w*1.5+sprite_gap*(min_gap+1));
               sprite_y = text_y + (sprite_w*.5+sprite_gap*.5);
               sprite_spr = object_get_sprite(obj_powerup_parent_downs);
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(2,0);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               
               //Draw sidegrad sprite
               sprite_x = text_x - (sprite_w*.5+sprite_gap*(min_gap));
               sprite_y = text_y + (sprite_w*.5+sprite_gap*.5);
               sprite_spr = object_get_sprite(obj_powerup_parent_neutral);
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(3,0);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               
               
               
               
               //Draw second line text
               //frame_text = "You get more time for#long combos.";
               frame_text = "Combos and levels#give more time."
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               //text_x = title_x - text_w/2 + (sprite_w+sprite_gap)/2;  //40 = sprite width; 10=padding
               text_y = text_y + text_h + text_line_gap; //50 = distance from title
               draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
               
               //Draw upgrade sprite
               //sprite_x = text_x - (sprite_w*1+sprite_gap*(min_gap+.5));
               sprite_x = text_x - (sprite_w*.5+sprite_gap*(min_gap));
               sprite_y = text_y;
               sprite_spr = object_get_sprite(obj_star);
               sprite_scale = 40/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(-1,0);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               
               
    
        break;
        
    case 2:
               draw_set_valign(fa_middle);
               draw_set_halign(fa_left);
               //Draw first line text
               //frame_text = "Penalties happen if all#stars escape and there's#still time remaining.";
               frame_text = "Penalties happen when#all stars escape."// and there's#still time remaining.";
               //frame_text = "Letting all stars escape gives a#penalty. Penalties make it harder."; 
               //frame_text = "Each level the stars get faster#and the paddle gets smaller."//#Take aim and tap to begin!";
               //Mzybe we display tap to begin when tutorial isn't active
               line_h = string_height("H")/2 + text_line_gap; //50 = distance from title
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               sprite_w = 40//50;
               sprite_gap = 8//10;
               text_x = title_x - text_w/2 + (sprite_w*1+sprite_gap)/2;  //60 = sprite width; 10=padding
               //text_y = text_start_y+ text_h/1.5 + text_line_gap;//50 = distance from title
               text_y = text_start_y + text_h *.5 + line_h*1 ;
               draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
               
               //Draw shooter sprite
               sprite_x = text_x - (sprite_w*.5+sprite_gap*1);
               sprite_y = text_y;
               sprite_spr =  s_v_penalty_white;
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(-1,0);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               
               
               // Penalties make it harder.
               //Draw second line text
               frame_text = "Penalties make it harder.";
               line_h = text_line_gap/2 + text_h * .5 ; //50 = distance from title
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               //text_x = title_x - text_w/2 + (sprite_w+sprite_gap)/2;  //40 = sprite width; 10=padding
               //may want to finesse this and the other text x to line it up like mockup with the pyramid
               text_y = text_y + text_h *.5 + line_h*1 ;
               draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
               
               //Draw shooter sprite
               //sprite_x = text_x - (sprite_w+sprite_gap)/2;
               sprite_y = text_y;
               sprite_spr =  s_v_penalty_white;
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(-1,0);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               
               
               //Draw third line text
               frame_text = "When time runs out it#gets much faster."
               line_h = text_line_gap/2 + text_h * .5 ; //50 = distance from title
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               //text_x = title_x - text_w/2 + (sprite_w+sprite_gap)/2;  //40 = sprite width; 10=padding
               //may want to finesse this and the other text x to line it up like mockup with the pyramid
               text_y = text_y + text_h *.5 + line_h*1 ;
               draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
               
               //Draw shooter sprite
               //sprite_x = text_x - (sprite_w+sprite_gap)/2;
               sprite_y = text_y;
               sprite_spr =  s_v_penalty_white;
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(-1,0);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               
               
    
        break;
        
    case 3:
      /*   
    
    
               draw_set_valign(fa_middle);
               draw_set_halign(fa_left);
               //Draw first line text
               frame_text = "When time runs out it#gets much faster."
               //frame_text = "If time runs out and#there's still stars. The#game speeds up.";
               //frame_text = "Letting all stars escape gives a#penalty. Penalties make it harder."; 
               //frame_text = "Each level the stars get faster#and the paddle gets smaller."//#Take aim and tap to begin!";
               //Mzybe we display tap to begin when tutorial isn't active
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               sprite_w = 40//50;
               sprite_gap = 8//10;
               text_x = title_x - text_w/2 + (sprite_w*1+sprite_gap)/2;  //60 = sprite width; 10=padding
               text_y = text_start_y+ text_h + text_line_gap;//50 = distance from title
               draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
               
               //Draw shooter sprite
               sprite_x = text_x - (sprite_w*.5+sprite_gap*1);
               sprite_y = text_y;
               sprite_spr =  s_v_penalty_white;
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(-1,0);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               
        /*       
               // Penalties make it harder.
               //Draw second line text
               frame_text = "If time runs out stars keep getting faster.";
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               //text_x = title_x - text_w/2 + (sprite_w+sprite_gap)/2;  //40 = sprite width; 10=padding
               //may want to finesse this and the other text x to line it up like mockup with the pyramid
               text_y = text_y + text_h + text_line_gap; //text_h/2
               draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
               
               //Draw shooter sprite
               //sprite_x = text_x - (sprite_w+sprite_gap)/2;
               sprite_y = text_y;
               sprite_spr =  s_v_penalty_white;
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(-1,0);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
        */
               
    
        break;
        
    case 4:
    
    
    
        break;
        
    case 5:
    
    
    
        break;
        
    case 6:
    
    
    
        break;
        
        
    default:
        break;


















}
