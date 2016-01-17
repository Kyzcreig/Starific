///set_promotion_urls_gamestart()


globalvar FREE_APP_URL, PREMIUM_APP_URL, LANDING_PAGE_URL, COMPANY_URL;

LANDING_PAGE_URL = "http://StarificGame.com/";
COMPANY_URL = "http://BeveledEdge.co/";

// Following URLS mostly just used for the Rate Button
if CONFIG == CONFIG_TYPE.IOS{
   FREE_APP_URL = "https://itunes.apple.com/us/app/starific/id954647642";
   PREMIUM_APP_URL = FREE_APP_URL; 
} else if CONFIG == CONFIG_TYPE.ANDROID{
   FREE_APP_URL = "https://play.google.com/store/apps/details?id=com.alexgierczyk.starific"; 
   //market://play.google.com/store/apps/details?id=com.alexgierczyk.starific"; 
   PREMIUM_APP_URL = FREE_APP_URL; 
} else if CONFIG == CONFIG_TYPE.AMAZON{
       FREE_APP_URL = "http://www.amazon.com/gp/mas/dl/android?p=com.alexgierczyk.starific";
       PREMIUM_APP_URL = FREE_APP_URL; 
} else {
   FREE_APP_URL = LANDING_PAGE_URL; //Maybe don't use these
   PREMIUM_APP_URL = LANDING_PAGE_URL; //Maybe don't use these, instead use landing page
}

globalvar URL_TARGET;
URL_TARGET = "_parent" //_blank //_self
