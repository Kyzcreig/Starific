#define ads_show_reward_video
///ads_show_reward_video(reward);


ads_provider = "HeyZap";
if string_pos(ads_provider, ADS_REWARD_VIDEOS) != 0 {

    with ( asset_get_index("obj_control_ads_"+ads_provider) ) {
        
        // Show Video Ad
        if HeyZap_RewardStatus() {
            HeyZap_ShowReward();
            // Schedule Recache
            //HeyZap_LoadReward(); // //NB: Auto Fetch is on
            //NB: Let's see if this works fine, maybe set it so video ads show up every gameover
            // Or they never go away so we can keep watching them
        } else if HeyZap_VideoStatus() {
            HeyZap_ShowVideo();
            // Schedule Recache
            //HeyZap_LoadVideo(); // //NB: Auto Fetch is on
        }
        // Clear Video Cache Flag
        ADS_REWARD_VIDEO_CACHED = false;
        
        // If Reward
        if argument0{
            // Calculate Reward, Set Cash and Execute Confetti
            with (obj_control_gameover){
                scr_button_reward_helper(16, 1.5, true)
            }
        }
    }
}

/*

ads_provider = "ChartBoost";
if string_pos(ads_provider, ADS_REWARD_VIDEOS) != 0 {

    with ( asset_get_index("obj_control_ads_"+ads_provider) ) {
        showRewardedVideo();
    }
}

#define ads_show_interstitial
///ads_show_interstitial(reward)

ads_provider = "HeyZap";
if string_pos(ads_provider, ADS_INTERSTITIALS) != 0 {

    with ( asset_get_index("obj_control_ads_"+ads_provider) ) {
        
        // Show Video Ad
        if HeyZap_InterstitialStatus() //ADS_INTERSTITIAL_CACHED//
        {
            HeyZap_ShowInterstitial();
            // Schedule Recache
            //HeyZap_LoadInterstitial(); //NB: Auto Fetch is on
        }
        // Clear Video Cache Flag
        ADS_INTERSTITIAL_CACHED = false;
        
        // If Reward
        if argument0{
            // Calculate Reward, Set Cash and Execute Confetti
            with (obj_control_gameover){
                scr_button_reward_helper(19, 1, true)//.75
            }
        }
        
    }
}

/*
//[ChartBoost Disabled]
ads_provider = "ChartBoost";
if string_pos(ads_provider, ADS_INTERSTITIALS) != 0 {

    with ( asset_get_index("obj_control_ads_"+ads_provider) ) {
        showInterstitial();
    }
}


/*
ads_provider = "AdMob";
if string_pos(ads_provider, ADS_INTERSTITIALS) != 0 {

    with ( asset_get_index("obj_control_ads_"+ads_provider) ) {
       GoogleMobileAds_ShowInterstitial();
    }
}

    /*
switch argument0 {

case "AdMob" :
    if global.interShow[0] > 0 and is_string(GoogleMobileAds_InterstitialStatus()) {
       if (GoogleMobileAds_InterstitialStatus() == "Ready") {
           GoogleMobileAds_ShowInterstitial();
           global.interShow[0] -= 1; //Decrement for 1 showing
           global.interLoaded = false;
           
           //Reset Ads Time
           ads_time = 0;
            
           //Update Analytics
           if ANALYTICS{
              ana_GP[3] += 1;  //interstitials shown
           }
       }
    }
    break;

case "ChartBoost" :
    if global.interShow[0] > 0 {
    
        showInterstitial();
    
        global.interShow[0] -= 1; //Decrement for 1 showing
        //Reset Ads Time
        ads_time = 0;
         
        //Update Analytics
        if ANALYTICS{
           ana_GP[3] += 1;  //interstitials shown
        }
    
    }

break;
    
    
}

    */

#define ads_show_banner
///ads_show_banner()
/*
ads_provider = "AdMob";
if string_pos(ads_provider, AD_PROVIDERS) != 0 {
    with(asset_get_index("obj_control_ads_"+ads_provider)){
        // Call our ad 
        show_debug_message("Add banner");
        //GoogleMobileAds_AddBanner(global.bannerId, GoogleMobileAds_Banner);
        GoogleMobileAds_AddBanner(global.bannerId, GoogleMobileAds_SmartBannerPortrait);
        
        // Position it at bottom right of screen
        var bw = GoogleMobileAds_BannerGetWidth();
        var bh = GoogleMobileAds_BannerGetHeight();
        //var px = GAME_X + GAME_W/2//display_get_width()-bw;
        //var py = GAME_H + GAME_H/2//display_get_height()-bh;
        var px = display_get_width()-bw;
        var py = display_get_height()-bh;
        GoogleMobileAds_MoveBanner(px, py);
        show_debug_message("Moving banner: " + string(px) + "," + string(py));
        
        global.bannerShow = true;
        //NB: if the early lag on play initialization is not good we can load the banner ad from the star
        //but move it out of view until gameplay begins, then move it back into view.
        
        //But for now I think it's ok.
    }
}
*/

#define ads_remove_banner
///ads_remove_banner()

/*
ads_provider = "AdMob";
if string_pos(ads_provider, AD_PROVIDERS) != 0 {
    with(asset_get_index("obj_control_ads_"+ads_provider)){
        show_debug_message("Remove banner");
        GoogleMobileAds_RemoveBanner();
        
        global.bannerShow = false;
    
    }
}
*/