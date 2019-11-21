/* [Straw Config] */

// Outer diameter of the straw being placed on, in mm.
straw_outer_diameter = 11.6;

// Thickness of the straw's material, in mm.
straw_thickness = 0.3;

/* [Dimensions] */

// Thickness of the part, in mm.
thickness = 1.2;

// Height of the window (not counting part thickness), in mm. This is about as much as the inner indicator is expected to move, with some extra.
window_height = 50;

// Number of windows rotated around the straw.
windows = 6;

// Size of each window, in mm.
window_thickness = 5;

// Length of part to be inserted into straw, in mm.
insert_height = 16;

/* [Expert] */

// Quality
$fn=32;

union(){
    difference(){
        difference(){
            cylinder(h = window_height+2*thickness, d=straw_outer_diameter+2*thickness, center=false);
            cylinder(h = window_height+thickness, d1=straw_outer_diameter-2*straw_thickness-2*thickness, d2=straw_outer_diameter-2*straw_thickness-2*thickness, center=false);
        }

        for(i=[1:windows])
            rotate([0, 0, i*360/windows])
                intersection(){
                    translate([window_thickness, 0, thickness+window_height/2])
                        scale([1,0.3,1])
                            sphere(d = window_height);
                    translate([0, -window_thickness/2, thickness])
                        cube([10, window_thickness, window_height]);
                }
    }

    translate([0, 0, thickness])
        rotate([180, 0, 0]) {
            difference(){
                cylinder(h = insert_height, d=straw_outer_diameter-2*straw_thickness, center=false);
                cylinder(h = insert_height, d=straw_outer_diameter-2*straw_thickness-2*thickness, center=false);
            }
        }
}