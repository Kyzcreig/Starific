#define scr_increment_combo
///scr_increment_combo(color)

if !POWER_multimalus[@ 0]{
    global.pComboTimer = global.pComboTimerMax
    global.pComboCount +=1
    global.pComboColor = argument0;
    
 
    
    //Effects for combo counts
    if global.pComboCount >= 10{//50 {
    
        /*
        if global.pComboCount mod 25 == 0{

            //Change current theme
            if  global.pComboColorSwitched[0] != 2{
                global.pComboColorSwitched[0] = 2;
                
                
                var newSkin = CURSKIN;
                var newSkinRange = array_length_1d(global.pComboColorSkins)-1;
                //Randomize until new skin selected
                while (newSkin == CURSKIN && newSkinRange != 0){
                    newSkin = irandom(newSkinRange);
                }
            
                scr_change_color_theme(global.pComboColorSkins[newSkin]);
                
            }
            //What if we did the spins as else if's here, instead of different modulus
            //this might be good because we want it to change colors less frequently?
            
        
        }*/
        
        //Starts at .5 goes up to .75 for each increment over 25 up to 200
        var beatAlpha = min(1, .5 + max(0,(global.pComboCount - 25)/175 * .25))
        
        if (global.pComboCount+9) mod 5 == 0{
            scr_beat_effect('A',beatAlpha);
        }
        else if (global.pComboCount+7) mod 5 == 0{
            scr_beat_effect('B',beatAlpha);
        }
        else if (global.pComboCount+5) mod 5 == 0{
            scr_beat_effect('C',beatAlpha);
        }
        else if (global.pComboCount+3) mod 10 == 0{
            scr_beat_effect('D',beatAlpha);
        }
        else if (global.pComboCount+1) mod 15 == 0{
            scr_beat_effect('E',beatAlpha);
        }
    }
        
    
}

#define scr_change_color_theme
///scr_change_color_theme(theme index)


//Change current theme
CURSKIN = argument0
mColorsChanger = -1// true;
    //We use -1 because +1 triggers the pause color changer.
    

//Save Skin Change
ini_open("scores.ini")
    ini_write_real("settings", "CURSKIN", CURSKIN);
ini_close()

    
//Color Easer
var eDur = 2 //.5
scr_color_easer(eDur)

ScheduleScript(obj_control_game, 1, eDur, array_set_index_1d, 
                                global.pComboColorSwitched, 0, 1);

#define scr_restore_color_theme
///scr_restore_color_theme()



//Restore current theme
if global.pComboColorSwitched[0] != 0 {
    global.pComboColorSwitched[0] = 0;
    scr_change_color_theme(global.pComboColorSkins[0]);
}