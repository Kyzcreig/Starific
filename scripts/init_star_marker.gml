///init_star_marker()

var gridCoords = convertXYtoGrid(x,y)

gridX = gridCoords[0];
gridY = gridCoords[1];

selected[0] = true; 
//detoggle this with a with(obj_star_marker) call when mixers are selected

markerDir = noone; //unused but bugged?
marker_dir = noone;

///birth tween
marker_col = COLORS[0];
arrowEndXY = noone;
arrowEndX = 0;
arrowEndY = 0;

marker_spr = object_get_sprite(obj_powerup_parent_neutral)//sprite_index;

marker_scale = cellH/sprite_get_width(marker_spr)




star_spr = object_get_sprite(obj_star);
star_rad = 2*cellW
star_scale = star_rad*2/sprite_get_width(star_spr);

Creator_ID = obj_control_modifiers.id;

mixers_alpha = MixersEase; 


//Easer
markerTween[0] = 0;
TweenMarker = TweenFire(id,markerTween,EaseLinear,
                TWEEN_MODE_ONCE,1,0,.5,0,1)

//Birth tween effect
//symScale = 0; symScaleStart = 0; //necessary to use reflectorscale
//tweenSpawn = TweenFire(id,reflectorScale__,false,EaseLinear,0,1,room_speed*.5)
//TweenSimpleScale(0,0,image_xscale,image_yscale,room_speed*.5,EaseLinear)
//TweenDestroyWhenDone(tweenSpawn,true);
part_particles_create_color(PSYS_FIELD_LAYER, x, y, p_spawn,marker_col,1);


hoverScale = 1;
hoverSelected = true;

star_launch = false;
ParticleDeath = false;//true;
