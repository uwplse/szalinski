
// First let's define the dimentions of the radio
// all measurements are in mm

// Width of the radio you are targeting
radio_width = 150.5;

// Height of the radio you are targeting
radio_height = 39.5;

// Length of the radio you are targeting (unimportant)
radio_length = 173;

// Height of the bracket (recommend ~1.5 times the radio height)
bracket_height = 56;

// Length of the bracket
bracket_length = 86.5;

// Extra space around the radio
bracket_extra_width = 1;

// Length of the holes in the back of the bracket
bracket_wide_hole_length = 30;

// Size of the angle to cut for the tilt screw holes. Recommend 30 degrees
bracket_tilt_angle = 30;

// Thickness of the bracket (thicker == stronger, default 3mm)
bracket_thickness = 3; // [1:10]

// This doesn't really seem useful, but why not?
radio_fan_depth = 27;

// distance on center between the two screw holes on the side of the radio
radio_screw_spacing = 50;

// Radius (in mm) for the screw holes
radio_screw_radius = 2.75;

include <MCAD/boxes.scad>
$fa=5;
$fs=0.3;

module draw_radio() {
    color([1,1,1])
        translate([0, 0, radio_height / 2]) roundedBox([radio_width, radio_length, radio_height], 5);
}
//translate([0,0,radio_height/2 + bracket_thickness]) draw_radio();

module draw_bracket() {
    outer_width = (radio_width+bracket_extra_width+(bracket_thickness)*2);
        
    hole_z = bracket_thickness + bracket_height - radio_height / 2;
    hole_y = radio_screw_spacing / 2;
    color([0,1,0])
    difference() {
        intersection() {
            // Draw the rounded box
            translate([0,0,bracket_height])
                roundedBox([outer_width, bracket_length*2, bracket_height * 2], 5);
            // chop off the rounded box to give us the shape we need
            translate([-outer_width/2, -bracket_length/2, 0])
                cube([outer_width, bracket_length, bracket_height + bracket_thickness]);
        }
        // subtract the "hole" for the radio to go in
        translate([-radio_width/2, -bracket_length, bracket_thickness])
            cube([radio_width, bracket_length*3, bracket_height*2]);
        
        // drill the screw holes
        translate([-outer_width/2, hole_y, hole_z])
            rotate([0,90,0])
            cylinder(bracket_thickness*2.5, radio_screw_radius, radio_screw_radius, true);
        translate([outer_width/2, hole_y, hole_z])
            rotate([0,90,0])
            cylinder(bracket_thickness*2.5, radio_screw_radius, radio_screw_radius, true);
        
        // cut the angling holes
        translate([-outer_width/2 + bracket_thickness/2, -hole_y, hole_z])
            rotate([0,0,-90]) scale([1,5,1]) {
                
                angle_hole([-radio_screw_spacing, 0, 0], radio_screw_spacing, radio_screw_radius, 10);
                angle_hole([-radio_screw_spacing, 0, 0], radio_screw_spacing, radio_screw_radius, -(bracket_tilt_angle - 10));
            }
        translate([outer_width/2 - bracket_thickness/2, -hole_y, hole_z])
            rotate([0,0,-90]) scale([1,5,1]) {
                angle_hole([-radio_screw_spacing, 0, 0], radio_screw_spacing, radio_screw_radius, 10);
                angle_hole([-radio_screw_spacing, 0, 0], radio_screw_spacing, radio_screw_radius, -(bracket_tilt_angle - 10));
            }
        cylinder(bracket_thickness*2.5, radio_screw_radius, radio_screw_radius, true);
            
        translate([-radio_width/4, bracket_length/4, -0.5])
            rounded_hole(bracket_wide_hole_length, bracket_thickness+1, radio_screw_radius);
        translate([radio_width/4, bracket_length/4, -0.5])
            rounded_hole(bracket_wide_hole_length, bracket_thickness+1, radio_screw_radius);
        translate([-radio_width/4, -bracket_length/4, -0.5])
            rounded_hole(bracket_wide_hole_length, bracket_thickness+1, radio_screw_radius);
        translate([radio_width/4, -bracket_length/4, -0.5])
            rounded_hole(bracket_wide_hole_length, bracket_thickness+1, radio_screw_radius);
    }
}

module angle_hole(center_point, radius, hole_radius, degrees) {
    translate(center_point)
    rotate([90,0,0]) {
        rotate_extrude(angle=degrees, convexity=10)
        translate([radius, 0, 0])
        circle(r=hole_radius);
    }
}

/*union() {
    angle_hole([0,0,0], 50, radio_screw_radius, -15);
    angle_hole([0,0,0], 50, radio_screw_radius, 15);
}*/

module rounded_hole(length, height, radius) {
    translate([-length/2 + radius, -radius, 0]) {
        cube([length-radius*2, radius*2, height]);
        translate([0, radius, 0]) cylinder(height, radius, radius);
        translate([length-radius*2, radius, 0]) cylinder(height, radius, radius);
    }
}

draw_bracket();