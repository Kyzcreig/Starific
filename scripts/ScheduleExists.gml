/// ScheduleExists(schedule)

return (argument0 && ds_map_exists(global.SGMS_MAP_SCHEDULES, argument0) 
                  && is_array(global.SGMS_MAP_SCHEDULES[? argument0]));
