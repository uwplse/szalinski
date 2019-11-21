// Parametric Paper Cup Dispenser
//
// Author: Dan McDougall
//
// Version: 1.0.1
//
// NOTES:
//  * By default it's configured for 5oz Dixie Cups (65mm diameter) but it's parametric!
//  * Works best with paper cups that have a curled lip around the drinking edge (e.g. Dixie cups)
//  * The main body is meant to be printed upside down (and that's how it's rendered by default)
//  * Prints just fine with NO SUPPORTS!  Nice 45° angles on everything
//
// CHANGELOG:
//  1.0.1:
//      * Changed how the THICKNESS is handled so that it's more accurate now.  Should be able to make the exterior wall nice and thick if you want!
//      * Changed how the bracket is created almost entirely.  It's using a trangle() method now (which I just added) instead of trying to rotate cubes at 45 degree angles with a difference (which was hard to line up when things got thicker!)
//      * Changed loads and loads of hard-coded values into variables so you can change them and understand what they impact.
//      * The bracket is now placed outside of the main body in case someone wants to make it wider.
//      * The cutout is now slightly more configurable and handles smaller sizes better.
//      * The cap now takes more factors into account and is more adjustable overall.  It also makes it 12-sided by default to make gripping easier.
//      * Thanks to the more accurate (and parametric) measurement capabilities the default CUP_DIAMETER has been adjusted from 67 to 65mm.

// Want the cylinder to be smoother?  Increase this value to something like 256 and be patient for rendering!
$fn = 128;

// TODO:
//  * Make the bracket lockable.  So any upwards pressure on the cup holder doesn't result in it accidentally coming up and out.

TOLERANCE = 2; // This is how much wiggle room cups get inside the cup holder.
CUP_DIAMETER = 65; // Diameter of the cup at its widest (~65mm == 5z Dixie cup)
HEIGHT = 200; // How tall to make the cup holder (NOTE:if you go smaller than 70 or so you'll need to make a custom bracket)
SCREW_HOLE_SIZE = 4; // How big the screw holes should be
LIP_IN = 2; // How much the lip should stick out into the cylinder to stop cups from falling out
THICKNESS = 2; // How thick the walls of the cup dispenser should be
CAP_TOLERANCE = 0.5; // How much smaller the cap will be than the interior of the cup holder (wiggle room)

// Don't change these unless you know what you're doing:
MOUNT_CENTER_LENGTH = 10; // How much it will stick out from the main body
MOUNT_CENTER_WIDTH = 10; // How wide the mount's center part will be
MOUNT_WING_WIDTH = 20; // How wide the "wings" should be

// This translate/rotate is just to flip it over (it's meant to print upside down so the side mount doesn't need supports)
translate([0,0,HEIGHT]) rotate([0,180,0]) cup_holder(CUP_DIAMETER, HEIGHT, TOLERANCE, LIP_IN, THICKNESS, MOUNT_CENTER_LENGTH, MOUNT_CENTER_WIDTH, MOUNT_WING_WIDTH);
translate([0,MOUNT_CENTER_LENGTH+THICKNESS+CUP_DIAMETER/2,0]) mounting_bracket(CUP_DIAMETER, HEIGHT, SCREW_HOLE_SIZE, THICKNESS, MOUNT_CENTER_LENGTH, MOUNT_CENTER_WIDTH, MOUNT_WING_WIDTH);
translate([CUP_DIAMETER+THICKNESS+15,0,0]) cap(CUP_DIAMETER+TOLERANCE, THICKNESS, CAP_TOLERANCE);
//
// Bottom lip that holds the cups inside
module cup_holder(cup_diameter=67, height=200, tolerance=2, lip_in=2, thickness=2, mount_center_length=10, mount_center_width=10, mount_wing_width=20, cutout_width=10) {
    // NOTE: I don't *think* you'll ever need to change the lip height but if you do...
    lip_height = lip_in;
    // Main cylinder
    translate([0,0,lip_height]) difference() {
        cylinder(d=cup_diameter+tolerance+(thickness*2), h=height-lip_height);
        translate([0,0,-1]) cylinder(d=cup_diameter+tolerance, h=height+100);
        rounded_cutout(cutout_width, height);
    }
    // Lip that holds the cups in
    difference() {
        cylinder(d1=cup_diameter+(thickness*2)-(lip_in*2), d2=cup_diameter+(thickness*2)+tolerance, h=lip_height);
        cylinder(d1=cup_diameter-lip_in, d2=cup_diameter+tolerance, h=lip_height);
        // This is just so the preview doesn't have a phantom top/bottom
        translate([0,0,-1]) cylinder(d=cup_diameter-lip_in, h=lip_height+2);
    }
    // Side mounting thing
    translate([0,0,(height/2)-(height/8)]) side_mount(cup_diameter, height, thickness, mount_center_length, mount_center_width, mount_wing_width);
}

// Mounting bracket (the cup_diameter and holder_height are just so we can call side_mount() properly)
module mounting_bracket(cup_diameter, holder_height, hole_size, thickness, mount_center_length, mount_center_width, mount_wing_width) {
    // NOTE: The default bracket settings are probably fine for 99% of use cases but in case you need a ridiculously thick or strong bracke feel free to play with these values...
    bracket_height = holder_height/4-5; // Should work pretty well for most heights
    bracket_width = 45; // Don't go much less than 45 or you won't have room for screw holes
    bracket_thickness = 2; // How thick the base 'plate' of the bracket should be (default: 2)
    bottom_lip_thickness = 2; // Controls how thick should the bottom of the bracket should be (default: 2)
    wall_thickness = 1.5; // How thick the walls that stick out of the bracket should be (approximate)
    wiggle_room = 1; // How much space should the cup holder mount be given inside the bracket
    body_thickness = 10; // Controls far the mount sticks out (increase along with bracket_thickness)
    // This controls where the screw holes get placed:
    screw_hole_distance_from_top_bottom = bracket_width/2.5; // Hopefully this will be good spots for the holes no matter the bracket_width

    base_position = -(cup_diameter/2+thickness)-mount_center_length/2+bracket_thickness/2; // This is just to re-center the mount to use it as a template
    difference() {
        translate([-bracket_width/2,0,0]) cube([bracket_width,body_thickness,bracket_height], center=false);
        // These instances of side_mount() create 1mm leeway on all interior sides of the bracket:
        translate([-(wiggle_room/2),base_position+wall_thickness,bottom_lip_thickness]) side_mount(cup_diameter, holder_height, thickness, mount_center_length, mount_center_width, mount_wing_width);
        translate([-(wiggle_room/2),base_position-wiggle_room+wall_thickness,bottom_lip_thickness]) side_mount(cup_diameter, holder_height, thickness, mount_center_length, mount_center_width, mount_wing_width);
        translate([(wiggle_room/2),base_position+wall_thickness,bottom_lip_thickness]) side_mount(cup_diameter, holder_height, thickness, mount_center_length, mount_center_width, mount_wing_width);
        translate([(wiggle_room/2),base_position-wiggle_room+wall_thickness,bottom_lip_thickness]) side_mount(cup_diameter, holder_height, thickness, mount_center_length, mount_center_width, mount_wing_width);
        // These carve out the sides of the bracket (where the screw holes go):
        translate([mount_wing_width/2+bracket_thickness+wall_thickness,-bracket_thickness,-1]) cube([bracket_width,body_thickness,bracket_height+5], center=false); // TODO: Where's this +5 coming from?
        translate([-(mount_wing_width/2+bracket_thickness)-bracket_width-wall_thickness,-bracket_thickness,-1]) cube([bracket_width,body_thickness,bracket_height+5], center=false);
        // Screw holes
        screw_hole_y = body_thickness + bracket_thickness; // Adding bracket thickness is really just for previews
        translate([-screw_hole_distance_from_top_bottom,screw_hole_y,bracket_height/4]) rotate([90,0,0]) cylinder(d=hole_size, h=200);
        translate([screw_hole_distance_from_top_bottom,screw_hole_y,bracket_height/4]) rotate([90,0,0]) cylinder(d=hole_size, h=200);
        translate([-screw_hole_distance_from_top_bottom,screw_hole_y,bracket_height/(4/3)]) rotate([90,0,0]) cylinder(d=hole_size, h=200);
        translate([screw_hole_distance_from_top_bottom,screw_hole_y,bracket_height/(4/3)]) rotate([90,0,0]) cylinder(d=hole_size, h=200);
        // NOTE: The h=200 value above assumes we're never going to have thickness > 199.99 or so :)
    }
}

// The thing that sticks out the side to mount it to something (using the mounting_bracket()).
module side_mount(cup_diameter, holder_height, thickness, center_length, center_width, wing_width) {
    difference() {
        translate([0,cup_diameter/2+thickness+5,0]) side_mount_no_cylinder(holder_height, thickness, center_length, center_width, wing_width);
        translate([0,0,-holder_height/2]) cylinder(d=cup_diameter+2, h=holder_height+100);
    }
}

// The gist of the side_mount() without the difference() against the cylinder (because we need to diff against the whole thing)
module side_mount_no_cylinder(holder_height, thickness, center_length, center_width, wing_width) {
    // You probably won't need to change these but you never know...
    bracket_wing_thickness = 4; // How thick the 'wings' of the bracket should be (default: 4)
    side_mount_height = holder_height/4;
    // translate() it to 0 on the Z:
    translate([0,0,side_mount_height/2]) {
        // Center part
        cube([center_width, center_length, side_mount_height], center=true);
        // Angled top (so we can print without supports)
        translate([center_length/2,-center_length/2,side_mount_height/2]) rotate([0,-90,0]) triangle(center_length, center_length, center_width);
        // Angled sides (so we can print without supports)
        translate([0,center_length/2-bracket_wing_thickness/2,0]) difference() {
            cube([wing_width,bracket_wing_thickness,side_mount_height], center=true);
            // NOTE: 1.999 (instead of 2), +0.5, and +1 are really just for the preview...
            translate([wing_width/1.999,bracket_wing_thickness/2+0.5,side_mount_height/2+center_length/2]) rotate([90,-180,0]) triangle(center_length, center_length, bracket_wing_thickness+1);
            translate([-wing_width/1.999,bracket_wing_thickness/2+0.5,side_mount_height/2+center_length/2]) rotate([90,90,0]) triangle(center_length, center_length, bracket_wing_thickness+1); 
        }
    }
}

// No reason for the cutout to be square! Makes it look more professional...
module rounded_cutout(width, holder_height, cup_diameter) { // Makes the number of cups remaining visible
    translate([-holder_height,0,width*2]) rotate([0,90,0]) cylinder(d=width, h=holder_height*2);
    translate([0,0,holder_height/2]) rotate([0,90,0]) cube([(holder_height-(width*4)),width,holder_height*2], center=true);
    translate([-holder_height,0,holder_height-(width*2)]) rotate([0,90,0]) cylinder(d=width, h=holder_height*2);
}

// Cap
module cap(cup_diameter, thickness, tolerance) {
    wall_thickness = 3; // Should be good in 99% of situations.
    cap_sides = 12; // Making it kinda-sorta low poly makes it easier to grip and pull off
    extra_diameter = 8; // How much wider the cap should be than the main body (make it a little bigger if lowering cap_sides)
    difference() {
        cylinder(d=cup_diameter-tolerance, h=10);
        translate([0,0,-1]) cylinder(d=cup_diameter-tolerance-wall_thickness, h=20);
    }
    cylinder(d=cup_diameter+thickness+extra_diameter, h=2, $fn=cap_sides); // Lip that prevents it from falling in
}

// This was copied from https://github.com/openscad/MCAD/blob/master/triangles.scad
module triangle(o_len, a_len, depth, center=false) {
    centroid = center ? [-a_len/3, -o_len/3, -depth/2] : [0, 0, 0];
    translate(centroid) linear_extrude(height=depth) {
        polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
    }
}
