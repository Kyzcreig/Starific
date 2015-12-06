///scr_touch_pad_tween_in()

if touchPad{
    with(obj_control_game){
        
        //If Not Tutorial
        if !instance_exists(obj_touch_pointer){
            // If Fluid Controls
            if TP_SENSE[1] == 0 {
                dynamicCenterX = TOUCH_FLUID_X;
                dynamicCenterY = TOUCH_FLUID_Y;
            } 
            // If Fixed or Linear Controls
            else {//if TP_SENSE[1] == 1 {
                dynamicCenterX = TOUCH_FIXED_X;
                dynamicCenterY = TOUCH_FIXED_Y;
            }
                  
            tp_big_x = dynamicCenterX;
            tp_big_y = dynamicCenterY; 
            tp_sml_x = tp_big_x;
            tp_sml_y = tp_big_y;
        }
        else{
            dynamicCenterX = obj_touch_pointer.sprite_center_x;
            dynamicCenterY = obj_touch_pointer.sprite_center_y;
                  
            tp_big_x = dynamicCenterX;
            tp_big_y = dynamicCenterY; 
            tp_sml_x = tp_big_x;
            tp_sml_y = tp_big_y;

        }
        
        tp_tween = TweenFire(id, tp_scale, EaseLinear, 
                        TWEEN_MODE_ONCE,1, 0, .5 , tp_scale[0], 1);
           
    }
}
