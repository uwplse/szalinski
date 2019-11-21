/* [Straw Config] */

// Outer diameter of the straw being placed on, in mm.
straw_outer_diameter = 11.6;

// Thickness of the straw's material, in mm.
straw_thickness = 0.3;

/* [Dimensions] */

// Thickness of the part, in mm.
thickness = 4;

/* [Expert] */

// Quality
$fn=32;

difference() {
    cylinder(h = thickness, d = straw_outer_diameter - 2*straw_thickness);

    for(i = [1:3])
        rotate([0, 0, i*360/3])
            translate([(straw_outer_diameter - 2*straw_thickness)/4, 0, 0])
                cylinder(h = thickness+2, d = (straw_outer_diameter - 2*straw_thickness)/3);
}