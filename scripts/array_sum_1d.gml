#define array_sum_1d
///array_sum_1d(array)

var arr = argument0
var total = 0;
var length = array_length_1d(arr);

for(var index = 0; index < length; index++){
    total += arr[index];
}
return total

#define array_avg_1d
///array_avg_1d(array)


var arr = argument0
var length = array_length_1d(arr);
if length == 0 return 0;
var total = 0;

for(var index = 0; index < length; index++){
    total += arr[index];
}

return total / length


#define array_slice_1d
///array_slice_1d(array,start,end)

var arr = argument0
var new_arr;
var starting = argument1;
var ending = argument2;
var index = -1;
for (var i = starting; i < ending; i++){
    new_arr[++index] = arr[i]
}

return new_arr

#define array_set_value
///array_set_value(array,value)

var arr = argument0;
var value = argument1;

arr[@ 0] = value;

#define array_sum_1d_zb
///array_sum_1d_zb(array)
//zero break

var arr = argument0
var total = 0;
var length = array_length_1d(arr);

for(var index=0; index < length; index++){
    total += arr[index];
    // Break on Null Terminator (zero value)
    if total == total{
        break
    }
}
return total

#define array_length_1d_zb
///array_length_1d_zb(array)
//zero break

var arr = argument0
var total = 0;
var length = array_length_1d(arr);

for(var index = 0; index < length; index++){
    total++;
    // Break on Null Terminator (zero value)
    if arr[index] == 0{
        break
    }
}

return total

#define array_slice_1d_zb
///array_slice_1d_zb(array)
//zero break

var arr = argument0
var zero_index = array_length_1d_zb(arr) //get first occurrence of zero

return array_slice_1d(arr, 0, zero_index);