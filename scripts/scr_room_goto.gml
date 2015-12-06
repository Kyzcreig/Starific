///scr_room_goto(room,[resume music])


//Update analytics on time spent in a given room
if ANALYTICS{
   analytics_send_roomtime(room);
}

//Go to room
room_goto(argument[0])
