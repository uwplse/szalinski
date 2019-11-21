/* 

		This file had been created by Tim Chandler a.k.a. 2n2r5 and is 
		being shared under the creative commons - attribution license.
		Any and all icons, references to 2n2r5.com, 2n2r5.net, Tim 
		Chandler ,2n2r5 or Trademarks must remain in the the end product. 
		This script is free to use for any and all purposes, both 
		commercial and non-commercial provided that the above conditions 
		are met. 


		Please refer to http://creativecommons.org/licenses/by/3.0/ 
		for more information on this license.
*/

/*

Script by: Tim Chandler (2n2r5)

Filename: hourGlass.scad
Date of Creation: 8/8/13
True Revision Number: V1.2
Date of Revision: 8/12/13

Description:
Hour glass for printing challenge. Week 2


Todo:
 - Name Plate for Customization
 - Make Manifold Objects!
 - Make prettier glass


 Change Log:

 8/8/2013 - Basic Functionality completed.

*/
/* [Basic Options] */
// How many pillars should be around the glass?
pillarCount = 5 ;// [3:8]
// Radius of pillars
pillarWidth = 5	; //[3:10]
// Height of Pillars and Glass
pillarHeight = 60;// [30:150]
// Width of "Glass"
glassWidth = 50 ; //[20:100]

/* [Advanced Options] */
// Pillar Shape
pillarSides = 4 ;// [3,4,5,6,8,15,30]
// Center hole size where sand passes through
glassJunction = 3.25 ; //[2,2.25,2.5,2.75,3,3.25,3.5,3.75,4]
// Size of base
baseHeight = 5	; // [2:10]
// Rotation of Pillars
rotation = 360 ; // [0:1080]
// Thickness of "Glass"
wallWidth = .42; 

/* [Expert] */
//Set this to Pillar height/layer height for the best quality. Default should be fine for most.
pillarSlices = 300; // [50:500]
//Shape of "Glass". 
glassPretty = 30; // [3:100]
//Sets beveled edges on the top and bottom "base" 
minki = 1.5; // [0,.5,1,1.5,2,2.5,3,3.5,4]

part = "All"; //[Bases_and_Pillers,Glass,All]

/* [Hidden] */
ff = .001;


module base(){

	union(){
			minkowski() {
			translate([0,0,-pillarHeight/2]) cylinder(r=glassWidth/2+pillarWidth-minki ,h=baseHeight,$fn=pillarCount);
			sphere(r=minki);
				}
			minkowski() {
			translate([0,0,+pillarHeight/2+baseHeight]) cylinder(r=glassWidth/2+pillarWidth-minki ,h=baseHeight,$fn=pillarCount);
			sphere(r=minki);
					}
		
		}
			
}
module pillars(){

		
			for (i=[1:pillarCount]){
		  		rotate([0,0,i*360/pillarCount]) translate([glassWidth/2,0,baseHeight-pillarHeight/2]) { 
		  			linear_extrude(height=pillarHeight  , convexity = 50 , slices=pillarSlices, twist=rotation, $fn = pillarSides) circle(r=pillarWidth, $fn = pillarSides,  center=true);
				}
			}
		
}



module glassBulbs(){
	
	difference(){
			cylinder(r2=glassWidth/2 - pillarWidth , r1 = glassJunction/2 +wallWidth, h=pillarHeight/2+ff-minki, $fn=glassPretty);
			cylinder(r2=glassWidth/2-pillarWidth-wallWidth , r1 = glassJunction/2, h=pillarHeight/2+ff-minki , $fn=glassPretty);
				
			
	}
}



module fillPlug(){
	 	union(){
				translate([0,0,-pillarHeight/2-minki]) cylinder(r=(glassWidth/2+pillarWidth)/2,h=baseHeight/2+minki,$fn=pillarCount);
				translate([0,0,-pillarHeight/2+ baseHeight/2 ]) cylinder(r=(glassWidth/2+pillarWidth)/2-2,h=baseHeight/2+minki,$fn=pillarCount);
		}
}



print_part();

module print_part() {

	 if (part == "All") {
		
	difference(){
		union(){
			color("BurlyWood")pillars();
			color("SaddleBrown")translate([glassWidth,0,(baseHeight*.03)]) rotate ([0,0,0]) scale([.97,.97,1]) fillPlug();
			color("SaddleBrown")base();

			union(){

					translate([0,0,baseHeight]){color("skyblue")glassBulbs();
					mirror([0,0,1])color("skyblue")glassBulbs();}
					}
				}
		
		union(){
			fillPlug();
		}
	}
	}else if (part == "Glass") {
		
			translate([0,0,baseHeight]){color("skyblue")glassBulbs();
			mirror([0,0,1])color("skyblue")glassBulbs();}
			
		
	} else if (part == "Bases_and_Pillers") {
		difference(){
			union(){
				base();
				pillars();
			}
				union(){
			fillPlug();
		}
		}
		translate([glassWidth,0,(baseHeight*.03)]) rotate ([0,0,0]) scale([.97,.97,1]) fillPlug();
	}
	


	 else {

			difference(){
		union(){
			color("BurlyWood")pillars();
			color("SaddleBrown")translate([glassWidth,0,(baseHeight*.03)]) rotate ([0,0,0]) scale([.97,.97,1]) fillPlug();
			color("SaddleBrown")base();

			union(){

					translate([0,0,baseHeight]){color("skyblue")glassBulbs();
					mirror([0,0,1])color("skyblue")glassBulbs();}
					}
				}
		
		union(){
			fillPlug();
		}
	}
}
}
