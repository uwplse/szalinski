// Designed by Stanley <stanoba@gmail.com>
// SMD Feeder <smd_feeder.scad>
// Version: 0.1
// Creative Commons - Attribution license
// https://www.thingiverse.com/stanoba/about
// Inspired by https://www.thingiverse.com/thing:675336/ and https://www.thingiverse.com/thing:690054
// Use width SMD feeder rails https://www.thingiverse.com/thing:2414978

inner_width=8;  // [8:8mm,12:12mm,16:16mm,24:24mm]
inner_height=5;  // [2:10]

difference(){

	union(){
		cube([inner_width+4,45,inner_height+3]); // main shape
		translate([0,26,inner_height+2]) cube([inner_width+4,10,3]); // main shape top
		translate([2,-1.5,0]) cube([inner_width,48,1]); // main shape, bottom nipple
	}
	// corners
	translate([inner_width+1,-2,inner_height+0.5]) rotate([0,0,30]) cube([3,3,1.5]);
	translate([3,-2,inner_height+0.5]) rotate([0,0,60]) cube([3,3,1.5]);
	translate([inner_width+2,42.5,inner_height+0.5]) rotate([0,0,60]) cube([3,3,1.5]);
	translate([2,42.5,inner_height+0.5]) rotate([0,0,30]) cube([3,3,1.5]); 

	translate([2.9,0,2]) cube([inner_width-2+0.4,50,inner_height]); //inner shape 1
	translate([1.8,0,inner_height+0.5]) cube([inner_width+0.4,50,1.5]); // inner shape 2

	translate([0,3,inner_height+2]) cube([inner_width+4,20,1]); // main window

	translate([1.9,26,inner_height+3]) cube([inner_width+0.4,3,1.2]);
	translate([1.9,29,inner_height+3]) rotate([20,0,0]) cube([inner_width+0.4,10,1.2]);
}
