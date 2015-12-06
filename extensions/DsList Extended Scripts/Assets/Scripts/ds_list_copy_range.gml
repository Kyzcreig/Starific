/// ds_list_copy_range(id,source,index,length)
/*
    Copies a range of entries from one ds_list (source) to another (id)
    
    Arguments:
        id      the ds_list to copy to
        source  the ds_list to copy from
        index   the start index
        length  the length of the range
*/

var list_to = argument0;
var list_from = argument1;
var index = argument2;
var length = argument3;
var total = index + length;

// Clear target list
ds_list_clear(list_to);

// Verify that source contains the specified range
if(ds_list_size(list_from) < total) {
    // It doesn't contain the range
    show_error("ds_list_copy_range, Out Of Range Error", false);
    exit;
}

for(var i = index; i < total; i++) {
    ds_list_add(list_to, ds_list_find_value(list_from, i));
}
