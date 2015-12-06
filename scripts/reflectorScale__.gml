///reflectorScale__(scale, target)

// Calc New Scale
var new_oScale = argument[1].oScale*argument[0];


// Set Scale
argument[1].image_xscale = new_oScale;
argument[1].image_yscale = new_oScale;

// Set Symbol Scale
argument[1].symScale = argument[1].symScaleStart*argument[0];
