///shooter_scale__(scale, target)


with (argument[1]) {
    // Calc New Scale
    var new_oScale = oScale * argument[0];
    
    // Set Scale
    image_xscale = new_oScale;
    image_yscale = new_oScale;
    
    // Get Particle
    var cur_par = p_star;
    // Set Particle Scale/Size
    part_type_size(cur_par,1,1,-0.01*argument[0],0);
    part_type_scale(cur_par,new_oScale,new_oScale);

}
