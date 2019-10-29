/*
*  Name: rod_ends.scad
*  Description: caps to be plugged to the end of rods
*  Author: Anhtien Nguyen
*  Date: June 12, 2018
*/

// diameter of the rod
diameter=8;
rad =diameter/2;
// clearance between rod & inner wall
gap=0.5; 
// wall thickness between inner & outter wall
thickness=2; 
// rod end height
height=15; 
// enter zero here if base not needed
base_diameter=16;
base_radius=base_diameter/2;
//  base height
base_height=5;

cap();

module cap(rad = rad+gap,thick=thickness,height=height, base_height=base_height, base_radius=base_radius) {
    
    shiftdown = thick > base_height?  base_height :thick;
    difference() {
        // outter circle
    cylinder(r=rad+thick,h=height,$fn=50);
        // inner circle
    translate([0,0,thick]) cylinder(r=rad,h=height,$fn=50);
    }
    
    // add the base
    if (base_height >0 && base_radius>0)
    {
        translate([0,0,-shiftdown]) cylinder(r=base_radius, h=base_height,$fn=50);
    }
    
}
    
