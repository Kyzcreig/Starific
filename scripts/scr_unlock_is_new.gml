///scr_unlock_is_new(data)

var data = argument0;
//Return whether unlocked and not "Viewed" yet
return (data[1] == 2) and (data[2] <= 0);

/* NB: We only count status 2 as new because we wouldn't be 
//able to decrement the indicators on gameover otherwise when they do show up.
