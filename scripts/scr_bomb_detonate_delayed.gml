#define scr_bomb_detonate_delayed
///scr_bomb_detonate_delayed(dataXY)
var dataXY;
dataXY = argument[0]

///If Cell is "Valid" inside corners
if !MOVE_ACTIVE or gamecell_is_valid(dataXY[0],dataXY[1],0)
{

    // Get Cell Data
    var cellData = global.FIELD_OBJECTS[# dataXY[0],dataXY[1]];
    // If Object
    if (cellData > DENSITY){
        // Detonate
        with (cellData){
            bomb = true;
            //destroyer = other.destroyer
            event_perform(ev_other, ev_user0);
            //instance_destroy();
        }
    }
    // Else Spawn Faux Detonation Particle Effect
    else{ 
        var fieldXY = convertGridtoXY(dataXY[0],dataXY[1]);
        scr_bomb_particle_effect(fieldXY[0], fieldXY[1], dataXY[3]);
        
    }
}

#define scr_particle_explosion_count
///scr_particle_explosion_count(type)

switch argument0{

// Board Clear = false
case 0:
    return 10;
break;

// Board Clear = true
case 1:
    return 6;
break; 

// Extra
case 2:
    return 15;
break;

default:
    return 10;
break;
}


//return clamp(12 - scr_particle_explosion_queue(true,true),6,12)

#define scr_particle_explosion_number
///scr_particle_explosion_number()

return part_particles_count(PSYS_FIELD_LAYER) >> 4;
//NB: Bit shift right is faster than div 16.
//div 16

#define scr_particle_explosion_queue
//scr_particle_explosion_queue(divide particle, divide dying)
return (scr_particle_explosion_number() /(1+(gridSize-1)*argument0) + scr_death_timers_count()/(1+(gridSize-1)*argument1))

#define scr_bomb_particle_effect
///scr_bomb_particle_effect(x,y, boardClear);

var pdensity = scr_particle_explosion_count(argument2)
part_particles_create_color(PSYS_FIELD_LAYER, argument0, argument1, p_destroy_sparkles, COLORS[4], pdensity);//10
part_particles_create_color(PSYS_FIELD_LAYER, argument0, argument1, p_destroy_ring,  COLORS[4], 1);
        //instance_create(aax*cellW+ox+cellW/2, aay*cellW+oy+cellH/2, obj_explosion_bomb);