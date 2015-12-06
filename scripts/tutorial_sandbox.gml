///tutorial_sandbox(frame_index)


switch argument0{
    
    case 0:
    
    
               draw_set_valign(fa_middle);
               draw_set_halign(fa_left);
               //Draw first line text
               frame_text = "Sandbox combines the best of#everything. And you can't lose.";
               //frame_text = "Letting all stars escape gives a#penalty. Penalties make it harder."; 
               //frame_text = "Each level the stars get faster#and the paddle gets smaller."//#Take aim and tap to begin!";
               //Mzybe we display tap to begin when tutorial isn't active
               text_w = string_width(frame_text);
               text_h = string_height(frame_text);
               sprite_w = 40//50;
               sprite_gap = 8//10;
               text_x = title_x - text_w/2 + (sprite_w*1+sprite_gap)/2;  //60 = sprite width; 10=padding
               text_y = text_start_y+ text_h/2 + text_line_gap;//50 = distance from title
               draw_text_colour(text_x,text_y,frame_text,text_color,text_color,text_color,text_color,tutorialTextTween[0]);
               
               //Draw shooter sprite
               sprite_x = text_x - (sprite_w*.5+sprite_gap*1);
               sprite_y = text_y;
               sprite_spr = object_get_sprite(obj_star);
               sprite_scale = sprite_w/sprite_get_width(sprite_spr);
               sprite_col = power_type_colors(-1,9);
               draw_sprite_ext(sprite_spr,0,sprite_x,sprite_y,sprite_scale,sprite_scale,0,sprite_col,tutorialTextTween[0]);
               
               //Draw second line text
               frame_text = "Use board modifiers and the#paddle after the round begins.";
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
        
    case 2:
        
    case 3:
        
    case 4:
        
    case 5:
        
    case 6:
        
    default:
        break;


















}
