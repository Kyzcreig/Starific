///scr_quest_progress();

var tmp = 0;
// Get Quest Type
switch QUEST_DATA[0] {
    
      
       //Games played
       case 0:
            tmp += 1;
       break;


       //Reach Score
       case 1:
            tmp += score_p1;
       break;
       
       
       //Reach Combo [unused]
       case 2:
            tmp = lastBestCombo;
            
       break;
       
       
       //Reach level
       case 3:
            tmp += level-1;
       break;

       //Deflectors Destroyed
       case 4:
            var data = scr_deflector_get_data(obj_reflector_parent);
            tmp += data[6];
            if MODE == MODES.MOVES{
                tmp += data[7];
            }
       break;

       //Bombs Destroyed
       case 5:
            var data = scr_deflector_get_data(obj_powerup_parent_bomb);
            tmp += data[6];
            if MODE == MODES.MOVES{
                tmp += data[7];
            }
       break;

       //Triggered Powers
       case 6:
            var data = scr_deflector_get_data(obj_powerup_projectile_parent);
            tmp += data[6];
            if MODE == MODES.MOVES{
                tmp += data[7];
            }
            
       break;


       //Rebound Stars
       case 7:
            tmp += lastSCatches
       break;
       
       //Unique Stars Seen/Spawned
       case 8:
            tmp += lastStars 
       break;

       //GamesPlayed Arcade 
       case 9:
            if MODE == MODES.ARCADE {
                tmp += 1;
            } 
       break;
            
       //GamesPlayed Moves
       case 10:
            if MODE == MODES.MOVES {
                tmp += 1;
            } 
       break;
            
       //GamesPlayed Time
       case 11:
            if MODE == MODES.TIME {
                tmp += 1;
            }  
       break;
            
       //GamesPlayed Sandbox
       case 12:
            if MODE == MODES.SANDBOX {
                tmp += 1;
            } 
       break;
       
       //GamesPlayed Size 15x15
       case 13:
            if GRID == 0 {
                tmp += 1;
            } 
       break;
            
       //GamesPlayed Size 20x20
       case 14:
            if GRID == 1 {
                tmp += 1;
            } 
       break;
            
       //GamesPlayed Size 25x25 [unused] 
       case 15:
            if GRID == 2 {
                tmp += 1;
            } 
       break;
            
       //GamesPlayed Size 30x30
       case 16:
            if GRID == 3 {
                tmp += 1;
            } 
       break;
       
       //Collect Grow Paddles
       case 17:
            var data = scr_deflector_get_data(obj_powerup_growpaddle);
            tmp += data[8];
       break;
       //Collect Shrink Paddles
       case 18:
            var data = scr_deflector_get_data(obj_powerup_shrinkpaddle);
            tmp += data[8];
       break;
       //Collect Slower Stars
       case 19:
            var data = scr_deflector_get_data(obj_powerup_slower);
            tmp += data[8];
       break;
       //Collect Faster Stars
       case 20:
            var data = scr_deflector_get_data(obj_powerup_faster);
            tmp += data[8];
       break;
       //Collect Mirror Paddles
       case 21:
            var data = scr_deflector_get_data(obj_powerup_mirrorpaddle);
            tmp += data[8];
       break;
       //Collect Big Stars
       case 22:
            var data = scr_deflector_get_data(obj_powerup_bigstar);
            tmp += data[8];
       break;
       //Collect Turn Changers
       case 23:
            var data = scr_deflector_get_data(obj_powerup_halfangleturn);
            tmp += data[8];
            var data = scr_deflector_get_data(obj_powerup_threehalvesangle);
            tmp += data[8];
            var data = scr_deflector_get_data(obj_powerup_pierce);
            tmp += data[8];
            var data = scr_deflector_get_data(obj_powerup_reverseturn);
            tmp += data[8];
            var data = scr_deflector_get_data(obj_powerup_diagturn);
            tmp += data[8];
            var data = scr_deflector_get_data(obj_powerup_randomturn);
            tmp += data[8];
       break;
       //Collect Freeze Paddles
       case 24:
            var data = scr_deflector_get_data(obj_powerup_freezepaddle);
            tmp += data[8];
       break;
       //Collect Split Paddles
       case 25:
            var data = scr_deflector_get_data(obj_powerup_splitpaddle);
            tmp += data[8];
       break;
       //Collect Slow Paddles
       case 26:
            var data = scr_deflector_get_data(obj_powerup_slowpaddle);
            tmp += data[8];
       break;
            
       //Collect (Any) Powers
       case 27:
            tmp += lastDCatches;
       break;
       
       //Collect Board Clears
       case 28:
            var data = scr_deflector_get_data(obj_powerup_boardclear);
            tmp += data[8];
       break;
       //Collect Board Fills
       case 29:
            var data = scr_deflector_get_data(obj_powerup_boardfill);
            tmp += data[8];
       break;
       
       //Collect Uppers
       case 30:
            var data = scr_deflector_get_data(obj_powerup_parent_ups);
            tmp += data[8];
       break;
       
       //Collect Downers
       case 31:
            var data = scr_deflector_get_data(obj_powerup_parent_downs);
            tmp += data[8];
            
       break;
       //Collect Rounders
       case 32:
            var data = scr_deflector_get_data(obj_powerup_parent_neutral);
            tmp += data[8];
       break;
       
       //Playtime (in seconds)
       case 33:
            tmp += lastPlaytime * RMSPD_DELTA;
       break;
       
       //Not Implemented   
       default:
            tmp += 0;
       break;
       

}

return tmp;
