$fn=96;
clearance = 0.01;

// Add screw holes to plate
screw_holes = 1; // [0, 1]

// Add holes for rubber feets
feet_holes = 1; // [0, 1]

// Position of screw holes
screw_holes_position = 0; // [0: linear, 1:shifted]

// Number of magnets
magnets = 1;

// Diameter of the used magnet
magnet_diamter = 12;

// Height of the used magnet
magnet_height = 3.6;

// Print hole support for magnets
print_support = 1; // [0, 1]

// Suport width
support_width = 0.6;

// wall width
wall_width = 1;

// Corner radius
corner_radius = 5;

// Diameter of circle around the feet
foot_diameter = 8;

// Sphere diameter for the rounded feet hole
foot_sphere_diameter = 7.6;

// Sphere offset for the rounded feet hole
foot_sphere_y_offset = 2.6;

// Height of rubber feet
foot_height = 0.4;

// X offset for foot
foot_x_offset = 6;

// Y offset for foot
foot_y_offset = 6;

// Mount hole diameter
screw_diameter = 3.6;

// Mount screw head diameter
screw_head_diameter = 6.4;

// Mount screw head diameter
screw_head_height = 3;

// Width (x) of the plate
width = 75;

// Length (y) of the plate
length = 35;


height = magnet_height + wall_width;

difference() {
    roundedRectangle(width, length, height, corner_radius);
    
    // magnet hole
    x = width / (magnets + 1);
    for (r=[1:1:magnets]) {
        translate([r*x,length/2,-clearance]) {
            cylinder(d=magnet_diamter, h=magnet_height+clearance);
        }
    }
    
    // Feet holes
    if (feet_holes) {
         translate([0,0,height-foot_height+clearance]) {
            translate([foot_x_offset,foot_y_offset,0]) {
                foot_hole();
            }
            translate([width-foot_x_offset,foot_y_offset,0]) {
                foot_hole();
            }
            translate([width-foot_x_offset,length-foot_y_offset,0]) {
                foot_hole();
            }
            translate([foot_x_offset,length-foot_y_offset,0]) {
                foot_hole();
            }
        }
    }
    
    // Screw holes
    if (screw_holes) {
        translate([0,0,-clearance]) {

            if (screw_holes_position == 0) {
                translate([corner_radius,length/2,0]) {
                    screwhole(screw_diameter, height+2*clearance, screw_head_diameter, screw_head_height+2*clearance);
                }
                translate([width-corner_radius,length/2,0]) {
                    screwhole(screw_diameter, height+2*clearance, screw_head_diameter, screw_head_height+2*clearance);
                }
            }

            if (screw_holes_position == 1) {
                translate([corner_radius,corner_radius,0]) {
                    screwhole(screw_diameter, height+2*clearance, screw_head_diameter, screw_head_height+2*clearance);
                }
                translate([width-corner_radius,length-corner_radius,0]) {
                    screwhole(screw_diameter, height+2*clearance, screw_head_diameter, screw_head_height+2*clearance);
                }
            }
        }
    }
}
// magnet hole suport
if (print_support) {
    x = width / (magnets + 1);
    for (r=[1:1:magnets]) {
        translate([r*x,length/2,-clearance]) {
            difference() {
                cylinder(d=magnet_diamter/2, h=magnet_height+clearance);
                translate([0,0,-clearance]) {
                    cylinder(d=magnet_diamter/2-support_width, h=magnet_height+2*clearance);
                }
            }
        }
    }
}

module roundedRectangle(width, depth, height, radius) {
    hull () {    
        translate([radius,radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([width-radius,radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([radius,depth-radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
        translate([width-radius,depth-radius,0]) {
            cylinder(h=height, r=radius, $fn=90);
        }
    }
}

module screwhole(hole_diameter, hole_length, head_diameter, head_length) {
    cylinder(d=hole_diameter, h=hole_length);

    translate([0,0,hole_length-head_length+clearance]) {
        cylinder(d1=hole_diameter, d2=head_diameter, h=head_length);
    }
}

module foot_hole() {
    cylinder(d=foot_diameter, h=foot_height+clearance);
    translate([0,0,foot_sphere_y_offset]) {
        sphere(d=foot_sphere_diameter);
    }
}
