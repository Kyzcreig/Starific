#define scr_tp_init
///scr_tp_init()


/// Initialize Fixed Location
globalvar 
TOUCH_FIXED_PRESSED,
TOUCH_FIXED_X, 
TOUCH_FIXED_Y, 
TOUCH_FLUID_X, 
TOUCH_FLUID_Y,
TOUCH_LINE_START_ANGLE,
//TOUCH_LINE_X,
//TOUCH_LINE_Y
TOUCH_PAD_SHOW
;
// Initialize TP Sensitivity
globalvar TP_SENSE;

//if file_exists("scores.ini") { file_delete("scores.ini");}

ini_open("scores.ini")
    TP_SENSE[0] = ini_read_real("settings", "TP_SENSE", .5) //value from 0 (big) to 1 (small)
    TP_SENSE[1] = ini_read_real("settings", "TP_MODE", 1);//1);//0);  //EVALUATE ME
                            // EVALUATE ME: We're using fixed center by default now.
        /* NB: used for "fixed" vs "fluid" controls
           0 = fluid
           1 = fixed
           2 = linear
        
        */
                        //We can come up with some neat icons for that
    TP_SENSE[2] = false; //is pressed value
    TP_SENSE[3] = 0; //has sensitivity changed? bool
    
    // Load Previous fixed location
    TOUCH_FIXED_X = ini_read_real("settings", "TOUCH_FIXED_X", -1);
    TOUCH_FIXED_Y = ini_read_real("settings", "TOUCH_FIXED_Y", -1);
    TOUCH_FIXED_PRESSED = 0;
    TOUCH_FLUID_X = -1;
    TOUCH_FLUID_Y = -1;
    //TOUCH_LINE_X = -1;
    //TOUCH_LINE_Y = -1;
    
    TOUCH_PAD_SHOW = ini_read_real("settings", "TOUCH_PAD_SHOW", 1);
    
    
ini_close();

// Get DPIX
//var myLaptop_dpiX = 96;
var iPhone5_dpiX = 326;
var currentDPIX = display_get_dpi_x();


globalvar touchPad;
if (os_type == os_winphone or os_type == os_ios or 
    os_type == os_android) or os_device{
     touchPad = 1
}
else touchPad = 0
//Force Touchpad flag for debugging
if game_filming{
    if os_type == os_windows {
        touchPad = 3;
    }
}
//DEBUGGING
if 1 { //debugging
    if (os_type == os_windows) and 
       (os_browser == browser_not_a_browser) { 
        touchPad = 2;//0;
    }
    
    // If Testing Touch Controls
    if touchPad == 2 { 
        // Use phone DPIX
        currentDPIX = iPhone5_dpiX;
    }
}
/* TP Constants:
 * 0 = no touchpad
 * 1 = touchpad on mobile
 * 2 = touchpad on pc for testing, no os_is_paused checking
 * 3 = fake touchpad on pc for capturing footage
 */
 
 
 
globalvar TOUCH_ENABLED ;
if touchPad != 0 and touchPad != 3{
    TOUCH_ENABLED = true;
    device_mouse_dbclick_enable(false);
} else {
    TOUCH_ENABLED = false;
}
 
 
// Set Pixels Per Inch
global.dpiX = 1
// If We're Using Touch Controls
if TOUCH_ENABLED{
    //global.dpiX = display_get_dpi_x()/iPhone5_dpiX;
    global.dpiX = currentDPIX/iPhone5_dpiX;
}
















#define scr_tp_controls_init
///scr_tp_controls_init()


//Set Touch Control Vars
scr_tp_set_rad();

// Set oldMXY
oldMX = mouse_x
oldMY = mouse_y

if GAME_IS_HTML5 {
    scr_HTML5_mouse_set_xy();
}

//Virtual Mouse for WASD Controls  (Presently Disabled But We're keeping it)
/*
VMouseX = mouse_x;
VMouseY = mouse_y;
oldVMX = mouse_x;
oldVMY = mouse_x;
VMState = 0;
*/
/*
//Touch Trail Stuff (Presently Disabled But We're keeping it)
TouchTrailInit = true;
TouchTrailArray[0,0] = 0;
TouchMX = 0;
TouchMY = 0;
*/


//Set GUI TouchPad Vars
tp_scale[0] = 0;
tp_bigR = 0 * tp_scale[0]//;
tp_smlR = 0 * tp_scale[0]//;

tp_dist = 0;
tp_dist_max = (scr_tp_set_rad_clamp(0)+scr_tp_set_rad_clamp(1))*1.25
tp_col = c_white;//COLORS[0];

// Calculate Default Location
dCX_start = GAME_MID_X;
dCY_start = min(  (fieldEndY+60  +  GAME_Y+GAME_H-20)/2,//+ scr_tp_set_rad_clamp(0) * 1.2, 
                 //Ceiling is midpoint of below power icons and screen end
                  GAME_Y+GAME_H - 20 - scr_tp_set_rad_clamp(0) * 1.2)
                  //Floor is screen end less touch pad sprite


// Set Starting Location
//Fluid Control
/// Set Fluid to Default Location
TOUCH_FLUID_X = dCX_start;
//TOUCH_FLUID_Y = dCY_start;
TOUCH_FLUID_Y = dCY_start;//(fieldEndY + GAME_Y + GAME_H -20 )/2 ;

// Fixed/Linear Controls
// If No Location Set Yet
if TOUCH_FIXED_X == -1 or TOUCH_FIXED_Y == -1 or true { //FIX ME
    // Set Fixed to Default Location
    TOUCH_FIXED_X = dCX_start;
    //TOUCH_FIXED_Y = dCY_start;
    TOUCH_FIXED_Y = dCY_start;//(fieldEndY + GAME_Y + GAME_H -20 )/2 ;
    /*
    // Save
    ini_open("scores.ini")
        ini_write_real("settings", "TOUCH_FIXED_X", TOUCH_FIXED_X);
        ini_write_real("settings", "TOUCH_FIXED_Y", TOUCH_FIXED_Y);
    ini_close();
    */
}
// Else Set to Saved Location
else if TP_SENSE[1] == 1 or  TP_SENSE[1] == 2 {
    dCX_start = TOUCH_FIXED_X;
    dCY_start = TOUCH_FIXED_Y;
}
// Set Start Angle (Linear Controls)
TOUCH_LINE_START_ANGLE = 90;  



// Set DC Center
dynamicCenterX = dCX_start;
dynamicCenterY = dCY_start;
DCXdelta = 0;
DCYdelta = 0;

MAFromMove = 90;
      
// Starting Draw Location for TouchPad Components, all centered
tp_big_x = dCX_start;
tp_big_y = dCY_start; 
tp_sml_x = dCX_start;
tp_sml_y = dCY_start;


//Misc TP vars
tp_alpha[0] = 1;
tp_tween = noone;
tp_dummy = false;

globalvar tp_on_button;
tp_on_button[0] = 0;
tp_on_button[1] = 0; //timer
tp_on_button[2] = .5 * room_speed;; //max timer

 

#define scr_tp_set_fixed
///scr_tp_set_fixed()



if TOUCH_ENABLED and ((TP_SENSE[1] == 1) or (TP_SENSE[1] == 2)) and 
   room == rm_game and MODE != MODES.MOVES 
{
    // If Not Swiping
    if SWIPE and !SWIPE_BRK {
        //Increment Hold to Place Fixed TP Counter
        TOUCH_FIXED_PRESSED++;
        
        // If Held Long Enough
        if (TOUCH_FIXED_PRESSED > 1.5 * room_speed) 
        {
            // Reset Counter
            TOUCH_FIXED_PRESSED = 0;
            
            var AdjustedFixedX = mouse_x + dcos(mouseangle-180) * 10;
            var AdjustedFixedY = mouse_y + dsin(mouseangle-180) * 10;
            
            // Cache the mouse_x/y in Home Global Location
            TOUCH_FIXED_X = AdjustedFixedX//mouse_x;
            TOUCH_FIXED_Y = AdjustedFixedY//mouse_y;
            
            
            // Save
            ini_open("scores.ini");
                ini_write_real("settings", "TOUCH_FIXED_X", TOUCH_FIXED_X);
                ini_write_real("settings", "TOUCH_FIXED_Y", TOUCH_FIXED_Y);
            ini_close();
    
            // Break Swipe
            SWIPE_BRK = true; 
                //NB: Prevents further star launch and prevents redundant saving.
            //SWIPE = false;
            if !GAME_PAUSE {
                scr_tp_set_fixed_ease()
                    // NB: Reset Swipe too so TP doesn't run away after being set
            } else {
                with(obj_control_pause){
                    resumeFixedTP = true;
                }
            }
            
                
            // Spawn Dialogue Confirmation
            if !GAME_PAUSE {
                //txt_font = fnt_game_bn_40_bold;
                txt_font = fnt_game_bn_26_black;
            } else {
                //txt_font = fnt_menu_bn_40_bold;
                txt_font = fnt_menu_bn_26_black;
            } 
            draw_set_font(txt_font)
            //txt_text = "pad placed!";
            txt_text = "recenter control pad by#tapping and holding!";
            if !GAME_PAUSE {
                txt_height = string_height("H")*.6 + string_height(txt_text) / 2;
                txt_y = centerfieldy+txt_height;
            } else {
                txt_y = GAME_Y + GAME_H*.75 //string_height("H")*1.6 + string_height(txt_text) / 2;
            } 
            scr_popup_text_field_static(GAME_MID_X,txt_y ,
            txt_text,COLORS[0],txt_font, false, 4*room_speed)
            
            // Play Placement Sound
            scr_sound(sd_tp_place);
            
            /*  Maybe use an obj_paddle_marker to mark the paddle placement when there's no touchpad indicator
                e.g. on sandbox mode or pause screen.
                you can see our notepad notes for more details
                
                
                    //It could just be the touchpad top sprite
                    //then when paddle exists it can ease out. and self destruct.
            
            
            */
        }
    } 
    else {
        // Reset Held Press Counter
        TOUCH_FIXED_PRESSED = 0;
    }
}

#define scr_tp_set_rad
///scr_tp_set_rad()


globalvar TR_min, TR_max, TP_BASE_RAD, TP_BASE_RAD_SCALED, TouchRad;

TP_BASE_RAD = 100;

TP_BASE_RAD_SCALED = TP_BASE_RAD * (2 - TP_SENSE[0])

//Set Touch Control Vars
/*
ini_open("scores.ini");
    TP_SENSE[0] = ini_read_real("settings", "TP_SENSE", 1)
ini_close();
*/

// Scale Touch Radius for Device
TouchRad = TP_BASE_RAD_SCALED  * global.dpiX //* (1 + .5*!MOVE_ACTIVE)


//TR_min = .3 * TP_BASE_RAD * global.dpiX 
TR_min = .3 * TouchRad;//.6;
TR_max = .9 * TouchRad;//.8 //1// EVALUATE ME //nice comment idea


/*  I found .6 was a nice distance for medium sensitivity 
    spins but caused other people problems.
    
    .3 TR_min worked much better for not causing issues but is super sensitive

*/

#define scr_tp_set_rad_clamp
///scr_tp_set_rad_clamp(index)

// Return Big Rad
if !argument0{
    //return TP_BASE_RAD_SCALED  * TR_max //* global.dpiX
    return TP_BASE_RAD_SCALED  * .75 //* global.dpiX
        //dpix isn't necessary here since we 
        //scale up the game on higher resolutions already
} 
// Return Small Rad
else {
    //return TP_BASE_RAD_SCALED * TR_min / //* global.dpiX
    return TP_BASE_RAD_SCALED * .25//.25 ; //* global.dpiX
}

#define scr_tp_reset_rad
///scr_tp_reset_rad()


// If Sensitivity slider was changed
if TP_SENSE[3] == 1 {

    // Reset the sensitivity
    scr_tp_set_rad()
    
    //Set Sensitivity to State for Tweening Touchpad sprites
    TP_SENSE[@ 3] = 2;
    
    

}
#define scr_tp_set_fixed_ease
///scr_tp_set_fixed_ease()

TweenFire(id, scr_tp_fixed_easer, EaseOutSine, 
        TWEEN_MODE_ONCE, 1, 0, .75, 0, 1);
                // NB: Reset Swipe too so TP doesn't run away after being set

with (obj_control_game) {
    // Set TP Button Press Mutex;
    tp_on_button[0] = 1;
    // Temporarily Disable Player Control of Paddle, so it doesn't spazz
    ScheduleScript(id, 1, .75, array_set_index_1d,TP_SENSE,1,TP_SENSE[1]) //SWIPE_BRK);
    TP_SENSE[1] = -1; 
}

#define scr_tp_fixed_easer
///scr_tp_fixed_easer(val)

with obj_control_game {
    //Ease DC towards appropriate distance away from mouse
     
    //var AdjustedFixedX = TOUCH_FIXED_X + dcos(mouseangle) * 20;
    //var AdjustedFixedY = TOUCH_FIXED_Y + dsin(mouseangle) * 20;
    
    dynamicCenterX = dynamicCenterX + 
                    (TOUCH_FIXED_X - dynamicCenterX) * argument0;
    dynamicCenterY = dynamicCenterY + 
                    (TOUCH_FIXED_Y - dynamicCenterY) * argument0;
    // Ease TP Base Also
    tp_big_x = dynamicCenterX;
    tp_big_y = dynamicCenterY;
}