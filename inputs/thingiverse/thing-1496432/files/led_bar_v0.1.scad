// 2016 Paul Nokel <pnokel@gmail.com>
// LED Bar (this is the sruface on which you mount your LED strip)
led_bar_height = 12; // [10:100]
led_bar_width = 50; // [10:200]
led_bar_thickness=2.3; // [1:0.1:10]

// Add a top and bottom border to the LED bar
add_border = 1; // [1:Yes,0:No]
border_thickness = 2; // [1:10]

alu_spacer_diameter = 5; // [1:15]
// Distance between the spacers
alu_spacer_distance = 26.6; // [1:0.1:100]

/* [Hidden] */
mounting_hole_outer_diameter=alu_spacer_diameter+alu_spacer_diameter/2;
// adjust the diameter of the spacer
alu_spacer_diameter_real=alu_spacer_diameter+0.2;

// LED Strip
cube([led_bar_thickness, led_bar_width, led_bar_height], center=true);
// LED Strip Border
if(add_border == 1) {
    translate([-led_bar_thickness, 0, led_bar_height/2-border_thickness/2]) cube([led_bar_thickness, led_bar_width, border_thickness], center=true);
    mirror([0, 0, 1]) translate([-led_bar_thickness, 0, led_bar_height/2-border_thickness/2]) cube([led_bar_thickness, led_bar_width, border_thickness], center=true);
}
// mounting holes for the spacers
translate([mounting_hole_outer_diameter+led_bar_thickness/2, alu_spacer_distance/2, 0]) genSpacerMountingPoint();
mirror([0, -1, 0]) translate([mounting_hole_outer_diameter+led_bar_thickness/2, alu_spacer_distance/2, 0]) genSpacerMountingPoint();

module genSpacerMountingPoint() {
    difference() {
        union() {
            translate([-mounting_hole_outer_diameter/2, 0, 0]) cube([mounting_hole_outer_diameter, mounting_hole_outer_diameter, led_bar_height], center=true);
            cylinder(led_bar_height, mounting_hole_outer_diameter/2, mounting_hole_outer_diameter/2, center=true, $fn=50);
        }
        cylinder(led_bar_height, alu_spacer_diameter_real/2, alu_spacer_diameter_real/2, center=true, $fn=50);
    }
}