#define scr_button_giftReward
///scr_button_giftReward()


analytics_button_counter("giftReward");


//Update Gift Data
ini_open("scores.ini")
    var GIFT_COUNT = ini_read_real("misc", "GIFT_COUNT", 0);
    ini_write_real("misc", "GIFT_COUNT", ++GIFT_COUNT); 
    //Decide when next gift will be
    var giftDelayMinutes = scr_gift_set_time(GIFT_COUNT);
    giftNextTime =  date_inc_minute(date_current_datetime(), giftDelayMinutes);
    ini_write_real("misc", "GIFT_NEXT_TIME", 
       giftNextTime); 
ini_close()  


// Calculate Reward, Set Cash and Execute Confetti
scr_button_reward_helper(14, 1)


// Update Gift Text with Next Gift Time
if giftDelayMinutes > 0{
    // Set Delay
    var easeDelay = .1;
    //Replace our placeholder dialogue with real dialogue
    ScheduleScript(id, 1, easeDelay, scr_go_replace_dialogue, 6, 7);
    
    //Set Dialogue Alpha Easer back by 1
    go_SlideTweenText[0] = (ds_list_size(go_dialogue_txt)-1)/2 +.5;
    var TxtLenEnd = (ds_list_size(go_dialogue_txt))/2 +.5;
    var tempTween = TweenCreate(id, go_SlideTweenText,EaseLinear,
                        TWEEN_MODE_ONCE,true,0,.5, go_SlideTweenText[0],TxtLenEnd)
    TweenDestroyWhenDone(tempTween, true);
                        
    //Schedule Easing Text Alpha In
    ScheduleScript(id, 1, easeDelay, TweenPlay, tempTween);
}

// Add Reward Earned Text To Dialogue
/*
scr_gameover_add_dialogue(  6);        
var TxtLen = ds_list_size(go_dialogue_txt)/2 +.5;
go_TweenSlideText = TweenFire(id, go_SlideTweenText,EaseLinear,
                TWEEN_MODE_ONCE, 1, 0, .5, go_SlideTweenText[0], TxtLen);


// Remove Button from List [disabled]
var rewardButtonIndex = scr_go_is_button(14);
ds_list_delete( go_sp_buttons, rewardButtonIndex)
*/

#define scr_gift_set_time
///scr_gift_set_time(gift_count)



var giftCount = argument0;
var minutesUntilNextGift;
var vals, z;

// Set Viable Times
z = -1;
vals[++z] = 1;
vals[++z] = 2;
vals[++z] = 3;
vals[++z] = 4;
vals[++z] = 5;
vals[++z] = 6;
vals[++z] = 7;
vals[++z] = 8;
vals[++z] = 9;
vals[++z] = 10;
vals[++z] = 15;
vals[++z] = 20;
vals[++z] = 25;
vals[++z] = 30;
vals[++z] = 35;
vals[++z] = 40;
vals[++z] = 45;
vals[++z] = 50;
vals[++z] = 55;
vals[++z] = 60;
vals[++z] = 70;
vals[++z] = 80;
vals[++z] = 90;
vals[++z] = 100;
vals[++z] = 110;
vals[++z] = 120;
/*
vals[++z] = 150;
vals[++z] = 180;
vals[++z] = 210;
vals[++z] = 240;
vals[++z] = 5.0*60;
vals[++z] = 6.0*60;
*/

if giftCount <= z {

    minutesUntilNextGift = vals[giftCount-1]
}
else  {
    minutesUntilNextGift = 2*60; //default 2 hours //6

}

//return minutesUntilNextGift

return minutesUntilNextGift*2 //scale up to 4 hours between gifts.
/*
minutesUntilNextGift = 360; 
*/

/* NB: If we deem it unnecessary to ramp up the gifts because you get video rewards 
then we can switch to always 360 minute gifts

*/