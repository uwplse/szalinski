// Designed by Stanley <stanoba@gmail.com>
// SMD Feeder Rail <smd_feeder_rail.scad>
// Version: 0.1
// Creative Commons - Attribution license
// https://www.thingiverse.com/stanoba/about
// SMD feeder rail for SMD feeders https://www.thingiverse.com/thing:2414955

length=190; // length in mm

difference(){
	cube([8,length,2]);
	translate([0,0,1]) cube([2,length,1]);
	translate([5,5,0]) cylinder(h=15, d=3.2, $fn=40);
	translate([5,length/3,0]) cylinder(h=15, d=3.2, $fn=40);
	translate([5,(length/3)*2,0]) cylinder(h=15, d=3.2, $fn=40);
	translate([5,length-5,0]) cylinder(h=15, d=3.2, $fn=40);
}