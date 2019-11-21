// Customizable Cable Catcher v1.0
// by TheNewHobbyist 2014 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:
//
// "Customizable Cable Catcher" is licensed under a 
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//
// Description: 
// Never lose a cable behind your desk again! Just route your cables through the holes on the cable catcher
// and stop worrying! The cable catcher will catch any cables that begin to slip off your desk.
//
// Created at the 2014 Thingiverse Make-a-thon.
// 
//
// Usage: 
// 1. Input the thickness of your table top in mm.
// 2. Select the number of cables you would like to catch.
// 3. Print Cable Catcher.
// 4. Live a long a fulfilling life never worrying about cables falling behind your desk.
//

/* [Cable Catcher] */

//How thick is your desk in mm?
desk_thickness = 25;

// How many cables would you like to save?
cable_number = 2; // [1:25]

/* [Build Plate] */

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 50; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 50; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

// preview[view:south, tilt:top]


/////////////////////////
// Beat it Customizer //
///////////////////////

/* [Hidden] */

use <utils/build_plate.scad>

width = (10 + 10*cable_number);

module cord_holder(){
	difference(){
		union(){
			cube([width, desk_thickness, 3], center=false);
			translate([0,0,0]) cube([width, 3, 40], center=false);
			rotate([5,0,0]) translate([0,desk_thickness,-3]) cube([width, 3, 40], center=false);
			}
		translate([-1,0,39]) rotate([45,0,0]) cube([width+2, 10, 10], center=false);
		translate([-1,3,39]) rotate([45,0,0]) cube([width+2, 10, 10], center=false);
		translate([-1,desk_thickness-3.3,38]) rotate([50,0,0]) cube([width+2, 10, 10], center=false);
		translate([-1,desk_thickness,38]) rotate([50,0,0]) cube([width+2, 10, 10], center=false);
		translate([-1,0,-10]) cube([10+cable_number*12, desk_thickness*2, 10]);
		}
	difference(){
		translate([0,-10,0])  cube([width, 10, 10], center=false);
		translate([-1,-10,3]) rotate([45,0,0]) cube([width+10, 10, 10], center=false);
		translate([-7,-10.01,10]) rotate([0,45,0]) cube([10, 10, 10], center=false);
		translate([width-7,-10.01,10]) rotate([0,45,0]) cube([10, 10, 10], center=false);
	}
}

module cut_outs(){
	cylinder(r=2.5, h=30, center=true, $fn=24);
	translate([0,-5,0]) cube([3.2, 10, 20], center=true);
}

module built(){
	difference(){
		cord_holder();
		for ( i = [1 : cable_number] )
		{
    		translate([10*i,-5,0]) cut_outs();
		}	
	translate([-1,0,-10]) cube([width+2, width, 10], center=false);
	}
}

module hole_hex(){
	translate([5,desk_thickness+5,15]) rotate([90,0,0]) cylinder(r=2, h=desk_thickness+10, $fn=6);	
	translate([5,desk_thickness+5,25]) rotate([90,0,0]) cylinder(r=2, h=desk_thickness+10, $fn=6);	
	translate([5,desk_thickness+5,35]) rotate([90,0,0]) cylinder(r=2, h=desk_thickness+10, $fn=6);	
	translate([width-5,desk_thickness+5,15]) rotate([90,0,0]) cylinder(r=2, h=desk_thickness+10, $fn=6);	
	translate([width-5,desk_thickness+5,25]) rotate([90,0,0]) cylinder(r=2, h=desk_thickness+10, $fn=6);	
	translate([width-5,desk_thickness+5,35]) rotate([90,0,0]) cylinder(r=2, h=desk_thickness+10, $fn=6);
}

module hole_span(){
	translate([10,desk_thickness+5,20]) rotate([90,0,0]) cylinder(r=4, h=desk_thickness+10, $fn=6);	
	translate([10,desk_thickness+5,30]) rotate([90,0,0]) cylinder(r=4, h=desk_thickness+10, $fn=6);	
	translate([15,desk_thickness+5,15]) rotate([90,0,0]) cylinder(r=2, h=desk_thickness+10, $fn=6);	
	translate([15,desk_thickness+5,25]) rotate([90,0,0]) cylinder(r=2, h=desk_thickness+10, $fn=6);	
	translate([15,desk_thickness+5,35]) rotate([90,0,0]) cylinder(r=2, h=desk_thickness+10, $fn=6);
}

module back_holes(){
	 translate([10,18,0]) cylinder(r=4, h=10, center=true, $fn=6);
	 translate([10,8,0]) cylinder(r=4, h=10, center=true, $fn=6);
	 translate([5,13,0]) cylinder(r=2, h=10, center=true, $fn=6);
	 translate([15,13,0]) cylinder(r=2, h=10, center=true, $fn=6);
}

color("red"){
translate([-width/2,-desk_thickness/2+3.5,0]){
difference(){
	built();
	hole_hex();
	for ( i = [0 : cable_number-1] )
		{
    	translate([10*i,0,0]) hole_span();
	}
	for ( i = [0 : cable_number-1] )
		{
    	translate([10*i,0,0]) back_holes();
	}
}
}
}