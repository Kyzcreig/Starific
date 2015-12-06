#define time_decode
///time_decode(steps)
/*
** Input    : Real   : Steps
** Output   : String : 00:00:00
*/
 
//Set-up of script local variables
var Steps = argument0 ;
var Seconds = floor(Steps / room_speed) ;
var Minutes = floor(Seconds/60) ;
var Hours   = floor(Minutes/60) ;
 
//Calculate the number of minutes and second
 
Minutes = Minutes - Hours*60 ;
Seconds = Seconds - Hours *3600 - Minutes*60 ;
 
//Insert additional zeroes to mantain format
if (Hours < 10)
{
    Hours = "0" + string(Hours) ;
}
if (Minutes < 10)
{
    Minutes = "0" + string(Minutes) ;
}
if (Seconds < 10)
{
    Seconds = "0" + string(Seconds) ;
}
   
//Return the string
//All Variables must be converted to strings at this stage.
return string(Hours) + ":" + string(Minutes) + ":" + string(Seconds) ;

#define time_decode_opt
///time_decode_opt(hours, minutes, seconds, steps)


///time_decode(steps)
/*
** Input    : Real   : Steps
** Output   : String : 00:00:00
*/
 
//Set-up of script local variables
var IncludeHours = argument0;
var IncludeMinutes = argument1;
var IncludeSeconds = argument2;
var Steps = argument3 ;
var Seconds = floor(Steps / room_speed) ;
var Minutes = floor(Seconds/60) ;
var Hours   = floor(Minutes/60) ;
var TimeString = "";
 
//Calculate the number of minutes and second
 
Minutes = Minutes - Hours*60 ;
Seconds = Seconds - Hours *3600 - Minutes*60 ;

//Insert additional zeroes to mantain format
//All Variables must be converted to strings at this stage.
if IncludeHours {
    if TimeString != "" {
        TimeString += ":"
    } 
    if (Hours < 10){
        Hours = "0" + string(Hours) ;
    }
    TimeString += string(Hours)
}
if IncludeMinutes {
    if TimeString != "" {
        TimeString += ":"
    } 
    if (Minutes < 10){
        Minutes = "0" + string(Minutes) ;
    }
    TimeString += string(Minutes)
}
if IncludeSeconds {
    if TimeString != "" {
        TimeString += ":"
    } 
    if (Seconds < 10){
        Seconds = "0" + string(Seconds) ;
    }
    TimeString += string(Seconds)
}

//Return the string
return TimeString;

#define time_decode_custom
///time_decode_custom(steps, fps)



/*
** Input    : Real   : Steps
** Output   : String : 00:00:00
*/
 
//Set-up of script local variables
var Steps = argument0 ;
var StepSpeed = argument1;
var Seconds = floor(Steps / StepSpeed) ;
var Minutes = floor(Seconds/60) ;
var Hours   = floor(Minutes/60) ;
 
//Calculate the number of minutes and second
 
Minutes = Minutes - Hours*60 ;
Seconds = Seconds - Hours *3600 - Minutes*60 ;
 
//Insert additional zeroes to mantain format
if (Hours < 10)
{
    Hours = "0" + string(Hours) ;
}
if (Minutes < 10)
{
    Minutes = "0" + string(Minutes) ;
}
if (Seconds < 10)
{
    Seconds = "0" + string(Seconds) ;
}
   
//Return the string
//All Variables must be converted to strings at this stage.
return string(Hours) + ":" + string(Minutes) + ":" + string(Seconds) ;

#define time_decode_opt_custom
///time_decode_opt_custom(hours, minutes, seconds, steps, fps)


///time_decode(steps)
/*
** Input    : Real   : Steps
** Output   : String : 00:00:00
*/
 
//Set-up of script local variables
var IncludeHours = argument0;
var IncludeMinutes = argument1;
var IncludeSeconds = argument2;
var Steps = argument3 ;
var StepSpeed = argument4;
var Seconds = floor(Steps / StepSpeed) ;
var Minutes = floor(Seconds/60) ;
var Hours   = floor(Minutes/60) ;
var TimeString = "";
 
//Calculate the number of minutes and second
 
Minutes = Minutes - Hours*60 ;
Seconds = Seconds - Hours *3600 - Minutes*60 ;

//Insert additional zeroes to mantain format
//All Variables must be converted to strings at this stage.
if IncludeHours or Hours > 0{
    if TimeString != "" {
        TimeString += ":"
    } 
    if (Hours < 10){
        Hours = "0" + string(Hours) ;
    }
    TimeString += string(Hours)
}
if IncludeMinutes or Minutes > 0 {
    if TimeString != "" {
        TimeString += ":"
    } 
    if (Minutes < 10){
        Minutes = "0" + string(Minutes) ;
    }
    TimeString += string(Minutes)
}
if IncludeSeconds or Seconds > 0{
    if TimeString != "" {
        TimeString += ":"
    } 
    if (Seconds < 10){
        Seconds = "0" + string(Seconds) ;
    }
    TimeString += string(Seconds)
}

//Return the string
return TimeString;