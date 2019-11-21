// This is a one-inch ball mount adapter. It adapts one-inch mounts
// to other size ball mount accessories.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// To fulfill the attribution requirement, please link to:
// http://www.thingiverse.com/thing:2977108

/* [Main] */

// Define number of facets (larger numbers provide better smoothing)
$fn=100;

// Outside diameter of larger ball in mm
diameter01=25.0;

// Outside diameter of smaller ball in mm
diameter02=17.0;

// Length of cylinder in mm
cylinder_length=10.0;

// Diameter of cylinder in mm
cylinder_diameter=10.0;

module brace()
{
    intersection()
    {
        translate([0,0,-(cylinder_length+5.0)]) cylinder(h=cylinder_length+diameter01/4+1,r1=diameter01/3,r2=diameter02/3.5);
        translate([0,0,0]) cube([2*cylinder_length+diameter01/4,1.0,2*cylinder_length],center=true);
    }
}

translate([0,0,-(diameter01/2+cylinder_length/2)]) sphere(r=diameter01/2,center=true);
translate([0,0,0]) cylinder(h=cylinder_length+diameter01/4,r=cylinder_diameter/2,center=true);
rotate([0,0,0]) brace();
rotate([0,0,60]) brace();
rotate([0,0,120]) brace();
translate([0,0,(diameter02/2+cylinder_length/2)]) sphere(r=diameter02/2,center=true);
