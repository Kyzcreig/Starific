#define scr_beat_effect
///scr_beat_effect(beat type, alpha)

var beatType = argument0;
var beatAlpha = argument1;

switch beatType{
    case 'A':
        with obj_reflector_basic{
            scr_create_beater(beatAlpha,obj_beat_FX_thump);
        }
    break;
    case 'B':
        with obj_reflector_cwise{
            scr_create_beater(beatAlpha,obj_beat_FX_thump);
        }
    break;
    case 'C':
        with obj_reflector_ccwise{
            scr_create_beater(beatAlpha,obj_beat_FX_thump);
        }
    break;
    case 'D':
        with obj_reflector_special_parent{
            scr_create_beater(beatAlpha,obj_beat_FX_thump);
        }
    break;
    
    case 'E':
        with obj_reflector_parent_basic{
            scr_create_beater(beatAlpha,obj_beat_FX_spin);
        }
        with obj_reflector_special_parent{
            scr_create_beater(beatAlpha,obj_beat_FX_spin);
        }
    break;
    case 'Z':
        var_beat_list = "Z";
        with obj_reflector_basic
            {var Beat = instance_create(x,y,obj_beat_FX_thump);
                Beat.sprite_index = sprite_index
                Beat.image_alpha = 0.5
                Beat.image_blend = image_blend}
    break;
}
 

#define scr_create_beater
///scr_create_beater(alpha, object_index)

var beat;

// Spawn Beater
if RESOURCE_POOLING {
    // Pool Spawn
    if ds_queue_size(global.BEATER_POOL) > 0 {
        beat = ds_queue_dequeue(global.BEATER_POOL);
        with (beat) {
            x = other.x;
            y = other.y;
            instance_change(argument1,true);
        }
    }
}
else {
    // Normal Spawn 
    beat = instance_create(x,y,argument1);
}

// Set Params
with (beat) {
    sprite_index = other.sprite_index;
    image_alpha = other.argument0;//0.5 //set base alpha
    image_blend = other.image_blend;
    objType = other.objType;
    image_xscale = other.image_xscale;
    image_yscale = other.image_yscale;

}

return beat;

#define scr_beater_destroy
///scr_beater_destroy()

// Relocate
x = -100; y = -100;
if RESOURCE_POOLING {
    instance_change(obj_beat_pool,true);
} else {
    instance_destroy();
}

#define scr_beater_enqueue
///scr_beater_enqueue(id)

ds_queue_enqueue(global.BEATER_POOL, argument0);