/// ds_list_insert_range(id,index,value,...)
/*
    Inserts an array of entries into a ds_list at the specified index
    
    Arguments:
        id          the ds_list to insert into
        index       the index to insert the first value at
        value,...   the values to begin inserting at the specified index
*/

var list = argument[0];
var index = argument[1];
var count = argument_count - 2;

for(var i = 0; i < count; i++) {
    ds_list_insert(list, index + i, argument[2 + i]);
}
