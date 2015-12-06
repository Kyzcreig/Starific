///draw_text_outline_color(x,y,str,c1, c2, c3, c4, alpha, outwidth,outcol,outfidelity)
//Created by Andrew McCluskey http://nalgames.com/
//x,y: Coordinates to draw
//str: String to draw
//outwidth: Width of outline in pixels
//outcol: Colour of outline (main text draws with regular set colour)
//outfidelity: Fidelity of outline (recommended: 4 for small, 8 for medium, 16 for larger. Watch your performance!)

var dto_dcol = draw_get_color();
var dto_dalph = draw_get_alpha();
draw_set_color(argument9);
draw_set_alpha(argument7);

for(var dto_i=45; dto_i<405; dto_i+=360/argument10)
{
    draw_text(argument0+lengthdir_x(argument8,dto_i),argument1+lengthdir_y(argument8,dto_i),argument2);
}

draw_set_color(dto_dcol);
draw_set_alpha(dto_dalph);

draw_text_color(argument0,argument1,argument2,argument3,argument4,argument5,argument6,argument7);
