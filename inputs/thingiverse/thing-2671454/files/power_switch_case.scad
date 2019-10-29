// preview[view:south east, tilt:top diagonal]

// Screwed inlet mount
screwed_switch = "YES"; // [Yes,No]

// Back cap hole size (0 to disable)
wire_hole      = 10;

// Case depth
depth          = 40;


/* [Hidden] */

height    = 56;
width     = 70;
thickness = 3;
ear       = 10;

$fn = 50;
round_radius = 6;


module mount_hole() {
    translate([ -(width + ear)/2, -20, -0.1 ])
    union() {
        cylinder(h = depth, d = 3.2);
        translate([ 0, 0, thickness + 0.1 ])
        cylinder(h = depth, d = 6.2);
    };
}


module mount_holes() {
    mount_hole();
    mirror([ 0, 1, 0]) mount_hole();
    mirror([ 1, 0, 0]) mount_hole();
    mirror([ 0, 1, 0]) mirror([ 1, 0, 0]) mount_hole();
}


module bottom_rounding_left() {
    translate([ -(width)/2 - round_radius, height/2, 0])
    rotate([ 90, 0, 0 ]) {
        difference() {
            cube([round_radius + thickness, round_radius + thickness, height]);
            translate([ 0, round_radius + thickness, -0.05 ])
            cylinder(h = height + 0.1, r = round_radius);
        }
    }
}


module bottom_roundings() {
    bottom_rounding_left();
    mirror([ 1, 0, 0 ]) bottom_rounding_left();
}


module top_rounding_left() {
    translate([ -thickness - width/2, height/2 + 1, depth - round_radius ])
    rotate([ 90, 0, 0 ]) {
        difference() {
            cube([round_radius + thickness, round_radius + thickness, height + 2]);

            translate([ round_radius + thickness, 0, -1 ])
            cylinder(h = height + 4, r = round_radius);
        }
    };
}


module top_roundings() {
    top_rounding_left();
    mirror([ 1, 0, 0 ]) top_rounding_left();
}


module inner_space () {
    hull() {
        translate([
            -(width/2 - thickness - round_radius),
            height/2 - thickness,
            depth - thickness - round_radius ])
        rotate([90, 0, 0 ])
        cylinder(h = height - thickness*2, r = round_radius);

        translate([
            (width/2 - thickness - round_radius),
            height/2 - thickness,
            depth - thickness - round_radius ])
        rotate([90, 0, 0 ])
        cylinder(h = height - thickness*2, r = round_radius);

        translate([ -(width/2 - thickness - .5), 0, 0 ])
        cube([1, height - thickness*2, 1], true);

        translate([ (width/2 - thickness - .5), 0, 0 ])
        cube([1, height - thickness*2, 1], true);
    }
}


module sw_latch_tpl() {
    translate([ -6, -15, depth - 10 - 1 ]) cube([ 12, 30, 10 ]);
}


module sw_latches() {
    translate([ -15, 0, 0 ]) sw_latch_tpl();
    translate([ 15, 0, 0 ]) sw_latch_tpl();
}


module power_switch_box() {
    difference () {
        union() {
            translate([ -width/2, -height/2, 0 ])
                cube([ width, height, depth ]);

            translate([ -width/2 - ear, -height/2, 0 ])
                cube([ width + ear*2, height, thickness ]);

            bottom_roundings();
        }

        mount_holes();

        top_roundings();

        inner_space();

        // window
        cube([ 47.5, 28, 1000], true);
        
        sw_latches();
        
        // bottom cap space
        translate([ 0, 0, thickness/2 - .5])
            cube([ width - thickness*2 + 2, height - thickness*2 + 2, thickness + 1 ], true);
        
        if (screwed_switch != "No") {
           translate([ 0, 20, 0 ]) cylinder(h = 1000, d = 3.2);
           translate([ 0, -20, 0 ]) cylinder(h = 1000, d = 3.2);  
        }
    }
}

module bottom_cap() {
    translate([ -(width - thickness -.4)/2, -(height *1.5 + 10), 0 ]) {
        difference() {
            cube([width - thickness*2 + 2 -.4, height - thickness*2 + 2 -.4, thickness ]);
            
            if (wire_hole > 0) {

                    translate([ wire_hole/2, (height - thickness - .4)/2, -.1 ])
                        cylinder(10, d = wire_hole);

                    translate([ 0, (height - thickness - .4)/2, -.1 ])
                        cube([ wire_hole, wire_hole, 100 ], true);
                    
            }
        }
    }
}

power_switch_box();

bottom_cap();
