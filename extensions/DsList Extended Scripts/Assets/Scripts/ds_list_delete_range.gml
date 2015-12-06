/// ds_list_delete_range(id,index,length)
/*
    Deletes a range of entries
    
    Arguments:
        id      the ds_list to invert
        index   the start index
        length  the length of the range
*/

var list = argument0;
var index = argument1;
var length = argument2;
var total = index + length;

// Verify that source contains the specified range
if(ds_list_size(list) < total) {
    // It doesn't contain the range
    show_error("ds_list_delete_range, Out Of Range Error", false);
    exit;
}
    
while(length > -1) {
    ds_list_delete(list, index + length);
    length--;
}
