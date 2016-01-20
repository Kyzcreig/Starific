///string_keep_chars(str,chars)
//
//  Returns the string minus any chars not in the string of chars provided.
//
//      str         string of text, string
//      chars       string of chars, string
//  
//  Example: string_keep_chars("$1.99","123456789.,") returns "1.99"
//  
//
/// GMLscripts.com/license


var str = argument0;
var chars = argument1;
var rtn = ""
var len = string_length(str);
var char;

for (var i = 1; i <= len; i++){
    char = string_char_at(str, i);
    if string_pos(char, chars) != 0 {
        rtn += char;
    }    
}

return rtn;
