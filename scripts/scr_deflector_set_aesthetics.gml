///scr_deflector_set_aesthetics()



if scr_deflector_is_projectile(objType) and 
   scr_gamemod_get_index("mystery_powers", 8) > 0 
   //object_is_ancestor(object_index, obj_powerup_projectile_parent) or object_index == obj_powerup_falling
{
    //Set Sprite and Symbol
    sprite_index = object_get_sprite(scr_deflector_get_direct_parent(3));
    symSprite = spr_power_mystery;
    symDraw = sprite_exists(symSprite);
    
    //Set Colors
    image_blend = power_type_colors(3, 0);
    symColor = power_type_colors(3, 1); 
    
} else {
    //Set Sprite and Symbol
    sprite_index = object_get_sprite(scr_deflector_get_direct_parent(objType));
    symSprite = objData[4];
    symDraw = sprite_exists(symSprite);
    
    //Set Colors
    image_blend = power_type_colors(objType, 0);
    symColor = power_type_colors(objType, 1);
}

// Hidden Icons GameMod
if scr_gamemod_get_index("hidden_icons", 8) > 0 {
    symSprite = noone;
    symDraw = false;
}

