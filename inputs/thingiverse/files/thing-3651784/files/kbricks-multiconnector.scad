// Make multiple connectors or pegs for kbricks.
// Ben Kelley 2019.

// A derivative of kbricks construction system V1.0.0
// Copyright 2019 Robert Kern

// Print connectors or pegs?
make = "pegs"; // [connectors_short:Print short connectors,connectors_long:Print long connectors,pegs:Print pegs]
// Make a grid this many items wide.
grid_width = 3; // [2:10]
// Make a grid this many items deep.
grid_depth = 2; // [2:10]
// Print support lines between items.
print_supports = "yes"; // [yes,no]

/* [Hidden] */

// --------------------------------------------------------------------------------
// Defaults
// --------------------------------------------------------------------------------
// Do not modify defaults because they are not yet used consistently
$fn = 64;
cube_size = 24;
connector_width = 4;
connector_tolerance = 0;
support_width = 0.2;
beam_tolerance = 0.1;
axle_diameter = cube_size/4;
axle_tolerance = 0.2;

support_thickness=0.5;

if (make == "pegs") {
    pegs(grid_depth, grid_width, print_supports);
} else if (make == "connectors_short") {
    connectors(grid_depth, grid_width, 6, print_supports);
} else if (make == "connectors_long") {
    connectors(grid_depth, grid_width, 16, print_supports);
}

module connectors(depth = 3, width = 3, connector_length = 16, supports = "yes") {
    spacing_y = 5 + connector_length;
    spacing_x = 10;
    
    for (x = [0:width]) {
        for (y = [0:depth]) {
            translate([x * spacing_x, y * spacing_y, 0]) {
                if (x > 0 && y > 0) {
                    translate([0, 0, 2.8]) {
                        connector(connector_length);
                    }
                } else {
                    if (supports == "yes") {
                        translate([0, 0.6, 0]) {
                            cube([spacing_x - 2, 1, support_thickness]);
                        }
                        translate([1, 1, 0]) {
                            cube([1, connector_length / 2, support_thickness]);
                        }
                    }
                }
                if (supports == "yes") {
                    translate([1.5, 0.6, 0]) {
                        cube([spacing_x - 3, 1, support_thickness]);
                    }
                    translate([1, connector_length / 2, 0]) {
                        cube([1, 5, support_thickness]);    
                    }
                }
            }
        }
    }
    if (supports == "yes") {
        translate([1, 0.6, 0]) {
            cube([1, (depth + 1) * spacing_y - 7, support_thickness]);
        }
        translate([-2 + ((width + 1) * spacing_x), 0.6, 0]) {
            cube([1, (depth + 1) * spacing_y - 7, support_thickness]);
        }
        translate([2, 0.6, 0]) {
            cube([(width + 1) * spacing_x - 3, 1, support_thickness]);
        }
        translate([1, ((depth + 1) * spacing_y) - (connector_length / 2), 0]) {
            cube([(width + 1) * spacing_x - 3, 1, support_thickness]);
        }    
    }
}

module pegs(length = 3, width = 3, supports = "yes") {
    spacing = 12;
    
    for (x = [0:width]) {
        for (y = [0:length]) {
            translate([x * spacing, y * spacing, 0]) {
                if (x > 0 && y > 0) {
                    translate([0, 0, 12]) {
                        peg();
                    }
                } else {
                    if (supports == "yes") {
                        translate([0, 0.6, 0]) {
                            cube([spacing - 7, 1, support_thickness]);
                        }
                        translate([-0.3, 1, 0]) {
                            cube([1, 5.5, support_thickness]);
                        }
                    }
                }
                if (supports == "yes") {
                    translate([2, 0.6, 0]) {
                        cube([spacing - 4.5, 1, support_thickness]);
                    }
                    translate([-0.3, 2, 0]) {
                        cube([1, spacing - 4.5, support_thickness]);    
                    }
                }
            }
        }
    }
    if (supports == "yes") {
        translate([-0.3, 0.6, 0]) {
            cube([1, (length + 1) * spacing - 2.5, support_thickness]);
        }
        translate([-3 + ((width + 1) * spacing), 0.6, 0]) {
            cube([1, (length + 1) * spacing - 2.5, support_thickness]);
        }
        translate([0, 0.6, 0]) {
            cube([(width + 1) * spacing - 3, 1, support_thickness]);
        }
        translate([0, ((length + 1) * spacing) - 3, 0]) {
            cube([(width + 1) * spacing - 3, 1, support_thickness]);
        }    
    }
}

// kbricks construction system V1.0.0
// This file contains the CAD source of all kbricks core parts
// Copyright 2019 Robert Kern

module connector(length=16) {
    diameter = connector_width - connector_tolerance;
    waist = 2.6;
    slot = 1.3;
    slot_length = length + support_width;
    rotate([90,0,0])
    difference() {
        union() {
            translate([0,-diameter/2,0])
            cylinder(length,diameter/2,diameter/2,center=true);
            translate([0,diameter/2,0])
            cylinder(length,diameter/2,diameter/2,center=true);
            cube([waist,diameter,length],center=true);
        }
        for(i=[-1:2:1]) {
            translate([0,diameter*i*6/5,0])
            cube([diameter,diameter,length+2*diameter],center=true);
            translate([0,diameter*i/2,0])
            cylinder(slot_length,slot,slot,center=true);
        }
    }
}

module peg() {
    peg_half();
    rotate([180,0,0])
    peg_half();
}

module peg_half() {
    axle_radius = axle_diameter/2;
    difference() {
        union() {
            cylinder(cube_size/2,axle_radius,axle_radius);
            cylinder(3,4,4,center=true);
            translate([0,0,1.5])
            cylinder(0.5,4,3);
            translate([0,0,11])
            rotate_extrude()
            translate([3,0,0])
            scale([1,2.66666])
            circle(0.35);
        }
        translate([0,0,9])
        //cube([8,0.8,8],center=true);
        cube([8,1.2,8],center=true);
        for(i=[0:1]) {
            rotate([0,0,180*i])
            translate([4,0,10])
            cube([2.1,5,4],center=true);
        }
        //cylinder(18,1.25,1.25);
        //cylinder(18,1.8,1.8);
        cylinder(18,1.9,1.9);
    }
}

