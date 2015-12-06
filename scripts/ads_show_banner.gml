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
