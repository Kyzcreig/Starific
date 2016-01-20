///scr_shop_draw()




// SubEasers
scr_menu_draw_settings_set_easers();


// Page Header
scr_settings_page_header(subEase[0], subEase[1]);




//Page Body

//Sets Coords for Text
row_h = 180;
row_y = line_y + 50;

//Draw Page Settings
for(i = 0; i < array_length_1d(menu); i++)
{
    // Get Button Data 
    menu_data = menu[i];   
    // Get Item Data
    item_data = menu_data[1];
    
    // Draw Button Frame 
    
        // TO DO
    // If Product
        // Draw Buy Button
            //TO DO make this into a script for use in scr_themes_draw_deflectors and here
        // Draw Title Text
        // Draw Description
        // Draw Icon
    // If Custom
        // Draw Title Centered
        
    // Detect Hover
    
    // Detect Press
    
    // Execute Button 
        // If Product
            // IAP Acquire
        
        // If Custom
            // Script Execute
    
    // Increment Y Coordinate
    row_y += row_h;
    
} 


// Draw Footer (copy from themes or codex page)
// Draw Coin Count
//TO DO

if coin_display != STAR_CASH {
    // Ease Coin Display Up
    coin_display += ceil((STAR_CASH - coin_display) * .1);
        //TO DO//EVALUATE SPEED OF EASE 

}

if ADS_FORCED != 0 {
    // Draw Asertisk *Any Purchase Removes Ads 
    // TO DO
    // Probably add the asterisk to whatever font we end up using.
}


