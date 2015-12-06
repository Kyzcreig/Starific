///scr_ModifiersPlaceSelection()




//If board modifier selected
if bMSelected[0] != noone
{
    var mType = bMSelected[0];
    bMRad = sqrt(boardMixers[mType,4]*cellW*cellH / pi)
    //If star marker
    if mType == bMStarIndex{
       bMRad = cellH*2
    }
            
    //var mouseX = ((mouse_x-ox -cellW/2) / cellW) 
    //var mouseY = ((mouse_y-mRad*2-oy -cellH/2) / cellH)
    var mouseX = ((bMX-ox -cellW/2) / cellW) 
    var mouseY = ((bMY-bMRad-(touchPad*bMYadj)-oy -cellH/2) / cellH)
    
    //Check if mouse near to grid
    if gamecell_is_valid(round(mouseX),round(mouseY),3) //3 cells of leeway
    { 
        //Determine which cells to draw as selected
        ds_list_clear(global.SelectedCells);
        scr_find_nearest_gridcells(mouseX,mouseY,boardMixers[mType,4],
                            global.SelectedCells, mType == bMStarIndex);
 
    
        //If click, execute board modification
        if SWIPE_TAP and (abs(mouse_y - mixers_y[mixPos[0]]) > 60){ //mouse_check_button_pressed(mb_left){

        
                mouse_clear(mb_left); //maybe comment this out too?
                //SWIPE = false;
                //SWIPE_TAP = false;
                
                scr_board_mixer(mouseX,mouseY,boardMixers[mType,4],mType-1, mType == bMStarIndex);
                
                // Play Click Sound
                scr_sound(sd_menu_click);
                
                //Unselect if out of inventory or if placing star
                boardMixers[mType,0] = boardMixers[mType,0] -1;
                if boardMixers[mType,0] <= 0 or mType == bMStarIndex{  //Star index must be cleared due to the SWIPE selection
                    bMSelected[0] = noone;
                    ds_list_clear(global.SelectedCells);
                    //Clear Instruction Text
                    bMtext[mType] = 1*room_speed;
                }
                else{ 
                    //Refresh Instruction Text
                    bMtext[mType] = 7*room_speed;
                }
                
                
                
                //Increment modification count for reference in tutorial
                if TUTORIAL_ENABLED{
                    bMCount[0]++;
                }
                else{
                    //Enable music if disabled
                    MUSIC_ACTIVE = true;
                    moves_time_active = true;
                }
      
                //Dialogue text on use
                txt_font = fnt_menu_in_game//fnt_menu_buttons;//; 
                txt_text = "-1 "+string_replace(boardMixers[mType,3],"#"," ");
                if mType == bMStarIndex{ txt_text = "Star Placed"}
                draw_set_font(txt_font)
                txt_height = string_height("H")*.6 + string_height(txt_text) / 2;
                scr_popup_text_field_static(centerfieldx,centerfieldy+txt_height,
                txt_text,power_type_colors(boardMixers[mType,1],0),txt_font)

        }
        //Right Click out of bounds, deselect
        else if !TOUCH_ENABLED and mouse_check_button_pressed(mb_right)
        {
            bMSelected[0] = noone;
            mouse_clear(mb_left);
            mouse_clear(mb_right);
            SWIPE = false;
            SWIPE_TAP = false;
            
            //Clear Instruction text and display cells
            bMtext[mType] = 1*room_speed;
            ds_list_clear(global.SelectedCells);
        }
    }
    //Click out of bounds, deselect
    else if SWIPE_TAP //mouse_check_button_pressed(mb_left) 
    or (!TOUCH_ENABLED and mouse_check_button_pressed(mb_right))
    {
        bMSelected[0] = noone;
        mouse_clear(mb_left);
        mouse_clear(mb_right);
        SWIPE = false;
        SWIPE_TAP = false;
        
        //Clear Instruction text and display cells
        bMtext[mType] = 1*room_speed;
        ds_list_clear(global.SelectedCells);
    }
    else if !ds_list_empty(global.SelectedCells){
        ds_list_clear(global.SelectedCells);
    }
}
