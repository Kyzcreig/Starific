///scr_draw_pad(outerpadrad)


outerpadrad = argument[0] //((GAME_Y + GAME_H)-padcentery-5)
innerpadrad = max(0,outerpadrad - 60 * global.dpiX)
firepad = max(0,innerpadrad - 20 * global.dpiX)
/*
draw_set_color(merge_color(COLORS[0],COLORS[6],0))//.30*(k-1)))
draw_circle_width(x-GAME_X,y-GAME_Y,outerpadrad,4,128)//60*k)
draw_circle_width(x-GAME_X,y-GAME_Y,innerpadrad,4,128)//60*k)
*/
//draw_set_circle_precision(64)
//for (k=4;k>3;k--)
//{
//    draw_set_color(merge_color(COLORS[0],COLORS[6],0));//.2*(k - 1)))//.30*(k-1)))
//    //draw_circle_width(x/*-GAME_X*/,y/*-GAME_Y*/,outerpadrad,k,32)//60*k)
//    draw_circle_width(x/*-GAME_X*/,y/*-GAME_Y*/,innerpadrad,k,32)//60*k)
//}
//draw_set_circle_precision(32)
var tcXscale = 2*innerpadrad/sprite_get_width(s_v_touchoutline);
//var tcYscale = 2*innerpadrad/sprite_get_height(s_v_touchoutline);
draw_sprite_ext(s_v_touchoutline,0,x,y,tcXscale,tcXscale,0,COLORS[0],1);

//Draw thumb circle
var thumbx = dcos((mouseangle))*((outerpadrad-innerpadrad)/2 + innerpadrad)+x
var thumby = dsin((mouseangle))*((outerpadrad-innerpadrad)/2 + innerpadrad)+y
//draw_circle_color(thumbx,thumby,((outerpadrad-innerpadrad)/2),COLORS[0],COLORS[0],false)
var tcXscale = ((outerpadrad-innerpadrad))/sprite_get_width(s_v_touchcircle);
draw_sprite_ext(s_v_touchcircle,0,thumbx,thumby,
tcXscale,tcXscale, 0,COLORS[0],1)
