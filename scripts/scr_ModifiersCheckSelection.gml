///scr_ModifiersCheckSelection(bool)
var markerType = argument0;
var is_tweening = argument1;

for (i=0; i<6; i++){
     mixer_size = 60
     mixer_scale = mixer_size/40;
     mixer_x = mixers_x[mixPos[0]] + i*90 + bMjiggle[i,1];
     mixer_y = mixers_y[mixPos[0]] + bMjiggle[i,2];
     


     scaleUp = 1.25;
     //Check if mouse over icon
     if point_in_rectangle(mouse_x,mouse_y,mixer_x-mixer_size/2*scaleUp,mixer_y-mixer_size/2*scaleUp,
        mixer_x+mixer_size/2*scaleUp,mixer_y+mixer_size/2*scaleUp) and is_tweening and 
        (!touchPad or mouse_check_button(mb_left) or ScheduleExists(bMScheduler)) 
     {
         sMSelected = false;
         with (markerType){
              if Creator_ID == other.id and selected[0]{
                 other.sMSelected = true; 
                 break;
              }
         }
         if mouse_check_button_pressed(mb_left){
             if !sMSelected{
                 
                 //Select mixer
                 if boardMixers[i,0] > 0{
                     bMScheduler = ScheduleScript(id,1,.25,array_set_value,bMSelected,i)
                     bMSelected[0] = noone;
                     scr_sound(sd_menu_click);
                     //Set x,y coords
                     bMX = mouse_x;
                     bMY = mouse_y;
                     bMXS = bMX;
                     bMYS = bMY;
                     
                     
                     //mouse_clear(mb_left);
                     //SWIPE = false;
                     //SWIPE_TAP = false;
                     
                     //Set instruction text 
                     bMtext[i] = 7*room_speed;
                     //Clear Warning text
                     bMtext[array_length_1d(bMtext)-1] = 0;
                 }
                 else{
                     mouse_clear(mb_left);
                     SWIPE = false;
                     SWIPE_TAP = false;
                     bMSelected[0] = noone;
                     
                     
                     //Set warning text
                     bMtext[array_length_1d(bMtext)-1] = 3*room_speed;
                     for (var j=0; j <5; j++){
                         bMtext[j] = 0;
                     } 
                     //Warning sound
                     scr_sound(sd_menu_wrongclick,1,false)
                 }
             
             }
             //They tried to click while staregg was being directed
             else{
                 //Warning sound
                 scr_sound(sd_menu_wrongclick,1,false)
             
             }
         
         }
     }
     
 }
