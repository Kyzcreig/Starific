#define string_split
///string_split(delimiter,string)
//
//  Returns an array of strings parsed from a given 
//  string of elements separated by a delimiter.
//
//      delimiter   delimiter character, string
//      string      group of elements, string
//
/// 
{
    var arr;
    var del = argument0;
    var str = argument1 + del;
    var len = string_length(del);
    var ind = 0;
    repeat (string_count(del, str)) {
        var pos = string_pos(del, str) - 1;
        arr[ind] = string_copy(str, 1, pos);
        str = string_delete(str, 1, pos + len);
        ind++;
    }
    return arr;
}

#define string_split_real
///string_split_real(delimiter,string)
//
//  Returns an array of reals parsed from a given 
//  string of elements separated by a delimiter.
//
//      delimiter   delimiter character, string
//      string      group of elements, string
//
/// 
{
    var arr;
    var del = argument0;
    var str = argument1 + del;
    var len = string_length(del);
    var ind = 0;
    repeat (string_count(del, str)) {
        var pos = string_pos(del, str) - 1;
        arr[ind] = real(string_copy(str, 1, pos));
        str = string_delete(str, 1, pos + len);
        ind++;
    }
    return arr;
}