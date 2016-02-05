#define scr_gameover_buttons_add_adverts
///scr_gameover_buttons_add_adverts(use_rng)

var useRNG = argument0;
var advertRNG = !useRNG or random(1) < .75; 
                        
// Add Video Reward
var pageNotCrowded = (ds_list_size(go_sp_buttons) < 4);
//var veteranPlaytime = careerPlaytimeTotal > 60*60*4 - lastPlaytime; // gamesPlayedTotal > 2
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
    if ads_video_is_cached() // or 1
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

#define scr_gameover_buttons_add_forced_ads
///scr_gameover_buttons_add_forced_ads()

var pageNotCrowded = (ds_list_size(go_sp_buttons) < 5);

 // Toggle Forced Interstitial
 if ADS_INTERSTITIALS != "" and 
    ADS_INTERSTITIAL_CACHED and 
    ADS_FORCED != 0 and 
    pageNotCrowded and
    !rate_prompt[0]
{
    var alternateGames = gamesPlayed mod 2 == 0; // every other game
    var minPlaytimeForAd = lastPlaytime >= 60 * 60 * .5; // 30 seconds of play
    var forcedRNG = random(1) < .5;  //( 1 - clamp(lastPlaytime / minPlaytimeForAd, 0, 1)); 
    if (alternateGames and (forcedRNG or minPlaytimeForAd))
    {
                    //NB: Evaluate our much more aggressive advertising on android first
        // Flag To Show Interstitial Ad
        forced_ads_prompt[0] = true;
         // Add No-Ads Button to Gameover
         if scr_go_is_button(7) == -1{ // if button not in list
             scr_gameover_add_button(7);
         }
    
    }
}