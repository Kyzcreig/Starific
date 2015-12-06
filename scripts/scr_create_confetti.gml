#define scr_create_confetti
///scr_create_confetti(x, y, num1, num2, texture_page)

var pCol;
var fieldX = argument0;
var fieldY = argument1;
var count1 = argument2;
var count2 = argument3;
var tex_page = argument4;


// Set Sprite Based on Texture Page
scr_confetti_set_sprite(partConfetti_1, tex_page);
scr_confetti_set_sprite(partConfetti_2, tex_page);


// Create Ripple Effect
//instance_create(fieldX, fieldY, obj_ripple);

var pCol;
// Create Confetti 1
for (var z = 0; z < count1; z++) {
    pCol = irandom_range(0, 5);
    part_particles_create_colour( PSYS_STAR_LAYER, fieldX, fieldY, partConfetti_1, COLORS[pCol], 1);
}
// Create Confetti 2
for (var z = 0; z < count2; z++) {
    pCol = irandom_range(0, 5);
    part_particles_create_colour( PSYS_STAR_LAYER, fieldX, fieldY, partConfetti_2, COLORS[pCol], 1);
}

#define scr_confetti_set_sprite
///scr_confetti_set_sprite(particle_type, texture_page)

var cur_par = argument0;
var tex_page = argument1;

// Set Texture Page
switch tex_page{

case 0:
    // Set Particle Sprite
    part_type_sprite(cur_par, sp_particle_square_full_menu, false, false, false); 
break;

case 1:
    // Set Particle Sprite
    part_type_sprite(cur_par, sp_particle_square_full, false, false, false); 

break;


}