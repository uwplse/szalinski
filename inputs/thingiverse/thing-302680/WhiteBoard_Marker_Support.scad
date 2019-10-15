/*=========================================
Program Name :	WhiteBoard Marker support
Base Language:	English
Created by   :	Esmarra
Creation Date:	18/04/2014 03:57
Rework date entries:
	21/03/2015 Design Now Compatible with Customizer, polished Comments and variables

Program Objectives: Create a mount for my marker
Observations: It was 2 stl's A part and B
Special Thanks:
=========================================*/

// preview[view:north west, tilt:top diagonal]

// Type In Pen Diameter
pen_d=20  ;
//Enter Pen Diameter + 2 for the gap

// Select Wall Thickness
wall_thick=3 ; 									
//Printed With thickness = 2

/* [Hidden] */
pen_size=pen_d + 2 ; 						// Pen diameter + small gap

wall_h=pen_d/2 +pen_size/2+wall_thick; 		// Biggest Wall Height
$fn=120;
//=============
module support(){
	module base(){
		cube([pen_size/2,wall_thick,wall_h]);
		cube([pen_size/2,pen_size+2*wall_thick,wall_thick+pen_size/2]);
		//pretty
		difference(){
			translate([-wall_thick+.1,0,0]) cube([wall_thick,pen_size+2*wall_thick,wall_h]);
			translate([-wall_thick,pen_size+wall_thick,wall_thick+pen_size/2+pen_size])rotate([0,90,0])cylinder(wall_thick+.2,pen_size,pen_size);			// Edge Slice 
		}
		translate([-wall_thick+.1,pen_size+2*wall_thick-(wall_thick/2),wall_thick+pen_size/2])rotate([0,90,0])cylinder(pen_size/2+wall_thick-.1,wall_thick/2,wall_thick/2);		// Smoth Edge
	}
	difference(){
		base();
		translate([0,wall_thick+pen_size/2,wall_thick+pen_size/2])rotate([0,90,0])cylinder(pen_size/2+.1,pen_size/2,pen_size/2);		// Pen
	}
}

//=============

//=============
module A(){
	support();
}
//=============

//=============
module B(){
	mirror([1,0,0])support();
}
//=============

//=============
module final(){
	support();
	translate([2*pen_size,0,0])mirror([1,0,0])support();
}
//=============


final();


