///draw_text_outline_ext_transformed_color(x,y,str, sep, w, xscl, yscl, rot, c1, c2, c3, c4, alpha, outwidth,outcol,outfidelity)
//Created by Andrew McCluskey http://nalgames.com/
//x,y: Coordinates to draw
//str: String to draw
//outwidth: Width of outline in pixels
//outcol: Colour of outline (main text draws with regular set colour)
//outfidelity: Fidelity of outline (recommended: 4 for small, 8 for medium, 16 for larger. Watch your performance!)

var i, xx, yy, str, sep, w, xscl, yscl, rot, c1, c2, c3, c4, alph, outwidth, outcol, outfidelity
i = 0;
xx = argument[i++];
yy = argument[i++];
str = argument[i++];
sep = argument[i++];
w = argument[i++];
xscl = argument[i++];
yscl = argument[i++];
rot = argument[i++];
c1 = argument[i++];
c2 = argument[i++];
c3 = argument[i++];
c4 = argument[i++];
alph = argument[i++];
outwidth = argument[i++];
outcol = argument[i++];
outfidelity = argument[i++];

var dto_dcol=draw_get_color();
var dto_dalph = draw_get_alpha();
draw_set_color(outcol);
draw_set_alpha(alph);

//sep, w, xscl, yscl, rot,

for(var dto_i=45; dto_i<405; dto_i+=360/outfidelity)
{
    draw_text_transformed(xx+lengthdir_x(outwidth,dto_i),yy+lengthdir_y(outwidth,dto_i),str, xscl, yscl, rot);
}

draw_set_color(dto_dcol);
draw_set_alpha(dto_dalph);

draw_text_ext_transformed_colour(xx,yy,str,sep, w, xscl, yscl, rot, c1, c2, c3, c4, alph);
