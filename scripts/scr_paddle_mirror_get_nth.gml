#define scr_paddle_mirror_get_nth
///scr_paddle_mirror_get_nth(array_of_mirrors, n)
/*  returns the nth non-tweening mirror from an array of mirrors.


*/

var arr = argument0;
// If Not Array
if !is_array(arr) {
    // Return Noone
    return noone;
}

// Which Mirror to Return
var n = argument1;
var total = array_length_1d(arr);


// With Each Mirror Paddle
for (var z = 0; z < total; z++){ 
    // If Not Tweening Out
    if !arr[z].tweeningOut {
        // If Countdown Hasn't Reached Zero
        if n != 0{
            // Decrement Mirror Countdown
            n--;
        }
        // Else We Found Our Mirror
        else {
            return arr[z]
        }
    } 
} 
            
            


#define scr_power_get_quick_deplete_value
///scr_power_get_quick_deplete_value()


return railOverload * .75 * global.ActiveStarCount;

    /*NB: I found it doesn't really matter if the board is covered and
        there's lots of stars.  So we should only decrement based on star counts.
        
        I tried using the power count but it wasn't as good for some of the rarer powerups.
    */