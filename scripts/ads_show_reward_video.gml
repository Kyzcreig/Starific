#define ads_show_reward_video
///ads_show_reward_video(reward);


ads_provider = "HeyZap";
if string_pos(ads_provider, ADS_REWARD_VIDEOS) != 0 {

    with ( asset_get_index("obj_control_ads_"+ads_provider) ) {
        // Clear Video Cache Flag
        ADS_REWARD_VIDEO_CACHED = false;
        
        // Show Video Ad
        if HeyZap_RewardStatus() {
            HeyZap_ShowReward();
            // Schedule Recache
            HeyZap_LoadReward(); //ScheduleScript
            //NB: Let's see if this works fine, maybe set it so video ads show up every gameover
            // Or they never go away so we can keep watching them
        } else if HeyZap_VideoStatus() {
            HeyZap_ShowVideo();
            // Schedule Recache
            HeyZap_LoadVideo();
        }
        
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
        // Clear Video Cache Flag
        ADS_INTERSTITIAL_CACHED = false;
        
        // Show Video Ad
        if HeyZap_InterstitialStatus() {
            HeyZap_ShowInterstitial();
            // Schedule Recache
            HeyZap_LoadInterstitial(); //ScheduleScript
            //NB: Let's see if this works fine, maybe set it so video ads show up every gameover
            // Or they never go away so we can keep watching them
        }
        
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
