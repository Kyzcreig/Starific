#define scr_quest_text
///scr_quest_text(use_brief?, adjust_qProg)

var useBrevity = argument[0];


var qType = QUEST_DATA[0];
var qCrit = QUEST_DATA[1];
var qProgAdjust = 0;
if argument_count > 1 {
    qProgAdjust = argument[1];
}
var qProg = clamp(QUEST_DATA[2]+qProgAdjust, 0, qCrit); // keep prog val clamped


// Get Quest Type
switch qType {
    
      
       //Games played
       case 0:
            if !useBrevity {
                str = "Play "+scr_quest_text_format(qType,qProg,qCrit)+" games!"
            }
            else {
                str = scr_quest_text_format(qType,qProg,qCrit)+" games"
            }
            
       break;


       //Reach Score
       case 1:
            if !useBrevity {
                str = "Score "+ string_abbrev_real(qProg,0)+"/"
                    +string_abbrev_real(qCrit,0)+" points!"
            }
            else {
                str = string_abbrev_real(qProg,0)+"/"
                    +string_abbrev_real(qCrit,0)+" points"
            }
       break;
       
       
       //Reach Combo [unused]
       case 2:
            if !useBrevity {
                str = "Make "+scr_quest_text_format(qType,qProg,qCrit)+" combos!"
            }
            else {
                str = scr_quest_text_format(qType,qProg,qCrit)+" combos"
            }
            
       break;
       
       
       //Reach level
       case 3:
            if !useBrevity {
            str = "Level up "+scr_quest_text_format(qType,qProg,qCrit)+" times!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" level ups"
            }
       break;

       //Deflectors Destroyed
       case 4:
            if !useBrevity {
            str = "Destroy "+scr_quest_text_format(qType,qProg,qCrit)+" Deflectors!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Deflectors"
            }
       break;

       //Bombs Destroyed
       case 5:
            if !useBrevity {
            str = "Detonate "+scr_quest_text_format(qType,qProg,qCrit)+" Bombs!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Bombs"
            }
       break;

       //Triggered Powers
       case 6:
            if !useBrevity {
            str = "Trigger "+scr_quest_text_format(qType,qProg,qCrit)+" Power Projectiles!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Projectiles"
            }
       break;


       //Rebound Stars
       case 7:
            if !useBrevity {
            str = "Rebound "+scr_quest_text_format(qType,qProg,qCrit)+" Stars!"
            }
            else {
            str = "Rebound "+scr_quest_text_format(qType,qProg,qCrit)+" Stars"
            }
       break;
       
       //Unique Stars Seen/Spawned
       case 8:
            if !useBrevity {
            str = "Spawn "+scr_quest_text_format(qType,qProg,qCrit)+" Stars!"
            }
            else {
            str = "Spawn "+scr_quest_text_format(qType,qProg,qCrit)+" Stars"
            }
       break;

       //GamesPlayed Arcade [unused]
       case 9:
            if !useBrevity {
            str = "Play "+scr_quest_text_format(qType,qProg,qCrit)+" Arcade Mode games!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Arcade games"
            }
       break;
            
       //GamesPlayed Moves
       case 10:
            if !useBrevity {
            str = "Play "+scr_quest_text_format(qType,qProg,qCrit)+" Moves Mode games!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Moves games"
            }
       break;
            
       //GamesPlayed Time
       case 11:
            if !useBrevity {
            str = "Play "+scr_quest_text_format(qType,qProg,qCrit)+" Time Mode games!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Time games"
            }
       break;
            
       //GamesPlayed Sandbox [unused]
       case 12:
            if !useBrevity {
            str = "Play "+scr_quest_text_format(qType,qProg,qCrit)+" Sandbox Mode games!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Sandbox games"
            }
       break;
       
       //GamesPlayed Size 15x15
       case 13:
            if !useBrevity {
            str = "Play "+scr_quest_text_format(qType,qProg,qCrit)+" Small Grid games! (Select in Options)"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Small games"
            }
       break;
            
       //GamesPlayed Size 20x20
       case 14:
            if !useBrevity {
            str = "Play "+scr_quest_text_format(qType,qProg,qCrit)+" Medium Grid games! (Select in Options)"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Medium games"
            }
            
       break;
            
       //GamesPlayed Size 25x25 [unused] 
       case 15:
            if !useBrevity {
            str = "Play "+scr_quest_text_format(qType,qProg,qCrit)+" Large Grid games! (Select in Options)"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Large size games"
            }
       break;
            
       //GamesPlayed Size 30x30
       case 16:
            if !useBrevity {
            str = "Play "+scr_quest_text_format(qType,qProg,qCrit)+" Giant Grid games! (Select in Options)"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Giant games"
            }
       break;
       
       //Collect Grow Paddles
       case 17:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Bigger Paddles!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Bigger Paddles"
            }
       break;
       //Collect Shrink Paddles
       case 18:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Smaller Paddles!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Smaller Paddles"
            }
       break;
       //Collect Slower Stars
       case 19:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Slower Stars!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Slower Stars"
            }
       break;
       //Collect Faster Stars
       case 20:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Faster Stars!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Faster Stars"
            }
       break;
       //Collect Mirror Paddles
       case 21:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Mirror Paddles!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Mirror Paddles"
            }
       break;
       //Collect Big Stars
       case 22:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Super Stars!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Super Stars"
            }
       break;
       //Collect Turn Modifiers
       case 23:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Turn Modifiers!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Turn Modifiers"
            }
       break;
       //Collect Freeze Paddles
       case 24:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Freeze Paddles!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Freeze Paddles"
            }
       break;
       //Collect Split Paddles
       case 25:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Split Paddles!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Split Paddles"
            }
       break;
       //Collect Slow Paddles
       case 26:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Slow Paddles!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Slow Paddles"
            }
       break;
            
       //Collect (Any) Powers
       case 27:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Power Deflectors!"
            }
            else {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Powers"
            }
       break;
       
       //Collect Board Clears
       case 28:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Board Clears!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Board Clears"
            }
       break;
       
       //Collect Board Fills
       case 29:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Board Fills!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Board Fills"
            }
       break;
       
       //Collect Uppers
       case 30:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Uppers!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Uppers"
            }
       break;
       
       //Collect Downers
       case 31:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Downers!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Downers"
            }
            
       break;
       //Collect Rounders
       case 32:
            if !useBrevity {
            str = "Collect "+scr_quest_text_format(qType,qProg,qCrit)+" Rounders!"
            }
            else {
            str = scr_quest_text_format(qType,qProg,qCrit)+" Rounders"
            }
       break;
       
       //Survive Time
       case 33:
            if !useBrevity {
            str = "Survive for "+scr_quest_text_format(qType,qProg,qCrit)+"!"
            }
            else {
            str = "Survive " + scr_quest_text_format(qType,qProg,qCrit)+""
            }
       break;
       //Not Implemented   
       default:
            str = "Not Implemented"
       break;

}

return str;

#define scr_quest_text_format
///scr_quest_text_format(quest_type, progress, criteria)




var qType = argument0;
var qProg = argument1; // keep prog val clamped
var qCrit = argument2;
var str = "";

// Get Quest Type
switch qType {
    
      
       //Games played
       case 0:
       
            str = string(qProg)+"/"+string(qCrit);
            
       break;


       //Reach Score
       case 1:
       
            str = string_abbrev_real_mag(qProg,2,2)+"/"+string_abbrev_real_mag(qCrit,2,2);
       break;
       
       
       //Reach Combo [unused]
       case 2:
       
            str = string(qProg)+"/"+string(qCrit);
            
       break;
       
       
       //Reach level
       case 3:
       
            str = string(qProg)+"/"+string(qCrit);
       break;

       //Deflectors Destroyed
       case 4:
       
            str = string(qProg)+"/"+string(qCrit);
       break;

       //Bombs Destroyed
       case 5:
       
            str = string(qProg)+"/"+string(qCrit);
       break;

       //Triggered Powers
       case 6:
       
            str = string(qProg)+"/"+string(qCrit);
       break;


       //Rebound Stars
       case 7:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       
       //Unique Stars Seen/Spawned
       case 8:
       
            str = string(qProg)+"/"+string(qCrit);
       break;

       //GamesPlayed Arcade [unused]
       case 9:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
            
       //GamesPlayed Moves
       case 10:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
            
       //GamesPlayed Time
       case 11:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
            
       //GamesPlayed Sandbox [unused]
       case 12:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       
       //GamesPlayed Size 15x15
       case 13:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
            
       //GamesPlayed Size 20x20
       case 14:
       
            str = string(qProg)+"/"+string(qCrit);
            
       break;
            
       //GamesPlayed Size 25x25 [unused] 
       case 15:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
            
       //GamesPlayed Size 30x30
       case 16:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       
       //Collect Grow Paddles
       case 17:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       //Collect Shrink Paddles
       case 18:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       //Collect Slower Stars
       case 19:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       //Collect Faster Stars
       case 20:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       //Collect Mirror Paddles
       case 21:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       //Collect Big Stars
       case 22:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       //Collect Turn Changers
       case 23:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       //Collect Freeze Paddles
       case 24:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       //Collect Split Paddles
       case 25:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       //Collect Slow Paddles
       case 26:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
            
       //Collect (Any) Powers
       case 27:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       
       //Collect Board Clears
       case 28:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       
       //Collect Board Fills
       case 29:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       
       //Collect Uppers
       case 30:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       
       //Collect Downers
       case 31:
       
            str = string(qProg)+"/"+string(qCrit);
            
       break;
       //Collect Rounders
       case 32:
       
            str = string(qProg)+"/"+string(qCrit);
       break;
       
       // Survive Time
       case 33:
            str = time_decode_opt_custom(0, 1, 1, qProg, 60)+"/"+time_decode_opt_custom(0, 1, 1, qCrit, 60);
       break;
       //Not Implemented   
       default:
            str = ""
       break;

}

return str;