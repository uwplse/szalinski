// 3Dtje buildplate holder

plate_inner_dimension = 100.4;
plate_border = 1.6;
M3_tolerance = 0.2;

// don't touch from here!
plate_outer_dimension = plate_inner_dimension + 2*plate_border;
M3_diameter = 1.5 + M3_tolerance;

difference() {
    union() {
        // groundplate
        cube([plate_outer_dimension, plate_outer_dimension, 3], true); 
        // mounting bumbers to level buildplate on 4 points
        translate([45, 45, 1]) cylinder(2, 2, 2, true, $fn = 180);
        translate([-45, 45, 1]) cylinder(2, 2, 2, true, $fn = 180);
        translate([-45, -45, 1]) cylinder(2, 2, 2, true, $fn = 180);
        translate([45, -45, 1]) cylinder(2, 2, 2, true, $fn = 180);
    }
 
    // 3 holes
    translate([0, 37, 0]) cylinder(10, M3_diameter, M3_diameter, true, $fn = 180);
    translate([30, -37, 0]) cylinder(10, M3_diameter, M3_diameter, true, $fn = 180);
    translate([-30, -37, 0]) cylinder(10, M3_diameter, M3_diameter, true, $fn = 180);
}
 
 
translate([0, 0, 2]) 
    // add 2 access areas from front and back to the buildplate
    difference() {
        // mountplate
        difference() {
            cube([plate_outer_dimension, plate_outer_dimension, 3], true);
            cube([plate_inner_dimension, plate_inner_dimension, 5], true);
        }
        
        cube([16, plate_outer_dimension*1.5, 10], true);
    }
