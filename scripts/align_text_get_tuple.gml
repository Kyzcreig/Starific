#define align_text_get_tuple
///align_text_get_tuple()

var edgeBuffer = +.33*gridSize*cellSize;

var x_is_right = (x >= centerfieldx + edgeBuffer);
var y_is_bottom = (y >= centerfieldy + edgeBuffer);
var x_is_left = (x < centerfieldx - edgeBuffer);
var y_is_top =  (x < centerfieldx - edgeBuffer);


// Init Array
var arr = noone;

if x_is_right {
    arr[0] = fa_right;
} else if x_is_left {
    arr[0] = fa_left;
} else {
    arr[0] = fa_center;
}

if y_is_bottom {
    arr[1] = fa_bottom;
} else if y_is_top {
    arr[1] = fa_top;
} else {
    arr[1] = fa_middle;
}




return arr; 

#define scr_align_text_popup
///scr_align_text_popup(dynamic)


if GAME_ACTIVE and instance_exists(obj_control_game) and room == rm_game and argument0{
    alignments = align_text_get_tuple()
}
else{
    alignments[0] = fa_center
    alignments[1] = fa_middle
}
return alignments;