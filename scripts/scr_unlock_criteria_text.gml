#define scr_unlock_criteria_text
///scr_unlock_criteria_text(data)

//NB: required, file is open.

var data = argument0;
var criteria_type = data[3];
var criteria_quantity = data[4];
var str = "";


switch criteria_type{
       
       //Games played
       case 0:
            str = "play "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" games"
            break;


       //Reach Score
       case 1:
            str = "score "+string_abbrev_real_mag(criteria_quantity, 2, 2)+" points" 
            break;



       //Reach Combo X
       case 2:
            str = "reach combo x"+string(criteria_quantity) + "";
       
       
            break;
       //Reach level
       case 3:
            str = "reach level "+string(criteria_quantity)+"" 
            break;



       //Deflectors Destroyed
       case 4:
            str = "destroy "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" deflectors" 
            break;



       //Bombs Destroyed
       case 5:
            str = "detonate "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" bombs"
            break;



       //Activated Powers
       case 6:
            str = "catch "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" power deflectors" 
            break;


       //Rebound Stars
       case 7:
            str = "rebound "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" stars" 
            break;

       //Unique Stars Seen
       case 8:
            str =  "spawn "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" stars" 
            break;

       //GamesPlayed Arcade [unused]
       case 9:
            str =  "play "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" arcade games" 
            break;
            
       //GamesPlayed Moves
       case 10:
            str =  "play "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" moves games" 
            break;
            
       //GamesPlayed Time
       case 11:
            str =  "play "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" time games" 
            break;
            
       //GamesPlayed Sandbox [unused]
       case 12:
            str =  "play "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" sandbox games" 
            break;
            
       //Career Score
       case 13:
            str =  "accumulate "+string_abbrev_real(max(0,check_stats(criteria_type)),1)+"/"+string_abbrev_real(criteria_quantity,1)+" career score"
            break;
            
       //Game Shared (Friends theme)
       case 14:
            str =  "share a score on gameover"
            break;
            //Maybe add themes for multiple shares
            
       //Game Rated [unused] (used for time mode)
       case 15:
            str =  "rate us in the app store"
            break;
      
           
       //GamesPlayed Size 15x15
       case 16:
            str =  "play "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" small games" 
            break;
            
       //GamesPlayed Size 20x20
       case 17:
            str =  "play "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" medium games" 
            break;
            
       //GamesPlayed Size 25x25 [unused] 
       //(maybe I should use it... I wouldn't want people not playing the best modes and size)
       //Then again I don't think that many people will collect these
       case 18:
            str =  "play "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" large games" 
            break;
            
       //GamesPlayed Size 30x30
       case 19:
            str =  "play "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" giant games" 
            break;
            
          
        //unused 
       case 20:
            break;
            
        //unused 
       case 21:
            break;
            
        //unused 
       case 22:
            break;
            
        //unused 
       case 23:
            break;
            
        // Quest Count
       case 24:
            str =  "complete "+string(max(0,check_stats(criteria_type)))+"/"+string(criteria_quantity)+" quests";
            break;

        // Prize Wheel
       case 25:
            str =  "win from prize wheel"
            break;
            
        // Watch a Video
       case 26:
            str =  "watch a video"
            break;
            
        // Achievement (Grab Achievement Description)
       case 27:
            str = scr_achievement_get_description(criteria_quantity);
            break;
       
        // worst score
       case 28:
            str =  "end a game with at most "+string(criteria_quantity)+" points" 
            break;
       
       
       
       //Default Unlock     
       case -1:
            str = "default unlocked!";
            break;
            
            
       //Premium Unlock     
       case -2:
            //str = "see deluxe edition";
            str = "see deluxe edition!";
            break;
            
            
       // IAP Unlock     
       case -3:
            str = "purchase from shop!";
            break;
       
       
       //Not Implemented   
       default:
       
            str = "not implemented";
            break;
       



}

return str;

#define scr_achievement_get_description
///scr_achievement_get_description(achievement_index);

var str;

switch argument0 {
case 0: 
    str = "cover the entire board with paddle";
break;

case 1:
    str =  "control 4+ paddles at once"
break;



default:
    str = "not implemented";
break;

}




return str;