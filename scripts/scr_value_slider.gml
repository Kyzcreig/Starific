#define scr_value_slider
///scr_value_slider(x,y, width,height, value_data, outline_w,col_outline,test sound, locked, mouse_x, mouse_y)
// x: position on x axis
// y: position on y axis
// wid: width of the backline, and the limit when hv is 0
// heig: height of the backline, and the limit when hv is 1
// colr: outline and bar color
//
//
// returns: precentage in % (0-100)
var xx,yy,w,h,outline_w, outcolor, soundTest,locked, Mxx, Myy,value_data;
xx=argument0 //midpoint
yy=argument1 //midpoint 
w=argument2
h=argument3
value_data=argument4
outline_w=argument5
outcolor=argument6
soundTest=argument7
locked = argument8
Mxx = argument9
Myy = argument10


//Draw Volume Rectangle Outline
draw_rectangle_outline_width_ext(xx-w/2,yy-h/2,xx+w/2,yy+h/2, outline_w,outcolor, 1, 0)
    
//Draw Volume Rectangle Fill
draw_sprite_stretched_ext(s_v_background_solid_menu, 0, 
    xx-w/2, yy-h/2, w*value_data[0], h, outcolor, 1); 
//draw_rectangle(xx-w/2,yy-h/2,xx-w/2+w*value_data[0],yy+h/2,false);

var pressed = value_data[2];
if !locked{
    //Check for Mouse in Volume Rectangle
    if point_in_rectangle(Mxx,Myy,xx-w/2,yy-h/2,xx+w/2,yy+h/2)
    {
        // If Mouse Pressed
        if mouse_check_button_pressed(mb_left) {
            value_data[@ 2] = true;
            pressed = true;
            
            //Play test noise if mouse pressed
            if soundTest and !TESTING_SOUND[0] 
            {
                scr_volume_sound_test_helper()
            }
        }
        /*
        // If Mouse Held 
        else if (mouse_check_button(mb_left) and pressed)
        {
            pressed = true;value_data[@ 2] = true
        }*/
        
    }
    
    //Readjust Volume Value if Pressed
    if pressed
    {
        value_data[@ 0] = clamp((Mxx - (xx-w/2))/w,0,1)
        // If Released, Unset Pressed Flag
        if mouse_check_button_released(mb_left)
        {
           value_data[@ 2] = false;
           
           //If Sound Test Enabled
           if soundTest and !TESTING_SOUND[0]
           {    
                //Play test noise if mouse released
                scr_volume_sound_test_helper()
           }
        }
    
    }
}


return pressed;

#define scr_volume_sound_test_helper
///scr_volume_sound_test_helper()


TEST_SOUND_INSTANCE = scr_sound(TEST_SOUND,3,false)
TESTING_SOUND[0] = 1;
var soundDur = audio_sound_length(TEST_SOUND) * 1.5; //sound length in seconds
ScheduleScript(id, 1, soundDur, array_set_index_1d, TESTING_SOUND, 0, 0);