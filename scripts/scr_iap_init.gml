#define scr_iap_init
///scr_iap_init()

var map_create, product_map, product_id, product_list, product_data;
globalvar 
IAP_PURCHASE_MAP,
IAP_PRICE_MAP;


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

// Initialize Price Map
IAP_PRICE_MAP = ds_map_create();

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
        if string_pos("theme_",product_id) != -1 {
            // Unlock Theme
            var theme_index = real(string_digits(product_id));
            var theme_data = scr_unlock_set_status(3, theme_index, 2, false);
        }
        // If Perk
        //TO DO
        // If Coins (run iap_consume)
        //TO DO
        
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
        if os_is_network_connected() {
            // Maybe Do a second activation attempt?
              
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
    show_debug_message("iap_ev_product: product_id="+string(product_id));
    var price = product_map[? "price"];
    show_debug_message("iap_ev_product: price="+string(price));
    
    // Format Price
    price = string_digits(price);
        /* 
            iOS Format is [Currency Symbol][Currency Value]
    // TO DO
            Google Format is ????
    // TO DO
            Amazon Format is ????
        */
    
    // Set Regional Price, Formatted
    IAP_PRICE_MAP[? product_id] = price;
    show_debug_message("iap_ev_product: price_formatted="+string(price));
    
    // Garbage Collect
    ds_map_destroy(product_map);
    
    /*
        This event fires for each product_id you activate via iap_activate(product_list)
        It's a way to get product information e.g. like the regional price.
    
    */

    
    
    break;
case iap_ev_restore: 
    //TO DO
    var result = iap_map[? "result"]
    show_debug_message("iap_ev_restore: result="+string(result));
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
                // Flag Product as Purchased
                IAP_PURCHASE_MAP[? product_id] = 1;
                        
                // If Theme Purchase
                if string_pos("theme_",string(product_id)) != 0 {
                    var theme_index = real(string_digits(product_id));
                    
                    // Get Theme Data
                    var theme_data = scr_unlock_get_data(3, theme_index);
                    // Unlock Theme
                    theme_data[@ 1] = 2;
                    theme_data[@ 2] = max(theme_data[2], 0);
                      
                    // Delete Loading Icon
                    with(obj_prompt_loading) {
                        load_destroy = true;
                    }
                    
                    if room != rm_menu {
                        // Set Prize Prompt
                        var prizeData, prizeText, prizeName, prizeNoise;
                        prizeText = "great choice!"; //kudos! //winner!
                        prizeName = scr_unlock_get_name_long(theme_data);
                        prizeNoise = 2; //unlock noise
                        
                        prizeData = scr_prompt_prize_create_data(s_v_themeswitcher_x2,4,
                                    prizeText, prizeName, prizeNoise, 3, theme_data, 0, "", false);
                        // Spawn Prize Prompt (allow .25 seconds for loading icons to die);
                        ScheduleScript(id, true, .3, scr_prompt_prize_spawn, prizeData);
                        //ScheduleScript(id, false, 1, scr_prompt_prize_spawn, prizeData);
                    }
                    
                    // Set Current Theme
                    CURRENT_SKIN = theme_index;
                    
                }
                // If Coin Purchase
                    //TO DO
                    //iap_consume(index)
                
                //If Perk Purchase
                    //TO DO
            }
        }
    
    }
    
    
    // Garbage Collect
    ds_map_destroy(purchase_map);
    
    
    
    //TO DO
    // Process themes, coins, cashdoubler purchases here based on index
    /* s
        
        
        
        
        for coins_## you would do something similar and call
               iap_consume(product_id);
        
        for perks you could use an index to make the perks to names maybe or just use the name...
        we can figure that out last.
        
        i think maybe 3 levels of coin purchases plus the cash doubler would be sufficient,
        though i imagine it would be fine to open an entire store page too and we could scroll it then 
        
    
    */
    
    break;
case iap_ev_consume: 
    var product_id = iap_map[? "product"];
    show_debug_message("iap_ev_consume: product="+string(product_id));
    
    if ds_map_exists(IAP_PURCHASE_MAP , product_id) {
        // Flag Product as UnPurchased
        IAP_PURCHASE_MAP[? product_id] = 0;
        
        // Delete Loading Icon
        with(obj_prompt_loading) {
            load_destroy = true;
        }
            
        // If Coin Consume
        if string_pos("coins_",product_id) != 0 {
        
            var quantity = real(string_digits(product_id));
            STAR_CASH += quantity
            
            //Save StarCash
            ini_open("scores.ini");
                ini_write_real("misc", "STAR_CASH", STAR_CASH);
            ini_close();
            
            // Set Prize Prompt
            var prizeData, prizeText, prizeName, prizeNoise, prizeValue;
            prizeText = "great choice!"; //kudos! //winner!
            prizeName = "+"+CASH_STR+string(0);
            prizeNoise = 1; //unlock noise
            prizeValue = quantity;
            prizeData = scr_prompt_prize_create_data(s_v_cash_circle_x2,3,
                        prizeText, prizeName, prizeNoise, 3, prizeValue, 0, "", false);
            // Spawn Prize Prompt (allow .25 seconds for loading icons to die);
            ScheduleScript(id, true, .3, scr_prompt_prize_spawn, prizeData);
            //ScheduleScript(id, false, 1, scr_prompt_prize_spawn, prizeData);
        }
    
    }
    
    break;




}

/// Save Product Map
ds_map_secure_save(IAP_PURCHASE_MAP, "iap_data.json");









#define scr_iap_product_list_init
///scr_iap_product_list_init()


var product_list = ds_list_create();
var durable_maps = noone;
var consumable_maps = noone;


// Iterate Through Themes
for (i = SKIN_COUNT-1; i >= 0 ; i--) {
    // Make Product Map
    durable_maps[i] = scr_iap_product_create(ds_map_create(), 
                        "theme_"+string(i), "Theme "+string(i),
                        "The greatest of themes! An excellent choice!",
                        "$0.99", "Durable");
    ds_list_add(product_list, durable_maps[i]);
}
/*
// Coin Doubler
//TO DO

// Iterate Through Consummables
for (i = 0; i < ....; i++) {
    // Make Product Map
    consumable_maps[i] = scr_iap_product_create(ds_map_create(), 
                        "theme_"+string(i), "Theme "+string(i),
                        "The greatest of themes! An excellent choice!",
                        "$0.99", "Consumable");
    ds_list_add(product_list, consumable_maps[i]);
}

*/
// TO DO
// Other IAPs, including coins and cash doubler
//coins will probably be consummables


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

#define scr_iap_acquire
///scr_iap_acquire(product_id, store_status)

var store_status = argument[1];//iap_status();

// Check if IAP Available
if store_status == iap_status_available {
    // Get Product ID
    var product_id =  argument[0];
    // Get Purchase Status
    var status = IAP_PURCHASE_MAP[? product_id];
    show_debug_message("IAP Purchase Attempt: "+string(product_id)+","+string(status));
    // If status == Unpurchased
    if status == 0 {
        iap_acquire(product_id, "");
        //Create Loading Icon Object
        CreateInstanceIfNone(x,y,obj_prompt_loading);
    }
    return true;
} else {
    show_message_async("Store is not available."); 
    return false;  
}      

#define scr_iap_get_price
//scr_iap_get_price(product_id, default)

var product_id = argument0;
var price = IAP_PRICE_MAP[? product_id];

if ds_map_exists(IAP_PRICE_MAP, product_id) {
    return IAP_PRICE_MAP[? product_id];;
} else {
    return argument1;
}

