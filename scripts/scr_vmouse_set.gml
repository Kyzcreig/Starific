///scr_vmouse_set()

// Set Velocity
var VMvel = 7.5;
var KeyPressed = false; 
// Detect WASD
if keyboard_check(vk_up) or keyboard_check(ord("W")){
    //window_mouse_set(mouse_x,mouse_y-VMvel);
    VMouseY -= VMvel;
    KeyPressed = true;
}
if keyboard_check(vk_down) or keyboard_check(ord("S")){
    //window_mouse_set(mouse_x,mouse_y+VMvel);
    VMouseY += VMvel;
    KeyPressed = true;
}
if keyboard_check(vk_right) or keyboard_check(ord("D")){
    //window_mouse_set(mouse_x+VMvel,mouse_y);
    VMouseX += VMvel;
    KeyPressed = true;
}
if keyboard_check(vk_left) or keyboard_check(ord("A")){
    //window_mouse_set(mouse_x-VMvel,mouse_y);
    VMouseX -= VMvel;
    KeyPressed = true;
}


// Set VMState
if KeyPressed {
    VMState = 1;
}

if VMState == 1 {
    // If Distance From Center too Great
    var MaxMouseDist = pradius/2//gridSize / 2 * cellSize; //pradius
    var scaledMouseDistance = point_distance(VMouseX, VMouseY, centerfieldx, centerfieldy) / MaxMouseDist;
    if scaledMouseDistance > 1{
        //Get Angle of Mouse
        tempMouseAngle = darctan2(VMouseY-centerfieldy,VMouseX-centerfieldx);
        //Normalize to Center
        VMouseX = dcos(tempMouseAngle) * MaxMouseDist + centerfieldx;
        VMouseY = dsin(tempMouseAngle) * MaxMouseDist + centerfieldy;
        //window_mouse_set(normMX,normMY);
        
    }
    // Else If Distance too Close 
    else if scaledMouseDistance < .3 and !KeyPressed{
        //Get Angle of Mouse
        tempMouseAngle = darctan2(VMouseY-centerfieldy,VMouseX-centerfieldx);
        //Normalize to Center
        VMouseX = dcos(tempMouseAngle) * MaxMouseDist * .3 + centerfieldx;
        VMouseY = dsin(tempMouseAngle) * MaxMouseDist * .3 + centerfieldy;
    }
}
