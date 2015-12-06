///scr_ModifiersDragSelection()

    
//Drag Modifiers With TouchPad
if TOUCH_ENABLED and bMSelected[0] != noone{
    
    //Adjust MX/MY from anchor
    if SWIPE{
        if touchPad{var bMYoff = bMRad + bMYadj;}
        else{       var bMYoff = cellH*1.5}//bMRad;}
        
        bMX = clamp(bMXS + SMX - SMXS, GAME_X, GAME_X + GAME_W);
        bMY = clamp(bMYS + SMY - SMYS, GAME_Y +bMYoff, GAME_Y + GAME_H +bMYoff);
    
         

    }
    
    //Set new Anchor MX/MY
    if mouse_check_button_released(mb_left){
        bMXS = bMX;
        bMYS = bMY;
    }
    
}
    
    
//Drag Modifiers With Mouse Cursor (no anchor needed)
if !TOUCH_ENABLED and bMSelected[0] != noone{
    bMX = mouse_x;
    bMY = mouse_y;
}
