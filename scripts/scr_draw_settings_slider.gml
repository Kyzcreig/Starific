///scr_draw_settings_slider(value_data, sound_list, save_section, save_key, ease, slider_type)


var value_data = argument0;
var current_val = value_data[0];
var sound_list = argument1; 
var save_section = argument2;
var save_key = argument3;
var ease = argument4;
var slider_type = argument5;
/* 
    slider_type == 0: music (no sound testing)
    slider_type == 1: sfx (yes sound testing)
    slider_type == 2: sensitivity (no sound testing)

*/



// Draw Slider
slider_pressed = scr_value_slider(sliderMidX, sliderMidY,sliderW * ease, sliderH,value_data,
                                  4,COLORS[0],slider_type == 1, false, mouse_x, mouse_y)



// If Value Was Changed                   
if current_val != value_data[0]
{
    /*
   //Save new value to file
    ini_open("scores.ini")
        ini_write_real(save_section, save_key, value_data[0]);
    ini_close();
    */ 
    //NB: Factored this out because i/o lags bad in step events.
    
    // If Sound/Music Slider     
    if slider_type < 2
    {
       //Raise list of sounds to new volume
       for (var k = 0, o = ds_list_size(sound_list); k < o; k++)
       {
           cur_sound = sound_list[| k]
           if(audio_is_playing(cur_sound))
           {
               if !value_data[1]{
                    audio_sound_gain(cur_sound,0,0);
               }
               else {
                    audio_sound_gain(cur_sound,value_data[0],0);
               }
           } 
       }
    }
    // Else if Sensitivity Slider
    else if slider_type == 2 {
        //If Changed Mid Game, set state
        if GAME_PAUSE {value_data[@ 3] = 1}
    }
}
