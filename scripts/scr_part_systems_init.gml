#define scr_part_systems_init
///scr_part_systems_init()


globalvar PSYS_SUBSTAR_LAYER, PSYS_FIELD_LAYER, PSYS_STAR_LAYER;


//Create Systems ,above and below
PSYS_SUBSTAR_LAYER = part_system_create()
PSYS_STAR_LAYER = part_system_create()
PSYS_FIELD_LAYER = part_system_create()

part_system_position(PSYS_SUBSTAR_LAYER, 0, 0);
part_system_position(PSYS_FIELD_LAYER, 0, 0);
part_system_position(PSYS_STAR_LAYER, 0, 0);

scr_part_systems_set_depth();


//globalvar PSYS_SUBSTAR_LAYER_EMITTER;
//PSYS_SUBSTAR_LAYER_EMITTER = part_emitter_create(PSYS_SUBSTAR_LAYER)

globalvar 
VFX_LEVEL;

ini_open("savedata.ini")
    VFX_LEVEL = ini_read_real("settings", "VFX_LEVEL", 1);
ini_close();

// Part Type Declarations
scr_part_types_declare()


//Part Type Settings
scr_part_types_set()



#define scr_part_types_declare
///scr_part_types_declare()


globalvar p_spr_star;
p_spr_star = part_type_create();

//globalvar p_trail;
//p_trail = part_type_create();

globalvar p_impact;
p_impact = part_type_create();

globalvar p_launch;
p_launch = part_type_create();

globalvar p_catch;
p_catch = part_type_create()

globalvar p_catch_bad;
p_catch_bad = part_type_create()

globalvar p_catch_neutral;
p_catch_neutral = part_type_create()

globalvar p_catch_good;
p_catch_good = part_type_create()

globalvar p_spawn;
p_spawn = part_type_create();

globalvar p_unspawn;
p_unspawn = part_type_create();

globalvar p_destroy_sparkles;
p_destroy_sparkles = part_type_create();

globalvar p_destroy_ring;
p_destroy_ring = part_type_create();

globalvar p_destroy_sparkles_long;
p_destroy_sparkles_long = part_type_create();

globalvar p_destroy_ring_long;
p_destroy_ring_long = part_type_create();

globalvar partConfetti_1;
partConfetti_1 = part_type_create();

globalvar partConfetti_2;
partConfetti_2 = part_type_create();

globalvar partConfetti_3;
partConfetti_3 = part_type_create();


globalvar pFallingParticle;
for(var i=0;i<3;i++){ //for each sprite
    for(var j=0;j<8;j++){ //for each direction
        pFallingParticle[i,j] = part_type_create();
    }
}


#define scr_part_types_set
////scr_part_types_set()

///NB: It's best practice to use texture allocated sprites to avoid texture page switching
///Instead of any inbuilt shapes
var cur_par;

cur_par = p_spr_star;
part_type_sprite(cur_par,s_v_star_white,0,0,0);
part_type_size(cur_par,1,1,-0.01*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_scale(cur_par,1,1);
//part_type_color2(cur_par,c_white,COLORS[6]);
part_type_alpha2(cur_par,1,0.2);
//part_type_speed(cur_par,1*RMSPD_DELTA,1*RMSPD_DELTA,0*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_direction(cur_par,0,359,0*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_gravity(cur_par,0*RMSPD_DELTA,270);
part_type_orientation(cur_par,0,0,0*RMSPD_DELTA,0*RMSPD_DELTA,1);
part_type_life(cur_par,room_speed*.4,room_speed*.4);



cur_par = p_impact;
//part_type_shape(cur_par,pt_shape_pixel);
//part_type_shape(cur_par,pt_shape_flare);
part_type_sprite(cur_par,sp_particle_dot,0,0,0);
//part_type_size(cur_par,0.1,0.2,0*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_size(cur_par,1,1,0*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_scale(cur_par,1,1);
part_type_color1(cur_par,c_white);//16777215);
//part_type_alpha2(cur_par,1,0.75);
part_type_alpha2(cur_par,1,0);
part_type_speed(cur_par,0*RMSPD_DELTA,1.5*RMSPD_DELTA,0*RMSPD_DELTA,0*RMSPD_DELTA)//0.10);
part_type_orientation(cur_par,0,0,0*RMSPD_DELTA,0*RMSPD_DELTA,1);
//part_type_blend(cur_par,1);
part_type_life(cur_par,room_speed*.5,room_speed*.5);


cur_par = p_launch;
part_type_sprite(cur_par,sp_particle_dot,0,0,0);
part_type_size(cur_par,1,1,0*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_scale(cur_par,1,1);
part_type_color1(cur_par,c_white);//16777215);
//part_type_alpha2(cur_par,1,0.75);
//part_type_alpha2(cur_par,1,1);
part_type_speed(cur_par,0*RMSPD_DELTA,1.5*RMSPD_DELTA,0*RMSPD_DELTA,0*RMSPD_DELTA)//0.10);
part_type_orientation(cur_par,0,0,0*RMSPD_DELTA,0*RMSPD_DELTA,1);
//part_type_blend(cur_par,1);
part_type_life(cur_par,room_speed*.5,room_speed*.5);



///Particles for Special Deflectors

/* NB: We need so many because we need 1 for each possible type and direction.
        Which is 3x8.  Alternatively you could have one for each instance
        But I Think this is cleaner.
        
        Also particles aren't super heavy on memory so it's no problem.

*/
var pFallingSprite, pFallingColor, pFallingScale;

pFallingSprite[0] = object_get_sprite(obj_powerup_parent_ups)//s_v_deflector_powerdown
pFallingSprite[1] = object_get_sprite(obj_powerup_parent_downs)
pFallingSprite[2] = object_get_sprite(obj_powerup_parent_neutral)

pFallingColor[0] = c_white//COLORS[1] //powerup
pFallingColor[1] = c_white//COLORS[2] //powerdown
pFallingColor[2] = c_white//COLORS[3] //neutrals

pFallingScale =  1//1.25 * cellH/sprite_get_width(s_v_deflector_basic)
    //NB: Scaling must be done at runtime based on grid size, etc.

for(var i=0;i<3;i++){ //for each sprite
    for(var j=0;j<8;j++){ //for each direction
        cur_par = pFallingParticle[i,j];
        part_type_sprite(cur_par,pFallingSprite[i],0,0,0);
        part_type_size(cur_par,1,1,-0.02*RMSPD_DELTA,0*RMSPD_DELTA);
        part_type_scale(cur_par,pFallingScale,pFallingScale);
        part_type_color1(cur_par,pFallingColor[i]);
        part_type_alpha2(cur_par,1,0.2);
        //part_type_speed(cur_par,1*RMSPD_DELTA,1*RMSPD_DELTA,0*RMSPD_DELTA,0*RMSPD_DELTA);
        //part_type_direction(cur_par,0,359,0*RMSPD_DELTA,0*RMSPD_DELTA);
        //part_type_gravity(cur_par,0*RMSPD_DELTA,270);
        //part_type_blend(cur_par,0);
        //part_type_orientation(cur_par,image_angle,image_angle,0*RMSPD_DELTA,0*RMSPD_DELTA,0);
        part_type_orientation(cur_par,j*45,j*45,0*RMSPD_DELTA,0*RMSPD_DELTA,1);
        //part_type_life(p_spr_fall,room_speed*5,room_speed*5);
        part_type_life(cur_par,room_speed*.4,room_speed*.4);
    }
}




cur_par = p_catch;
part_type_sprite(cur_par,sp_particle_dot,0,0,0);
part_type_size(cur_par,1,1,0*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_shape(cur_par,pt_shape_flare);//pt_shape_pixel
//part_type_sprite(cur_par,sp_particle_sparkle_good,0,0,0);
//part_type_size(cur_par,0.1,0.2,0*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_scale(cur_par, 1, 1);//good for circle/ring->ellipses :)
part_type_speed(cur_par,0*RMSPD_DELTA,3*RMSPD_DELTA,0*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_direction(cur_par,0,360,0*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_gravity(cur_par,0*RMSPD_DELTA,choose(0,90,180,270));
part_type_color1(cur_par,c_white);
//part_type_alpha2(cur_par,1,0.5);
part_type_alpha1(cur_par,1);//
if VFX_LEVEL == 0 {
    part_type_alpha1(cur_par,.75); //EVALUATE ME
}
part_type_life(cur_par,room_speed*.5,room_speed*1);//multiply by roomspeed?


cur_par = p_catch_bad;
part_type_sprite(cur_par,sp_particle_sparkle_neutral,0,0,0);
part_type_size(cur_par,0.25,.5,0*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_scale(cur_par, 1, 1);//good for circle/ring->ellipses :)
//part_type_speed(cur_par,0.375*RMSPD_DELTA,3*RMSPD_DELTA,0*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_speed(cur_par,0*RMSPD_DELTA,2.5*RMSPD_DELTA,0*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_direction(cur_par,0,359,3*RMSPD_DELTA,20*RMSPD_DELTA);//*RMSPD_DELTA
//part_type_gravity(cur_par,0*RMSPD_DELTA,choose(0,90,180,270));
part_type_orientation(cur_par,0,360,1*RMSPD_DELTA,0*RMSPD_DELTA,1);//0,10,1);
part_type_color1(cur_par,c_white);
//part_type_alpha2(cur_par,1,0.4);
part_type_alpha1(cur_par,1);//
if VFX_LEVEL == 0 {
    part_type_alpha1(cur_par,.75); //EVALUATE ME
}
part_type_life(cur_par,room_speed*.3,room_speed*.6);//multiply by roomspeed?


cur_par = p_catch_neutral;
part_type_sprite(cur_par,sp_particle_circle_outline,0,0,0);
part_type_size(cur_par,.1,.40,0*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_scale(cur_par, 1, 1);//good for circle/ring->ellipses :)
part_type_speed(cur_par,.05*RMSPD_DELTA,2.5*RMSPD_DELTA,0*RMSPD_DELTA,0*RMSPD_DELTA);//0.375
part_type_direction(cur_par,0,359,1*RMSPD_DELTA,10*RMSPD_DELTA);
//part_type_gravity(cur_par,0*RMSPD_DELTA,choose(0,90,180,270));
part_type_orientation(cur_par,0,360,0*RMSPD_DELTA,10*RMSPD_DELTA,1);
part_type_color1(cur_par,c_white);
//part_type_alpha2(cur_par,1,0.2);
part_type_alpha1(cur_par,1);//
if VFX_LEVEL == 0 {
    part_type_alpha1(cur_par,.75); //EVALUATE ME
}
part_type_life(cur_par,room_speed*.35,room_speed*.7);//multiply by roomspeed?


cur_par = p_catch_good;
part_type_sprite(cur_par,sp_particle_dot,0,0,0);
part_type_size(cur_par,1,1,0*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_sprite(cur_par,sp_particle_sparkle_good,0,0,0);
//part_type_size(cur_par,0.1,.25,0*RMSPD_DELTA,0*RMSPD_DELTA);//.1
//part_type_scale(cur_par, 1, 1);//good for circle/ring->ellipses :)
part_type_speed(cur_par,0*RMSPD_DELTA,3*RMSPD_DELTA,0*RMSPD_DELTA,0*RMSPD_DELTA);//0.375
part_type_direction(cur_par,0,360,0*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_gravity(cur_par,0*RMSPD_DELTA,choose(0,90,180,270));
part_type_orientation(cur_par,0,360,0,10,1);
part_type_color1(cur_par,c_white);
//part_type_alpha2(cur_par,1,0.4);
part_type_alpha1(cur_par,1);//
if VFX_LEVEL == 0 {
    part_type_alpha1(cur_par,0.75); //EVALUATE ME
}
part_type_life(cur_par,room_speed*.5,room_speed*1);//1


cur_par = p_spawn;
part_type_sprite(cur_par,sp_particle_flare,0,0,0);
//part_type_shape(cur_par,pt_shape_flare);
part_type_size(cur_par,0.10,0.10,0.0225*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_size(cur_par,0.15,0.15,0.0225*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_scale(cur_par,1.5,1.5);//.5);
//NB: Color overwritten in obj_reflector_parent
part_type_color1(cur_par,c_white);//c_white);  COLORS[5]
part_type_alpha2(cur_par,1,0.50);
part_type_life(cur_par,room_speed*.5,room_speed*.5);



cur_par = p_unspawn;
part_type_sprite(cur_par,sp_particle_flare,0,0,0);
part_type_size(cur_par,.775,.775,-0.0225*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_size(cur_par,0.775,0.775,-0.0225*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_size(cur_par,0.15,0.15,0.0225*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_scale(cur_par,1.5,1.5);//.5);
//Color overwritten in obj_reflector_parent
part_type_color1(cur_par,c_white);//c_white);  COLORS[5]
part_type_alpha2(cur_par,1,0.50);
part_type_life(cur_par,room_speed*.5,room_speed*.5);
//So actually most of these do work by changing how it looks on creation

//Grab Default Values for later manipulation
globalvar P_Destroy_Vals;
var z = -1;
P_Destroy_Vals = noone;
P_Destroy_Vals[++z] = 1;
    //NB: This is used to let us tween the duration of explosion field particles.


//Grab Default Values for later manipulation
P_Destroy_Vals[++z] = room_speed*.5;

cur_par = p_destroy_sparkles;
//part_type_shape(cur_par,pt_shape_star);
part_type_sprite(cur_par,sp_particle_star_five,0,0,0);
part_type_size(cur_par,0.30,0.30,-0.0075*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_size(cur_par,0.30,0.30,-0.015*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_scale(cur_par,1,1);
part_type_speed(cur_par,0.4*RMSPD_DELTA,4*RMSPD_DELTA,-0.02*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_direction(cur_par,0,359,0*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_orientation(cur_par,0,359,10*RMSPD_DELTA,0*RMSPD_DELTA,1);
part_type_alpha1(cur_par,1);
if VFX_LEVEL == 0 {
    part_type_alpha2(cur_par,.5,0.5); //EVALUATE ME
}
part_type_life(cur_par,P_Destroy_Vals[z],P_Destroy_Vals[z]);
//part_type_life(cur_par,room_speed*.5,room_speed*.5);


//Grab Default Values for later manipulation
P_Destroy_Vals[++z] = room_speed*.45;

cur_par = p_destroy_ring;
//part_type_shape(cur_par,pt_shape_circle);
part_type_sprite(cur_par,sp_particle_circle_outline,0,0,0);
part_type_size(cur_par,0.05,0.05,0.015*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_size(cur_par,0.05,0.05,0.03*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_scale(cur_par,1,1);
part_type_alpha1(cur_par,1);
if VFX_LEVEL == 0 {
    part_type_alpha2(cur_par,.5,0.5); //EVALUATE ME
}
part_type_life(cur_par,P_Destroy_Vals[z],P_Destroy_Vals[z]);
//part_type_life(cur_par,room_speed*.45,room_speed*.45);



//Grab Default Values for later manipulation
P_Destroy_Vals[++z] = room_speed*.7;

cur_par = p_destroy_sparkles_long;
//part_type_shape(cur_par,pt_shape_star);
part_type_sprite(cur_par,sp_particle_star_five,0,0,0);
part_type_size(cur_par,0.30,0.30,-0.0075*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_size(cur_par,0.30,0.30,-0.015*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_scale(cur_par,1,1);
part_type_speed(cur_par,0.35*RMSPD_DELTA,3.5*RMSPD_DELTA,-0.02*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_direction(cur_par,0,359,0*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_orientation(cur_par,0,359,10*RMSPD_DELTA,0*RMSPD_DELTA,1);
part_type_alpha1(cur_par,1);
if VFX_LEVEL == 0 {
    part_type_alpha2(cur_par,.5,0.5); //EVALUATE ME
}
part_type_life(cur_par,P_Destroy_Vals[z],P_Destroy_Vals[z]);
//part_type_life(cur_par,room_speed*.7,room_speed*.7);


//Grab Default Values for later manipulation
P_Destroy_Vals[++z] = room_speed*.63;

cur_par = p_destroy_ring_long;
//part_type_sprite(cur_par,sp_particle_star_outline,0,0,0);
part_type_sprite(cur_par,sp_particle_circle_outline,0,0,0);
part_type_size(cur_par,0.05,0.05,0.015*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_scale(cur_par,1,1);
//part_type_alpha2(cur_par,1,0.5);//.2
//part_type_blend(cur_par,1);
part_type_orientation(cur_par,0,359,2*RMSPD_DELTA,0*RMSPD_DELTA,1); //rangerandom(-2,2);
part_type_alpha1(cur_par,1);
if VFX_LEVEL == 0 {
    part_type_alpha2(cur_par,.5,0.5); //EVALUATE ME
}
part_type_life(cur_par,P_Destroy_Vals[z],P_Destroy_Vals[z]);
//part_type_life(cur_par,room_speed*.63,room_speed*.63);



// Create Confetti Particle Type
cur_par = partConfetti_1;
scr_part_types_set_confetti(cur_par);

// Create Confetti Particle Type
cur_par = partConfetti_2;
scr_part_types_set_confetti(cur_par);

// Create Confetti Particle Type
cur_par = partConfetti_3;
scr_part_types_set_confetti(cur_par);




/*
globalvar p_destroy_sparkles_bomb;
p_destroy_sparkles_bomb = part_type_create();
part_type_sprite(cur_par,sp_particle_star_five,0,0,0);
part_type_size(cur_par,0.30,0.30,-0.0075*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_scale(cur_par,1,1);
part_type_speed(cur_par,0.4*RMSPD_DELTA,4*RMSPD_DELTA,-0.02*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_direction(cur_par,0,359,0*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_orientation(cur_par,0,359,10*RMSPD_DELTA,0*RMSPD_DELTA,1);
part_type_life(cur_par,room_speed*.5,room_speed*.5);



globalvar p_destroy_ring_bomb;
p_destroy_ring_bomb = part_type_create();
//part_type_shape(cur_par,pt_shape_circle);
part_type_sprite(cur_par,sp_particle_circle_outline,0,0,0);
part_type_size(cur_par,0.05,0.05,0.015*RMSPD_DELTA,0*RMSPD_DELTA);
//part_type_size(cur_par,0.05,0.05,0.03*RMSPD_DELTA,0*RMSPD_DELTA);
part_type_scale(cur_par,1,1);
part_type_life(cur_par,room_speed*.45,room_speed*.45);


/*
for (i=0; i<1;i++)
{
    p_trail[i] = part_type_create();
    cur_par = p_trail[i];
    part_type_sprite(cur_par,sp_particle_star_five,0,0,0);
    //part_type_shape(p_trail[i],pt_shape_star);
    part_type_size(cur_par,0.1,0.5,-0.0075*RMSPD_DELTA,0*RMSPD_DELTA);
    part_type_scale(cur_par,1,1);//.5);
    part_type_color1(cur_par,c_white);//506 6061);  5704 403
    //part_type_alpha2(p_trail[i],1,.20);
    part_type_speed(cur_par,0.1*RMSPD_DELTA,.5*RMSPD_DELTA,0*RMSPD_DELTA,0*RMSPD_DELTA);
    part_type_direction(cur_par,0,359,0*RMSPD_DELTA,0*RMSPD_DELTA);
    part_type_orientation(cur_par,0,359,2*RMSPD_DELTA,0*RMSPD_DELTA,1);
    //part_type_life(cur_par,room_speed*.5,room_speed*.5);
    part_type_life(cur_par,room_speed,room_speed);
}*/




#define scr_part_systems_set_depth
///scr_part_systems_set_depth()


part_system_depth(PSYS_SUBSTAR_LAYER,-800) //also set in obj_powerup_falling
part_system_depth(PSYS_STAR_LAYER,-900)
part_system_depth(PSYS_FIELD_LAYER,1000)
#define scr_part_types_adjust_for_game
///scr_part_types_adjust_for_game()

                    
var sparkScale = objectScale*6
var ringScale = objectScale*7.5

part_type_scale(p_destroy_sparkles,sparkScale,sparkScale);
part_type_scale(p_destroy_ring,ringScale,ringScale);

part_type_scale(p_destroy_sparkles_long,sparkScale,sparkScale);
part_type_scale(p_destroy_ring_long,ringScale,ringScale);

//part_type_scale(p_destroy_sparkles_bomb,sparkScale,sparkScale);
//part_type_scale(p_destroy_ring_bomb,ringScale,ringScale);

part_type_scale(p_spr_star,8/5*cellSize/sprite_get_width(s_v_star_white),8/5*cellSize/sprite_get_width(s_v_star_white));
//for (i=0; i<3;i++){part_type_scale(p_spr_fall[i],1.25*cellSize/sprite_get_width(p_sprite[i]),1.25*cellSize/sprite_get_width(p_sprite[i]));}

//Scale Falling Powerup Particle
pFallingScalar = 1.4;
pFallingSize = pFallingScalar * cellSize
//pFallingScalar = 1.4//25
pFallingScale = pFallingSize/sprite_get_width(s_v_deflector_basic)
for(var i=0;i<3;i++){ //for each sprite
    for(var j=0;j<8;j++){ //for each direction
        part_type_scale(pFallingParticle[i,j],pFallingScale,pFallingScale);
    }
}

//Scale Respawn/Unspawn Particles
var spawnPartScale = 3*objectScale 
part_type_scale(p_spawn,spawnPartScale,spawnPartScale);
part_type_scale(p_unspawn,spawnPartScale,spawnPartScale);

//Scale Power Catch Particles
var powerPartScale = 2*objectScale
part_type_scale(p_catch_good,powerPartScale,powerPartScale);
part_type_scale(p_catch_neutral,powerPartScale,powerPartScale);
part_type_scale(p_catch_bad,powerPartScale,powerPartScale);
part_type_scale(p_catch,powerPartScale,powerPartScale);


//part_type_scale(p_destroy_sparkles_powerup,1.5*sparkScale,1.5*sparkScale);
//part_type_scale(p_destroy_ring_powerup,1.5*ringScale,1.5*ringScale);


#define scr_part_types_set_confetti
///scr_part_types_set_confetti(particle_type)

var cur_par = argument0;

part_type_sprite(cur_par, sp_particle_square_full, false, false, false); 
part_type_scale(cur_par, .5, 1);
    // Instead of using subimages and creating 32 all at once, we could loop through
    // to create 32 with a random (valid) theme color, via part create colour
//part_type_orientation(cur_par, 0, 360, 0, 5, 0); 
part_type_orientation(cur_par, 0, 360, 0*RMSPD_DELTA, 0*RMSPD_DELTA, 0); 
//part_type_gravity(cur_par, 0.2*RMSPD_DELTA, 270);
part_type_gravity(cur_par, 0.15*RMSPD_DELTA, 270);
//part_type_direction(cur_par, 0, 360, 0*RMSPD_DELTA, 30*RMSPD_DELTA);
part_type_direction(cur_par, 0, 360, 0*RMSPD_DELTA, 0*RMSPD_DELTA);
//part_type_speed(cur_par, 3*RMSPD_DELTA, 6*RMSPD_DELTA, -0.15*RMSPD_DELTA, 0*RMSPD_DELTA);
part_type_speed(cur_par, .5*RMSPD_DELTA, 8*RMSPD_DELTA, -.05*RMSPD_DELTA, 0*RMSPD_DELTA);
part_type_alpha3(cur_par, 1, 1, .5);
if VFX_LEVEL == 0 {
    part_type_alpha3(cur_par, .75, .75, .5); //EVALUATE ME
}
part_type_size(cur_par, 0.2, 0.3, 0*RMSPD_DELTA, 0*RMSPD_DELTA);
//part_type_life(cur_par, 30, 90);
//part_type_life(cur_par, 60, 120);
part_type_life(cur_par, 1*room_speed, 3*room_speed);