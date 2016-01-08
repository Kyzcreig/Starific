#define scr_leaderboard_post_score
///scr_leaderboard_post_score()

ach_custom_post_score();



#define get_leaderboard_id
///get_leaderboard_id(mode, size)

var leaderboard_id = "";

switch os_type {

case os_ios:

    leaderboard_id = get_ios_leaderboard(argument0, argument1);

break;


case os_android:
    leaderboard_id = get_android_leaderboard(argument0, argument1);
    /* NB: Why don't we use platform subtype?  Because I used the same names
        For both the Amazon and Googleplay leaderboards.
    */
    
break;

default:

//TO DO custom leaderboard stuff here

break;


}



return leaderboard_id;

#define get_ios_leaderboard
///get_ios_leaderboard(mode, size)


var l_mode, l_size, l_id;
l_mode = argument0;
l_size = argument1;
l_id = "grp.";

switch l_mode{
     case 0:
          l_id += "arcade"+"_";
          break;
     case 1:
          l_id += "moves"+"_";
          break;
     case 2:
          l_id += "time"+"_";
          break;
     case 3:
          l_id += "sandbox"+"_";
          break;
}
switch l_size{
     case 0:
          l_id += "15";
          break;
     case 1:
          l_id += "20";
          break;
     case 2:
          l_id += "25";
          break;
     case 3:
          l_id += "30";
          break;
}


return l_id;

#define get_android_leaderboard
///get_android_leaderboard(mode, size)

var leaderboard_id = "";
var an_boards = noone;
var i = -1;
var l_mode = argument0;
var l_size = argument1;

//Arcade
an_boards[++i] = "CgkI6tXG2t0IEAIQBw"
an_boards[++i] = "CgkI6tXG2t0IEAIQCA"
an_boards[++i] = "CgkI6tXG2t0IEAIQCQ"
an_boards[++i] = "CgkI6tXG2t0IEAIQCg"
//Moves
an_boards[++i] = "CgkI6tXG2t0IEAIQCw"
an_boards[++i] = "CgkI6tXG2t0IEAIQDA"
an_boards[++i] = "CgkI6tXG2t0IEAIQDQ"
an_boards[++i] = "CgkI6tXG2t0IEAIQDg"
//Time
an_boards[++i] = "CgkI6tXG2t0IEAIQEA"
an_boards[++i] = "CgkI6tXG2t0IEAIQEQ"
an_boards[++i] = "CgkI6tXG2t0IEAIQEg"
an_boards[++i] = "CgkI6tXG2t0IEAIQEw"
//Sandbox
an_boards[++i] = "CgkI6tXG2t0IEAIQFA"
an_boards[++i] = "CgkI6tXG2t0IEAIQFQ"
an_boards[++i] = "CgkI6tXG2t0IEAIQFg"
an_boards[++i] = "CgkI6tXG2t0IEAIQFw"

var index = l_mode*4 + l_size; 
    //NB: The order here is different from our stat section convert script stuff

leaderboard_id = an_boards[index];  


return leaderboard_id;