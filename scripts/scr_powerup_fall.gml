///scr_powerup_fall()

//if argument[0] != 13 and argument[0] != 9 return 0
//if instance_number(obj_powerup_falling) > 5 {return 0}


var obj = instance_create( x + cellW/2 * choose(1,-1),
                           y + cellH/2 * choose(1,-1),
                           obj_powerup_falling);
    //NB: We offset it the from the actual grid so it's less obstructive.

with(obj){
    direction = other.odir
    //if other.odir mod 90 != 0{direction = other.ndir - 180
    sprite_index = other.sprite_index 
    objData = other.objData;
    objIndex = other.object_index;
    symSprite = other.symSprite
    symDraw = other.symDraw 
    symColor = other.symColor
    //lerp1 = TweenSimpleScale(1, 1, 1.25, 1.25, 75, EaseInBounce);
    oSize = obj_control_game.pFallingSize//1.25 
    oScalar = obj_control_game.pFallingScalar;
    oScale = other.oScale * oScalar//objectScale
    symScale = other.symScaleStart * oScalar //cellW/60
    //this would mess up when it hit an object scaling into existance
    image_xscale = oScale
    image_yscale = oScale//objectScale
    image_speed = other.image_speed
    top_speed = max(3*RMSPD_DELTA,other.spe * random_range(.5,1.25));
    destroyer = other.destroyer
    image_blend = other.image_blend;
    image_angle = direction
    
    objType = other.objType
    boardClear = other.boardClear
    //If board clear, give random direction and 10% chance of diagonal
    if boardClear{ 
        direction = irandom(3) * 90 + (45*(random(1) <= .1))
    }
    
    starModifiers = other.starModifiers;
    
    //This is used for boardwipes setting reflector vars
    ndir = other.ndir //Bombs won't go off if this is used so it doesn't (continued)
    odir = other.odir //matter that they would cause bombs to overlap without rng
    
    
    //maybe add some particle effect for falling powerup trigger
}
