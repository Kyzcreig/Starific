///scr_menu_draw_credits()


// SubEasers
if true {//TweenExists(mainTween) {//and TweenIsPlaying(mainTween) {
    subEase[0] = EaseOutBack(clamp(mainEase[0],0,1), 0, 1, 1)
    subEase[1] = clamp(mainEase[0]-0.5,0,1)
    subEase[2] = EaseOutBack(clamp(mainEase[0]-1.0,0,1), 0, 1, 1);
    

}


///Page Header
scr_settings_page_header(subEase[0], subEase[1]);



//Page Body

//Draw Game Designed By
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fnt_menu_buttons);
cat_text = "designed by";
cat_scale = subEase[2];
cat_h = string_height(cat_text) * cat_scale;
cat_x = GAME_MID_X - line_w;
cat_y = line_y + 50 * RU;
draw_text_ext_transformed_colour(cat_x, cat_y, cat_text, -1, -1, 
cat_scale, cat_scale, 0, COLORS[0], COLORS[0],COLORS[0],COLORS[0],1);

// Draw Studio Info 
draw_set_font(fnt_gui_options3);
sub_text = "Beveled Edge Studios#CEO: Alex Gierczyk";
sub_start_x = cat_x + cat_h * .1;  //adjusted right to be inside of the bigger category text
sub_x = sub_start_x;
sub_y = cat_y + cat_h * 1.2;
sub_scale = cat_scale;
sub_h = string_height("S") * sub_scale;
draw_text_ext_transformed_colour(sub_x, sub_y,sub_text, -1,-1, 
sub_scale, sub_scale, 0, COLORS[0], COLORS[0],COLORS[0],COLORS[0],1);



//Draw Special Thanks
draw_set_font(fnt_menu_buttons);
cat_text = "special thanks";
cat_y = sub_y + sub_h + cat_h;
draw_text_ext_transformed_colour(cat_x, cat_y, cat_text, -1, -1, 
cat_scale, cat_scale, 0, COLORS[0], COLORS[0],COLORS[0],COLORS[0],1);

// Draw People and Roles
draw_set_font(fnt_gui_options3); 
//Set People Names
var i = -1;
sub_text[++i] = "Spencer McKone"
sub_text[++i] = "Jeremy Winn"
sub_text[++i] = "Jessie Richards"
sub_text[++i] = "Elliott Thurman-Newell"
sub_text[++i] = "Monstercat"
sub_text[++i] = "Jonathan Ringstad"
// Set Y and Line Height
sub_start_y = cat_y + cat_h * 1.2;
sub_y = sub_start_y;
sub_group_h = 2.25;//(2.5)//1.5
// Draw Names
for (var i = 0, n = array_length_1d(sub_text); i < n ; i++){

    draw_text_ext_transformed_colour(sub_x, sub_y,sub_text[i], -1,-1, 
    sub_scale, sub_scale, 0, COLORS[0], COLORS[0],COLORS[0],COLORS[0],1);
    
    //Increment Y
    sub_y += sub_h * sub_group_h
}

//Draw People Websites
var i = -1;
sub_text[++i] = "twitter.com/spencemckn"
sub_text[++i] = "jeremywinn.com" 
sub_text[++i] = "jvillustration.com"
sub_text[++i] = "ethurmannewell.weebly.com"
sub_text[++i] = "monstercat.com"
sub_text[++i] = "" //ask jon if he has a website
sub_y = sub_start_y + sub_h; //maybe add some space here between lines
for (var i = 0, n = array_length_1d(sub_text); i < n ; i++){
    
    // Alernate Color Index
    var col = (i mod 5) + 1;
    // Draw Websites
    draw_text_ext_transformed_colour(sub_x, sub_y, sub_text[i], -1,-1, //"   "
    sub_scale, sub_scale, 0, COLORS[col], COLORS[col],COLORS[col],COLORS[col],1);
    
    // Get Mouse Hover
    sub_hover = point_in_rectangle(mouse_x,mouse_y,
                    GAME_MID_X-line_w,sub_y - sub_h,
                    GAME_MID_X+line_w,sub_y + sub_h)
                          
    if sub_text[i] != "" and sub_hover and 
    (!touchPad or mouse_check_button(mb_left))
    and !TweenExists(mainTween)
    {
        //On Press
        if mouse_check_button_pressed(mb_left)
        {
            //Call Switch Code for this menu choice
            mouse_clear(mb_left);
            url_open_ext("http://www."+sub_text[i]+"/",'_blank')
            
        }
   }
   // Increment Y Coordinate            
    sub_y += sub_h * sub_group_h //this might be wron
}


//Draw People Roles
draw_set_halign(fa_right); 
var i = -1;
sub_text[++i] = "Mechanics"
sub_text[++i] = "Mechanics"
sub_text[++i] = "Iconography"
sub_text[++i] = "Aesthetics"
sub_text[++i] = "Music"
sub_text[++i] = "Feedback"
sub_x = GAME_MID_X+line_w;
sub_y = sub_start_y + sub_h*.5;
for (var i = 0, n = array_length_1d(sub_text); i < n ; i++){

    draw_text_ext_transformed_colour(sub_x, sub_y,sub_text[i], -1,-1, 
    sub_scale, sub_scale, 0, COLORS[0], COLORS[0],COLORS[0],COLORS[0],1);

    
    sub_y += sub_h * sub_group_h;
}
// Adjust for End of Section
sub_y -= sub_h * sub_group_h
        



// Draw Contact
draw_set_font(fnt_menu_buttons);
draw_set_halign(fa_left); 
cat_text = "contact us";
cat_y = sub_y + cat_h;
draw_text_ext_transformed_colour(cat_x, cat_y, cat_text, -1, -1, 
cat_scale, cat_scale, 0, COLORS[0], COLORS[0],COLORS[0],COLORS[0],1);


// Draw Contact Info
draw_set_font(fnt_gui_options3);
// Set Contact Types
contactType[0] = "Web: ";
contactType[1] = "Email: ";
contactType[2] = "Twitter: ";

// Set Contact URLs
contactURL[0] = string_slice(LANDING_PAGE_URL,7,-1)//string_copy(LANDING_PAGE_URL, 8, string(LANDING_PAGE_URL - 8)string_copy_start(LANDING_PAGE_URL, 7);
contactURL[1] = "Hello@BeveledEdge.co"//"Support@"+contactURL[0]; //string_copy(LANDING_PAGE_URL, 8, string_length(LANDING_PAGE_URL) - 8);
contactURL[2] = "@BeveledEdgeCo";

// Set Coordinates
sub_y = cat_y + cat_h * 1.2;
// Draw Text in Different Colors
for (var k = 0; k < array_length_1d(contactType); k++){

    // Draw Contact Type
    col = 0;
    sub_text = contactType[k];
    sub_x = sub_start_x;
    draw_text_ext_transformed_colour(sub_x, sub_y,sub_text, -1,-1, 
    sub_scale, sub_scale, 0, COLORS[col], COLORS[col],COLORS[col],COLORS[col],1);

    
    // Draw Contact URL
    col = (k mod 5) + 1;
    sub_x += string_width(sub_text);
    sub_text = contactURL[k];
    draw_text_ext_transformed_colour(sub_x, sub_y, sub_text, -1,-1, 
    sub_scale, sub_scale, 0, COLORS[col], COLORS[col],COLORS[col],COLORS[col],1);

    
    
    //Iterate through links
    sub_hover = point_in_rectangle(mouse_x,mouse_y,
            GAME_MID_X - line_w, sub_y ,
            GAME_MID_X + line_w, sub_y + sub_h)
            
                         
    if sub_hover and !TweenExists(mainTween) and
      (!touchPad or mouse_check_button(mb_left))  
    {
        //On Press
        if mouse_check_button_pressed(mb_left)
        {
            //Call Switch Code for this menu choice
            mouse_clear(mb_left);
            if k == 0{url_open_ext("http://"+contactURL[k],URL_TARGET)}
            else if k == 1{url_open_ext("mailto:"+contactURL[k],URL_TARGET)} // /?subject=YourSubjectHere
            else if k == 2{url_open_ext("https://twitter.com/"+string_copy_start(contactURL[k],1),URL_TARGET)}
            
        }
   }
   
   // Increment Info Text Y Coordinate
   sub_y += sub_h;
}





//Page Footer
scr_settings_page_footer();
