#define array_sorted_indexes_1d
///array_sorted_indexes_1d(array, ascending?)

var array = argument0;
var ascending = argument1;
var indexes = noone;
var size = array_length_1d(array);

//Add indexes to array
for (z = 0; z < size; z++){
    indexes[z] = z;
}

//Sort indexes
for (z = 0; z < size; z++){

    var j = z;
    while ( j > 0 and array_sort_helper(array[indexes[j-1]],array[indexes[j]], ascending) ){
        var tmp = indexes[j-1];
        indexes[j-1] = indexes[j];
        indexes[j] = tmp;
        j--;
    }

}


return indexes;



#define array_sort_helper
//array_sort_helper(val1, val2, ascending?)

if argument2{
    return argument0 > argument1;
}
else{
    return argument0 < argument1;
}

 