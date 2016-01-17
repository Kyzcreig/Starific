#define scr_button_rate
///scr_button_rate()


analytics_button_counter("gameRated");


ini_open("scores.ini")
    RATE_COUNT = ini_read_real("misc", "RATE_COUNT", 0);
    //Increment Rate count
    ini_write_real("misc", "RATE_COUNT", ++RATE_COUNT);
    //Decide when next rate prompt will be available
    var rateDelayDays= scr_rate_set_time(RATE_COUNT);
    rateNextTime =  date_inc_day(date_current_datetime(), rateDelayDays);
    // Save Next Rate Date
    ini_write_real("misc", "RATE_NEXT_TIME", rateNextTime); 
ini_close();



if PREMIUM == 1{
   //Premium app store link
   url_open_ext(PREMIUM_APP_URL,URL_TARGET)//"_blank")
}
else{
    // Normal Appstore link
   url_open_ext(FREE_APP_URL,URL_TARGET)
} 


// Give Reward on Gameover Rating
if GAMEOVER {
    // Calculate Reward, Set Cash and Execute Confetti
    //scr_button_reward_helper(6)
        //NB: Rewarding rating is against store policy
}


#define scr_rate_set_time
///scr_rate_set_time(rate_count)



var rateCount = argument0;
var daysUntilNextRate;
var vals, z;
daysUntilNextRate = 30;
return daysUntilNextRate

/*
// Set Viable Times
z = -1;
vals[++z] = 5;
vals[++z] = 10;
vals[++z] = 15;
vals[++z] = 20;
vals[++z] = 30;
vals[++z] = 45;
vals[++z] = 60;
vals[++z] = 1.5*60;
vals[++z] = 2.0*60;
vals[++z] = 3.0*60;
vals[++z] = 4.0*60;
vals[++z] = 5.0*60;

if giftCount <= z {

    daysUntilNextRate = vals[z]
}
else  {
    daysUntilNextRate = 6*60; //default 6 hours

}

return daysUntilNextRate
*/