
///////////////
// Variables //
///////////////

/* [General] */

// Radius for the rectangle
radius = 5;

// Thickness
thickness = 4;

// Distance between the two vesa mounting holes
vesa_hole_distance = 200;

// Diameter of the vesa mounting hole
vesa_hole_diameter = 6.6;

// With of the baseplate
base_x = 62;

// Length of the baseplate
base_y = 92;

// X distance for the mounting screws
case_mount_dist_x = 45;

// Y distance for the mointing screws
case_mount_dist_y = 70;

// Mounting screw diameter
case_mount_screw_diameter = 3.1;

// Mounting screw head diameter
case_mount_screw_head_diameter = 6.1;

// Mounting screw head height
case_mount_screw_head_height = 2.6;

/* [Misc] */
// Resolution
$fn=96;

// Avoid artifacts
clearance = 0.01;


///////////////////////
// Calculated values //
///////////////////////

wing_width = base_x-2*radius;


///////////
// Build //
///////////

// Case base
difference() {
    translate([
        -base_x/2,
        -base_y/2,
        0
    ]) {
        // Base
        roundedRectangle(
            base_x,
            base_y,
            thickness,
            radius
        );
    }
    // Mounting screws
    translate([case_mount_dist_x/2, case_mount_dist_y/2, -clearance]) {
        cylinder(
            d=case_mount_screw_diameter,
            h=thickness+2*clearance
        );
        cylinder(
            d=case_mount_screw_head_diameter,
            h=case_mount_screw_head_height
        );
    }
    translate([case_mount_dist_x/2, -case_mount_dist_y/2, -clearance]) {
        cylinder(
            d=case_mount_screw_diameter,
            h=thickness+2*clearance
        );
        cylinder(
            d=case_mount_screw_head_diameter,
            h=case_mount_screw_head_height
        );
    }
    // Mounting screws
    translate([-case_mount_dist_x/2, case_mount_dist_y/2, -clearance]) {
        cylinder(
            d=case_mount_screw_diameter,
            h=thickness+2*clearance
        );
        cylinder(
            d=case_mount_screw_head_diameter,
            h=case_mount_screw_head_height
        );
    }
    translate([-case_mount_dist_x/2, -case_mount_dist_y/2, -clearance]) {
        cylinder(
            d=case_mount_screw_diameter,
            h=thickness+2*clearance
        );
        cylinder(
            d=case_mount_screw_head_diameter,
            h=case_mount_screw_head_height
        );
    }
}

difference() {

    union() {
        // Bar
        translate([
            -vesa_hole_diameter,
            -vesa_hole_distance/2,
            0
        ]) {
            cube([
                2*vesa_hole_diameter,
                vesa_hole_distance,
                thickness
            ], center=false);
        }
        // Top rounding
        translate([0,vesa_hole_distance/2,0]) {
            cylinder(
                d=2*vesa_hole_diameter,
                h=thickness
            );
        }
        // Bottom rounding
        translate([0,-vesa_hole_distance/2,0]) {
            cylinder(
                d=2*vesa_hole_diameter,
                h=thickness
            );
        }
        
        // Wing top
        translate([
            -wing_width/2,
            base_y/2,
            0
        ]) {
            wings(
                wing_width,
                wing_width/2-vesa_hole_diameter,
                thickness,
                wing_width/2-2*vesa_hole_diameter,
                2*vesa_hole_diameter
            );
        }

        // Wing bottom
        #translate([
            wing_width/2,
            -base_y/2,
            0
        ]) {
            rotate(180, [0,0,1]) {
                wings(
                    wing_width,
                    wing_width/2-vesa_hole_diameter,
                    thickness,
                    wing_width/2-2*vesa_hole_diameter,
                    2*vesa_hole_diameter
                );
            }
        }
    }
    // Top mounting hole
    translate([0,vesa_hole_distance/2,-clearance]) {
        cylinder(
            d=vesa_hole_diameter,
            h=thickness+2*clearance
        );
    }
    // Bottom mounting hole
    translate([0,-vesa_hole_distance/2,-clearance]) {
        cylinder(
            d=vesa_hole_diameter,
            h=thickness+2*clearance
        );
    }
}

module roundedRectangle(width, depth, height, radius) {
    translate([radius,radius,0]) {
        minkowski() {
            cube([
                width-2*radius,
                depth-2*radius,
                height/2]
            );
            cylinder(r=radius,h=height/2);
        }
    }
}

module wings(width, length, height, radius, distance) {
    difference() {
        cube([width, length, height]);
        translate([0,length,-clearance]) {
            cylinder(r=length,h=height+2*clearance);
            translate([width,0,0]) {
                cylinder(r=length,h=height+2*clearance);
            }
        }
    }
}
