///scr_button_interstitialReward()


analytics_button_counter("interstitialReward");


//Increment Interstitial Reward Count
ini_open("scores.ini")
   INTERSTITIAL_REWARD_COUNT = ini_read_real("misc", "INTERSTITIAL_REWARD_COUNT", 0);
   ini_write_real("misc", "INTERSTITIAL_REWARD_COUNT", ++INTERSTITIAL_REWARD_COUNT);
ini_close();


// Show Interstitial
ads_show_interstitial(true);
