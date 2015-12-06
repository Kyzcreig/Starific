////array_get_largest_index(padColorTimers)

var arr = argument0;
var bigIndex = 0;

for (var i = 1, n = array_length_1d(arr); i < n; i++) {
    if arr[i] > arr[bigIndex] {
        bigIndex = i;
    }
}

return bigIndex 


/*


padColorsTimersSorted = array_sorted_indexes_1d(padColorTimers, false);
