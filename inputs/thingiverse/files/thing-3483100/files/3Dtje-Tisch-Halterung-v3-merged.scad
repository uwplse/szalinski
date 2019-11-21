// 3Dtje buildplate holder

plate_inner_dimension = 100.2;
plate_border = 1.6;
M3_tolerance = 0.25;

// don't touch from here!
plate_outer_dimension = plate_inner_dimension + 2*plate_border;
M3_diameter = 1.5 + M3_tolerance;

module mainbody() {
    union() {
        // imported base
        rotate([0, 180, 90]) translate([-50, -50, -1.4]) import("3.1-009_bedtwrap-export.stl");
        // groundplate
        difference() {
            translate([0, 0, 0.3]) cube([plate_outer_dimension, plate_outer_dimension, 1.4], true); 

            // 3 holes for cable ties
            translate([-38, +19, 4.5]) cube([18, 5, 10], center = true);
            translate([-38, -19, 4.5]) cube([18, 5, 10], center = true);
            translate([39, 0, 4.5]) cube([18, 5, 10], center = true);
        }

        // mounting bumbers to level buildplate on 4 points
        translate([45, 45, 0.5]) cube([8, 8, 3], center = true);
        translate([-45, 45, 0.5]) cube([8, 8, 3], center = true);
        translate([-45, -45, 0.5]) cube([8, 8, 3], center = true);
        translate([45, -45, 0.5]) cube([8, 8, 3], center = true);
    }
}

difference() {
    mainbody();

    // smoothen bearing slots
    translate([-40.3, 0, -7.6]) rotate([90, 0, 0]) cylinder(58, 6, 6, true, $fn = 180);
    translate([+40.3, 0, -7.6]) rotate([90, 0, 0]) cylinder(58, 6, 6, true, $fn = 180);

    translate([39, 0, 4.4]) cube([18, 5, 10], center = true);

    // add more space for the belt to bend
    translate([-26, -7, -15]) rotate([90, +25, 90]) scale([1.75, 1, 1]) cylinder(10, 1, 1, true, $fn = 180);
    translate([-26, -9, -15]) rotate([90, -25, 90]) scale([1.75, 1, 1]) cylinder(10, 1, 1, true, $fn = 180);
    translate([-26, -8, -16.3]) rotate([90, -25, 90]) cylinder(10, 2.9, 2.9, true, $fn = 180);
}





translate([0, 0, 2.5]) 
    // add 2 access areas from front and back to the buildplate
    difference() {
        // mountplate
        difference() {
            cube([plate_outer_dimension, plate_outer_dimension, 6], true);
            cube([plate_inner_dimension, plate_inner_dimension, 8], true);
        }
        
        cube([16, plate_outer_dimension*1.5, 10], true);
    }