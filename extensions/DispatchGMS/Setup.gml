#define DGMS_Init
/// DGMS_Init()

// Create maps for holding dispatcher and callback arrays
global.DGMS_MAP_DISPATCHER = ds_map_create();
global.DGMS_MAP_CALLBACK = ds_map_create();

// Create global variables for setting incremented dispather and callback indexes
global.DGMS_INDEX_DISPATCHER = 0;
global.DGMS_INDEX_CALLBACK = 0;

// Create null callback -- used in clearing callbacks marked for removal
global.DGMS_NULL_CALLBACK[0] = noone;
#define DGMS_Final

// Destroy maps referencing dispatcher and callback arrays
ds_map_destroy(global.DGMS_MAP_DISPATCHER);
ds_map_destroy(global.DGMS_MAP_CALLBACK);
