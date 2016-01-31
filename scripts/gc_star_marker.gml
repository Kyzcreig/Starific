///gc_star_marker()

///particle launch effect

if ParticleDeath{ 
    var particleCount = scr_particle_explosion_count(0)
    
    particleCount = round(particleCount * 2);
    //part_type_orientation(p_destroy_ring_long,0,359,random_range(-2.5,2.5),0,1); //rangerandom(-2,2);
    part_type_orientation(p_destroy_ring_long,0,360,0,0,1); //rangerandom(-2,2);
    part_particles_create_color(PSYS_FIELD_LAYER, x, y, p_destroy_sparkles_long, marker_col , particleCount);//1
    part_particles_create_color(PSYS_FIELD_LAYER, x, y, p_destroy_ring_long, marker_col, 1);

    
}
