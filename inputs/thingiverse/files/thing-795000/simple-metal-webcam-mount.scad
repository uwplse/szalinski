// Print the size tester or the full bracket? Start with the Size Tester.
part = "test"; // [test:Size Tester,bracket:Camera Bracket]

// How wide should the groove be for the bed wing? Print Sizer Tester objects until you find a good value for this number. You want a fit that slides on with a tiny amount of force, without scratching and stays there.
cut_thickness = 3.75;

/* [Hidden] */

// How big is the mounting bracket when seen from the front of the
// machine?
outer_size = 23;

// Any small value used to slightly offset faces when
// using difference() to avoid artifacting.
epsilon = 1;

if (part == "bracket") {
    bed_corner_mount(cut_thickness=cut_thickness);

    clip_to_top(outer_size)
    move_to_top(outer_size)
    camera_tab();
    
    // I'd like to try this in a later version.
    //c525_camera_box();
} else {
    bed_corner_mount(cut_thickness=cut_thickness, cut_depth=5);    
}


// A single, flat tab to which the camera can be attached using rubber
// bands.
module camera_tab() {
    tab_thickness = 3;
    tab_height = 20;
    tab_length = outer_size * sqrt(2);
    
    translate([0, -tab_thickness/2, 0])
    cube([tab_length, tab_thickness, tab_height]);
}

// Holds the lower articulation a Logitech C525 webcam.  This is an
// an excellent camera for this application, because it can focus on
// objects as close as 7cm, and it has both rotation and position
// adjustments.
module c525_camera_box(x=60, y=7, depth=20) {
    wall_thickness = 3;
    translate([0, -(y+2*wall_thickness)/2, 0])
    linear_extrude(depth)
    difference() {
        square([x+2*wall_thickness, y+2*wall_thickness]);
        
        translate([wall_thickness, wall_thickness])
        square([x, y]);
    }
}

// Slides nicely onto the right bed corner of a Printrbot Simple Metal.
module bed_corner_mount(cut_thickness=3.75, cut_depth=25) {
    depth = cut_depth + 3;

    outer_size = 23;
    cut_size = 20;
    inner_size = 12;
    
    cut_radius = 5;

    translate([outer_size, outer_size, 0])
    mirror([1, 1, 0])
    difference() {
        // Our main block.
        cube([outer_size, outer_size, depth]);
        
        // Cut our groove.
        translate([-epsilon, -epsilon, depth-cut_depth])
        linear_extrude(cut_depth+epsilon)
        bent_sheet(cut_size+epsilon,
                   radius=cut_radius,
                   thickness=cut_thickness);
        
        // Cut out an inside block
        translate([-epsilon, -epsilon, -epsilon])
        cube([inner_size+2*epsilon, inner_size+2*epsilon, depth+2*epsilon]);
    }
}

// Move something from the x, y plane to the top of the bracket.
module move_to_top(outer_size) {
    translate([0, outer_size, 0])
    rotate([45, 0, 0])
    rotate([0, -90, 0])
    children();
}

// Clip a part to fit within the aispace on top of the bracket.
module clip_to_top(outer_size) {
    airspace = 50;
    intersection() {
        translate([-airspace, 0, 0])
        cube([airspace, outer_size, outer_size]);

        children();
    }
}    

// A square with one rounded corner at the upper right.
module round_corner_square(size, radius) {
    intersection() {
        square(size);

        translate([-radius,-radius])
        minkowski() {
            square(size);
            circle(radius);
        }
    }
}

// Simulates a bent steel sheeet with the rounded corner at the upper
// right.
module bent_sheet(size, radius, thickness) {
    difference() {
        round_corner_square(size, radius);
        
        translate([-thickness, -thickness])
        round_corner_square(size, max(1, radius-thickness));
    }
}
