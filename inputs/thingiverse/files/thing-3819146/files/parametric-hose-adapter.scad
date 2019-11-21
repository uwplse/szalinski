/* [Basics] */

// Inner Diameter of Part A (mm)
part_a_inner_diameter = 32;

// Outer Diameter of Part B (mm)
part_b_outer_diameter = 37;

/* [Advanced] */

// Material Strength (mm)
material_strength = 4;

// How long is the slide on section per part? (mm)
slide_on_length = 20;

// How long is the connection section between the parts? (mm)
connection_length = 10;

// What is the slide on ramp for creating a tight fit? (mm)
slide_on_ramp = 2;

/* [Hidden] */
//  Number of fragments for rendering a circle
$fn = 100;

//projection(cut = true) rotate([90,0,0])
//projection(cut = false) rotate([90,0,0])
adapter(
    part_a_inner_diameter, 
    part_b_outer_diameter, 
    material_strength, 
    slide_on_length, 
    connection_length,
    slide_on_ramp
);


module adapter(partA, partB, strength, length, con_length, ramp) {
    union() {
        // Part A
        translate([0, 0, length + con_length]) {
            difference() {
                cylinder(length, d1 = partA + ramp, d2 = partA - ramp);
                cylinder(length, d1 = partA - strength, d2 = partA - strength);
            }
        }

        // Connection between Part A and Part B
        translate([0, 0, length]) {
            difference() {
                cylinder(con_length, d1 = partB + strength, d2 = partA + ramp);
                cylinder(con_length, d1 = partB - ramp, d2 = partA - strength);
            }
        }

        // Part B
        difference() {
            cylinder(length, d1 = partB + strength, d2 = partB + strength);
            cylinder(length, d1 = partB + ramp, d2 = partB - ramp);
        }
    }
}