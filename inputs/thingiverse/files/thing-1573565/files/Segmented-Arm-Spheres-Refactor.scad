// $fn = 100;
$fn = 50;
echo(fn=$fn);

/* [Basics] */
// Number of rows in the layout
rows = 4;
// Number of columns in the layout
columns = 3;

// Radius of ball in mm
ball_radius = 5;
// Length of the neck in mm
neck_length = 10;
// Optional - Radius of the hole through the piece for fluid. (0 = no hole)
fluid_radius = 1.5;

// Optional - Number of relief slots to cut into the socket to ease assembly/disassembly
relief_slots = 5;

/* [Advanced] */
// Space in mm between printed segments
separation = 2;
// Thickness of the socket/tube wall
wall_thickness = 2;
// Tolerance between ball and socket (Smaller = tighter fit, larger = looser fit)
socket_tolerance = 0.2;
// Percentage of lower half of the socket hemisphere to add for locking
socket_ring_pct = 20;
// Width in mm of each relief slot
slot_width = 1.5;

// Distance between centre of ball and centre of socket
distance_between_centres = 2 * ball_radius * wall_thickness + neck_length;

// Used for blanking bottom part of socket to make socket opening
socket_radius = ball_radius + wall_thickness;
socket_blank_length = socket_radius + 1;
socket_blank_offset = socket_radius * socket_ring_pct / 100;

// Used for fluid channel through the piece
fluid_channel = fluid_radius > 0;
fluid_radius_bevel = max(fluid_radius / 3, 1);
fluid_relief_additional_radius = ball_radius / 4;
fluid_relief_radius = fluid_radius + fluid_relief_additional_radius;

// Fudge factor to avoid overlapping vertices/edges/surfaces
d = 0.1 / 10;

// ball of a segment
module ball() {
    difference() {
        sphere(r=ball_radius);
        // Overlapping inner socket
        translate([0, 0, -distance_between_centres])
            sphere(r=socket_radius - d);
        if (fluid_channel) {
            // Channel bevel at top
            translate([0, 0, ball_radius - fluid_radius_bevel])
                cylinder(h=fluid_radius_bevel, r1=fluid_radius, r2=fluid_radius + 2 * fluid_radius_bevel);
            // Channel receiving volume
            *translate([0, 0, -wall_thickness])
                sphere(r=fluid_relief_radius);
            // Channel
            translate([0, 0, -1.5 * socket_radius])
                cylinder(h=socket_radius * 3, r=fluid_radius);            
        }    
    }
}
// ball();

// Neck, of a segment
module neck() {
    neck_h = neck_length + 2 * ball_radius;
    neck_r = 2 * ball_radius / 3;
    translate([0, 0, neck_h / 2])
    difference() {
        translate([0, 0, -neck_h / 2])
            cylinder(h=neck_h, r=neck_r);
        if (fluid_channel) {
            translate([0, 0, -neck_h / 2 - 1])
            cylinder(h=neck_h + 2, r=fluid_radius);
        }
        translate([0, 0, neck_h / 2 + d])
            sphere(r=ball_radius);
        translate([0, 0, - neck_h / 2 - d])
            sphere(r=socket_radius);
    }
}
// neck();

// Slot in the socket to allow flexation
module socket_snap_slot() {
    union() {
        // Slice
        translate([-slot_width/2, 0, -socket_blank_offset])
            cube([slot_width, socket_radius + 1, socket_blank_offset * 2 + d]);
        // Rounded top of slice
        translate([0, 0, socket_blank_offset])
            rotate([-90, 0, 0])
                cylinder(h=socket_radius + 1, r=slot_width/2);
    }
}    
// socket_snap_slot();

// Socket of a link
module socket() {
    // socket
    difference() {
        // Outer surface
        sphere(r=socket_radius);
        // Inner surface
        sphere(r=ball_radius + socket_tolerance);
        // %age of Hemispehere that will not overlap the next ball
        translate([0, 0, -socket_blank_length - socket_blank_offset])
            cylinder(h=socket_blank_length, r=socket_radius + 1);
        // Extra space for fluid movement
        if (fluid_channel) {
            translate([0, 0, ball_radius])
                sphere(r=fluid_relief_radius);
        }
        // Any relief slots
        if (relief_slots > 0) {
            translate([0, 0, -d])
                for (a = [0:360/relief_slots:359]) {
                    rotate([0, 0, a])
                        socket_snap_slot();
                }
        }
    }
}
// socket();

// Build a segment from a ball, neck, and socket
module single_segment() {
    translate([0, 0, socket_blank_offset])
    union() {
        // Place ball
        translate([0, 0, 2 * ball_radius + neck_length - 2 * d])
            ball();
        // Place neck
        translate([0, 0, 0])
            neck();
        // Place socket
        translate([0, 0, d])
            socket();
    }
}
//single_joint();

// Layout all the ball and socket segments
module layout() {
    // Calculate extents for each joint
    xe = socket_radius * 2 + separation;
    ye = socket_radius * 2 + separation;
    ze = ball_radius + socket_radius + distance_between_centres - (ball_radius - socket_blank_offset) - wall_thickness;
    bounds = [xe, ye, ze];
    // Place a segment in each in each position
    for (x=[0:rows-1]) {
        translate([(x + 0.5) * xe, 0, 0])
        for (y=[0:columns-1]) {
            translate([0, (y + 0.5) * ye, 0])
                single_segment();
        }
    }
}

layout();
