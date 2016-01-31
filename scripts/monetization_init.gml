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
//PREMIUM, 
VC_ENABLED,
CASH_STR;


// Declare Vars
PREMIUM = false; //NB: No longer really used
VC_ENABLED = 1; //Enable Virtual Currency
CASH_STR = "¢";//"$" //NB: Maybe refactor to VC_SYMBOL
IAP_ENABLED = 0;
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
    if CONFIG != CONFIG_TYPE.AMAZON {
        IAP_ENABLED = 1;
    } else {
        IAP_ENABLED = 0; //NB: Fix me when we know better how to get Amazon working
    }
    
    // Set Ad Parameters
    if !PREMIUM {
        ADS_FORCED = true;
    } else {
        ADS_FORCED = false;
    }
    //What Kinds of Ads to show?
    AD_PROVIDERS = "HeyZap"; //"ChartBoost";  //AdMob, 
    /* Holds which ad provider objects to initialize
       e.g. "Admob", "ChartBoost", "HeyZap"
    
    */
    ADS_INTERSTITIALS = "HeyZap"; //"ChartBoost"; //maybe refactor to ADS_STATIC
    ADS_REWARD_VIDEOS = "HeyZap"; //"ChartBoost"; //maybe refactor to ADS_VIDEO
    ADS_MORE_APPS = "";
    ADS_BANNERS = ""; //supposedly people hate banner ads, true they ruin ambience
    
}

if IAP_ENABLED != 0 {
    // Create IAPs Controller
    ScheduleScript(id, true, .2, CreateInstanceIfNone, x, y,obj_control_IAP);
}

if AD_PROVIDERS != "" {
    // Create Ads Objects
    ScheduleScript(id, false, 1, ads_init);
}
