// Glasses_perch
// Thing that lets you place your glasses on the top edge of your
// computer monitor
//
// David Palmer
// dmopalmer at gmail.com
// Distributed under GPL version 2
// <http://www.gnu.org/licenses/gpl-2.0.html>
//
// Designed to use customizer at thingiverse
// <http://www.makerbot.com/blog/2013/01/23/openscad-design-tips-how-to-make-a-customizable-thing/>

// Generate just a narrow test profile to ensure it fits your monitor
test_profile = 0; // [0: Full width, 1: Test profile]

// Thickness of the plastic in mm
thickness = 2.0;  // thickness

// Thickness of monitor at top edge (mm)
monitor_thickness = 30;

// Length of front leg
front_length = 20;

// Length of back leg
back_length = 40;

// Length of riser
riser_length = 60;

// slope of riser.  (Degrees: 90 means vertical)
riser_slope = 60;

// Monitor back wedge (degrees: 0 means back is perp. to top edge, >0 means it is slanted)
monitor_back_slope = 20;

// Monitor top wedge (degrees: >0 means that the top slopes way instead of being perpendicular to the screen)
monitor_top_wedge = 0;

// Width of the perch (mm).
width = 40;

// Nose width (mm).
nose_width = 10;

// Nose_depth
nose_depth = 20;

// Nose_height along riser
nose_height = 25;

// Nose_brim_rimwidth
nose_brim_rimwidth = 5;

// Radius of bead along joints
bead = 1.5 * thickness;

// epsilon to prevent problems with coincident planes
eps = 0.01;

module Nose()   // flat of cylinder is on the Y axis.
{
    nose_radius = nose_width/2 * 1.5;
    stretch = 2;
    scale([stretch,1,1]) {
        difference() {
            union() {
                translate([0,0,nose_depth+thickness]) cylinder(h = thickness, r=nose_radius+nose_brim_rimwidth);
                cylinder(h=thickness + nose_depth + 0.5*thickness, r=nose_radius);
            }
            translate([-50,0,0]) cube([100,100,100],center=true);
        }
    }
}

module Riser()
{
    rotate([0,-riser_slope,0]) {
        union() {
            translate([nose_height,0,0]) Nose();
            translate([eps,-width/2,-eps]) cube([riser_length, width,thickness],center=false);
        }
    }
}

module Perch() // Top level module
{
    rotate([90,0,0]) union() {
        // Front is in the xy plane
        translate([-bead*0.72,0,bead*0.72]) rotate([90,0,0]) cylinder(h=width-eps,r=bead,center=true);
        translate([-thickness,-width/2,-front_length+eps]) cube([thickness, width, front_length]);
        rotate([0,monitor_top_wedge,0]) {
            union(){
                translate([-thickness,-width/2,0]) cube([monitor_thickness + 2*thickness, width, thickness]);
                translate([monitor_thickness+thickness,-width/2,thickness])
                    rotate([0,180-monitor_back_slope-monitor_top_wedge,0])
                        cube([thickness,width,back_length]);
                translate([monitor_thickness+thickness,(width-eps)/2,bead])
                    rotate([90,0,0]) cylinder(h=width-eps,r=bead,center=false);
            }
        }
        Riser();
    }
}

module Profile()
{
    intersection() {
        Perch();
        cube([1000,1000,2],center=true);
    }
}
// Rotate it so that ends up on the printer bed in the right orientation

if (test_profile == 1) {
    Profile();
} else {
    Perch();
}
