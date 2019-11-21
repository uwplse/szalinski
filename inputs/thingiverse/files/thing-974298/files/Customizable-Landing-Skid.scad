// Diameter of skid (same as motor works well)
diameter        = 23;

// Height of skid, wanna stand tall?
height          = 10;

// Diameter of the sphere used for curved bottom of skid
curvature       = 25;

// First motor mounting hole spacing (used for two-hole and four-hole mounting)
spacing1        = 12;

// Second motor mounting hole spacing (used for four-hole mounting)
spacing2        = 12;

// Motor mounting screw size, adjusted for clearance
holesize        = 2; // [2:M2, 3:M3]

// Thickness of base (increases motor screw lengths)
thickness       = 4; // [1:1MM, 2:2MM, 3:3MM, 4:4MM, 5:5MM, 6:6MM]

// Rounded is heavier and stonger and cross is lighter
style           = 1; // [1:Rounded, 2:Cross]

// Number of mounting holes
count           = 4; // [2:Two, 4:Four]

holesize_r      = holesize/2;
curvature_r     = curvature/2;
diameter_r      = diameter/2;

// Rotate it for correct printing orientation.
rotate([180, 0, 0]) {
    difference() {
        // Skid body
        intersection() {
            translate([0, 0, curvature_r]) sphere(r=curvature_r);
            cylinder(r=diameter_r, h=height);
        }

        // Mounting holes
        // Screw shafts
        translate([spacing1/2, 0, 0]) cylinder(r=holesize_r*1.3, h=height, $fn=20);
        translate([0-spacing1/2, 0, 0]) cylinder(r=holesize_r*1.3, h=height, $fn=20);
        if (count==4) {
            translate([0, spacing2/2, 0]) cylinder(r=holesize_r*1.3, h=height, $fn=20);
            translate([0, 0-spacing2/2, 0]) cylinder(r=holesize_r*1.3, h=height, $fn=20);
        }

        if (style==1) {
            // Style: Rounded
            // Screw head insets
            translate([spacing1/2, 0, 0]) cylinder(r=holesize_r+1.7, h=height-thickness, $fn=20);
            translate([0-spacing1/2, 0, 0]) cylinder(r=holesize_r+1.7, h=height-thickness, $fn=20);
            if (count==4) {
                translate([0, spacing2/2, 0]) cylinder(r=holesize_r+1.7, h=height-thickness, $fn=20);
                translate([0, 0-spacing2/2, 0]) cylinder(r=holesize_r+1.7, h=height-thickness, $fn=20);
            }
        } else {
            // Style: Cross
            // Square cutouts
            rotate([0, 0, 45]) translate([1.5, 1.5, 0-thickness]) cube([diameter_r, diameter_r, height]);
            rotate([0, 0, -45]) translate([1.5, 1.5, 0-thickness]) cube([diameter_r, diameter_r, height]);
            rotate([0, 0, 135]) translate([1.5, 1.5, 0-thickness]) cube([diameter_r, diameter_r, height]);
            rotate([0, 0, 225]) translate([1.5, 1.5, 0-thickness]) cube([diameter_r, diameter_r, height]);
        }
    }
}
