///scr_button_promotePLM()


analytics_button_counter("promotePLM");


ini_open("scores.ini")
    PLM_COUNT = ini_read_real("misc", "PLM_COUNT", 0);
    //Increment Rate count
    ini_write_real("misc", "PLM_COUNT", ++PLM_COUNT);
ini_close();


// Open PLM URL
url_open_ext("https://play.google.com/store/apps/details?id=it.adways.plp&hl=en",URL_TARGET);


// Give Reward 
if GAMEOVER {
    // Calculate Reward, Set Cash and Execute Confetti
    scr_button_reward_helper(20, 1)
}
