///ads_show_reward_video();



ads_provider = "ChartBoost";
if string_pos(ads_provider, ADS_REWARD_VIDEOS) != 0 {

    with ( asset_get_index("obj_control_ads_"+ads_provider) ) {
        showRewardedVideo();
    }
}
