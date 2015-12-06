///scr_touch_pad_reset_button()

/* This function prevents the touch pad from flying towards a button that you tap.

*/


if mouse_check_button_pressed(mb_left){ 
    PAUSE_RESUME = false;
}
if mouse_check_button_released(mb_left){ //maybe only fire this for obj_control_game, so it doesn't fire twice or something and cause issues
    //Reset whether touchpad is on a button
    tp_on_button[0] = 0;
}
else if tp_on_button[0] > 0{
   
   //Decrement tp_on_button state
   if tp_on_button[0] == 2{
      tp_on_button[0] = 1;
   }  
   //If Already decremented, clear state
   else if tp_on_button[0] == 1 and !PAUSE_RESUME{
      tp_on_button[0] = 0;
   }
}
   
