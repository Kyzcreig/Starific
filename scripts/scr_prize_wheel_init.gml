#define scr_prize_wheel_init
///scr_prize_wheel_init()


title_txt = "spin"//"prizes"//"prize wheel";
rect_h = round(.60 * GAME_H);
showBackButton = true;

spinCount = 0;
spinState[0] = 0; //0 = off; 1 = spinning; 2 = selected;
spinStateSchedule = noone;
wheelRot = 0; 
wheelVel = 0;
wheelVelStart = 0;
starCashDisplay = STAR_CASH;

ini_open("scores.ini")
    spinCountTotal = ini_read_real("misc", "spinCount", 0);
ini_close();

backWheel_scale = 0;
flapper = instance_create(x,y, obj_prize_flapper)
with (flapper) {
    prizeWheel = other.id;
}
//buttonSpawner = instance_create(x,y, obj_prize_button_spawner);

// Create Index List
prizeList = ds_list_create();

//Slice Array
var i = -1;
if EASY_SPINS or false {
    repeat(4){
        sliceArray[++i] = scr_slice_data_create(4); //4 //5 //1 //0
        sliceArray[++i] = scr_slice_data_create(5); //4 //5 //1 //0
    }
}
// Normal Ods for Veteran Players
else if (spinCountTotal >= 5 or STAR_CASH >= 500)  {
    sliceArray[++i] = scr_slice_data_create(3);
    sliceArray[++i] = scr_slice_data_create(4);
    sliceArray[++i] = scr_slice_data_create(1);
    sliceArray[++i] = scr_slice_data_create(5);
    sliceArray[++i] = scr_slice_data_create(3);
    sliceArray[++i] = scr_slice_data_create(4);
    sliceArray[++i] = scr_slice_data_create(1);
    sliceArray[++i] = scr_slice_data_create(5);
}
// Rig Next Few Spins No Debuffs
else if (spinCountTotal > 1 or STAR_CASH >= 300) {
    sliceArray[++i] = scr_slice_data_create(3);
    sliceArray[++i] = scr_slice_data_create(4);
    sliceArray[++i] = scr_slice_data_create(1);
    sliceArray[++i] = scr_slice_data_create(4);
    sliceArray[++i] = scr_slice_data_create(3);
    sliceArray[++i] = scr_slice_data_create(4);
    sliceArray[++i] = scr_slice_data_create(1);
    sliceArray[++i] = scr_slice_data_create(4);
}

// Rig First Spin is a Skin or Buff
else {
    sliceArray[++i] = scr_slice_data_create(3);
    sliceArray[++i] = scr_slice_data_create(4); //1
    sliceArray[++i] = scr_slice_data_create(3);
    sliceArray[++i] = scr_slice_data_create(4); //1
    sliceArray[++i] = scr_slice_data_create(3);
    sliceArray[++i] = scr_slice_data_create(4); //1
    sliceArray[++i] = scr_slice_data_create(3);
    sliceArray[++i] = scr_slice_data_create(4); //1
}


// Text Jiggles
prompt_jiggletime = 1.0*room_speed
for ( var i = 0; i < 2; i++ ){
    for (var j = 0; j < 3; j++){
        prompt_jiggle[i,j] = 0;
    }
}
//Spin Button Jiggle
spinButton_wiggle_state = 0;
spinButton_wiggle_duration = 20 * room_speed;
spinButton_wiggle_state_count = 2;
spinButton_wiggle_x = 0;
spinButton_wiggle_y = 0;


testBool = false;

#define scr_prize_wheel_destroy
///scr_prize_wheel_destroy()

// Destroy Helpers
with(obj_prize_helpers_parent) {
    // Delay Button Spawner so it can spawn buttons
    if object_index == obj_prize_button_spawner {
        ScheduleScript(id, false, 2, Destroy, id);
    }
    // Destroy Helpers
    else {
        instance_destroy();
    }
}

#define scr_prize_wheel_draw
///scr_prize_wheel_draw()



// Prompt Head
scr_prompt_step_head(spinState[0] == 0);

// Prompt Body

// Draw Spin Count
draw_set_valign(fa_middle);
draw_set_halign(fa_left);
draw_set_font(fnt_menu_bn_26_black);//fnt_menu_bn_40_bold
spinCount_text = "spins: "+string(spinCount);
spinCount_text_h = string_height(spinCount_text);
spinCount_x = GAME_MID_X - line_w + prompt_jiggle[0,1];
spinCount_y = line_y + spinCount_text_h + prompt_jiggle[0,2];
spinCount_scale = 1 * subEase[3];
spinCount_alpha = subEase[3]//1;
draw_text_ext_transformed_colour(spinCount_x, spinCount_y, spinCount_text, 
-1, -1,spinCount_scale,spinCount_scale,0, COLORS[0], COLORS[0], COLORS[0], COLORS[0],  spinCount_alpha);
    
// Draw Cash
draw_set_halign(fa_right);
cashCount_text = CASH_STR+string(starCashDisplay);
cashCount_text_h = string_height(cashCount_text);
cashCount_x = GAME_MID_X + line_w + prompt_jiggle[1,1];
cashCount_y = line_y + cashCount_text_h + prompt_jiggle[1,2];
cashCount_scale = spinCount_scale;
cashCount_alpha = spinCount_alpha;
draw_text_ext_transformed_colour(cashCount_x, cashCount_y, cashCount_text, 
-1, -1,cashCount_scale,cashCount_scale,0, COLORS[0], COLORS[0], COLORS[0], COLORS[0],  cashCount_alpha);

// Update Cash Display
if starCashDisplay != STAR_CASH {
    //var diff = STAR_CASH - starCashDisplay;
    //starCashDisplay += sign(diff)
    var cash_diff = (STAR_CASH - starCashDisplay) * .05
    var cash_sign = sign(cash_diff);
    starCashDisplay += cash_sign*(ceil(abs(cash_diff)));
}


// Draw Wheel Back Circle
backWheel_x = rect_x + rect_w/2;
backWheel_y = rect_y + rect_h/2 + GAME_H *.05;
backWheel_scale = .85 * subEase[3];
backWheel_size = backWheel_scale * sprite_get_width(spr_prize_wheel_back_circle)
backWheel_alpha = subEase[3]//1;
draw_sprite_ext(spr_prize_wheel_back_circle, 0,
backWheel_x,backWheel_y,backWheel_scale,backWheel_scale,
wheelRot,COLORS[0],backWheel_alpha) 

// Draw Slices
for (var i = 0; i < 8; i++) {
    // Set Slice Data
    sliceRot = i * 45 + wheelRot; 
    sliceSpr = spr_prize_wheel_slice_nogap_0degrees_gif//spr_prize_wheel_slice_gap_0degrees
    //NOTE: PNGs with transparency cause artifacts, use GIFs with transparency for such sprites instead.
    //if mouse_check_button(mb_right) sliceSpr = spr_prize_wheel_slice_nogap_0degrees_gif;
    //else sliceSpr = spr_prize_wheel_slice_gap_0degrees_gif;
    sliceData = sliceArray[i];
    sliceCol = sliceData[1]
    sliceWidth = backWheel_scale * sprite_get_width(sliceSpr);
    // Draw Slice 
    draw_sprite_ext(sliceSpr, 0, backWheel_x,backWheel_y,
    backWheel_scale,backWheel_scale,sliceRot,
    COLORS[sliceCol],backWheel_alpha) 
    // Set Slice Symbol Data
    sliceSymbol = sliceData[0]
    sliceSymbol_rot = sliceRot + 90;
    sliceSymbol_scale = .6 * backWheel_scale;
    sliceSymbol_rad =  sliceWidth * .7;
    sliceSymbol_x = backWheel_x + dcos(sliceRot) * sliceSymbol_rad;
    sliceSymbol_y = backWheel_y - dsin(sliceRot) * sliceSymbol_rad;
    // Draw Slice Symbol
    draw_sprite_ext(sliceSymbol, 0,sliceSymbol_x,sliceSymbol_y,
    sliceSymbol_scale,sliceSymbol_scale,sliceSymbol_rot,
    COLORS[6],backWheel_alpha) 
    
    // Set Slice Knob Coordinates
    sliceKnob = sliceData[3]; //get slice knob instance
    sliceKnob_rad = sliceWidth * .9
    sliceKnob.x = backWheel_x + dcos(sliceRot - 22.5) * sliceKnob_rad;
    sliceKnob.y = backWheel_y - dsin(sliceRot - 22.5) * sliceKnob_rad;
}  

// Draw Wheel Center
draw_sprite_ext(spr_prize_wheel_front_center, 0,
backWheel_x,backWheel_y,backWheel_scale,backWheel_scale,
wheelRot,COLORS[0],backWheel_alpha) 

// Draw Wheel Flapper
with (obj_prize_flapper){
    event_user(15)
    /*
    if flapper_draw {
        // Draw Wheel Flapper
        draw_sprite_ext(flapper_spr, 0,
        flapper_x,flapper_y,flapper_scale,flapper_scale,
        image_angle,COLORS[0],flapper_alpha) 
        // Draw Wheel Flapper Center
        draw_sprite_ext(spr_prize_wheel_flapper_center, 0,
        flapper_x,flapper_y,flapper_scale,flapper_scale,
        image_angle,COLORS[5],flapper_alpha) 
    }
    */
}


// Spin Button Data
spinButton_spr = spr_button_basic;
spinButton_scale = 1 * subEase[3];
spinButton_w = sprite_get_width(spinButton_spr) 
spinButton_h = sprite_get_height(spinButton_spr) 
spinButton_x = backWheel_x + spinButton_wiggle_x * (spinButton_wiggle_state == 1);
spinButton_y = backWheel_y + backWheel_size / 2 + spinButton_h + spinButton_wiggle_y * (spinButton_wiggle_state == 1);

//Check if mouse over icon
if point_in_rectangle(mouse_x,mouse_y,
    spinButton_x-spinButton_w/2,spinButton_y-spinButton_h/2,
    spinButton_x+spinButton_w/2,spinButton_y+spinButton_h/2) 
    and (!touchPad or mouse_check_button(mb_left)) and !TweenExists(mainTween) 
    and spinState[0] == 0
{
    //Disable increase scale when hovered/clicked
    spinButton_scale *= 1.2;
    //On Button Press
    if mouse_check_button_pressed(mb_left)
    {
        //Call Action
        if scr_prize_wheel_spin_available(){
            //Update Spin Count/State
            spinCount++;
            spinState[0] = 1; 
            spinButton_wiggle_state = 0; // reset spinButton wiggles
            // Randomize Velocity
            wheelVelStart = -10 * random_range(.90,1.10) * RMSPD_DELTA;
            wheelVel = wheelVelStart;
            // Randomize Friction
            wheelFrictionDur = random_range(5,7) * room_speed  // takes x seconds
            //wheelFrictionThreshold = .01 * RMSPD_DELTA;
            wheelFrictionThreshold = .01 * RMSPD_DELTA; //EVALUATE
            wheelFrictionCoefficient = 1 - exp( ln(wheelFrictionThreshold) / wheelFrictionDur );
            
            // Decrement StarCash
            STAR_CASH -= 100;
            // Update Stats
            ini_open("scores.ini");
                ini_write_real("misc", "STAR_CASH", STAR_CASH);
                ini_write_real("misc", "spinCount", ++spinCountTotal);
            ini_close();
            
            // Click SOund
            scr_sound(sd_menu_click,1,false);
            
            // Analytics
            analytics_button_counter("spinPrizeWheel");
            
            
        
        }
        else {
            // No Enough Cash Sound
            scr_sound(sd_not_enough_cash,1,false);
            // Cash Jiggler
            prompt_jiggle[1,0] = 1.5 * room_speed;
        } 
    }
}



// Handle Wheel Position by Velocity
if spinState[0] == 1 {//abs(wheelVel) > 0 {

    //Increment Wheel Rot
    wheelRot += wheelVel;
    
    // Friction
    wheelVel += max((0 - wheelVel) * wheelFrictionCoefficient, 
                    min((0 - wheelVel),wheelFrictionThreshold))
    
    
    // If Slowed Sufficiently
    if (abs(wheelVel) <= abs(wheelFrictionThreshold)  ) or
       (abs(wheelVel) <= abs(wheelFrictionThreshold) * 5 and flapper.flapper_image_angle == 0 )
    {
        //spinState[0] = 2;
        wheelVel = 0;
        if flapper.flapper_image_angle == flapper.prev_image_angle {  
            // Switch Wheel State to [2] Selected Slice
            if !ScheduleExists(spinStateSchedule){
                // Delay State Switch to Allow Flapper to Settle in Place
                spinStateSchedule = ScheduleScript(id,true, 0.1,array_set_index_1d,spinState,0,2);
                
                /*
                // If no more cash
                if !scr_prize_wheel_available() {
                    //Schedule Prize Prompt to Exit
                    ScheduleScript(id, true, .2, scr_prompt_exit);
                }*/
            }
        }
    } 
}


//Draw Spin Button
draw_sprite_ext(spinButton_spr, 0,spinButton_x,spinButton_y,
spinButton_scale,spinButton_scale,0,COLORS[0],1) 

// Draw Spin Button Price Text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_menu_bn_40_bold);
spinButton_text = CASH_STR+string(PRIZE_WHEEL_COST);
spinButton_text_y_adj = string_height("S") * .15;
draw_text_ext_transformed_colour(spinButton_x, spinButton_y - spinButton_text_y_adj , 
spinButton_text, -1,-1,spinButton_scale,spinButton_scale,0,COLORS[6],COLORS[6],COLORS[6],COLORS[6],1)


// Spin Button Jiggles
if spinState[0] == 0 {
    // If Wiggle State Duration Finished
    if spinButton_wiggle_duration == 0{
        // Set Next Wiggle State
        spinButton_wiggle_state = (++spinButton_wiggle_state) mod spinButton_wiggle_state_count;
        
        // If Base State
        if spinButton_wiggle_state == 0 {
            // Add Time
            spinButton_wiggle_duration = room_speed * 8;
        }
        // If Jiggle State
        else if spinButton_wiggle_state == 1{
            // Add Time
            spinButton_wiggle_duration = room_speed * 1.5;
        }
    }
    // Decrement Wiggle Duration
    if spinButton_wiggle_duration > 0 {
        spinButton_wiggle_duration--;
        // Set Wiggle Coordinates
        if spinButton_wiggle_state != 0{
            spinButton_wiggle_strength = 4;
            spinButton_wiggle_x = random_range(-1,1) * spinButton_wiggle_strength
            spinButton_wiggle_y = random_range(-1,1) * spinButton_wiggle_strength
        }
    }
}

//Decrement Text Jigglers
var jiggle_strength = 4;
for (var i=0, n = 2; i < n; i++){
    if prompt_jiggle[i,0] > 0{
        prompt_jiggle[i,0] -= 1
        prompt_jiggle[i,1] = random_range(-1,1)*jiggle_strength;
        prompt_jiggle[i,2] = random_range(-1,1)*jiggle_strength;
    }
    else if prompt_jiggle[i,0] >= -1{
        prompt_jiggle[i,0] = -2
        prompt_jiggle[i,1] = 0;
        prompt_jiggle[i,2] = 0;
    }
}


// Prompt Foot
scr_prompt_step_foot(spinState[0] == 0)
// If Out of Cash, Exit Out
if !scr_prize_wheel_spin_available() and 
   starCashDisplay == STAR_CASH and
   spinState[0] == 0 and !TweenExists(mainTween)
{
    //Schedule Prize Prompt to Exit
    ScheduleScript(id, true, .2, scr_prompt_exit);
}


// If Spin Finished
if spinState[0] == 2 {
    // Clear Spin State
    spinState[0] = 0;
    
    //Normalize WheelRot
    if wheelRot >= 360 {
        wheelRot -= 360;
    }else if wheelRot < 0 {
        wheelRot += 360;
    }
    
    
    // Get Flapper Tip Coordinates
    flapper_tip_rad = flapper.flapper_scale * ( sprite_get_height(flapper.flapper_spr ) - sprite_get_yoffset( flapper.flapper_spr));
    flapper_tip_x = flapper.x + dcos(flapper.image_angle -90) * flapper_tip_rad;
    flapper_tip_y = flapper.y - dsin(flapper.image_angle -90) * flapper_tip_rad;
    // Get Flapper Tip Angle
    flapper_tip_angle = point_direction(backWheel_x,backWheel_y, flapper_tip_x,flapper_tip_y);
    // Adjust for wheel rotation
    flapper_tip_angle -= wheelRot;
    // Get Selected Slice Index
    for (var i = 0; i < 8; i++){
        var angle_diff = angle_difference(i*45, flapper_tip_angle); 
        if abs(angle_diff) <= 22.5 and angle_diff != -22.5 {
            //NB: We except 22.5 exactly so that a single angle can't be on two slices at once
            //This is a remote chance but it can happen without this exception
            
            sliceData = sliceArray[i];
            scr_prize_type_process(sliceData[2]);
            //NB: We keep this block under prompt step footer so the screenshot works properly
            break;
            
        }
    }
}


#define scr_slice_data_create
///scr_slice_data_create(slice_type)

var sliceData = noone;
    
switch argument[0] {

// Empty Slice
case 0: 
    sliceData[0] = s_v_frown//sprite
    sliceData[1] = 2//color
break;

// Cash
case 1: 
    sliceData[0] = s_v_cash_circle//sprite
    sliceData[1] = 3//color
break;

// Features
case 2: 
    sliceData[0] = s_v_options//sprite
    sliceData[1] = 1//color
break;

// Themes
case 3: 
    sliceData[0] = s_v_themeswitcher//sprite
    sliceData[1] = 4//color
break;

// Buff Slice
case 4: 
    sliceData[0] = s_v_smile//sprite
    sliceData[1] = 1//color
break;

// DeBuff Slice
case 5: 
    sliceData[0] = s_v_frown//sprite
    sliceData[1] = 2//color
break;

}

// Other Slice Data
sliceData[2] = argument[0]//slice type
// Knob Slice Data
if instance_exists(obj_prize_flapper){
    sliceData[3] = instance_create(x,y,obj_prize_knob)//slice knob
    with (sliceData[3]) {
        prizeWheel = other.id;
        flapper = other.flapper;
    }
}


return sliceData;

#define scr_prize_flapper_collision
///scr_prize_flapper_collision()


//var inst = collision_point(x,y, flapper,true, true);
var inst = collision_circle(x,y, 2.5 * RMSPD_DELTA, flapper,true,true);

return inst;