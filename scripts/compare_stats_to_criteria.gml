#define compare_stats_to_criteria
///compare_stats_to_criteria(data)

var data = argument0; 
var criteria_type = data[3];
var criteria_quantity = data[4];
var tmp, cmp = false;

switch criteria_type {

//Conventional Stats >=
case 0:
case 1:
case 2:
case 3:
case 4:
case 5:
case 6:
case 7:
case 8:
case 9:
case 10:
case 11:
case 12:
case 13:
case 14:
case 15:
case 16:
case 17:
case 18:
case 19:
case 20:
case 21:
case 22:
case 23:
case 24:
case 26:
    tmp = check_stats(criteria_type);
    cmp = tmp >= criteria_quantity;
break;

//Prize Wheel
case 25:
    cmp = false;
    if data[1] >= 2{
        cmp = true;
    }
break;


//Check for Achievement 
case 27:
    // If More than X GamesplayedTotal
    if check_stats(0) >= 5 {
        /*NB: Req. 5 games to avoid overwhelming new players
        */ 
        cmp = scr_unlock_get_status(5,criteria_quantity) != 0;
    }
break


//Less than X points
case 28:
    // If More than X GamesplayedTotal
    if check_stats(0) >= 10 {
        /*NB: Req. 10 games to avoid overwhelming new players
        */ 
        tmp = check_stats(criteria_type);
        cmp = (tmp >= 0) and (tmp <= criteria_quantity) 
    }
break;

//Default
case -1:
//Premium
case -2:
default:
    tmp = check_stats(criteria_type);
    cmp = tmp >= criteria_quantity;
break;

}


return cmp;

#define check_stats
///check_stats(stat_type)
//required, file is open.


var stat_type, tmp;
stat_type = argument0;
tmp = 0;


switch stat_type{
       
       //Games played
       case 0:
            for (var m = 0; m < 4; m++){
                for (var s = 0; s < 4; s++){
                    tmp += ini_read_real("Stats_"+string(m+s*4), "gamesPlayed", 0)
                }
            }
            break;


       //Reach Score
       case 1:
            for (var m = 0; m < 4; m++){
                for (var s = 0; s < 4; s++){
                    tmp = max(tmp,ini_read_real("Stats_"+string(m+s*4), "highScore", 0))
                }
            }
            break;



       //Reach Combo X
       case 2:
            for (var m = 0; m < 4; m++){
                for (var s = 0; s < 4; s++){
                    tmp = max(tmp,ini_read_real("Stats_"+string(m+s*4), "highestBestCombo", 0))
                }
            }
            break;

       //Reach level
       case 3:
            for (var m = 0; m < 5; m++){
                for (var s = 0; s < 4; s++){
                    tmp = max(tmp,ini_read_real("Stats_"+string(m+s*4), "highLevel", 0))
                }
            }
            break;



       //Deflectors Destroyed
       case 4:
            var key = scr_deflector_get_key(obj_reflector_parent);
            for (var m = 0; m < 4; m++){
                for (var s = 0; s < 4; s++){
                    tmp += ini_read_real("Stats_"+string(m+s*4), "careerDeaths-"+key, 0);
                }
            }
            break;



       //Bombs Destroyed
       case 5:
            var key = scr_deflector_get_key(obj_powerup_parent_bomb);
            for (var m = 0; m < 4; m++){
                for (var s = 0; s < 4; s++){
                    tmp += ini_read_real("Stats_"+string(m+s*4), "careerDeaths-"+key, 0);
                }
            }
            break;



       //Caught Powers
       case 6:
            var key = scr_deflector_get_key(obj_powerup_projectile_parent);
            for (var m = 0; m < 4; m++){
                for (var s = 0; s < 4; s++){
                    tmp += ini_read_real("Stats_"+string(m+s*4), "careerCatches-"+key, 0);
                }
            }
            break;


       //Rebound Stars
       case 7:
            for (var m = 0; m < 4; m++){
                for (var s = 0; s < 4; s++){
                    tmp += ini_read_real("Stats_"+string(m+s*4), "careerSCatches", 0)
                }
            }
            break;

       //Unique Stars Seen
       case 8:
            for (var m = 0; m < 4; m++){
                for (var s = 0; s < 4; s++){
                    tmp += ini_read_real("Stats_"+string(m+s*4), "careerStars", 0)
                }
            }
            break;

       //GamesPlayed Arcade [unused]
       case 9:
            for (var s = 0; s < 4; s++){
                tmp += ini_read_real("Stats_"+string(0+s*4), "careerSCatches", 0)
            }
            break;
            
       //GamesPlayed Moves
       case 10:
            for (var s = 0; s < 4; s++){
                tmp += ini_read_real("Stats_"+string(1+s*4), "gamesPlayed", 0)
            }
            break;
            
       //GamesPlayed Time
       case 11:
            for (var s = 0; s < 4; s++){
                tmp += ini_read_real("Stats_"+string(2+s*4), "gamesPlayed", 0)
            }
            break;
            
       //GamesPlayed Sandbox [unused]
       case 12:
            for (var s = 0; s < 4; s++){
                tmp += ini_read_real("Stats_"+string(3+s*4), "gamesPlayed", 0)
            }
            break;
            
       //Career Score
       case 13:
            for (var m = 0; m < 4; m++){
                for (var s = 0; s < 4; s++){
                    tmp += ini_read_real("Stats_"+string(m+s*4), "careerScore", 0)
                }
            }
            break;
       //Game Shared
       case 14:
            tmp += ini_read_real("misc", "SHARE_COUNT", 0);
            break;
            
       //Game Rated
       case 15:
            tmp += ini_read_real("misc", "RATE_COUNT", 0);
            break;
      
           
       //GamesPlayed Size 15x15
       case 16:
            for (var m = 0; m < 4; m++){
                tmp += ini_read_real("Stats_"+string(m+0*4), "gamesPlayed", 0)
            }
            break;
            
       //GamesPlayed Size 20x20
       case 17:
            for (var m = 0; m < 4; m++){
                tmp += ini_read_real("Stats_"+string(m+1*4), "gamesPlayed", 0)
            }
            break;
            
       //GamesPlayed Size 25x25 [unused]
       case 18:
            for (var m = 0; m < 4; m++){
                tmp += ini_read_real("Stats_"+string(m+2*4), "gamesPlayed", 0)
            }
            break;
            
       //GamesPlayed Size 30x30
       case 19:
            for (var m = 0; m < 4; m++){
                tmp += ini_read_real("Stats_"+string(m+3*4), "gamesPlayed", 0)
            }
            break;
             
        // UNUSED/ WE CAN ADD NEW ONES HERE
       case 20:
            break;
            
        // UNUSED/ WE CAN ADD NEW ONES HERE
       case 21:
            break;
            
        // UNUSED/ WE CAN ADD NEW ONES HERE
       case 22:
            break;
            
        // UNUSED/ WE CAN ADD NEW ONES HERE
       case 23:
            break;
    
        // Quest Count
       case 24:
            tmp += QUEST_DATA[4];//ini_read_real("misc", "QUEST_COUNT", 0)
            break;   

  
        // Prize Wheel   "spin prize wheel to unlock!"
       case 25:
            tmp = -1 //default prize wheel to locked. 
            break; 
           
        // Video Watch Count
       case 26:
            tmp += ini_read_real("misc", "VIDEO_REWARD_COUNT", 0)
            break;   
            
        // In Game Achievement
       case 27:
            tmp = -1 //achievements are unlocked directly in game
            break; 
            
        // Worst Score
       case 28:
            tmp = -1;
            for (var m = 0; m < 4; m++){
                for (var s = 0; s < 4; s++){
                    var val = ini_read_real("Stats_"+string(m+s*4), "worstScore", -1);
                    if tmp == -1 tmp = val;
                    else if val != -1 tmp = min(tmp,val);
                }
            }
            break; 
            
  
        // Interstitial Watch Count
       case 29:
            tmp += ini_read_real("misc", "INTERSTITIAL_REWARD_COUNT", 0)
            break;   
            
       //Default Unlock     
       case -1:
            tmp = 1;
            break;
            
            
       //Premium Unlock     
       case -2:
            if PREMIUM == 1{
                tmp = 1;
            }
            else{
                tmp = -1;
            }
            break;
       
           
            
       //Not Implemented   
       default:
       
            tmp = -1
            break;
       

}

return tmp;

#define scr_unlocks_get_old_index
///scr_unlocks_get_old_index(data)

var data = argument0;
var type = data[0];
var index = data[7];
var oldIndex = index;

for (var z = 0; z < type - 1; z++) {
    oldIndex += UNLOCKS_DATA_SIZES[z];
}
return oldIndex;