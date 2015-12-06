#define scr_dynamic_aimer
///scr_dynamic_aimer(instance,direction)
//adds direction and alpha values to grid
//calls itself recursively to find new grid cells to add based on direction and object type
//recursions limited by aimer recursions
//returns nothing


/* NB: To make this work again you need to uncomment the various support scripts that 
    clear and set data structures in this script group


*/



///scr_dynamic_aimer(instance,direction)
//adds direction and alpha values to grid
//calls itself recursively to find new grid cells to add based on direction and object type
//recursions limited by aimer recursions
//returns nothing

 //MAX RECURSION DPETH, SIMPLE TO CHANGE
 //COULD BE BASED ON GRIDSIZE
 
var gridobject = argument[0];
var adir = argument[1] mod 360;
//else {piercing = false;}

        //var adir = argument[1] //direction shooter comes from
    //problem this is going infinitely
//if global.aimer_ambiguity < gridSize div 3{ ///3{//5{ //direction shooter comes from
if true{//global.aimer_recursions < gridSize div 2{ ///3{//5{ //direction shooter comes from
    //var adir = other.sdir;
    var gx = round((x-ox -cellW/2) / cellW) +1;
    var gy = round((y-oy -cellH/2) / cellH) +1;
    var gridval = global.aimerfield[# gx, gy];
    if is_undefined(gridval){return noone}
    var g_array, newobj, newdir;


    g_array[0] = x//gridobject.x; //x
    g_array[1] = y//gridobject.y; //y
    
    g_array[4] = global.aimer_recursions
    g_array[5] = 1 ////max alpha
    //g_array[6] = 0///current alpha (used at fadein delay
    //g_array[7] = 1//indicates if object is active
     //amiguity var for color
    
    
    global.aimer_recursions +=1
    
    switch object_index{
        case obj_reflector_ccwise: 
            g_array[2] = floor(((adir / 90.0) + 1))*90 mod 360 //sprite rotation
            g_array[3] = spr_arrow_single //sprite to draw
            //g_array[4] = global.aimer_recursions -1
            g_array[8] = global.aimer_ambiguity
            
            
            //IF current alpha is maxed call new recursions
            if is_array(gridval) and gridval[6] >= 1{//maybe use [7]?
                newdir = g_array[2]; 
                newobj = scr_find_collision(id,newdir);
                if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
            }
            break;
        case obj_reflector_cwise:
            g_array[2] = ceil(((adir / 90.0) + 3))*90 mod 360 //rotation
            g_array[3] = spr_arrow_single //sprite to draw
            //g_array[4] = global.aimer_recursions -1
            g_array[8] = global.aimer_ambiguity
            
            
            //IF current alpha is maxed call new recursions
            if is_array(gridval) and gridval[6] >= 1{
                newdir = g_array[2]; 
                newobj = scr_find_collision(id,newdir);
                if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
            }
            break;
       case obj_reflector_basic:
            //sprite rot shouldn't make a different here
                 //g_array[2] = ceil(((adir / 90.0) + rdir/90))*90 mod 360
                 //g_array[3] = sp_reflector_arrow_double //sprite to draw
                 if adir mod 90 == 0 {g_array[2] = ((adir + rdir)+360) mod 360}
                 else {g_array[2] = ((adir + rdir/2)+360) mod 360}
                 g_array[3] = spr_arrow_single //sprite to draw
            

            
            g_array[8] = global.aimer_ambiguity                
            //IF current alpha is maxed call new recursions
            if is_array(gridval) and gridval[6] >= 1{
                newdir = g_array[2]; 
                newobj = scr_find_collision(id,newdir);
                if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
            }
            break;
        /*
        case obj_powerup_2balls:
            //sprite rot shouldn't make a different here
            g_array[2] = ceil(((adir / 90.0) + 3))*90 mod 360 //rotation
            g_array[3] = sp_reflector_arrow_double //sprite to draw
            g_array[8] = global.aimer_ambiguity
 
        
            if is_array(gridval) and gridval[6] >= 1{
                if !piercing{
                    newdir = ceil(((adir / 90.0) + 3))*90; 
                    newobj = scr_find_collision(id,newdir);
                    if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
                    newdir = floor(((adir / 90.0) + 1))*90; 
                    newobj = scr_find_collision(id,newdir);
                    if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
                }
                else{
                    newdir = adir; 
                    newobj = scr_find_collision(id,newdir);
                    if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
                    newdir = adir+180; 
                    newobj = scr_find_collision(id,newdir);
                    if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
                
                }
            }
            break;
        case obj_powerup_3balls:
                 //g_array[2] = ceil(((adir / 90.0) + rdir/90))*90 mod 360
                 //g_array[3] = sp_reflector_arrow_double //sprite to draw
                 if adir mod 90 == 0 {g_array[2] = ((adir + rdir)+360) mod 360}
                 else {g_array[2] = ((adir + rdir/2)+360) mod 360}
                 g_array[3] = sp_reflector_arrow_triple //sprite to draw
        
            g_array[8] = global.aimer_ambiguity
        
            if is_array(gridval) and gridval[6] >= 1{
                newdir = g_array[2]; 
                newobj = scr_find_collision(id,newdir);
                if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
                newdir = g_array[2] +90; 
                newobj = scr_find_collision(id,newdir);
                if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
                newdir = g_array[2] -90;
                newobj = scr_find_collision(id,newdir);
                if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
                
      
            }
            break;
        case obj_powerup_4balls:
            //sprite rot shouldn't make a different here
            g_array[2] = ceil(((adir / 90) + 3))*90 mod 360//adir - 45//choose(90,270) //sprite rotation
            g_array[3] = sp_reflector_arrow_quad //sprite to draw
        
            g_array[8] = global.aimer_ambiguity
            if is_array(gridval) and gridval[6] >= 1{
                newdir = ceil(((adir / 90.0) + 3))*90; 
                newobj = scr_find_collision(id,newdir);
                if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
                newdir = floor(((adir / 90.0) + 1))*90; 
                newobj = scr_find_collision(id,newdir);
                if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
                newdir = ceil(((adir / 90.0) + 3))*90 + 180; 
                newobj = scr_find_collision(id,newdir);
                if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
                newdir = floor(((adir / 90.0) + 1))*90 + 180; 
                newobj = scr_find_collision(id,newdir);
                if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
            }
            break;
            */
       //if we want to add bombs we actually need to loop through the values the way the bombs do
       //and if any things are chain loop through those and then if any balls or pierces are chained to calculate those
       //let's hold off on that for now
       case obj_star:
            g_array[2] = adir;
            g_array[3] = spr_arrow_dot
            g_array[8] = global.aimer_ambiguity   
                         
            //IF current alpha is maxed call new recursions
            //if is_array(gridval) and gridval[6] >= 1{
            newdir = g_array[2]; 
            newobj = scr_find_collision(id,newdir);
            if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
            break;
       default:
            //sprite rot shouldn't make a different here
            
                 //g_array[2] = ceil(((adir / 90.0) + rdir/90))*90 mod 360
                 //g_array[3] = sp_reflector_arrow_double //sprite to draw
                 if adir mod 90 == 0 {g_array[2] = ((adir + rdir)+360) mod 360}
                 else {g_array[2] = ((adir + rdir/2)+360) mod 360}
                 g_array[3] = spr_arrow_single_finish //sprite to draw
           
  
            
            g_array[8] = global.aimer_ambiguity                
            //IF current alpha is maxed call new recursions
            /*if is_array(gridval) and gridval[6] >= 1{
                newdir = g_array[2]; 
                newobj = scr_find_collision(id,newdir);
                if newobj != noone{with(newobj){scr_dynamic_aimer(newobj,newdir)}}
            }*/
            break;
                
    }
    
    
    global.aimer_recursions -=1
    
    //IF NOT IN GRID SET GRID ARRAY
    if !is_array(gridval){
       g_array[6] =MOVE_ACTIVE// 0///current alpha (used at fadein delay
       g_array[7] = 1//indicates if object is active
       global.aimerfield[# gx,gy] = g_array
       //show_message('set aimer: '+str_debug('gridval[6]',g_array[6])+str_debug('gx',gx)+str_debug('gy',gy));
    }
    //CHECK IF FADEOUT ENABLED`
    //IF VALUE OKAY THEN DISABLE FADEOUT
    else if gridval[2] == g_array[2] and
            gridval[3] == g_array[3] and
            gridval[4] == g_array[4]{ 
            //(MOVE_ACTIVE + (gridval[4] == g_array[4])){ 
            if !gridval[7]{
               //if MOVE_ACTIVE{gridval[4] = g_array[4]}
               gridval[7] = 1//DISABLES FADEOUT (MEANS VALUE ACTIVE)
               global.aimerfield[# gx,gy] = gridval
               //show_message('reset aimer: '+str_debug('gridval[6]',gridval[6])+str_debug('gx',gx)+str_debug('gy',gy));
            }
    }
    //CHECK THE ARRAY VALS IF THEY'RE NOT == THEN LET IT FADEOUT 
    else if gridval[7]{
            gridval[7] = 0
            //global.aimerfield[# gx,gy] = gridval
            //show_message('unset aimer: '+str_debug('gridval[6]',gridval[6])+str_debug('gx',gx)+str_debug('gy',gy));
    }
    else if is_array(gridval){
         global.aimerfield[# gx,gy] = gridval
    }
}
return noone


#define scr_find_collision
///scr_find_collision(gridobject,direction)
//returns object id
var gobject = argument[0]
var searchdir = (argument[1]+360) mod 360 //direction to look in
//var startx = gridobject.x
//var starty = gridobject.y
var gx1 = round((x-ox -cellW/2) / cellW) +1;
var gy1 = round((y-oy -cellH/2) / cellH) +1;
var iterx=0, itery=0,ingrid=false,i,j,obj,objx,objy,gval,g_ray;
if searchdir = 0 {iterx = 1}
else if searchdir = 45 {iterx=1;itery=-1;}
if searchdir = 90 {itery = -1}
else if searchdir = 135 {iterx=-1;itery=-1;}
if searchdir = 180 {iterx = -1}
else if searchdir = 225 {iterx=-1;itery=1;}
if searchdir = 270 {itery = 1}
else if searchdir = 315 {iterx=1;itery=1;}

if abs(iterx) and not abs(itery){
    for (i=gx1+iterx; i>=0 and i<fieldW+2;i+=iterx){
        objx = i
        objy = gy1
        if (objx > corner - objy - 1 and 
        objy < fieldH+2 - corner + objx and 
        objx < fieldW+2 - corner + objy and 
        objx < fieldW+2 + fieldH+2 - corner - objy - 1){
            if objx-1 >= 0 and objx-1 < fieldW and objy-1 >= 0 and objy-1 < fieldH{ingrid=true;}
            if ingrid {obj = global.FIELD_OBJECTS[# objx-1, objy-1]}
            else {obj = noone}
            gval = global.aimerfield[# objx, objy]
            if is_array(gval) and gval[3] == spr_arrow_dot{
               if !gval[7]{
                  //Keeps shallower recursion drawn on top
                  if gval[4] > global.aimer_recursions {
                     gval[4] = global.aimer_recursions - 1;
                     //if MOVE_ACTIVE{gval[6]=MOVE_ACTIVE}
                  }
                  if gval[8] > global.aimer_ambiguity {
                     gval[8] = global.aimer_ambiguity;
                  }
                  gval[7] = 1
                  global.aimerfield[# objx, objy] = gval;
               }
               //This returns noone because it means it's fading out 
               else if gval[6] < 1{
                  global.aimerfield[# objx, objy] = gval;
                  return noone
                  //if !MOVE_ACTIVE {return noone}
               }
            }
            else if !is_array(gval) or gval[4] >= global.aimer_recursions{// or gval[4] >= global.aimer_recursions{
               if (obj >= DENSITY and instance_exists(obj)){
                  //if is_array(gval) {show_message(object_get_name(obj)+str_debug('gval[6]',gval[6])+str_debug('objx',objx)+str_debug('objy',objy));}
                  //maybe set it here also?
                  global.aimerfield[# objx, objy] = gval;
                  return obj;
               }
               else if !is_array(gval){// and obj == noone{
                  g_ray[0] = objx*cellW + ox - cellW + cellW*.5; //X
                  g_ray[1] = objy*cellH + oy - cellH + cellH*.5; //Y
                  g_ray[2] = 0; //Rotation
                  g_ray[3] = spr_arrow_dot; //Sprite
                  g_ray[4] = global.aimer_recursions - 1 //10//global.aimer_recursions
                  g_ray[5] = 1 ////max alpha
                  g_ray[6] = MOVE_ACTIVE//0///current alpha (used at fadein delay
                  g_ray[7] = 1//indicates if object is active
                  g_ray[8] = global.aimer_ambiguity
                  global.aimerfield[# objx, objy] = g_ray;
                  return noone
                  //if !MOVE_ACTIVE {return noone}
               }
            }
        }
    }
} 
else if not abs(iterx) and abs(itery){
    for (j=gy1+itery; j>=0 and j<fieldH+2;j+=itery){
        objx = gx1
        objy = j
        if (objx > corner - objy - 1 and 
        objy < fieldH+2 - corner + objx and 
        objx < fieldW+2 - corner + objy and 
        objx < fieldW+2 + fieldH+2 - corner - objy - 1){
            if objx-1 >= 0 and objx-1 < fieldW and objy-1 >= 0 and objy-1 < fieldH{ingrid=true;}
            if ingrid {obj = global.FIELD_OBJECTS[# objx-1, objy-1]}
            else {obj = noone}
            gval = global.aimerfield[# objx, objy]
            if is_array(gval) and gval[3] == spr_arrow_dot{
               if !gval[7]{
                  //Keeps shallower recursion drawn on top
                  if gval[4] > global.aimer_recursions {
                     gval[4] = global.aimer_recursions - 1;
                     //if MOVE_ACTIVE{gval[6]=MOVE_ACTIVE}
                  }
                  if gval[8] > global.aimer_ambiguity {
                     gval[8] = global.aimer_ambiguity;
                  }
                  gval[7] = 1
                  global.aimerfield[# objx, objy] = gval;
               }
               //This returns noone because it means it's fading out 
               else if gval[6] < 1{
                  global.aimerfield[# objx, objy] = gval;
                  return noone
                  //if !MOVE_ACTIVE {return noone}
               }
            }
            else if !is_array(gval) or gval[4] >= global.aimer_recursions{// or gval[4] >= global.aimer_recursions{
               if (obj >= DENSITY and instance_exists(obj)){
                  //if is_array(gval) {show_message(object_get_name(obj)+str_debug('gval[6]',gval[6])+str_debug('objx',objx)+str_debug('objy',objy));}
                  global.aimerfield[# objx, objy] = gval;
                  return obj;
               }
               else if !is_array(gval){// and obj == noone{
                  g_ray[0] = objx*cellW + ox - cellW + cellW*.5; //X
                  g_ray[1] = objy*cellH + oy - cellH + cellH*.5; //Y
                  g_ray[2] = 0; //Rotation
                  g_ray[3] = spr_arrow_dot; //Sprite
                  g_ray[4] = global.aimer_recursions - 1 //10//global.aimer_recursions
                  g_ray[5] = 1 ////max alpha
                  g_ray[6] = MOVE_ACTIVE//0///current alpha (used at fadein delay
                  g_ray[7] = 1//indicates if object is active
                  g_ray[8] = global.aimer_ambiguity
                  global.aimerfield[# objx, objy] = g_ray;
                  return noone
                  //if !MOVE_ACTIVE {return noone}
               }
            }
        }
    }
} 
else if abs(iterx) and abs(itery){
    for (i=gx1+itery; i>=0 and i<fieldW+2;i+=iterx){
        objx = i
        objy = gy1+itery
        if !(objy >= 0 and objy < fieldH +2) {break;}
        if (objx > corner - objy - 1 and 
        objy < fieldH+2 - corner + objx and 
        objx < fieldW+2 - corner + objy and 
        objx < fieldW+2 + fieldH+2 - corner - objy - 1){
            if objx-1 >= 0 and objx-1 < fieldW and objy-1 >= 0 and objy-1 < fieldH{ingrid=true;}
            if ingrid {obj = global.FIELD_OBJECTS[# objx-1, objy-1]}
            else {obj = noone}
            gval = global.aimerfield[# objx, objy]
            if is_array(gval) and gval[3] == spr_arrow_dot{
               if !gval[7]{
                  //Keeps shallower recursion drawn on top
                  if gval[4] > global.aimer_recursions {
                     gval[4] = global.aimer_recursions - 1;
                     //if MOVE_ACTIVE{gval[6]=MOVE_ACTIVE}
                  }
                  if gval[8] > global.aimer_ambiguity {
                     gval[8] = global.aimer_ambiguity;
                  }
                  gval[7] = 1
                  global.aimerfield[# objx, objy] = gval;
               }
               //This returns noone because it means it's fading out 
               else if gval[6] < 1{
                  global.aimerfield[# objx, objy] = gval;
                  return noone
                  //if !MOVE_ACTIVE {return noone}
               }
            }
            else if !is_array(gval) or gval[4] >= global.aimer_recursions{// or gval[4] >= global.aimer_recursions{
               if (obj >= DENSITY and instance_exists(obj)){
                  //if is_array(gval) {show_message(object_get_name(obj)+str_debug('gval[6]',gval[6])+str_debug('objx',objx)+str_debug('objy',objy));}
                  global.aimerfield[# objx, objy] = gval;
                  return obj;
               }
               else if !is_array(gval){// and obj == noone{
                  g_ray[0] = objx*cellW + ox - cellW + cellW*.5; //X
                  g_ray[1] = objy*cellH + oy - cellH + cellH*.5; //Y
                  g_ray[2] = 0; //Rotation
                  g_ray[3] = spr_arrow_dot; //Sprite
                  g_ray[4] = global.aimer_recursions - 1 //10//global.aimer_recursions
                  g_ray[5] = 1 ////max alpha
                  g_ray[6] = MOVE_ACTIVE//0///current alpha (used at fadein delay
                  g_ray[7] = 1//indicates if object is active
                  g_ray[8] = global.aimer_ambiguity
                  global.aimerfield[# objx, objy] = g_ray;
                  return noone
                  //if !MOVE_ACTIVE {return noone}
               }
            }
        }
    }
} 



return noone

#define scr_update_dynamic_aimer
///scr_update_dynamic_aimer()
var gx,gy,gridval;
for (gx=0;gx<fieldW+2;gx++){
    for (gy=0;gy<fieldH+2;gy++){
        gridval = global.aimerfield[# gx, gy]
        if !is_array(gridval){continue}
        //show_message('update begin: '+str_debug('gridval[6]',gridval[6])+str_debug('gx',gx)+str_debug('gy',gy));
        //check if fade in/out enabled
        if gridval[7]{
           //extract alpha values; if not same increase current alpha
           if gridval[5] > gridval[6]{
              //you could totally put a tween escalation here instead of linear
              //gridval[6] = gridval[6] + .01*floor(gridSize *.34)
              gridval[6] += .01*floor(gridSize *1)//.34)//*(1+10*MOVE_ACTIVE);
              global.aimerfield[# gx, gy] = gridval;
              //show_message('update calpha: '+str_debug('gridval[6]',gridval[6])+str_debug('gx',gx)+str_debug('gy',gy));
           }
           else{//if same value then activate fade out
              gridval[7] = 0
              global.aimerfield[# gx, gy] = gridval;
              //show_message('update enable fadeout: '+str_debug('gridval[6]',gridval[6])+str_debug('gx',gx)+str_debug('gy',gy));
           }
        }
        //begin fadeout
        else{
           if gridval[6] > 0 {//and !MOVE_ACTIVE{
              gridval[6] -= .01*floor(gridSize*.34)//*(1+10*MOVE_ACTIVE);
              global.aimerfield[# gx, gy] = gridval;
              //show_message('update fading out:  '+str_debug('gridval[6]',gridval[6])+str_debug('gx',gx)+str_debug('gy',gy));
           }
           else{//if fade out complete wipe cell
              global.aimerfield[# gx, gy] = noone
              //show_message('update set noone: '+str_debug('gridval',global.aimerfield[# gx, gy])+str_debug('gx',gx)+str_debug('gy',gy));
           }
        }
    }
}

#define scr_draw_dynamic_aimer
///scr_draw_dynamic_aimer()
var gx,gy,gridval,sprite_rot,sprite_alpha,sprite_x,sprite_y,sprite_val,sprite_color;
for (gx=0;gx<fieldW+2;gx++){
    for (gy=0;gy<fieldH+2;gy++){
        gridval = global.aimerfield[# gx, gy]
        //check if cell empty
        if !is_array(gridval){continue}
        sprite_x = gridval[0] //gx * cellW + ox + .5*cellW;
        sprite_y = gridval[1] //gy * cellH + oy + .5*cellH;
        sprite_rot = gridval[2]
        sprite_val = gridval[3]
        sprite_alpha =  1//.75//clamp(gridval[6],0,1);//+MOVE_ACTIVE
        //Select image blend based on recursion depth
        //ANOTHER WAY TO-DO THIS IS TO SIMPLY CREATE A COLOR VIA MERGECOLOR AND A GRIDVAL[4]/FLOOR(GRIDSIZE/3)
        //could average gridval8 and gridval4
        //sprite_color = merge_color(c_white,c_black,gridval[8]/floor(gridSize/3));
        //sprite_color = merge_color(c_white,c_black,.5*(gridval[8]+gridval[4])/floor(gridSize/3));
        //sprite_color = merge_color(c_white,c_black,(gridval[4])/(gridSize div 2));//3
        sprite_color = COLORS[0]//merge_color(COLORS[0],COLORS[6],(gridval[4])/(gridSize div 2));//3
        //draw_text(sprite_x,sprite_y+15,str_debug((gridval[8])/(gridSize div 3)))

        sprite_scale = cellH/sprite_get_width(sprite_val) * 1.5
        
        if sprite_val == spr_arrow_single_finish{
            sprite_alpha = .5
            sprite_scale *= 2/1.5//1.2
        }
        
        draw_sprite_ext(sprite_val,0,sprite_x,sprite_y,sprite_scale,sprite_scale,sprite_rot,sprite_color,sprite_alpha);
        
        
        
        
        
    }
}

#define scr_dynamic_aimer_init
///scr_dynamic_aimer_init()



global.aimerfield = ds_grid_create(1,1)
global.aimer_recursions = 0
global.aimer_ambiguity = 0

#define scr_dynamic_aimer_grid_init
///scr_dynamic_aimer_grid_init()


ds_grid_resize(global.aimerfield,fieldW+2,fieldH+2);
ds_grid_clear(global.aimerfield,noone)

#define scr_dynamic_aimer_grid_clear
///scr_dynamic_aimer_grid_clear()

ds_grid_clear(global.aimerfield,noone)
#define scr_dynamic_aimer_dealloc
///scr_dynamic_aimer_dealloc()


ds_grid_destroy(global.aimerfield);