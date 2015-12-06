///string_split_lines(string,width,array);

/*
* Splits a string with given width.
* Argument0: string
* Argument1: width
* Argument2: array
* Returns: lines (array number)
*/  

/*
var split, a, b, width, lines;

split = argument0;    
split = string_replace_all(split, chr(13)+chr(10), " ");
data_array = argument2;

a = 1;
b = 0;
width = string_width(argument0);
lines = 0;

do {
    if b > 0 
    split = string_delete(split,1,string_length(data_array[b-1])));
    do { 
        if string_width(string_copy(split,0,a)) < argument1 { 
        variable_local_array_set(argument2,b,string_copy(split,0,a));
        a += 1;
        } else break;
    }  until (split == variable_local_array_get(argument2,b ))

    width -= string_width(variable_local_array_get(argument2,b ));
    if width != 0
    lines += 1;

    a = 1;

    if b < lines
        b += 1;
} until (width == 0)

return lines;
