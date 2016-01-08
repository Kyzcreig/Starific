///scr_gameover_buttons_add_adverts(use_rng)

var useRNG = argument0;
var advertRNG = !useRNG or random(1) < .80; 
                        
// Add Video Reward
var mostFeaturesAreUnlocked = scr_unlock_get_status(2,2) != 0; //NB: We do this to avoid having tons of buttons all at once... that's ugly
var pageNotCrowded = (ds_list_size(go_sp_buttons) < 4) or mostFeaturesAreUnlocked;
//var veteranPlaytime = careerPlaytimeTotal > 60*60*1 - lastPlaytime; // gamesPlayedTotal > 2
                                                  //3 //Evaluate me
                                                    
           //Reward Video Available if Few other buttons or Player has already unlocked most settings
           // This way the ad video opportunity increases as the user unlocks more stuff.   
if ADS_REWARD_VIDEOS != "" and //if videos enabled
   pageNotCrowded and //don't crowd page
   //veteranPlaytime and//4 and //don't ask until they're hooked 
   advertRNG 
   //NB: I think the scarcity will encourage clicking video rewards 
   //but I can a/b test this via analytics events
{ // Add Video Reward Button to Gameover
    //show_message("ADS_REWARD_VIDEO_CACHED="+string(ADS_REWARD_VIDEO_CACHED));
    if ADS_REWARD_VIDEO_CACHED // or 1
    { 
        if scr_go_is_button(16) == -1{ // if button not in list
            scr_gameover_add_button(16);
        }
    }
    // Else if No Videos, Use Backup Interstitial 
    else if ADS_INTERSTITIAL_CACHED 
    {
        if scr_go_is_button(19)  == -1{ // if button not in list
            scr_gameover_add_button(19);
        }
        //Attempt to Recache Video Reward
        ads_recache_video();
    }
}
