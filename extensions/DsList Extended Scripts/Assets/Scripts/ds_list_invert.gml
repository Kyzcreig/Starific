/// ds_list_invert(id)
/*
    Inverts a ds_list
    
    Arguments:
        id      the ds_list to invert
    
    Returns:
        the inverted ds_list
*/

var new_list = ds_list_create();
var list = argument0;

for(var i = ds_list_size(list) - 1; i > -1; i--) {
    ds_list_add(new_list, ds_list_find_value(list, i));
}

return new_list;
