///string_slice(str, start_index, end_index);
// Designed to mimic python string slicing

var end_count;
if argument_count <= 2 {
    end_count = string_length(argument[0]) - argument[1];
}
else {
    // Normal index to index
    if argument[2] >=+ argument[1] {
        end_count = argument[2] - (argument[1]);
    }
    //  Error index mismatch
    else if argument[2] > 0 {
        show_message("Error in string_slice");
    }
    // Negative indexes wrap around for convenient syntax
    else {
        end_count = string_length(argument[0]) + argument[2]  - (argument[1]);
    }
}

return string_copy(argument[0], argument[1]+1, end_count);
