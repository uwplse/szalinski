// Candle Shade

use <utils/build_plate.scad>

//preview[view:east,tilt:top]

/*Customizer Variables*/

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]


$fn = 2000 * 1;

// Wall Thickness
walls = 2.5;

// Cylinder Radius
MainRadius = 20;
// Cylinder Height
MainHeight = 40;
// Cylinder Z Offset
MainZOffset = 0;

//Hole Radius
HoleRadius = MainRadius - walls;
//Hole Z Offset
HoleZOffset = 2 * walls;
//Hole Height
HoleHeight = MainHeight - HoleZOffset;

module TransCylinder(R, H, Z) {
        translate([0, 0, Z]) {
            cylinder(r=R, h=H, center=false);
        }
    }
    

translate([0,0,-.1])

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

difference() {
    // Main Cylinder
    TransCylinder(MainRadius, MainHeight, MainZOffset);
    // Hole in Center
    TransCylinder(HoleRadius, HoleHeight, HoleZOffset);
}