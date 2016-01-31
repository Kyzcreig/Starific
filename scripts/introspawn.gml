#define introspawn
///introspawn(INTRO_ANGLE, INTRO_RAD, INTRO_DIST, INTRO_DUR,INTRO_EASE)

var tweenData = scr_tweenspawn_options(argument0,argument1,argument2,argument3) //argument4
    
switch argument4{//sp_ease
       case 0: 
           var refEase = EaseInOutQuart
           break
       case 1:
           var refEase = EaseInOutBack
           break
       
       case 2:
           var refEase = EaseInOutBounce
           break
       
       case 3:
           var refEase = EaseInOutCubic
           break
       
       case 4:
           var refEase = EaseInElastic
           break
       
       case 5:
           var refEase = EaseOutElastic
           break
       
       case 6:
           var refEase = EaseInOutElastic
           break
       
       case 7:
           var refEase = EaseInBack
           break
       
       case 8:
           var refEase = EaseInQuad
           break
       
       case 9:
           var refEase = EaseOutCirc
           break
       case 10:
           var refEase = EaseInCirc
           break
       
       default:
           var refEase = EaseOutElastic
           break;
}

// Set Start Location
var x1 = centerfieldx + dcos(tweenData[0])*tweenData[1];
var y1 = centerfieldy + dsin(tweenData[0])*tweenData[1];
//var x1 = centerfieldx + dcos((rangle))*rradius
//var y1 = centerfieldy + dsin((rangle))*rradius
// Set End Location
var x2 = x;//ax*cellW+ox+10
var y2 = y;//ay*cellH+oy+10


//Set Duration Clamp
var _introDur = clamp(tweenData[3],.25*room_speed,2.5*room_speed)
//Set location for tween
x = x1; y = y1;
// Fire Spawn Animation
tweenSpawn = TweenFire(id,reflectorScale__,EaseLinear,
                          TWEEN_MODE_ONCE,false,0,room_speed*.5,0,1); //NB: Don't use delta time here to be consistent
// Create Spawn Particle
part_particles_create_color(PSYS_FIELD_LAYER, x, y, p_spawn,image_blend,1);

// Create extended property setter
var extraData = TPExt(x1, x2, y1, y2); //creates array of coordinates
// Create Intro Tween 
//_introTween = TweenSimpleMoveInt(x1, y1, x2, y2, _introDur, refEase);   //NB: This uses TweenFire
var _introTween = TweenCreate(id,ext_xy__,refEase,
                    TWEEN_MODE_ONCE,false,0,_introDur,0,1,extraData)      
               
TweenAddCallback(tweenSpawn,TWEEN_EV_FINISH,id,TweenPlay,_introTween)
TweenDestroyWhenDone(_introTween,true);

//Begin Round When Last Tween Completes
obj_control_game.alarm[0] = max(obj_control_game.alarm[0], _introDur+room_speed*.5);


#define outrospawn
///outrospawn(INTRO_ANGLE, INTRO_RAD, INTRO_DIST, INTRO_DUR,INTRO_EASE)


var tweenData = scr_tweenspawn_options(argument0,argument1,argument2,argument3) //argument4

switch argument4{//sp_ease
       case 0: 
           var refEase = EaseInOutQuart
           break
       
       case 1:
           var refEase = EaseInOutBack
           break
       
       case 2:
           var refEase = EaseInOutBounce
           break
       
       case 3:
           var refEase = EaseInOutCubic
           break
       
       case 4:
           var refEase = EaseOutElastic
           break
       
       case 5:
           var refEase = EaseInElastic
           break
       
       case 6:
           var refEase = EaseInOutElastic
           break
       case 7:
           var refEase = EaseOutBack
           break
       
       case 8:
           var refEase = EaseOutQuad
           break
       
       case 9:
           var refEase = EaseInCirc
           break
       case 10:
           var refEase = EaseOutCirc
           break
           
           
       default:
           var refEase = EaseInElastic
           break

}
// Set Start Location
var x1 = x//ax*cellW+ox+10
var y1 = y//ay*cellH+oy+10
// Set End Location
var x2 = centerfieldx + dcos(tweenData[0])*tweenData[1];
var y2 = centerfieldy + dsin(tweenData[0])*tweenData[1];
//var x2 = centerfieldx + dcos((rangle))*rradius
//var y2 = centerfieldy + dsin((rangle))*rradius


_introDur = clamp(tweenData[3],.25*room_speed,2.5*room_speed)
_outroTween = TweenSimpleMoveInt(x1,y1,x2,y2,_introDur,refEase)//EaseOutBounce)
TweenAddCallback(_outroTween, TWEEN_EV_FINISH, id, DestroyReflector, id, false); 
TweenDestroyWhenDone(_outroTween,true);

// Set Gameover Tween In Alarm
with(obj_control_gameover) {
    alarm[0] = max(alarm[0], other._introDur + .5*room_speed);
}

#define scr_tweenspawn_options
///scr_tweenspawn_options(INTRO_ANGLE, INTRO_RAD, INTRO_DIST, INTRO_DUR) //INTRO_EASE

var tweenData = noone;
// Declare
tweenData[3] = 0;

switch argument0{//sp_angle
       case 0:
           tweenData[0] = irandom(359)
           break
       
       case 1: 
           tweenData[0] = darctan2(y-centerfieldy,x-centerfieldx); 
           break
       
       case 2:
           tweenData[0] = darctan2(y-centerfieldy,x-centerfieldx) -180; 
           break
       
       case 3:
           tweenData[0] = darctan2(y-centerfieldy,x-centerfieldx) +90; 
           break
       
       case 4:
           tweenData[0] = darctan2(y-centerfieldy,x-centerfieldx) -90; 
           break
       
       case 5:
           tweenData[0] = darctan2(y-centerfieldy,x-centerfieldx) choose(-90,90); 
           break
       
       default:
           tweenData[0] = irandom(359)
           break

}
switch argument1{//sp_rad
       case 0: 
           tweenData[1] = GAME_H/3
           break
       
       case 1://causing problems. was causing those lame jiggles
           //tweenData[1] =  point_distance(x,y,centerfieldx,centerfieldx)*2
           tweenData[1] =  GAME_H/6 + point_distance(x,y,centerfieldx,centerfieldx)*2
           //maybe we can make this conditional instead
           break

       case 2:
           tweenData[1] =  GAME_H/12 + point_distance(x,y,centerfieldx,centerfieldx)*4
           break
       
       case 3:
           tweenData[1] =  GAME_H/6 + 1+irandom(GAME_H/3)
           break
           
       case 4:
           tweenData[1] =  GAME_H/12
           break
       
       
       default:
           tweenData[1] = GAME_H/3
           break

}
switch argument2{//sp_dist
       case 0: 
           tweenData[2] = point_distance(x,y,centerfieldx,centerfieldx)
           break
       
       case 1:
           tweenData[2] = 2 * point_distance(x,y,centerfieldx,centerfieldx) + tweenData[1]
           break
           
       case 2:
           tweenData[2] = point_distance(x,y,centerfieldx,centerfieldx) + tweenData[1]
           break
       
       case 3:
           tweenData[2] = 2 * point_distance(x,y,centerfieldx,centerfieldx)
           break
       
       case 4:
           tweenData[2] = point_distance(x,y,centerfieldx,centerfieldx) / 2
           break
           
       case 5:
           tweenData[2] = (point_distance(x,y,centerfieldx,centerfieldx) + tweenData[1]) / 2
           break
           
       case 6:
           tweenData[2] = (point_distance(x,y,centerfieldx,centerfieldx) + tweenData[1]) * 2
           break
       case 7:
           tweenData[2] = (tweenData[1])
           break
           
       case 8:
           tweenData[2] = point_distance(x,y,centerfieldx,centerfieldx) + 2*tweenData[1]
           break
       
       default:
           tweenData[2] = point_distance(x,y,centerfieldx,centerfieldx)
           break

}
switch argument3{//sp_dur
       case 0: 
           tweenData[3] = .5*room_speed +irandom(1.5*room_speed)
           break
       
       case 1:
           tweenData[3] = 1 +2*room_speed*tweenData[2]/(tweenData[1]+1)
           break
       
       case 2:
           tweenData[3] = 1 +room_speed*tweenData[2]/(tweenData[1]+1)
           break
       
       case 3:
           tweenData[3] = 2*room_speed
           break
       
       case 4:
           tweenData[3] = room_speed
           break
       
       default:
           tweenData[3] = .5*room_speed +irandom(1.5*room_speed)
           break

}
//just so it doesn't give me a compiler error
return tweenData

/*

switch argument0{//sp_angle
       case 0:
           var tweenData[0] = irandom(359)
           break
       
       case 1:
           var tweenData[0] = darctan2(y-centerfieldy,x-centerfieldx)); 
           break
       
       case 2:
           var tweenData[0] = darctan2(y-centerfieldy,x-centerfieldx)) -180; 
           break
       
       case 3:
           var tweenData[0] = darctan2(y-centerfieldy,x-centerfieldx)) +90; 
           break
       
       case 4:
           var tweenData[0] = darctan2(y-centerfieldy,x-centerfieldx)) -90; 
           break
       
       case 5:
           var tweenData[0] = darctan2(y-centerfieldy,x-centerfieldx)) choose(-90,90); 
           break
       
       default:
           var tweenData[0] = irandom(359)
           break

}
switch argument1{//sp_rad
       case 0: 
           var tweenData[1] = GAME_H/3
           break
       
       case 1://causing problems. was causing those lame jiggles
           //var tweenData[1] =  point_distance(x,y,centerfieldx,centerfieldx)*2
           var tweenData[1] =  GAME_H/6 + point_distance(x,y,centerfieldx,centerfieldx)*2
           //maybe we can make this conditional instead
           break

       case 2:
           var tweenData[1] =  GAME_H/12 + point_distance(x,y,centerfieldx,centerfieldx)*4
           break
       
       case 3:
           var tweenData[1] =  GAME_H/6 + 1+irandom(GAME_H/3)
           break
           
       case 4:
           var tweenData[1] =  GAME_H/12
           break
       
       
       default:
           var tweenData[1] = GAME_H/3
           break

}
switch argument2{//sp_dist
       case 0: 
           var tweenData[2] = point_distance(x,y,centerfieldx,centerfieldx)
           break
       
       case 1:
           var tweenData[2] = 2 * point_distance(x,y,centerfieldx,centerfieldx) + tweenData[1]
           break
           
       case 2:
           var tweenData[2] = point_distance(x,y,centerfieldx,centerfieldx) + tweenData[1]
           break
       
       case 3:
           var tweenData[2] = 2 * point_distance(x,y,centerfieldx,centerfieldx)
           break
       
       case 4:
           var tweenData[2] = point_distance(x,y,centerfieldx,centerfieldx) / 2
           break
           
       case 5:
           var tweenData[2] = (point_distance(x,y,centerfieldx,centerfieldx) + tweenData[1]) / 2
           break
       
       default:
           var tweenData[2] = point_distance(x,y,centerfieldx,centerfieldx)
           break

}
switch argument3{//sp_dur
       case 0: 
           var tweenData[3] = .5*room_speed +irandom(1.5*room_speed)
           break
       
       case 1:
           var tweenData[3] = 1 +2*room_speed*tweenData[2]/(tweenData[1]+1)
           break
       
       case 2:
           var tweenData[3] = 1 +room_speed*tweenData[2]/(tweenData[1]+1)
           break
       
       case 3:
           var tweenData[3] = 2*room_speed
           break
       
       case 4:
           var tweenData[3] = room_speed
           break
       
       default:
           var tweenData[3] = .5*room_speed +irandom(1.5*room_speed)
           break

}