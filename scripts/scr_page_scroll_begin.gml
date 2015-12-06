#define scr_page_scroll_begin
///scr_page_scroll_begin(ScrollStartY, ScrollEndY)

/*
//Set Draw Target to scrollable Surface
if !surface_exists(ScrollSurf){
    ScrollSurf = surface_create(GAME_W,GAME_H)
    //Recall these are volatile and might disappear
}
surface_reset_target()
surface_set_target(ScrollSurf);
draw_clear_alpha(COLORS[6], 1); 
    // This is needed to prevent annoying alpha bugs with text
*/
    
// Set Scroll Margins    
ScrollStartY = argument0;
ScrollEndY = argument1;

ScrollDisplayH = ScrollEndY - ScrollStartY;
    
//Set Offset
ScrollOffset = (ScrollTextHeight-ScrollDisplayH)*Scroll; //GAME_Y+



#define scr_page_scroll_margins
///scr_page_scroll_margins(texture_page)

var tex_page = argument0;
var margin_spr = scr_return_solid_sprite(tex_page);

// Draw Top Margin Blackout
    draw_sprite_stretched_ext(margin_spr,0,GAME_X, VIEW_Y,GAME_W, ScrollStartY, COLORS[6],1);
// Draw Bottom Margin Blackout
draw_sprite_stretched_ext(margin_spr,0,GAME_X, ScrollEndY, GAME_W, VIEW_H - ScrollEndY, COLORS[6],1);

/* NB: We use vertical view coordinates instead of game coordinates
   because some devices can be skinnier than iphone and have more vertical margin.
   Otherwise you could see the scroll draws outside the game x/y/w/h


*/


/*NB: If we ever have horizontal scrolling we could add the blackouts
      to the left and right margins too.
*/



#define scr_page_scroll_end
///scr_page_scroll_end(offset_text_height, x, y, w, h)

ScrollDrawH = argument0;
ScrollSurfX = argument1;
ScrollSurfY = argument2;
ScrollDisplayW = argument3;  //how much screen width does it disply? 
ScrollDisplayH = argument4; //how much screen height does it disply?

//Update Scroll Vars
ScrollBottomMargin = 50*RU; //some extra blank space at bottom
ScrollTextHeight = ScrollDrawH+ScrollOffset + ScrollBottomMargin //how long is the text? 
ScrollableDistance = max(1,(ScrollTextHeight - ScrollDisplayH));
//ScrollBarHeight = ScrollDisplayH*ScrollDisplayH/ScrollTextHeight
//ScrollBarRange = ScrollDisplayH - ScrollBarHeight

/*
//ADDS MENU SURFACE BACK
surface_reset_target()
surface_set_target(global.menuSurface);
*/

//If Page Tapped
if mouse_check_button_pressed(mb_left) and ScrollEnabled 
{
    //Prepare for Scrolling
    ScrollStart = Scroll   
    ScrollOldY = mouse_y
    /*
    ScrollV = 0
    //Clear ScrollV_MA
    for(i=1; i < array_length_1d(ScrollV_MA); i++){
        ScrollV_MA[i] = 0;
    }*/
    
    
    //Scrolling = true;
}
//If Page Being Swiped
if mouse_check_button(mb_left) and SWIPE and SWIPE_BRK //Scrolling//SWIPE
{
    // Normalize Change in Y for values 0 to 1 of the page height
    ScrollDelta = (ScrollOldY - mouse_y)/ScrollableDistance
    
    //Make it harder to tug past scroll boundaries
    if Scroll < 0 or Scroll > 1{
        ScrollDelta /= 3;
    }
    
    
    // Adjust Scroll by the Normalized Y Delta
    Scroll = ScrollStart + ScrollDelta
    
        
    //Set Velocity to This Step As Delta
    ScrollV_MA[0] = ScrollDelta;
    //Set Velocity as Moving Average of Lasr 6 Steps
    ScrollV = array_avg_1d(ScrollV_MA)
    //Move back index of each value
    for(i=1; i < array_length_1d(ScrollV_MA); i++){
        ScrollV_MA[i] = ScrollV_MA[i-1];
    }
    
    
    ScrollOldY = mouse_y;
    ScrollStart = Scroll;
    Scrolling = true;
    
}


//Elastic Scroll clamp
else if Scroll < 0 or Scroll > 1
{
    Scroll += (clamp(Scroll,0,1) - Scroll)*.1
}
//Scroll Inertia
if !mouse_check_button(mb_left){
    
    //Mouse Wheel Controls
    ScrollWheelV = .2 * GAME_H / ScrollableDistance//.05//.1//.8;
            //Wheel Velocity is about 20% of a page
    
    if Scroll < 1 {
        //Mouse Wheel Up
        if mouse_wheel_down()  {
            // Ease Velocity
            ScrollV += (ScrollWheelV - ScrollV) * .1;
        } 
    }
    //Halt Excess Velocity
    else if ScrollV > 0 {
        ScrollV = 0;
    }
    
    if Scroll > 0 {
        //Mouse Wheel Down
        if mouse_wheel_up() {
            // Ease Velocity
            ScrollV += (-ScrollWheelV - ScrollV) * .1;
        }
    }
    //Halt Excess Velocity
    else if ScrollV < 0 {
        ScrollV = 0;
    }
    
    
    //Declerate Scrolling
    if abs(ScrollV) > .000001{
        // Set Delta as Velocity (which was a moving average of previous 6 steps)
        ScrollDelta = ScrollV
        // Adjust Scroll by Delta
        Scroll += ScrollDelta;
        // Decrement Velocity by Friction Scalar
        ScrollV -= ScrollDelta * .10//4//1.5; //reduce velocity by ScrollDelta/4
    }
    else if Scrolling {
    
        Scrolling = false;
        ScrollDelta = 0;
        ScrollV = 0;
    }
}

//Reset Scroll State
ScrollEnabled = true;





#define scr_page_scroll_init
///scr_page_scroll_init()


//ScrollSurf = surface_create(GAME_W,GAME_H)
//ScrollSurfX = 0;
//ScrollSurfY = 0;

Scroll = 0;
ScrollTextHeight = 1
ScrollStart = 1
ScrollOldY = 0
ScrollDelta = 0


ScrollDisplayW = GAME_H;
ScrollDisplayH = GAME_W;

ScrollableDistance = 1

//Init Array for Average Scroll Velocity
ScrollStepTime = 6; //12
ScrollV_MA[ScrollStepTime-1] = 0
ScrollV = 0
ScrollWheelV = 0;
Scrolling = false;

ScrollEnabled = false;


ScrollDrawH = 0;
ScrollStartY = 1;
ScrollEndY = GAME_H;

//Init Line Stuff
line_y = 0; 
line_w = 0;



#define scr_page_scroll_cleanup
///scr_page_scroll_cleanup()

/*

if surface_exists(ScrollSurf){
    surface_free(ScrollSurf)
}


#define scroll_convert_y_to_sy
///scroll_convert_y_to_sy(y, start_y)


return argument0 - argument1;



#define scroll_convert_x_to_sx
///scroll_convert_x_to_sx(x, start_x)


return argument0 - argument1;