///ads_show_interstitial(ads_provider)


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
