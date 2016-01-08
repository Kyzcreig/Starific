///ads_gamestart()


globalvar 
ADVERTISING, 
ADS_INTERSTITIALS, 
ADS_BANNERS, 
AD_PROVIDERS,
ADS_MORE_APPS,
ADS_REWARD_VIDEOS,
ADS_REWARD_VIDEO_CACHED,
ADS_INTERSTITIAL_CACHED;

    
if (os_type == os_ios || os_type == os_android) and !PREMIUM{

    ADVERTISING = 1;
        //0 disables ads AND shows "deluxe" button; 
        //1 shows "no-ads" button; 
        //2 shows "deluxe" button;
            //The first weeks of release we'll set this to 0.  
            //If we get a decent amount of downloads then we'll turn it up.
 
    //What Kinds of Ads to show?
    AD_PROVIDERS = "HeyZap"; //"ChartBoost";  //AdMob, 
    /* Holds which ad provider objects to initialize
       e.g. "Admob", "ChartBoost", "HeyZap"
    
    */
    ADS_INTERSTITIALS = "HeyZap"; //"ChartBoost"; 
    ADS_REWARD_VIDEOS = "HeyZap"; //"ChartBoost"; 
    ADS_MORE_APPS = "";
    ADS_BANNERS = ""; //supposedly people hate banner ads, true they ruin ambience
}
else {
    ADVERTISING = 0;
    AD_PROVIDERS = ""; 
    ADS_INTERSTITIALS = ""
    ADS_REWARD_VIDEOS = ""; 
    ADS_MORE_APPS = "";
    ADS_BANNERS = ""; 
}
ADS_REWARD_VIDEO_CACHED = false;
ADS_INTERSTITIAL_CACHED = false;

// Create Ads Objects
if ADVERTISING{
    ScheduleScript(id,0,1,ads_init)
}
