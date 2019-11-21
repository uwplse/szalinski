/* Spherical ice (or other cast object) form
Released 2013 - Stephen Baird
License: Creative Commons - Attribution - NonCommercial - Sharealike
http://creativecommons.org/licenses/by-nc-sa/3.0/us/ 

Don't forget to upload pictures of what you make on Thingiverse
I love to see what people make from my designs! */

include <utils/build_plate.scad>

 
//Configuration options:
//CUSTOMIZER VARIABLES

//Pick which half of the mold you want to make - Top or Bottom
	top_or_bottom = "Top"; // [Bottom,Top]

//Put your wall thickness here - Default: .42 - Note: This is found under the "Advanced" option in the Print Settings tab in Slic3r
	wall_thickness = .42;

//If your spiral screw-in connection is too tight, increase this - Default: .01
	fudge_factor = .01; // [0,0.01,0.02,0.03,0.04,0.05]

//If the connection between the halves won't fit together increase this, if the mold leaks at the connection point decrease this - Default: 0.1
	fudge_factor2 = 0.1; // [0,0.025,0.05,0.075,0.1,0.125,0.15,0.175,0.2]

//Desired radius of the cast ice (or other object) - Default: 20
	mold_size = 20;

//Fineness, increase to make cast object smoother - Default: 30     
fineness = 30; // [30:100]

//	This section is creates the build plates for scale
//	for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//	When Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//	When Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

//CUSTOMIZER VARIABLES END

//	This is just a Build Plate for scale
translate([0,0,-mold_size-2*wall_thickness]) build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);


//Begin object code

$fn = fineness;

// --* Bottom mold *--
if (top_or_bottom == "Bottom"){

	//Lower Shroud
	difference(){
translate([0,0,-mold_size-2*wall_thickness])cylinder(mold_size+2*wall_thickness,mold_size+(9+fudge_factor2)*wall_thickness,mold_size+(9+fudge_factor2)*wall_thickness); //outer wall
sphere(mold_size); //mold interior
	}

	//Upper Shroud
	difference(){
translate([0,0,-mold_size/4]) cylinder(mold_size/2,mold_size+(9+fudge_factor2)*wall_thickness,mold_size+(9+fudge_factor2)*wall_thickness); //outer wall
translate([0,0,-.1-mold_size/4]) cylinder(.2+mold_size/2,mold_size+(4+fudge_factor2)*wall_thickness,mold_size+(4+fudge_factor2)*wall_thickness); //inner wall

	//Connection Grooves
	for (j=[0:7]){
rotate([-40,0,45*j]) translate([-mold_size-4*wall_thickness,-1.17,1.49]) cylinder(mold_size/4,fudge_factor+2*wall_thickness,2*fudge_factor+2*wall_thickness,$fn=10); //angled groove
rotate([0,0,45*j]) translate([-mold_size-4*wall_thickness,0,1.78]) sphere(fudge_factor+2*wall_thickness,$fn=10); //corner
rotate([-90,0,45*j]) translate([-mold_size-4*wall_thickness,-1.78,-3.22]) cylinder(mold_size/6.2,fudge_factor+2*wall_thickness,2*fudge_factor+2*wall_thickness,$fn=10); //straight groove
rotate([0,0,45*j]) translate([-mold_size-4*wall_thickness,-3,1.78]) sphere(fudge_factor+2*wall_thickness,$fn=10); //ball end
	}}}


// --* Top Mold *--
if (top_or_bottom == "Top"){
	
	//Lower Shroud
	difference(){
translate([0,0,-mold_size-2*wall_thickness])cylinder(mold_size+2*wall_thickness,mold_size+(9+fudge_factor2)*wall_thickness,mold_size+(9+fudge_factor2)*wall_thickness); //outer wall
sphere(mold_size); //mold interior
translate([0,0,-mold_size-2]) cylinder(10,2.5,2.5,$fn=20); //filling hole

	//Upper Shroud
	difference(){
translate([0,0,-mold_size/4]) cylinder(10,mold_size+11*wall_thickness,mold_size+11*wall_thickness);
translate([0,0,-mold_size/4]) cylinder(10,mold_size+4*wall_thickness,mold_size+4*wall_thickness);
	}}

	//Connection Balls
	for (j=[0:7]){
rotate([0,0,45*j]) translate([-mold_size-4*wall_thickness,0,-1.78]) sphere(2*wall_thickness,$fn=10);
	}}