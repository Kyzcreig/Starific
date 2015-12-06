///scr_draw_messagebox(string text, real text_length, real padding, real talking_object, color background_color, bool force_text_below_object, bool triangles);

var text = argument0;       // Text for the box
var len = argument1;        // Text wrap width
var padding = argument2;    // Space between text and border
var obj = argument3;        // The object speaking. (message box points to them)
var bak_color = argument4;  // Color of the background
var force = argument5;      // Force box to draw below object
var triangles = argument6;      // Draw triangles or not

if(!instance_exists(obj) /* talker died */ || string(text) == "" /* nothing to say */) return 1;

var w = len+padding*2;
var height = string_height_ext(text, -1, len);
var h2 = height+padding*2;
var xx = obj.x;
var yy = obj.y - padding*4 - obj.sprite_height - height;//ok so it's padding*4 for the triangle

xx -= max(0,(xx+len+padding*4)-(GAME_X+GAME_W /* change to view_xview[x]+view_wview[x] for game with views or room_width */));

if(yy < 0 || force)
{
    yy = obj.y + obj.sprite_height + padding*2;
    if triangles draw_triangle(obj.x, obj.y+obj.sprite_height*.5+5, obj.x-padding,yy-padding+1,obj.x+padding,yy-padding+1,0);
}
else
{
    if triangles draw_triangle(obj.x, obj.y-obj.sprite_height*.5-5, obj.x+padding,yy+height+padding*2-1, obj.x-padding,yy+height+padding*2-1,0);
}


draw_roundrect(xx-padding,yy-padding,xx+len+padding*3,yy+height+padding*3,0);
draw_rectangle_colour(xx,yy,xx+w,yy+h2,bak_color,bak_color,bak_color,bak_color,0);

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text_ext(xx+padding+len*.5,yy+padding,text,-1,len);

return 0;
