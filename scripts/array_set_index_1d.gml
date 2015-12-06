#define array_set_index_1d
///array_set_index_1d(array,index,value)

var arrayToSet = argument[0];
var indexToSet = argument[1];
var valueToSet = argument[2];
arrayToSet[@ indexToSet] = valueToSet

return arrayToSet;

#define array_set_index_2d
///array_set_index_2d(array,index1,index2,value)


var arrayToSet = argument[0];
var index1ToSet = argument[1];
var index2ToSet = argument[2];
var valueToSet = argument[3];
arrayToSet[@ index1ToSet, index2ToSet] = valueToSet

return arrayToSet;
#define array_add_index_1d
///array_add_index_1d(array,index,value_to_add)

var arrayToAdd = argument[0];
var indexToAdd = argument[1];
var valueToAdd = argument[2];
arrayToAdd[@ indexToAdd] += valueToAdd

return arrayToAdd;