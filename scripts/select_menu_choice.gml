///select_menu_choice(room,[NEW_GAME,MODE])
var new_room = argument[0]

if argument_count > 1{
   NEW_GAME = argument[1];
   MODE = argument[2]
}

LAST_ROOM = room //should be rm_menu
scr_room_goto(new_room);
