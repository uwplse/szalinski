////////////////////////////////////////
//
//     By: Jeff Crossman
//	  For: Golan Levin's IACD 2014
//		   Carnegie Mellon University
//	Title: Parametric Robot Head
//
/////////////////////////////////////// 


////////////////////////////////////////
//									//
//		PARAMETRIC PARAMETERS		//
//									//
////////////////////////////////////////

AntennaHeight = 50;		// Default: 50
AntennaBallRadius = 5;	// Default: 5
EyeDiameter = 10;		// Default: 10
EyeSpacingOffset = 0;	// Default: 0
MouthHeight = 20;		// Default: 20


//////////////   END   /////////////////



// Head
translate([10, 0, 0]){
difference() {
	// Base head
	cube([100, 50, 50]);

	// Mouth
	translate([21, 0, 0]){
		cube([8, 10, MouthHeight]);
	}
	translate([31, 0, 0]){
		cube([8, 10, MouthHeight]);
	}
	translate([41, 0, 0]){
		cube([8, 10, MouthHeight]);
	}
	translate([51, 0, 0]){
		cube([8, 10, MouthHeight]);
	}
	translate([61, 0, 0]){
		cube([8, 10, MouthHeight]);
	}
	translate([71, 0, 0]){
		cube([8, 10, MouthHeight]);
	}

	// Left Eye
	translate([20+EyeSpacingOffset, 4, 35]){
		rotate(a=[90, 0, 0]) {
			cylinder(10, EyeDiameter, EyeDiameter, center=true);
		}
	}

	// Right Eye
	translate([80-EyeSpacingOffset, 4, 35]){
		rotate(a=[90, 0, 0]) {
			cylinder(10, EyeDiameter, EyeDiameter, center=true);
		}
	}
}
}

// Left Ear
translate([5, 25, 25]){
	rotate(a=[0, 90, 0]) {
		cylinder(10, 10, 10, center=true);
	}
}
translate([5, 25, (25+(AntennaHeight/2))]){
	cylinder(AntennaHeight, 1, 1, center=true);
}
translate([5, 25, 25+AntennaHeight]){
	sphere(AntennaBallRadius);
}

// Right Ear
translate([115, 25, 25]){
	rotate(a=[0, 90, 0]) {
		cylinder(10, 10, 10, center=true);
	}
}
translate([115, 25, (25+(AntennaHeight/2))]){
	cylinder(AntennaHeight, 1, 1, center=true);
}
translate([115, 25, 25+AntennaHeight]){
	sphere(AntennaBallRadius);
}


