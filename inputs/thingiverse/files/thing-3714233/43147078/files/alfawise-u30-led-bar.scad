// LED Bar for Alfawise U30 printer

bar_length=180; // Minimum=40 !
hole_size=5.5; // [3, 3.5, 4, 4.5, 5, 5.5]
use_wire_clip=true;


difference() {
    union() {
        // Main support for the LED bar
        linear_extrude(height=bar_length) {
            difference() {
                square(15);
                translate([-1, 16, 0]) circle(r=15);
            }

            // Triangle to spin the led toward the hotend
            translate([15, 0, 0]) polygon(points=[[0,0],[6,15],[0,15]]);

            translate([0.8, 6, 0]) rotate([0, 0, -22]) {
                // Left notch to fix the LED strip
                translate([15, 0, 0]) square([3.4, 1]);
                translate([17.4, 1, 0]) square([1, 3.2]);

                // Right notch to fix the LED strip
                translate([15, 14, 0]) square([3.4, 1]);
                translate([17.4, 10.8, 0]) square([1, 3.2]);
            }
        }

        // Small bar to align the support to the rail
        translate([4.5,-2,0]) cube(size=[6,2,bar_length]);
    }

// Blocks to fix the screws
    translate([4,2,11.5]) cube([7,6,7]);
    translate([4,2,bar_length-18.5]) cube([7,6,7]);

    // Holes to fix the bar to the aluminum profile
    translate([7.5,10,15]) rotate([90,0,0]) cylinder(15, d=hole_size);
    translate([7.5,10,bar_length-15]) rotate([90,0,0]) cylinder(15, d=hole_size);
}

if (use_wire_clip) {
    // Wire clip
    translate([10, 10, 0]) difference() {
        // Ring 
        difference() {
            cylinder(7, d=8, $fn=12);
            cylinder(7, d=6, $fn=12);
        }

        // Hole to do an open ring
        translate([-2,-7,-1]) cube([4,6,9]);
    }
}
