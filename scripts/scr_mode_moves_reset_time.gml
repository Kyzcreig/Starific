///scr_mode_moves_reset_time()


// Reset Move Time
moves_time_left = moves_time_max
//Update Time String
moves_time_string = string_format(max(0.00,moves_time_left/room_speed),2,2);
//Update Color
mode_bar_color = COLORS[0];
