///draw_star_marker()


//draw background star scaled up to be like it is when starmarker is selected
var str_scl = star_scale * markerTween[0] * hoverScale;
draw_sprite_ext(star_spr,0,x,y,str_scl,str_scl,0,marker_col,.5*mixers_alpha[0]);

var marker_alpha = 1*mixers_alpha[0];
if selected[0]{
   
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_gui_tutorial);
    var text_x = Creator_ID.dialogue_x[mixPos[0]];
    var text_y = Creator_ID.dialogue_y[mixPos[0]];
    draw_text_colour(text_x,text_y,"Swipe to select star direction.",
    marker_col,marker_col,marker_col,marker_col,marker_alpha);
    
}

//Draw Star Marker
var mkr_scl = marker_scale * markerTween[0] * hoverScale;
draw_sprite_ext(marker_spr,0,x,y,mkr_scl,mkr_scl,0,marker_col,marker_alpha*mixers_alpha[0]);

//Draw Marker Pointer
if marker_dir != noone and !selected[0] and mixers_alpha[0] == 1{

   draw_arrow_width(x, y, x+arrowEndX, y+arrowEndY, cellW, 3, marker_col);

}
