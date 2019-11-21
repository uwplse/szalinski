$fn = 50;

// How wide should tap be?
width = 10;
// How thick should tap be?
thick = 3;
// How much arc should the tap have?
arc = 45; // [30:180]
// How long should the tap be?
tap_length = 30; // [20:100]
// Nail diameter
nail_shaft_diam = 2;
// Nail head diameter
nail_head_diam = 4;
// Nail head thickness
nail_head_thick = 1;
// Want to show nail holes?
use_nails = "Yes"; // [Yes,No]

// Calc tap interior radius of curvature?
radius = - ((sin(arc/2)+1)*width-tap_length)/(2*sin(arc/2));

module tap_flat() {

// basic arc
module basic_arc()
{rotate_extrude(angle=arc, convexity=10, $fn = 100)
translate([width/2+radius,0,0])
square(size=[width, thick], center=true);}

// arc subtraction shape
module arc_subtract_shape()
{translate([0,-(width+radius),0])
cube([2*(width+radius),2*(width+radius),thick*2], center=true);
rotate([0,0,arc])
translate([0,(width+radius),0])
cube([2*(width+radius),2*(width+radius),thick*2], center=true);}

// arc
difference() {
basic_arc();
arc_subtract_shape();
}

//Round ends
{translate([radius+width/2,0,0])
cylinder(r=width/2,h=thick, center=true);}
{rotate([0,0,arc])
translate([radius+width/2,0,0])
cylinder(r=width/2,h=thick, center=true);}
}

//Nail Hole
module nail_void() {
cylinder(r=nail_shaft_diam/2,h=thick, center=true);
translate([0,0,thick/2-nail_head_thick])
cylinder(r=nail_head_diam/2,h=nail_head_thick);
}

//Nail Holes
module nail_voids() {
{rotate([0,0,arc])
translate([radius+width/2,0,0])
nail_void();}
{rotate([0,0,arc/2])
translate([radius+width/2,0,0])
nail_void();}
{translate([radius+width/2,0,0])
nail_void();}
}

if (use_nails=="Yes") {
    difference() {
    tap_flat();
    nail_voids();
    }
}
else
{
    tap_flat();
}

