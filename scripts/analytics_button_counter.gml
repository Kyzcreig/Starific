///analytics_button_counter(button_name, [optional_params_string]);

ini_open("savedata.ini")
var buttonCount = ini_read_real("button_counts", argument[0], 0);
//Increment count
ini_write_real("button_counts", argument[0], ++buttonCount);
ini_close();

if ANALYTICS{    
   if argument_count == 1 {
        analytics_send_buttonpress(argument[0],buttonCount);
   }
   else if argument_count > 1 {
        analytics_send_buttonpress(argument[0],buttonCount, argument[1]);
   }
}
