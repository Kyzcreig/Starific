///Returns argument0 as a string with zeroes if it has fewer than argument1 characters
///eg string_zeroes(150,6) returns "000150" or
///string_zeroes(mins,2)+":"+string_zeroes(secs,2) might return "21:02"
///Created by Andrew McCluskey, use it freely

var rtn="";

if string_length(string(argument0))<argument1
{
    repeat(argument1-string_length(string(argument0))) rtn+="0"
}

rtn+=string(argument0)

return rtn;
