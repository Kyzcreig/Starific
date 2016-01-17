#define scr_button_share
///scr_button_share(type)

var event_share_type, share_count;
share_button_id = -1; //needs to not be var for scope rules
switch argument0{
    case 0: //mobile share
        analytics_button_counter("share_mobile");
        share_button_id = 8;
        break;
    case 1: //html share facebook
        analytics_button_counter("share_html_facebook");
        share_button_id = 4;
        break;
    case 2: //html share twitter
        analytics_button_counter("share_html_twitter");
        share_button_id = 5;
        break;
}





//Increment Share count
ini_open("scores.ini")
   SHARE_COUNT = ini_read_real("misc", "SHARE_COUNT", 0);
   ini_write_real("misc", "SHARE_COUNT", ++SHARE_COUNT);
ini_close();

// Do Share Action
switch argument0{
    case 0: //mobile share

        // Get Share Button Data
        var buttonData = scr_go_button_get_data(share_button_id);
        // Create Share Preview
        var share_obj = instance_create(buttonData[4], buttonData[5], obj_prompt_share_preview);
        share_obj.share_reward = true;
        share_obj.share_button_id = share_button_id;
        //scr_share_mobile(true, true, scr_share_message_gameover());

        break;
    case 1: //html share facebook
    
        //Shares the iOS app page
        var fb_url = "http://www.facebook.com/sharer/sharer.php?u="+string_copy(LANDING_PAGE_URL, 8, string_length(LANDING_PAGE_URL)-8);
            //Apparently facebook has problems sharing with the http:// prefix, so we cut it out.
        url_open_ext(fb_url, URL_TARGET)//"_blank");
        //var fb = https://www.facebook.com/StarificApp"
        //url_open_ext("https://www.facebook.com/plugins/like.php?hreh="+fb,URL_TARGET)//"_blank")
        
        break;
    case 2: //html share twitter
    
        //Tweets and shares iOS app page
        var twt_txt = "Check it out! " + "Just scored "+string(score_p1)+"! #Starific -> ";
        var twt_url = LANDING_PAGE_URL;
        var twt_hash = "&hashtags=starific" ;//comma separate values
        GMTwitter_tweet_ext(twt_txt, twt_url, twt_hash)
        
        break;


}



// Call Share Reward
switch argument0{
    case 0: //mobile share
        break;
    case 1: //html share facebook
    case 2: //html share twitter
        scr_share_reward(share_button_id, true);
        break;


}


#define scr_share_reward
///scr_share_reward(share_button_id, confetti);


// Get Button Data
var buttonIndex = scr_go_is_button(argument0);
var buttonData = go_sp_buttons[| buttonIndex]; 

// If first button use
if buttonData[3] == 0 {
    // Calculate Reward
    scr_reward_set(.5,argument1);
    
    // Check if enough cash for prize, and add prize wheel button
    scr_check_if_available_prize_wheel();
    
    // Update Gift Button to indicate used
    buttonData[@ 1] = "earned#+"+CASH_STR+string(rewardValue); 
    buttonData[@ 3] = -1; ///comment out for unlimited rewards
    
}


#define scr_share_mobile
///scr_share_mobile(snap_screenshot, share_gameplay_screen, message)

var snap_screenshot = argument0;
var share_gameplay_screen = argument1;
var share_msg = argument2;
//Take Screenshot
if snap_screenshot {
    scr_screenshot_highdef_file("ss_gameover.png",0);
}

//share_image("ss_gameover.png") Simple sharing does work for twitter...

//Use share_set_popover_region If you want to change dimensions/location of popup
share_ext_prepare();
//consider only sharing best score? like timberman
share_ext_add_text(share_msg + " #Starific ->");
//Links to free app
share_ext_add_url(LANDING_PAGE_URL);  
share_ext_set_subject('Check it out!'); 



// Add Gameplay SS to Sharer
if share_gameplay_screen and SHARE_SCREEN_METRIC != noone {
    /*
    share_ext_add_image("ss_gameplay.png");
    share_ext_add_image("ss_gameover.png");
    */
    //var newImage = scr_share_screen_make_combined("ss_gameover.png","ss_gameplay.png","ss_combined.png");
    var newImage = scr_share_screen_make_combined(spr_gameplay,spr_temp,"ss_combined.png");
        /* NB: Using parent level scope paremeters like this is super bad but it's the hackiest way to do it.
            And I'm pretty tired.
        
        */
    share_ext_add_image(newImage);
    
    
} else {
    share_ext_add_image("ss_gameover.png");

}

//share_ext_set_activity(ACTIVITY_TYPE_TWITTER); //Forces share type

share_ext_launch();