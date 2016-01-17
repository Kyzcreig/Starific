#define HTML5_mouse_button_get_index
///HTML5_mouse_button_get_index(mouse_button_string)

switch argument0 {

case "mb_left":
    return 0;
    break;

case "mb_right":
    return 1;
    break;

case "mb_middle":
    return 2;
    break;

case "mb_any":
    return 3;
    break;


}



#define HTML5_mouse_button_get_name
///HTML5_mouse_button_get_name(mouse_button_index)

switch argument0 {

case 0:
    return "mb_left";
    break;

case 1:
    return "mb_right";
    break;

case 2:
    return "mb_middle";
    break;

case 3:
    return "mb_any";
    break;


}



#define HTML5_mouse_check_button_pressed
///HTML5_mouse_check_button_pressed(mouse_button)

// Use Normal MB Check
if CONFIG != CONFIG_TYPE.HTML {
    return mouse_check_button_pressed(argument0);
}
// Use HTML5 Safe Version
else {
    with (obj_HTML5_mouse) {
        var buttonName = HTML5_mouse_button_convert_gml_to_js(argument0);
        var buttonState = HTML5_mouse_check_button(buttonName)
        var buttonIndex = HTML5_mouse_button_get_index(buttonName);
        // If Pressed
        if lastButtonState[buttonIndex] == 0 and buttonState == 1 {
            return 1;
        }
    }
}

return 0;

#define HTML5_mouse_check_button_released
///HTML5_mouse_check_button_released(mouse_button)

// Use Normal MB Check
if CONFIG != CONFIG_TYPE.HTML {
    return mouse_check_button_released(argument0);
}
// Use HTML5 Safe Version
else {
    with (obj_HTML5_mouse) {
        var buttonName = HTML5_mouse_button_convert_gml_to_js(argument0);
        var buttonState = HTML5_mouse_check_button(buttonName)
        var buttonIndex = HTML5_mouse_button_get_index(buttonName);
        // If Pressed
        if lastButtonState[buttonIndex] == 1 and buttonState == 0 {
            return 1;
        }
    }
}

return 0;

#define HTML5_mouse_button_convert_gml_to_js
///HTML5_mouse_button_convert_gml_to_js(mouse_button)

switch argument0 {

case mb_left:
    return "mb_left";
    break;

case mb_right:
    return "mb_right";
    break;

case mb_middle:
    return "mb_middle";
    break;

case mb_any:
    return "mb_any";
    break;


}