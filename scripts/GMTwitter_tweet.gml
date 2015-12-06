///GMTwitter_tweet(String,URL)
/*
Prompts the user to Tweet.
If you don't want a URL, put "" as the argument.
Using the URL field shortens the link and allows for more characters.
Ex. GMTwitter_tweet("I scored "+string(score)+" in this new game!","https://twitter.com/")
*/

var s,d,link,c_rep;

s=argument0;
d=argument1;

c_rep[1,0]='%'
c_rep[1,1]='%25'
c_rep[2,0]='"'
c_rep[2,1]='%22'
c_rep[3,0]='#'
c_rep[3,1]='%23'
c_rep[4,0]='$'
c_rep[4,1]='%24'
c_rep[5,0]='!'
c_rep[5,1]='%21'
c_rep[6,0]='&'
c_rep[6,1]='%26'
c_rep[7,0]="'"
c_rep[7,1]='%27'
c_rep[8,0]='('
c_rep[8,1]='%28'
c_rep[9,0]=')'
c_rep[9,1]='%29'
c_rep[10,0]='*'
c_rep[10,1]='%2A'
c_rep[11,0]='+'
c_rep[11,1]='%2B'
c_rep[12,0]=','
c_rep[12,1]='%2C'
c_rep[13,0]='-'
c_rep[13,1]='%2D'
c_rep[14,0]='.'
c_rep[14,1]='%2E'
c_rep[15,0]='/'
c_rep[15,1]='%2F'
c_rep[16,0]=':'
c_rep[16,1]='%3A'
c_rep[17,0]=';'
c_rep[17,1]='%3B'
c_rep[18,0]='<'
c_rep[18,1]='%3C'
c_rep[19,0]='='
c_rep[19,1]='%3D'
c_rep[20,0]='>'
c_rep[20,1]='%3E'
c_rep[21,0]='?'
c_rep[21,1]='%3F'
c_rep[22,0]='@'
c_rep[22,1]='%40'
c_rep[23,0]='['
c_rep[23,1]='%5B'
c_rep[24,0]='\'
c_rep[24,1]='%5C'
c_rep[25,0]=']'
c_rep[25,1]='%5D'
c_rep[26,0]='^'
c_rep[26,1]='%5E'
c_rep[27,0]='_'
c_rep[27,1]='%5F'
c_rep[28,0]='`'
c_rep[28,1]='%60'
c_rep[29,0]='{'
c_rep[29,1]='%7B'
c_rep[30,0]='|'
c_rep[30,1]='%7C'
c_rep[31,0]='}'
c_rep[31,1]='%7D'
c_rep[32,0]='~'
c_rep[32,1]='%7E'
c_rep[33,0]='¢'
c_rep[33,1]='%A2'
c_rep[34,0]='£'
c_rep[34,1]='%A3'
c_rep[35,0]='¥'
c_rep[35,1]='%A5'
c_rep[36,0]='|'
c_rep[36,1]='%A6'
c_rep[37,0]='§'
c_rep[37,1]='%A7'
c_rep[38,0]='«'
c_rep[38,1]='%AB'
c_rep[39,0]='¬'
c_rep[39,1]='%AC'
c_rep[40,0]='¯'
c_rep[40,1]='%AD'
c_rep[41,0]='º'
c_rep[41,1]='%B0'
c_rep[42,0]='±'
c_rep[42,1]='%B1'
c_rep[43,0]='ª'
c_rep[43,1]='%B2'
c_rep[44,0]=','
c_rep[44,1]='%B4'
c_rep[45,0]='µ'
c_rep[45,1]='%B5'
c_rep[46,0]='»'
c_rep[46,1]='%BB'
c_rep[47,0]='¼'
c_rep[47,1]='%BC'
c_rep[48,0]='½'
c_rep[48,1]='%BD'
c_rep[49,0]='¿'
c_rep[49,1]='%BF'

for (i=1;i<=49;i++) //Replaces special characters
   {
   s=string_replace_all(s,c_rep[i,0],c_rep[i,1]);
   if d!="" d=string_replace_all(d,c_rep[i,0],c_rep[i,1]);
   }

link="http://twitter.com/intent/tweet?text="+s;
if d!="" link+="&url="+d;

url_open_ext(link,URL_TARGET)//"_blank")
