/// ds_list_destroy_lists(id,...)
/*
    Destroys an array of ds_lists
    
    Arguments:
        id,...  an array of ds_lists
*/

var count = argument_count - 1;

while(count > -1) {
    ds_list_destroy(argument[count]);
    count--;
}
