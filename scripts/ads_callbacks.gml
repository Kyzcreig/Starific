#define ads_callbacks
///ads_callbacks()

//Guardian Clause
if !ds_exists(async_load,ds_type_map) or ds_map_empty(async_load) {
    exit;
}

if string_pos(ads_provider, AD_PROVIDERS) != 0 {
    switch ads_provider {
    
    case "AdMob" :
        ads_callbacks_AdMob();
    break;
    
    
    case "ChartBoost" :
        ads_callbacks_ChartBoost();
    break;
    
    case "HeyZap" :
        ads_callbacks_HeyZap();
    break;
    
    }
}

#define ads_callbacks_HeyZap
///ads_callbacks_HeyZap()



show_debug_message("GM Social Async Event...");

// Get Callback Data
var type = string(ds_map_find_value(async_load, "type"));
var value = ds_map_find_value(async_load, "value");

if (type == "heyzap_ad_loaded") {
    if value {
        if HeyZap_InterstitialStatus() {
            ADS_INTERSTITIAL_CACHED = true;
        }
        if HeyZap_VideoStatus() {
            ADS_REWARD_VIDEO_CACHED = true;
        }
    } 
} else if (type == "heyzap_reward") {
    if value {
        if HeyZap_RewardStatus() {
            ADS_REWARD_VIDEO_CACHED = true;
        }
    }
} else if (type == "heyzap_banner_loaded") {
    if value {
        // pass
    }
} 









#define ads_callbacks_AdMob
///ads_callbacks_AdMob()

show_debug_message("AdMob Social Async Event...");

var ads_type = string(ds_map_find_value(async_load, "type" ));
var loaded = ds_map_find_value(async_load, "loaded");  

switch ads_type {

case "banner_load" :
    if (loaded)
    {
        var bw = ds_map_find_value(async_load, "width");
        var bh = ds_map_find_value(async_load, "height");
        
        show_debug_message("Banner loaded: size=" + string(bw) + "," + string(bh) );
        
        // Centre the ad on the screen (override what's in the AddBanner button code)
        //var px = (display_get_width() - bw)/2;
        //var py = (display_get_height() - bh/2)///2;
        //GoogleMobileAds_MoveBanner(px, py);
        //show_debug_message("Banner moved via Social event to " + string(px) + "," + string(py) );
        
        /*
         The commented-out lines above are what we would have to do for some other ad providers if
         we wanted to load a banner at a specified location. The code is here for Google also just 
         to demonstrate how you can still use the event to control positioning ads with this provider.
        */
    }
    else { show_debug_message("Banner failed to load!"); }

break;

case "interstitial_load" :
    global.interLoading = false; 
    global.interLoaded = true;
    
    if (loaded) { show_debug_message("Interstitial loaded"); }
    else { show_debug_message("Interstitial failed to load!"); }
break;



}

#define ads_callbacks_ChartBoost
///ads_callbacks_ChartBoost()

// Get Callback type
var callback_type = async_load[? "type"];


// Debugging
var debugging = true;
if debugging {
    ads_callbacks_ChartBoost_debug(callback_type, "Interstitial")
    ads_callbacks_ChartBoost_debug(callback_type, "MoreApps")
    ads_callbacks_ChartBoost_debug(callback_type, "RewardedVideo")
}







////////REWARDED VIDEOS////////////////

// Reward Video Re-Attempt Cache
if callback_type == "didFailToLoadRewardedVideo"
{
    result = async_load[? "value"];
    
    // Detect if Rewarded Video Cached
    if result == 1 {
        //ScheduleScript(id, true, 15, ads_cb_cacheRewardedVideo); 
            //NB: might use this if chartboost has issues
    }
} 
// Reward Video Set Cached
if callback_type == "didCacheRewardedVideo"
{
    result = async_load[? "value"];
    
    // Detect if Rewarded Video Cached
    if result == 1 {
        ADS_REWARD_VIDEO_CACHED = 1;
    }
} 

// Reward Video Set Displayed (uncache)
if callback_type == "didDisplayRewardedVideo"
{
    result = async_load[? "value"];
    
    // Detect if Rewarded Video Displayed
    if result == 1 {
        ADS_REWARD_VIDEO_CACHED = 0;
    }
} 

// Reward Video Set Complete
if callback_type == "didCompleteRewardedVideo"
{
    result = async_load[? "value"];
    
    // Detect if Rewarded Video Completed
    if result == 1 {
        ads_reward_video_state = max(ads_reward_video_state,1);
    }
} 


// Reward Video Set Clicked
if callback_type == "didClickRewardedVideo"
{
    result = async_load[? "value"];
    
    // Detect if Rewarded Video Completed
    if result == 1 {
        ads_reward_video_state = max(ads_reward_video_state,2);
    }
} 


// Reward Video Give Reward
if callback_type == "didCloseRewardedVideo" 
{
    result = async_load[? "value"];
    
    // Detect if Rewarded Video Completed
    if result == 1 and ads_reward_video_state > 0 {
        // Set Reward Weight
        switch ads_reward_video_state {
            case 1:
                ads_reward_scalar = 1.5;
                break;
            case 2: //was clicked, give more reward
                ads_reward_scalar = 3;
                break;
        }
        // Clear Reward State
        ads_reward_video_state = 0;
        // Calculate Reward, Set Cash and Execute Confetti
        with (obj_control_gameover ){
            scr_button_reward_helper(16, other.ads_reward_scalar)//1.5) //1
        }
    }

}







////////INTERSTITIALS////////////////




// Interstitial Set Cached
if callback_type == "didCacheInterstitial"
{
    result = async_load[? "value"];
    
    // Detect if Interstitial Cached
    if result == 1 {
        ADS_INTERSTITIAL_CACHED = 1;
    }
} 

// Interstitial Set Displayed (uncache)
if callback_type == "didDisplayInterstitial"
{
    result = async_load[? "value"];
    
    // Detect if Interstitial Displayed
    if result == 1 {
        // Flag Uncache
        ADS_INTERSTITIAL_CACHED = 0;
        // Set Interstitial Seen
        ads_interstitial_state = max(ads_interstitial_state,1); //set reward
    }
} 

// Interstitial Set Displayed (uncache)
if callback_type == "didClickInterstitial"
{
    result = async_load[? "value"];
    
    // Detect if Interstitial Displayed
    if result == 1 {
        ads_interstitial_state = max(ads_interstitial_state,2); //set reward
    }
} 


// Interstitial Give Reward
if callback_type == "didCloseInterstitial"
{
    result = async_load[? "value"];
    
    // Detect if Interstitial Completed
    if result == 1 and ads_interstitial_state > 0 {
        // Set Reward Weight
        switch ads_interstitial_state {
            case 1:
                ads_reward_scalar = 1;//.5;
                break;
            case 2:  //was clicked, give more reward
                ads_reward_scalar = 2;//1;
                break;
        }
        // Clear Reward State
        ads_interstitial_state = 0;
        
        // Calculate Reward, Set Cash and Execute Confetti
        with (obj_control_gameover ){
            scr_button_reward_helper(19, other.ads_reward_scalar)
        }
    }

}







// Reinit if Failed to Initialize?
if callback_type != undefined {
    if string_pos("didFailToLoad",callback_type) != 0
    {
        //ads_init_ChartBoost();
        //NB: we'll see if this causes any bug
    }
}

#define ads_callbacks_ChartBoost_debug
///ads_callbacks_ChartBoost_debug(ad_type, debugMsgLvl)

var callbackType = argument[0]
var adType = argument[1];
var debugMsgLvl = 1;
if argument_count > 2 {
    debugMsgLvl = argument[2];
}
debugMsg = "";


if (callbackType=="shouldRequest"+adType)
{
    result = async_load[? "value"];
    debugMsg = "shouldRequest"+adType+": "+string(result);
    ads_callbacks_ChartBoost_debug_helper(debugMsgLvl, debugMsg);
}
else if (callbackType=="shouldDisplay"+adType)
{
    result = async_load[? "value"];
    debugMsg = "shouldDisplay"+adType+": "+string(result);
    ads_callbacks_ChartBoost_debug_helper(debugMsgLvl, debugMsg);
}
else if (callbackType=="didCache"+adType)
{
    result = async_load[? "value"];
    debugMsg = "didCache"+adType+": "+string(result);
    ads_callbacks_ChartBoost_debug_helper(debugMsgLvl, debugMsg);
}
else if (callbackType=="didFailToLoad"+adType)
{
    result = async_load[? "value"];
    debugMsg = "didFailToLoad"+adType+": "+string(result);
    ads_callbacks_ChartBoost_debug_helper(debugMsgLvl, debugMsg);
}
else if (callbackType=="didDismiss"+adType)
{
    result = async_load[? "value"];
    debugMsg = "didDismiss"+adType+": "+string(result);
    ads_callbacks_ChartBoost_debug_helper(debugMsgLvl, debugMsg);
}
else if (callbackType=="didClose"+adType)
{
    result = async_load[? "value"];
    debugMsg = "didClose"+adType+": "+string(result);
    ads_callbacks_ChartBoost_debug_helper(debugMsgLvl, debugMsg);
}
else if (callbackType=="didClick"+adType)
{
    result = async_load[? "value"];
    debugMsg = "didClick"+adType+": "+string(result);
    ads_callbacks_ChartBoost_debug_helper(debugMsgLvl, debugMsg);
}
else if callbackType == "didDisplay"+adType
{
    result = async_load[? "value"];
    debugMsg = "didDisplay"+adType+": "+string(result);
    ads_callbacks_ChartBoost_debug_helper(debugMsgLvl, debugMsg);
} 
else if callbackType == "didComplete"+adType
{
    result = async_load[? "value"];
    debugMsg = "didDisplay"+adType+": "+string(result);
    ads_callbacks_ChartBoost_debug_helper(debugMsgLvl, debugMsg);
} 
else if callbackType == "didFailToRecordClick"
{
    result = async_load[? "value"];
    debugMsg = adType+": didFailToRecordClick: "+string(result);
    ads_callbacks_ChartBoost_debug_helper(debugMsgLvl, debugMsg);
} 
else if callbackType == "willDisplayVideo"
{
    result = async_load[? "value"];
    debugMsg = adType+": willDisplayVideo: "+string(result);
    ads_callbacks_ChartBoost_debug_helper(debugMsgLvl, debugMsg);
} 





#define ads_callbacks_ChartBoost_debug_helper
///ads_callbacks_ChartBoost_debug_helper(msgType, message)

var msgType = argument0;
var msg = argument1;

if msgType == 1{
    show_debug_message(msg);
}
else if msgType == 2 {
    show_message(msg);
}
else if msgType == 3 {
    show_debug_message(msg);
    show_message(msg);
}