///scr_config_init()


globalvar 
CONFIG;

enum CONFIG_TYPE {
    DESKTOP,
    HTML,
    IOS,
    ANDROID,
    AMAZON,
    OTHER
}

// Set Config
switch (os_browser){
    case browser_not_a_browser:
        switch (os_type){
            // Desktop Platforms
            case os_windows:
            case os_macosx:
                CONFIG = CONFIG_TYPE.DESKTOP;  
                break;
            // Mobile Platforms
            case os_ios:
                CONFIG = CONFIG_TYPE.IOS; 
                break;
            case os_android:
                switch (PLATFORM_SUBTYPE) {
                    case 0:
                        CONFIG = CONFIG_TYPE.ANDROID; 
                        break;
                    case 1:
                        CONFIG = CONFIG_TYPE.AMAZON; 
                        break;
                    default:
                        CONFIG = CONFIG_TYPE.ANDROID; 
                        break;
                } 
                break;
        }
        break;
    // HTML5 Platforms
    default:
        CONFIG = CONFIG_TYPE.HTML;  
        break;
}

/*
LOOK UP browser_not_a_browser and os_type and replace with the above config stuff
