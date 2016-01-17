#define ads_init
///ads_init()

ads_init_helper("HeyZap");
/*
ads_init_helper("AdMob");
ads_init_helper("ChartBoost");

#define ads_init_helper
///ads_init_helper(ads_provider)


ads_provider = argument0;

if string_pos(ads_provider, AD_PROVIDERS) != 0 {

    with ( instance_create(x,y, asset_get_index("obj_control_ads_"+ads_provider)) ) {
    
        // Init Interstitials
        ads_interstitials = string_pos(other.ads_provider, ADS_INTERSTITIALS) != 0
        ads_interstitial_state = 0;
        
        // Init Reward Videos
        ads_reward_videos = string_pos(other.ads_provider, ADS_REWARD_VIDEOS) != 0
        ads_reward_video_state = 0;
        
        // Misc
        ads_banners = string_pos(other.ads_provider, ADS_BANNERS) != 0
        ads_more_apps = string_pos(other.ads_provider, ADS_MORE_APPS) != 0
        ads_provider = other.ads_provider;
        ads_reward_scalar = 0;
        ads_time = 0;
    
    }
}

#define ads_init_ChartBoost
///ads_init_ChartBoost()

/*
//[ChartBoost Disabled]
if (os_type == os_android)
{
    //Chartboost  appId and appSignature
    
    // If Googleplay
    if PLATFORM_SUBTYPE <= 0{
        Init("559c4c3ac909a621844eac49","254938b4aacb3f19b4927e3579fee84302f20b94"); 
        //NB: Make sure the BundleID on ChartBoost.com matches the one you use 
        //    to compile the app.  It can take a day or so to update I believe.
    }
    // IF Amazon
    else if PLATFORM_SUBTYPE == 1 {
        Init("559c4c3ac909a621844eac4a","d85cf6af067c80fc68c81777b194add82ad7690d"); 
        //NB: Make sure the BundleID on ChartBoost.com matches the one you use 
        //    to compile the app.  It can take a day or so to update I believe.
    
    }
        
}
else if (os_type == os_ios)
{ 
    //Chartboost  appId and appSignature

    //If iOS
    Init("559c4c3ac909a621844eac48","bcc19207f92597d6ce1ea1bd0402f739675745e9"); 
        //NB: Make sure the BundleID on ChartBoost.com matches the one you use 
        //    to compile the app.  It can take a day or so to update I believe.
}

//(Optional) cache the ads
ScheduleScript(id, true, 0, ads_cb_cacheInterstitial);
//ScheduleScript(id, true, 1, ads_cb_cacheMoreApps);
ScheduleScript(id, true, 2, ads_cb_cacheRewardedVideo);
ScheduleScript(id, true, 10, ads_cb_cacheRewardedVideo);

#define ads_init_HeyZap
///ads_init_HeyZap()


//[ChartBoost Disabled]
if (os_type == os_android) or (os_type == os_ios)
{ 
    // publisher_id, test_mode
    HeyZap_Init("dc259a87f560c942657155ecb21b98c2",0); 
}

HeyZap_LoadInterstitial();
HeyZap_LoadVideo();
HeyZap_LoadReward();

#define ads_cb_cacheInterstitial
///ads_cb_cacheInterstitial()

/*
//[ChartBoost Disabled]
if !ADS_INTERSTITIAL_CACHED {
    cacheInterstitial();
}

#define ads_cb_cacheMoreApps
///ads_cb_cacheMoreApps()

/*
//[ChartBoost Disabled]
cacheMoreApps();

#define ads_cb_cacheRewardedVideo
///ads_cb_cacheInterstitial()

/*
//[ChartBoost Disabled]
if !ADS_REWARD_VIDEO_CACHED {
    cacheRewardedVideo();
}

#define ads_recache_video
///ads_recache_video()
/* Reloads Video ads for each ad network

*/

with(obj_control_ads_ChartBoost){
    ads_cb_cacheRewardedVideo();
}
with(obj_control_ads_HeyZap){
    HeyZap_LoadVideo();
    HeyZap_LoadReward();
}