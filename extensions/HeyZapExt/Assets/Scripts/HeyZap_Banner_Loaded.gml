if (argument0) {
    global.banner_width = HeyZap_BannerGetWidth();
    global.banner_height = HeyZap_BannerGetHeight();
    show_debug_message("Banner loaded!");
} else {
    show_debug_message("Banner failed to load!");
}
