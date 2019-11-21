// Firewall Customizer
// written by Dave Halderman
// 2017-10-03

//Motor diameter (mm)
motor_dia = 22; //[9:1:35]

//Thickness of softmount (mm)
thickness = 2; //[0.5:0.5:2.5]

//Diameter of center hole (mm)
center_hole_dia = 8; //[0:0.5:16]

//Diameter of bolt holes
bolt_hole_dia = 3.3; //[2.2:M2, 3.3:M3, 4.4:M4]

//Spacing of left/right holes (mm - center to center)
horiz_hole_spacing = 19; //[5:1:25]

//Spacing of top-bottom holes (mm - center to center)
vert_hole_spacing = 16; //[5:1:25]

/* [Hidden] */
$fn=150;
cut_offset = 1.5;

linear_extrude(thickness) {
    difference() {
        minkowski () {
            main_body();
            circle(r=1);
        }
        circle(r=center_hole_dia/2);
        rotate([0,0,45]) translate([horiz_hole_spacing/2,0,0]) circle(r=bolt_hole_dia/2);
        rotate([0,0,225]) translate([horiz_hole_spacing/2,0,0]) circle(r=bolt_hole_dia/2);
        rotate([0,0,135]) translate([vert_hole_spacing/2,0,0]) circle(r=bolt_hole_dia/2);
        rotate([0,0,315]) translate([vert_hole_spacing/2,0,0]) circle(r=bolt_hole_dia/2);
    }
}

module main_body() {
    difference() {
        circle(r=(motor_dia/2));
        translate([motor_dia/cut_offset,0,0]) circle(r=(motor_dia/2)-2);
        translate([-motor_dia/cut_offset,0,0]) circle(r=(motor_dia/2)-2);
        translate([0,motor_dia/cut_offset,0]) circle(r=(motor_dia/2)-2);
        translate([0,-motor_dia/cut_offset,0]) circle(r=(motor_dia/2)-2);
    }
}