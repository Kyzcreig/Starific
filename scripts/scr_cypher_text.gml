///scr_cypher_text(characters, cypher, text); 

var letters, cypher, myString, len, newString, newChar, pos, char;
 
letters = argument0;//"abcdefghijklmnopqrstuvwxyz";
cypher =  argument1;//"rstuvwxyzabcdefghijklmnopq";
myString = argument2;
 
len = string_length(myString);
cypherLen = string_length(cypher);
newString = "";
 
for(var i=1; i<= len; i++)
{
   char = string_char_at(myString,i);
   pos = string_pos(char, letters);
   if pos != 0{
       newChar = string_char_at(cypher,pos mod cypherLen);
   }
   else{
       newChar = char;
   }
   newString += newChar;
}
 
return newString;
