#define ads_timer_show_interstitial
///ads_timer_show_interstitial()

ads_timer_show_interstitial_helper("AdMob");
ads_timer_show_interstitial_helper("ChartBoost");


#define ads_timer_show_interstitial_helper
///ads_timer_show_interstitial_helper(ads_provider)
/*  We use this script to display extra interstitial ads in the menu pages
    It runs whenever you enter a new room, and sets an ad to be shown 3 seconds later
    So the room intro animation has time to finish

*/


ads_provider = argument0;
if string_pos(ads_provider, AD_PROVIDERS) != 0 {
    with ( asset_get_index("obj_control_ads_"+ads_provider) )  { 
        // Check if interstitials enabled and if time for an Ad
        if ads_interstitials and ads_time > 10 * 60 * room_speed //and !interstitals_requested 
                                                            //Adaptive prompting
        {      
            //Display Interstitial 3 second delay (so room tween intro finishes)
            ScheduleScript(id,1,3,array_set_index_1d,global.interShow,0,1) 
                        /*  NB: I tried to design a queued ad system with global.interShow
                            but it just deplays them all at once
                            So instead, we use this external timer system.                    
                        
                        */
           
        }
    }
}