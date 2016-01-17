///monetization_init()



globalvar 
ADVERTISING, 
ADS_INTERSTITIALS, 
ADS_BANNERS,
ADS_FORCED, 
AD_PROVIDERS,
ADS_MORE_APPS,
ADS_REWARD_VIDEOS,
ADS_REWARD_VIDEO_CACHED,
ADS_INTERSTITIAL_CACHED,
IAP_ENABLED,
PREMIUM, 
VC_ENABLED;


// Declare Vars
PREMIUM = -1; //Controls the No-Ads/Deluxe buttons showing up
    /* value meanings
            -1: premium not relevant
             0: premium locked, show offers for deluxe
             1: premium unlocked
    
    */
VC_ENABLED = 1; //Enable Virtual Currency
IAP_ENABLED = 1 //FIX ME //0;
ADS_FORCED = 0;
AD_PROVIDERS = ""; 
ADS_INTERSTITIALS = ""
ADS_REWARD_VIDEOS = ""; 
ADS_MORE_APPS = "";
ADS_BANNERS = ""; 
ADS_REWARD_VIDEO_CACHED = false;
ADS_INTERSTITIAL_CACHED = false;

// If Mobile
if (os_type == os_ios || os_type == os_android)
{
    //Enable IAPs
    IAP_ENABLED = 1;
    
    // Set Ad Parameters
    if PREMIUM != 1 {
        ADS_FORCED = 1;
        //0 disables ads AND shows "deluxe" button; 
        //1 shows "no-ads" button; 
        //2 shows "deluxe" button;
            //The first weeks of release we'll set this to 0.  
            //If we get a decent amount of downloads then we'll turn it up.
    } else {
        ADS_FORCED = false;
    }
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

if IAP_ENABLED != 0 {
    // Create IAPs Controller
    ScheduleScript(id,true,.2,CreateInstanceIfNone,x,y,obj_control_IAP)
}

if AD_PROVIDERS != "" {
    // Create Ads Objects
    ScheduleScript(id,false,1,ads_init)
}
