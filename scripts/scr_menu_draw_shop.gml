#define scr_menu_draw_shop
///scr_menu_draw_shop()




// SubEasers
scr_menu_draw_set_easers_simple();


// Page Header
scr_settings_page_header(subEase[0], subEase[1]);




//Page Body

//Sets Coords for Text
row_h = 150//180;
row_y = line_y + 50;

//Draw Page Settings
for(i = 0; i < array_length_1d(menu); i++)
{
    // Get Button Data 
    menu_data = menu[i];   
    // Get Item Data
    item_data = menu_data[1];
    
    
    // If Product Check Availability
    if menu_data[0] == 0 {
        if IAP_PURCHASE_MAP[? item_data[0]] {
            item_available = false;
        } else {
            item_available = true;
        }
    } else {
        item_available = true;
    }
    
    // Set Button Frame Parameters 
    frame_spr = spr_button_shop;
    frame_scale = subEase[2];//sqr(subEase[i+2]); 
        //evaluate staggered scale ease, we could also try easing them in from the sides
    frame_w = sprite_get_width(frame_spr) * frame_scale;
    frame_h = sprite_get_height(frame_spr) * frame_scale
    frame_x = GAME_MID_X; //+ GAME_W *.75 * (1 - subEase[i+2]);
    frame_y = row_y + frame_h/2;
    frame_alpha = 1;
    if item_available {
        frame_col = COLORS[0];
    } else {
        frame_col = merge_colour(COLORS[0],COLORS[6],.5); // Opacity for unavailable items
    }
    frame_hover = point_in_rectangle(mouse_x, mouse_y, 
                  frame_x - frame_w/2, frame_y - frame_h/2, 
                  frame_x + frame_w/2, frame_y + frame_h/2); 

    // Detect Button Hover
    if frame_hover {
        // Detect Button Press
        if item_available and !TweenExists(mainTween) and
        (!touchPad or mouse_check_button(mb_left))
        {
            // Blend Color on Mouseover
            frame_col = merge_colour(COLORS[0],COLORS[6],.5);
            
            //if mouse_check_button _released(mb_left)
            if mouse_check_button_pressed(mb_left) //and selected[1] == true
            {
                // Reset IAP Restore Flag
                IAP_RESTORE = false;
                // If Product
                if menu_data[0] == 0 {
                    // IAP Acquire
                    ScheduleScript(id, false, 1, scr_iap_acquire, item_data[0]);
                        //NB: We Schedule because IAP calls seem a bit wonky otherwise on iOS
                }  
                // If Custom 
                else if menu_data[0] == 1 {
                    ScheduleScript(id, false, 1, item_data[1]);
                        //NB: We Schedule because IAP calls seem a bit wonky otherwise on iOS
                }
            }
        }

    }
        
    
    // Draw Button Frame
    draw_sprite_ext(frame_spr, 0, frame_x, frame_y, 
    frame_scale, frame_scale, 0, frame_col, frame_alpha);
    
    // If Product
    if menu_data[0] == 0 {
        // Draw Buy Button
        btn_spr = spr_button_buy_round;
        btn_scale = frame_scale;
        btn_w = sprite_get_width(btn_spr) * btn_scale;
        btn_alpha = 1;
        btn_margin_x = 16 * btn_scale;
        btn_x = frame_x - frame_w/2 +btn_margin_x + btn_w/2;
        btn_y = frame_y;
        btn_col = COLORS[6];
        draw_sprite_ext(btn_spr,0,btn_x,btn_y,
        btn_scale,btn_scale,0,btn_col,btn_alpha)
                    
                    
        // Draw Cart Icon
        cart_spr = spr_shop_cart_40;
        cart_scale = .8 * frame_scale
        cart_w = sprite_get_width(cart_spr) * cart_scale;
        cart_margin_x = btn_margin_x;
        cart_x = btn_x - btn_w/2 +cart_w/2 + cart_margin_x;
        cart_y = btn_y;
        cart_col = frame_col;
        draw_sprite_ext(cart_spr,0,cart_x,cart_y,
        cart_scale,cart_scale,0,cart_col,1)
        
        // Draw Price Text
        draw_set_font(fnt_menu_bn_20_black);
        draw_set_valign(fa_middle);
        draw_set_halign(fa_right);
        price_text = scr_iap_get_price(item_data[0], item_data[4]);
        price_w = string_width(price_text) * frame_scale;
        price_h = string_height("H") * frame_scale;
        price_x = btn_x + btn_w * .5 - cart_margin_x;
        price_y = btn_y - price_h * .15;
        price_yscale = frame_scale;
        price_w_max = btn_w - cart_w - cart_margin_x*2;
        if price_w > price_w_max {
            // Squeeze Width to Fit
            price_xscale = price_w_max / price_w;
        } else {
            // Use Normal Width
            price_xscale = price_yscale;
        }
        draw_text_transformed_colour(price_x, price_y, price_text, 
        price_xscale,price_yscale, 0, cart_col, cart_col, cart_col, cart_col, 1);
        
        
        // Draw Product Icon
        icon_spr = item_data[1];
        icon_scale = frame_scale;
        icon_w = sprite_get_width(icon_spr) * icon_scale;
        icon_alpha = btn_alpha;
        icon_margin_x = btn_margin_x*2;
        icon_x = frame_x + frame_w/2 - icon_margin_x - icon_w/2;
        icon_y = frame_y;
        icon_col = COLORS[6];
        draw_sprite_ext(icon_spr,0,icon_x,icon_y,
        icon_scale,icon_scale,0,icon_col,icon_alpha)
            
            
        // Draw Title + Description 
        draw_set_font(fnt_menu_bn_20_black);
        draw_set_valign(fa_middle)
        draw_set_halign(fa_right);
        title_text = item_data[2] +"#" + item_data[3];   
        title_line_h = string_height("H") * frame_scale;
        title_x = icon_x - icon_w/2 - icon_margin_x/2;
        title_y = frame_y - title_line_h * .20; 
        title_col = COLORS[6];  
        draw_text_transformed_colour(title_x, title_y, title_text,
        frame_scale, frame_scale, 0,title_col,title_col,title_col,title_col,1);
   
    }  
    // If Custom 
    else if menu_data[0] == 1 {
        // Draw Title Centered  
        draw_set_font(fnt_menu_bn_20_black);
        draw_set_valign(fa_middle)
        draw_set_halign(fa_center);
        title_text = item_data[0]; 
        title_line_h = string_height("H") * frame_scale;
        title_x = frame_x;
        title_y = frame_y - title_line_h * .20;
        title_col = COLORS[6];  
        draw_text_transformed_colour(frame_x, frame_y, title_text,
        frame_scale, frame_scale, 0,title_col,title_col,title_col,title_col,1);
    
    }
                  
        
        
    // Increment Row Y Coordinate
    row_y += row_h * frame_scale;
    
} 


// Draw Coin Count
draw_set_font(counts_font); //NB: Defined in menu parent
draw_set_valign(fa_middle);
draw_set_halign(fa_left);
if coin_display != STAR_CASH {
    // Ease Coin Display Up
    coin_display += ceil((STAR_CASH - coin_display) * .1);
}
count_text = CASH_STR+string(coin_display);
count_h = string_height("S") 
count_x = GAME_MID_X - line_w;
count_y = GAME_Y + GAME_H - count_h * 1.2;
count_scale = subEase[1];
draw_text_ext_transformed_colour(count_x, count_y, count_text, 
-1,-1,count_scale,count_scale,0,COLORS[0],COLORS[0],COLORS[0],COLORS[0],1)

// Draw Asertisk *Any Purchase Removes Ads 
if ADS_FORCED != 0 {
    draw_set_font(fnt_menu_bn_20_black); 
    draw_set_valign(fa_middle);
    draw_set_halign(fa_right);
    text_text = "*any purchase#removes ads";
    text_x = GAME_MID_X + line_w;
    text_y = count_y;
    text_scale = count_scale;
    draw_text_ext_transformed_colour(text_x, text_y, text_text, 
    -1,-1,text_scale,text_scale,0,COLORS[0],COLORS[0],COLORS[0],COLORS[0],1);

}


//Draw OverLine
endLine_y = count_y - count_h
//make this a script and use it in various places
scr_draw_title_underline(endLine_y, subEase[1], 0)



#define scr_shop_init
///scr_shop_init()



title_txt = "shop";


var i;
i = -1; 
// Create Shop Items
menu[++i] = Array(0, Array(                             // button_type, data
            "coins_0", spr_coins_stack, "stack of coins",                    // product_id, sprite, name_text, 
            "+"+string(IAP_COIN_AMOUNTS[0])+CASH_STR, "$0.99"))                                       //description_text, default price
menu[++i] = Array(0, Array(                             
            "coins_1", spr_coins_bag, "bag of coins",                    
            "+"+string(IAP_COIN_AMOUNTS[1])+CASH_STR+" (+50%)", "$2.99"))                                 
menu[++i] = Array(0, Array(                             
            "coins_2", spr_coins_vault, "vault of coins", 
            "+"+string(IAP_COIN_AMOUNTS[2])+CASH_STR+" (+100%)", "$9.99")) 
menu[++i] = Array(0, Array(                          
            "perk_0", spr_perk_coin_doubler, "earn x2 coins", 
            "+"+string(IAP_COIN_AMOUNTS[0])+CASH_STR+" (+perk)", "$4.99")) 
menu[++i] = Array(1, Array(                             
            "restore purchases", scr_iap_restore_all))                        


// Coin Display Easer
coin_display = STAR_CASH;