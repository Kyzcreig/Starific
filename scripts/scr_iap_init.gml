#define scr_iap_init
///scr_iap_init()

var map_create, product_map, product_id, product_list, product_data;
globalvar 
IAP_PURCHASE_MAP,
IAP_PRICE_MAP, 
IAP_COIN_AMOUNTS,
IAP_RESTORE;

// Init IAP Restore
IAP_RESTORE = false;
// Initialize Price Map
IAP_PRICE_MAP = ds_map_create();

// Init Coin Amounts
scr_iap_coin_declare()

// Initialize List of Product IDs
var product_list = scr_iap_product_list_init()

map_create = true; // New IAP Data Flag On
// Check If IAP Map Stored
if file_exists("iap_data.json")  { 
    // Load in IAP Map
    IAP_PURCHASE_MAP = ds_map_secure_load("iap_data.json");
    // Check that It's Valid
    if ds_exists(IAP_PURCHASE_MAP, ds_type_map) {
        map_create = false; // Flag Off
        
        // Iterate Through IAPs
        for (var i = 0, n = ds_list_size(product_list); i < n; i++) {
            // Get Product Map
            product_map = product_list[| i];
            // Get ID
            product_id = product_map[? "id"];
            
            // Check IAP Key Exists
            if !scr_iap_product_init(product_id) {
                // Corrupt or Out of Date Map
                map_create = true;
                break;
            }
        }
    }
}


// Create and Save New IAP Map
if map_create {
    IAP_PURCHASE_MAP = ds_map_create();
    
    // Iterate Through IAPs
    for (var i = 0, n = ds_list_size(product_list); i < n; i++) {
        // Get Product Map
        product_map = product_list[| i];
        // Get ID
        product_id = product_map[? "id"];
        
        // Add to IAP Map
        IAP_PURCHASE_MAP[? product_id] = 0;
    }
    // Save Map
    ds_map_secure_save(IAP_PURCHASE_MAP, "iap_data.json");
}


// Activate IAPs
scr_iap_activate(product_list);
// Garbage Collect
scr_iap_product_dealloc(product_list);







#define scr_iap_product_init
///scr_iap_product_init(product_id)

var product_id = argument0;

// Check if Key Exists
if ds_map_exists(IAP_PURCHASE_MAP, product_id) {
    // Get Purchase Status
    var status = IAP_PURCHASE_MAP[? product_id];
    // If Status == Purchased
    if status == 1 {
        // Disable Ads for ANY purchase
        ADS_FORCED = 0;
        // If Theme
        if string_pos("theme_",product_id) != 0 {
            // Unlock Theme
            var theme_index = real(string_digits(product_id));
            var theme_data = scr_unlock_set_status(3, theme_index, 4, false);
                            //NB: Set Unlock Status to == 4, which is a premium unlock.
        }
        // If Perk
        else if string_pos("perk_",product_id) != 0 {
            // Unlock Perk
            var perk_index = real(string_digits(product_id));
            var perk_data = scr_unlock_set_status(4, perk_index, 4, false);
        }
        
        // NB: Unconsumed Coins Are Consumed in the IAP Product Event
        //if string_pos("coins_",product_id) != 0 {}
        
    } else if status > 1 {
        // Key Broken
        return false;
    }
    
    // Key OKay
    return true;
} else {
    // Key is Missing or DS Map Corrupted 
    return false;
}

#define scr_iap_event
///scr_iap_event()

var iap_map, type;

// Get Event Data and Type
iap_map = iap_data;
type = iap_map[? "type"]


switch type {

case iap_ev_storeload: 
    // IAPs have been activated
    var status = iap_map[? "status"]
    
    // Did We Connect?
    if status == iap_storeload_ok {
        show_debug_message("iap_ev_storeload: status = iap_storeload_ok");
    } else if status == iap_storeload_failed {
        show_debug_message("iap_ev_storeload: status = iap_storeload_failed");
        // Disable IAPs
        //IAP_ENABLED = false;
        
        if os_is_network_connected() {
            // Maybe Do a second activation attempt?
              // We could put scr_iap_init here, but we'd need to prevent infinite loops.
        }
    }
    break;
    
case iap_ev_product: 

    var index = iap_map[? "index"]
    show_debug_message("iap_ev_product: index="+string(index));
    // Get Product Details
    var product_map = ds_map_create();
    iap_product_details(index, product_map);
    
    // Get Product Data
    var product_id = product_map[? "id"];
    //show_debug_message("iap_ev_product: product_id="+string(product_id));
    var price = product_map[? "price"];
    //show_debug_message("iap_ev_product: price="+string(price));
    
    // Format Price
    price = string_keep_chars(price, "0123456789,.");
    /* 
        iOS Format is 
            [Currency Symbol][Currency Value]
        Google Format is 
            [Currency Symbol][Currency Value]
        Amazon Format is ????
            // TO DO
    */
    
    // Set Regional Price, Formatted
    IAP_PRICE_MAP[? product_id] = price;
    //show_debug_message("iap_ev_product: price_formatted="+string(price));
    
    // Consume Coin Products
    if IAP_PURCHASE_MAP[? product_id] == 1 and 
       string_pos("coins_",product_id) != 0 
    {
        // Disable Ads
        ADS_FORCED = false;
        // Consume
        iap_consume(product_id);
    }
    
    // Garbage Collect
    ds_map_destroy(product_map);
    
    /*
        This event fires for each product_id you activate via iap_activate(product_list)
        It's a way to get product information e.g. like the regional price.
    
    */

    
    
    break;
case iap_ev_restore: 
    var result = iap_map[? "result"]
    show_debug_message("iap_ev_restore: result="+string(result));
    //NB: Explanation http://joelsandberg.com/gamemaker/ios-in-app-purchases-tutorial-part-6/
    break;
    
case iap_ev_purchase: 
    var purchase_id = iap_map[? "index"];
    show_debug_message("iap_ev_purchase: purchase_id="+string(purchase_id));
    
    // Load Purchase Details
    var purchase_map = ds_map_create();
    iap_purchase_details(purchase_id, purchase_map);
    
    // Get Status
    var status = purchase_map[? "status"];
    if status == iap_purchased {
        // Get Product ID
        var product_id = purchase_map[? "product"];
        show_debug_message("iap_ev_purchase: product_id="+string(product_id));
        if ds_map_exists(IAP_PURCHASE_MAP, product_id) {
            var product_status = IAP_PURCHASE_MAP[? product_id];
            show_debug_message("iap_ev_purchase: product_status="+string(product_status));
            // If Not Purchased
            if product_status == 0 {
                // Process The Purchase
                scr_iap_purchase_process(product_id);
            }
        }
    } else if status == iap_failed {
        if CONFIG != CONFIG_TYPE.ANDROID { //Googleplay handles this already 
            show_message_async("Store is not available."); 
            //TO DO, maybe use a text prompt object instead of this message async thing?
            // Might look better.
        }
    }
    
    
    // Garbage Collect
    ds_map_destroy(purchase_map);
    
    break;
    
    
case iap_ev_consume: 
    var product_id = iap_map[? "product"];
    show_debug_message("iap_ev_consume: product="+string(product_id));
    
    if ds_map_exists(IAP_PURCHASE_MAP , product_id) {
        // Flag Product as UnPurchased
        IAP_PURCHASE_MAP[? product_id] = 0;
        
        // Delete Loading Icon
        with(obj_prompt_loading) {
            load_destroy[0] = true;
        }
            
        // If Coin Consume
        if string_pos("coins_",product_id) != 0 {
        
            var index = real(string_digits(product_id));
            var quantity = IAP_COIN_AMOUNTS[index];
            STAR_CASH += quantity;
            
            //Save StarCash
            ini_open("scores.ini");
                ini_write_real("misc", "STAR_CASH", STAR_CASH);
            ini_close();
            
            // Set Prize Prompt
            var prizeData;
            prizeData = scr_prize_cash_create(quantity, "great choice!", 0, false);
            // Spawn Prize Prompt (allow .25 seconds for loading icons to die);
            ScheduleScript(id, true, .3, scr_iap_unlock_prompt, noone, noone, obj_control_main, prizeData);
            //ScheduleScript(id, false, 1, scr_prompt_prize_spawn, prizeData);
        }
    
    }
    
    break;




}

/// Save Product Map
ds_map_secure_save(IAP_PURCHASE_MAP, "iap_data.json");









#define scr_iap_purchase_process
///scr_iap_purchase_process(product_id)

var product_id = argument0;

// Flag Product as Purchased
IAP_PURCHASE_MAP[? product_id] = true;

// Disable Ads
ADS_FORCED = false;
        
// If Theme Purchase
if string_pos("theme_",string(product_id)) != 0 {
    var theme_index = real(string_digits(product_id));
    
    // Get Theme Data
    var theme_data = scr_unlock_get_data(3, theme_index);
    // Unlock Theme
    theme_data[@ 1] = 4; // Set Theme to Purchased, status == 4
    theme_data[@ 2] = max(theme_data[2], 0);
    
    // If Not Restoring Purchases
    if !IAP_RESTORE {
        // Set Prize Prompt
        var prizeData, prizeText, prizeName, prizeNoise;
        prizeText = "great choice!"; //kudos! //winner!
        prizeName = scr_unlock_get_name_long(theme_data);
        prizeNoise = 2; //unlock noise
        prizeData = scr_prompt_prize_create_data(s_v_themeswitcher_x2,4,
                    prizeText, prizeName, prizeNoise, 3, theme_data, 0, "", noone);
        //(allow .25 seconds for loading icons to die);
        ScheduleScript(id, true, .3, scr_iap_unlock_prompt, theme_index, theme_data, obj_settings_themes, prizeData);
    }
      
    // Delete Loading Icon (Not for Consummables)
    with(obj_prompt_loading) {
        load_destroy[0] = true;
    }
    
    
}
//If Perk Purchase
else if string_pos("perk_",string(product_id)) != 0 {
    //NB: Lots of redundancy between this and the theme prompt stuff, we could probably make it a script...
        //Just swap out the unlock_type, prize_sprite, prize_type, page_controller

    var perk_index = real(string_digits(product_id));
    
    // Get Perk Data
    var perk_data = scr_unlock_get_data(4, perk_index);
    // Unlock Perk
    perk_data[@ 1] = 4; // Set Perk to Purchased, status == 4
    perk_data[@ 2] = max(perk_data[2], 0);
    
    // If Not Restoring Purchases
    if !IAP_RESTORE {
        // Set Prize Prompt
        var prizeData, prizeText, prizeName, prizeNoise;
        prizeText = "great choice!"; //kudos! //winner!
        prizeName = scr_unlock_get_name_long(perk_data);
        prizeNoise = 2; //unlock noise
        prizeData = scr_prompt_prize_create_data(s_v_options_x2,1,
                    prizeText, prizeName, prizeNoise, 2, perk_data, 0, "", noone);
        //(allow .25 seconds for loading icons to die);
        ScheduleScript(id, true, .3, scr_iap_unlock_prompt, perk_index, perk_data, obj_settings_shop, prizeData);
    }
    
    //ADD +1000 STARCASH
    var quantity = IAP_COIN_AMOUNTS[0];
    STAR_CASH += quantity;
    
    //Save StarCash
    ini_open("scores.ini");
        ini_write_real("misc", "STAR_CASH", STAR_CASH);
    ini_close();
          
    // Delete Loading Icon (Not for Consummables)
    with(obj_prompt_loading) {
        load_destroy[0] = true;
    }
}
// If Coin Purchase 
else if string_pos("coins_",string(product_id)) != 0 {
    // Consume Product
    iap_consume(product_id)
}

#define scr_iap_restore_all
///scr_iap_restore_all()

// Flag IAP Restore
IAP_RESTORE = true;

//Create Loading Icon
var loading = instance_create(x,y,obj_prompt_loading);
with (loading) {
    // Schedule Self Destruct
    ScheduleScript(loading, true, 1.75, array_set_index_1d, load_destroy, 0, true); 
}

// For iOS
if CONFIG == CONFIG_TYPE.IOS {
    var status = iap_status();
    if status == iap_status_available {
        iap_restore_all()
    } else if status == iap_status_unavailable {
        show_message_async("Store is not available."); 
    }
} 
// For GooglePlay
else if CONFIG == CONFIG_TYPE.ANDROID {
    var status = iap_status();
    if status == iap_status_available {
        var size, key, value;
        size = ds_map_size(IAP_PURCHASE_MAP);
        key = ds_map_find_first(IAP_PURCHASE_MAP);
        for (var i = 0; i < size; i++) {
            // Get Value
            value = IAP_PURCHASE_MAP[? key];
            
            // If IAP InActive and IsPurchased
            if value == false and iap_is_purchased(key) {
                // Process The Purchase
                scr_iap_purchase_process(key);
            }
            // Get Next Key
            key = ds_map_find_next(IAP_PURCHASE_MAP, key);
        }
    } else if status == iap_status_unavailable {
        show_message_async("Store is not available."); 
    }
} 
// For Amazon
else if CONFIG == CONFIG_TYPE.AMAZON {
    //TO DO amazon

}




#define scr_iap_acquire
///scr_iap_acquire(product_id)


var store_status = iap_status();

// Check if IAP Available
if store_status == iap_status_available {
    // Get Product ID
    var product_id =  argument[0];
    // Get Purchase Status
    var status = IAP_PURCHASE_MAP[? product_id];
    show_debug_message("IAP Acquire Attempt: "+string(product_id)+","+string(status));
    // If status == Unpurchased
    if status == 0 {
        iap_acquire(product_id, "");
        //Create Loading Icon Object
        CreateInstanceIfNone(x,y,obj_prompt_loading);
    }
    return true;
} else if store_status == iap_status_unavailable {
    // Show Failure Dialogue
    show_message_async("Store is not available."); 
    return false;  
} 

/*

// Get Product ID
var product_id =  argument[0];
// Get Purchase Status
var status = IAP_PURCHASE_MAP[? product_id];
show_debug_message("IAP Acquire Attempt: "+string(product_id)+","+string(status));
// If status == UnPurchased
if status == 0 {
    iap_acquire(product_id, "");
    //Create Loading Icon Object
    CreateInstanceIfNone(x,y,obj_prompt_loading);
}    

     

#define scr_iap_unlock_prompt
///scr_iap_unlock_prompt(unlock_index, unlock_data, page_controller, prizeData)

var unlock_index = argument0;
var unlock_data = argument1;
var page_controller = argument2;
var prizeData = argument3;

if instance_exists(page_controller) { 

    // Spawn Prize Prompt 
    scr_prompt_prize_spawn(prizeData);
    //ScheduleScript(id, false, 1, scr_prompt_prize_spawn, prizeData);
    
    // If Durable IAP
    if is_array(unlock_data) {
        // If Theme IAP
        if unlock_data[0] == 3 {
            // Set Current Theme (scheduled after unlock prompt dies)
            ScheduleScript(obj_settings_themes, false, 5, scr_theme_select, unlock_index, true, unlock_data);
        }
        // If Perk
        else if unlock_data[0] == 4 {
            //pass (for now), since we use the purchase map for this stuff already
        }
    }
}

#define scr_iap_product_list_init
///scr_iap_product_list_init()


var product_list = ds_list_create();
var theme_maps = noone;
var coin_maps = noone;
var perk_maps = noone;


// Iterate Through Themes
for (i = SKIN_COUNT-1; i >= 0 ; i--) {
    // Make Product Map
    theme_maps[i] = scr_iap_product_create(ds_map_create(), 
                        "theme_"+string(i), "Theme "+string(i),
                        "The greatest of themes! An excellent choice!",
                        "$0.99", "Durable");
    ds_list_add(product_list, theme_maps[i]);
}
// Iterate Through Consummables
for (i = array_length_1d(IAP_COIN_AMOUNTS); i >= 0; i--) {
    // Make Product Map
    coin_maps[i] = scr_iap_product_create(ds_map_create(), 
                        "coins_"+string(i), "Coins "+string(i), //NB: Wrong titles here
                        "So many coins, how ever will we spend them!",
                        "$0.99", "Consumable"); //NB: Wrong Prices here
    ds_list_add(product_list, coin_maps[i]);
}
// Iterate Through Perks (Coin Doubler)
for (i = 0; i >= 0 ; i--) {
    // Make Product Map
    perk_maps[i] = scr_iap_product_create(ds_map_create(), 
                        "perk_"+string(i), "Perk "+string(i), //NB: Wrong titles here
                        "Earn coins twice as fast! Wonderful!",
                        "$4.99", "Durable"); 
    ds_list_add(product_list, perk_maps[i]);
}


return product_list;









#define scr_iap_activate
///scr_iap_activate(product_list)

var product_list = argument0;
iap_activate(product_list);
//TO DO 
// Amazon Stuff

#define scr_iap_product_dealloc
///scr_iap_product_dealloc(product_list)

var product_list, product_map;
product_list = argument0;

// Destroy Maps
for (var i = ds_list_size(product_list)-1; i >= 0; i--) {
    // Get Map
    product_map = product_list[| i];
    ds_map_destroy(product_map);

}

// Destroy List
ds_list_destroy(product_list);

#define scr_iap_product_create
///scr_iap_product_create(map, id, title, description, price, type)

var map = argument[0];
//var i = 0;
ds_map_add(map, "id", argument[1]);
/*
ds_map_add(map, "title", argument[2]);
ds_map_add(map, "description", argument[3]);
ds_map_add(map, "price", argument[4]);
*/
ds_map_add(map, "type", argument[5]);

return map;

#define scr_iap_get_price
//scr_iap_get_price(product_id, default)

var product_id = argument0;
var price = IAP_PRICE_MAP[? product_id];

if ds_map_exists(IAP_PRICE_MAP, product_id) {
    return IAP_PRICE_MAP[? product_id];;
} else {
    return argument1;
}
#define scr_iap_coin_declare
///scr_iap_coin_declare()


IAP_COIN_AMOUNTS[2] = 20000;
IAP_COIN_AMOUNTS[1] = 4500;
IAP_COIN_AMOUNTS[0] = 1000;

return IAP_COIN_AMOUNTS;