#define scr_popup_text_field_static
///scr_popup_text_field_static(x,y,text,color,[font,deleteOverlapping,duration-steps,colIndex])

       
//LAYERS OF FIELD TEXT DIALOGUES
/*
Top: Combos, Paddle overheat,(super) star nova powerups
Mid:  Levelup, MovesMode Clear %, NearLoss/Miss
Bottom: Tappers, MovesMode Mixers, TimeMode Penalty      
Anywhere: Extra balls
*/



//Make sure calling instance has whatever vars you're adding, 
//e.g. obj_control_game doesn't have a sprite
//obj = instance_create(global.textx,global.texty,obj_text_override);
//obj = instance_create(global.textx,global.texty,obj_text_override);
obj = instance_create(argument[0],argument[1],obj_text_override);
with(obj){
    text = argument[2]
    col = argument[3]
    
    deleteOld = true;
    font = fnt_game_bn_20_black
    duraton = 2*room_speed;
    colIndex = -1;
    
    var i = 3
    if argument_count > ++i{font = argument[i]}
    if argument_count > ++i{deleteOld = argument[i]}
    if argument_count > ++i{duraton = argument[i]}
    if argument_count > ++i{colIndex = argument[i]}
     
    
    
    alpha_dec = true;
    outline = true;
    outlinewidth = 4
    
}

#define scr_popup_text_field_moving
///scr_popup_text_field_moving(x,y,text,color,[font,deleteOverlapping,duration, speed])

/* NB: Be sure to scale speeds by *RMSPD_DELTA


*/



//Make sure calling instance has whatever vars you're adding, 
//e.g. obj_control_game doesn't have a sprite
//obj = instance_create(global.textx,global.texty,obj_text_override);
//obj = instance_create(global.textx,global.texty,obj_text_override);
obj = instance_create(argument[0],argument[1]-10,obj_text_dynamic);
with(obj){
    text = argument[2];
    col = argument[3];

      
    colIndex = -1;
    font = fnt_game_bn_20_black
    duration = 1.5*room_speed;
    top_speed = 0
    deleteOld = false;
    
    var i = 3
    if argument_count > ++i{font = argument[i]}
    if argument_count > ++i{deleteOld = argument[i]}
    if argument_count > ++i{duration = argument[i]}
    if argument_count > ++i{colIndex = argument[i]}
    if argument_count > ++i{top_speed = argument[i]}
    
    alpha_dec = true;
    speed_dec = true
    outline = true;
    
}

#define scr_popup_text_zoomup
///scr_popup_text_zoomup(x,y,text,color,[font,deleteOverlapping,duration])
     



//Make sure calling instance has whatever vars you're adding, 
//e.g. obj_control_game doesn't have a sprite
obj = instance_create(argument[0],argument[1],obj_text_zoomup);
with(obj){
    
    text = argument[2];
    col = argument[3];
    
    font = fnt_game_bn_20_black;
    deleteOld = true;
    duraton = 2*room_speed;
    
    var i = 3
    if argument_count > ++i{font = argument[i]}
    if argument_count > ++i{deleteOld = argument[i]}
    if argument_count > ++i{duraton = argument[i]}
    
    alarm[0] = duraton//2*room_speed; //lasts 2 seconds
    
    alpha_dec = true;
    
    
    text_scaling = true;
    text_scale = 0;
    text_scale_end = 1;
    text_scale_ease = .05;
    
    
    outline = true;
    outlinewidth = 4
    
}