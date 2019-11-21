///////////////////////////////////////////////
// Garbage bag dispenser                     //
// https://www.thingiverse.com/thing:3362640 //
//                                           //
// by Klaus Moser (2019)                     //
///////////////////////////////////////////////


/* [Bag roll] */

// Diameter of the garbage bag roll
bag_diameter = 63; // Swirl 20l: 60mm

// Width of the garbage bag
bag_width = 140;


/* [Window] */

// Turn window to another direction
window_angle = 210;

// Windows corner radius
window_diameter = 10;

// Make window how much larger than the bag length
window_offset = 10;


/* [Screws] */

// Mounting screw diameter
screw_diameter = 3.6;

// Mounting screw large head diameter
screw_head_diameter = 6.1;

// Mounting screw large head diameter
screw_head_height = 3;

// Holes for screw driver
screw_driver_diameter = 7.6;

// Move screw holes
screw_offset = 0;


/* [Label] */

// Label width (0 disables label)
label_width = 50;

// Label height
label_height = 20;

// Label depth
label_depth = 10;

// Label angle
label_angle = -30;


/* [Misc] */

// Resolution
$fn=96;

// Avoid artifacts
clearance=0.01;

// Wall thickness
wall_width = 2;

// Turn bottom
bottom_angle = 90;


///////////////////////
// Calculated values //
///////////////////////

pipe_diameter = bag_diameter+2*wall_width;
pipe_length = bag_width+2*window_offset;


///////////
// Build //
///////////

difference() {

    // Outer case
    union() {
        cylinder(
            d=pipe_diameter,
            h=pipe_length
        );
        hanger();
        if (label_width > 0) {
            label();
        }
    }

    // Inner pipe
    translate([0,0,-clearance]) {
        cylinder(
            d=bag_diameter,
            h=pipe_length+2*clearance
        );
    }

    // Window
    rotate(window_angle, [0,0,1]) {
        window();
    }

    // Screw holes
    translate([
        screw_offset,
        screw_head_height+pipe_diameter/2+clearance,
        pipe_length/4
    ]) {
        screw_hole();
    }
    translate([
        screw_offset,
        screw_head_height+pipe_diameter/2+clearance,
        pipe_length*3/4
    ]) {
        screw_hole();
    }
}
rotate(bottom_angle, [0,0,1]) {
    pipe_lip();
}



/////////////
// Modules //
/////////////

module pipe_lip() {
    difference() {
        cylinder(
            d=bag_diameter,
            h=wall_width
        );
        translate([
            -bag_diameter/2,
            -bag_diameter/4,
            -clearance
        ]) {
            cube([
                bag_diameter,
                bag_diameter/2,
                wall_width+2*clearance
            ]);
        }
    }
}

module window() {

    rotate(90, [0,1,0]) {
        hull() {
            translate([
                (-pipe_length+bag_width)/2-window_diameter/2,
                0,
                0
            ]) {
                cylinder(d=window_diameter, h=50);

                translate([
                    -bag_width+window_diameter,
                    0,
                    0
                ]) {
                    cylinder(d=window_diameter, h=50);
                }
            }
        }
    }
}

module hanger() {
    translate([-pipe_diameter/2,0,0]) {
        cube([
            pipe_diameter,
            pipe_diameter/2+screw_head_height,
            pipe_length
        ]);
    }
}

module screw_hole() {
    rotate(90, [1,0,0]) {
        cylinder(d=screw_diameter, h=wall_width);
        translate([0,0,wall_width-clearance]) {
            cylinder(
                d1=screw_diameter,
                d2=screw_head_diameter,
                h=screw_head_height+2*clearance
            );
        }
        translate([0,0,wall_width+screw_head_height]) {
            cylinder(
                d=screw_driver_diameter,
                h=pipe_diameter
            );
        }
    }
}

module label() {
    rotate(label_angle, [0,0,1]) {
        translate([
            pipe_diameter/2-label_depth/2,
            0,
            pipe_length/2
        ]) {
            cube([label_depth, label_height, label_width], center=true);
        }
    }
}
