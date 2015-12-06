#define scr_field_data_init
///scr_field_data_init()



// Game Field Data
global.FIELD_OBJECTS = ds_grid_create(1,1);
//global.empties = ds_list_create()
global.FIELD_RESPAWNS = ds_list_create();

// Grid for Spawning Blocks
global.FIELD_EMPTIES = ds_grid_create(5,5);
//Priority Queue for Spawning Blocks
global.FIELD_EMPTIES_QUEUE = ds_priority_create();
// Lists of Cells To Represent Spawning Blocks
for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 5; j++){
        global.FIELD_EMPTIES[# i, j] = ds_list_create();
        ds_priority_add(global.FIELD_EMPTIES_QUEUE, global.FIELD_EMPTIES[# i, j], 0);
    }
}
// Empty SubGrid Size 
global.FIELD_EMPTIES_SIZE = 0; 


// Field Pool Data
global.FIELD_POOL = ds_queue_create();
global.BEATER_POOL = ds_queue_create();

globalvar SPAWNER_CHANCE_DATA;
SPAWNER_CHANCE_DATA = ds_map_create();

// Dynamic Aimer Stuff
//scr_dynamic_aimer_init()



// Death Timers
global.DEATH_TIMERS_GRID = ds_grid_create(1,1);
//global.DEATH_TIMERS_COUNT = 0;
global.DEATH_TIMERS_LIST = ds_list_create();

// Bomb Timers
global.ACTIVE_BOMB_TIMERS = ds_list_create(); 
// Threshold for bomb screenshake
global.BOMB_FORCE = 0;

// Particle List (Delayed Garbage Collect) 
global.GC_particles = ds_list_create();

//Board Modifier Selector List
global.SelectedCells = ds_list_create();

// Draw Surface
//global.menuSurface = 0//surface_create(room_width,room_height);
//scr_assert_menuSurface_exists()

/*
global.fpslist = ds_list_create()
global.fpsavg = 0



#define scr_grid_data_init
///scr_grid_data_init()

ds_grid_resize(global.FIELD_OBJECTS,fieldW,fieldH);
ds_grid_clear(global.FIELD_OBJECTS,noone)
//scr_dynamic_aimer_grid_init()


#define scr_field_data_clear
///scr_field_data_clear()

//Clear Field Data for New Field

// Clear Field Objects Grid
ds_grid_clear(global.FIELD_OBJECTS,noone); //fill the gamefield grid with noone
// Clear Bomb Detonation Timers
scr_death_timers_clear();
// Clear Empty Cell Queue
scr_field_empty_clear()
// Clear Respawn Timers
scr_field_respawn_clear()
// Clear Dynamic Aimer Data
//scr_dynamic_aimer_grid_clear()

#define scr_field_data_dealloc
///scr_field_data_dealloc()

//NB: Mostly useful on HTML5 because of refreshing



// Game Field Data
ds_grid_destroy(global.FIELD_OBJECTS);
ds_list_destroy(global.FIELD_RESPAWNS);

// Pool Objects
ds_queue_destroy(global.FIELD_POOL);
ds_queue_destroy(global.BEATER_POOL);

//Priority Queue for Spawning Blocks
ds_priority_destroy(global.FIELD_EMPTIES_QUEUE)
// Lists of Cells To Represent Spawning Blocks
for (var i = 0; i < 5; i++) {
    for (var j = 0; j < 5; j++){
        ds_list_destroy(global.FIELD_EMPTIES[# i, j])
    }
}
// Grid for Spawning Blocks
ds_grid_destroy(global.FIELD_EMPTIES);


ds_map_destroy(SPAWNER_CHANCE_DATA);

// Dynamic Aimer Stuff
//scr_dynamic_aimer_dealloc()



// Death Timers
ds_grid_destroy(global.DEATH_TIMERS_GRID);
ds_list_destroy(global.DEATH_TIMERS_LIST);

// Bomb Timers
ds_list_destroy(global.ACTIVE_BOMB_TIMERS);

// Particle List (Delayed Garbage Collect) 
var gc_size = ds_list_size(global.GC_particles)
for (var i = gc_size-1; i>=0; i-=1)
{
    // Get Particle Data
    var gc_array = global.GC_particles[| i];
    part_type_destroy(gc_array[0]);
    ds_list_delete(global.GC_particles,i);
}
ds_list_destroy(global.GC_particles)

//Board Modifier Selector List
ds_list_destroy(global.SelectedCells);