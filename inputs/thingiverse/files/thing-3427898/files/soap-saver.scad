$fn = 50;

// How wide should ring be?
width = 3; // [2:8]
// How thick should ring be?
thick = 6; // [1:20]
// What interior radius?
radius = 4; // [5:10]
// What is the width of the ring appature?
opening = 6; // [5:20]

// find angle of opening
angle_opening = 2*asin((width/(width+2*radius))+(opening/(width+2*radius)));

// basic arc
module basic_arc()
{rotate_extrude(convexity=10, $fn = 100)
translate([width/2+radius,0,0])
square(size=[width, thick], center=true);}

// half arc subtraction shape
module half_arc_subtract()
{translate([0,(width+radius),0])
cube([2*(radius+width),2*(radius+width),thick], center=true);}

// half arc
module half_arc() {
difference (){
basic_arc();
half_arc_subtract();
}}

// ring
module ring_simple() {
half_arc();
rotate([0,0,180-angle_opening])
half_arc();
}

// ring end
module ring_end() {
cylinder(r=width/2,h=thick, center=true);
}

// set ring ends
rotate([0,0,-angle_opening])
translate([-(radius+width/2),0,0])
ring_end();
translate([-(radius+width/2),0,0])
ring_end();

ring_simple();




