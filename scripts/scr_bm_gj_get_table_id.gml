///scr_bm_gj_get_table_id(MODE, GRID)
//returns table_id

var m = argument0;
var g = argument1;

// Arcade
if argument0== MODES.ARCADE && argument1==0 return "54413";
if argument0== MODES.ARCADE && argument1==1 return "54414";
if argument0== MODES.ARCADE && argument1==2 return "54415";
if argument0== MODES.ARCADE && argument1==3 return "54416";

// Moves
if argument0== MODES.MOVES && argument1==0 return "54417";
if argument0== MODES.MOVES && argument1==1 return "54418";
if argument0== MODES.MOVES && argument1==2 return "54419";
if argument0== MODES.MOVES && argument1==3 return "54420";

// Time
if argument0== MODES.TIME && argument1==0 return "54421";
if argument0== MODES.TIME && argument1==1 return "54422";
if argument0== MODES.TIME && argument1==2 return "54423";
if argument0== MODES.TIME && argument1==3 return "54424";

// Sandbox
if argument0== MODES.SANDBOX && argument1==0 return "97906";
if argument0== MODES.SANDBOX && argument1==1 return "97908";
if argument0== MODES.SANDBOX && argument1==2 return "97909";
if argument0== MODES.SANDBOX && argument1==3 return "97910";

return "";
