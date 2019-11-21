// This is designed to support the case from http://www.thingiverse.com/thing:92208
// The angle of the support should always be 45 degrees so that it can be printed without
//   support.

/* [Global] */
// Positive angles point camera case down, negative point up
angle=-30; // [-45:45]

difference() {

union() {
// Holder
rotate([angle,0,0])
translate([0,0,3.5]) cube([30+2,12+2,7],center=true);
// Up/Down part
translate([0,0,-5]) cube([30+2,2,18],center=true);

color("red")
translate([0,0,0]) translate([0,0,0]) rotate([0,90,0]) linear_extrude(height = 32, center = true, convexity = 10, twist = 0)
polygon(  points=[[0,0],[7*cos(angle)-7*sin(angle),0],[7*sin(-angle),7*cos(angle)]], paths=[[0,1,2]]);
}


// Cut-out for the camera and the ribbon cable
color("green")
union() {
rotate([angle,0,0]) translate([0,0,1])translate([0,0,15]) cube([30,12,30],center=true);

if(angle>0) {
rotate([angle,0,0]) translate([0,7,14]) cube([17,12,30],center=true);
} else {
rotate([angle,0,0]) translate([0,7,16]) cube([17,12,30],center=true);
}
translate([0,0,1]) translate([0,7,5]) cube([17,12,30],center=true);

}

}

// Base
translate([0,0,-14]) cube([30,12,2],center=true);
// Legs
translate([(2+30)/2-1,0,-14]) cube([2,2+50,2],center=true);
translate([-(2+30)/2+1,0,-14]) cube([2,2+50,2],center=true);


rotate([0,0,180])
color("blue")
translate([0,0,0]) translate([0,0,0]) rotate([0,90,0]) linear_extrude(height = 32, center = true, convexity = 10, twist = 0)
polygon(  points=[[0,0],[7*cos(angle)+7*sin(angle),0],[7*sin(angle),7*cos(angle)]], paths=[[0,1,2]]);



