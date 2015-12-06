#define scr_popup_text_field_static
///scr_popup_text_field_static(x,y,text,color,[font,deleteOverlapping,duration,colIndex])

       
//LAYERS OF FIELD TEXT DIALOGUES
/*
Top: Combos, Paddle overheat,(super) star nova powerups
Mid:  Levelup, MovesMode Clear %, NearLoss/Miss
Bottom: Tappers, MovesMode Mixers, TimeMode Penalty      
Anywhere: Extra balls
*/


_delOld=true;
_font = fnt_field
_dur = 2*room_speed;
_colIndex = -1;
var i = 3
if argument_count > ++i{_font = argument[i]}
if argument_count > ++i{_delOld = argument[i]}
if argument_count > ++i{_dur = argument[i]}
if argument_count > ++i{_colIndex = argument[i]}

//Make sure calling instance has whatever vars you're adding, 
//e.g. obj_control_game doesn't have a sprite
//obj = instance_create(global.textx,global.texty,obj_text_override);
//obj = instance_create(global.textx,global.texty,obj_text_override);
obj = instance_create(argument[0],argument[1],obj_text_override);
with(obj){
      text = argument[2]
      col = argument[3]
      colIndex = other._colIndex;
      font = other._font
      
      duraton = other._dur;
      alarm[0] = duraton//2*room_speed; //lasts 2 seconds
      
      alpha_dec = true;
      
      outline = true;
      outlinewidth = 4
      
      deleteOld = other._delOld;
}

#define scr_popup_text_field_moving
///scr_popup_text_field_moving(x,y,text,color,[font,deleteOverlapping,duration, speed])

/* NB: Be sure to scale speeds by *RMSPD_DELTA


*/


_delOld = false;
_font = fnt_field
_dur = 1.5*room_speed;
_colIndex = -1;
_spd = 0;
var i = 3
if argument_count > ++i{_font = argument[i]}
if argument_count > ++i{_delOld = argument[i]}
if argument_count > ++i{_dur = argument[i]}
if argument_count > ++i{_colIndex = argument[i]}
if argument_count > ++i{_spd = argument[i]}

//Make sure calling instance has whatever vars you're adding, 
//e.g. obj_control_game doesn't have a sprite
//obj = instance_create(global.textx,global.texty,obj_text_override);
//obj = instance_create(global.textx,global.texty,obj_text_override);
obj = instance_create(argument[0],argument[1]-10,obj_text_dynamic);
with(obj){
      text = argument[2]
      col = argument[3]
      font = other._font
      
      duration = other._dur;
      alarm[0] = other._dur;
      
      alpha_dec = true;
      
      top_speed = other._spd
      speed_dec = true
      
      outline = true;
      
      deleteOld = other._delOld;
}

#define scr_popup_text_zoomup
///scr_popup_text_zoomup(x,y,text,color,[font,deleteOverlapping,duration])
     


_delOld=true;
_font = fnt_field
_dur = 2*room_speed;

var i = 3
if argument_count > ++i{_font = argument[i]}
if argument_count > ++i{_delOld = argument[i]}
if argument_count > ++i{_dur = argument[i]}

//Make sure calling instance has whatever vars you're adding, 
//e.g. obj_control_game doesn't have a sprite
obj = instance_create(argument[0],argument[1],obj_text_zoomup);
with(obj){
      text = argument[2]
      col = argument[3]
      font = other._font
      
      duraton = other._dur;
      alarm[0] = duraton//2*room_speed; //lasts 2 seconds
      
      alpha_dec = true;
      
      
      text_scaling = true;
      text_scale = 0;
      text_scale_end = 1;
      text_scale_ease = .05;
      
      
      outline = true;
      outlinewidth = 4
      
      deleteOld = other._delOld;
}