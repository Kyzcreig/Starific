///scr_button_videoReward()


analytics_button_counter("videoReward");


//Increment Video count
ini_open("scores.ini")
   VIDEO_REWARD_COUNT = ini_read_real("misc", "VIDEO_REWARD_COUNT", 0);
   ini_write_real("misc", "VIDEO_REWARD_COUNT", ++VIDEO_REWARD_COUNT);
ini_close();


// Show Reward Video
ads_show_reward_video();
