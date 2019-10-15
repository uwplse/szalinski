// 	Rotating Rings v1.0
//	Based on Rotating Rings Toy by RarelyEvil

//	Saw the Rotating Rings Toy, but when I tried to print it, 
//	it didn't come out right,  so created this file to input custom settings.

// 	Note that sizing may not be accurate. 	

/* Changelog
	v1.3
		Added: Text support
	v1.2
		Fixed: Sizing
		Fixed: Ring numbers
		Added: Multiple Extruder setup
	v1.1
		Improved: Sizing
	v1.0
		Initial Release
*/


/// Customizer Stuff ///

/*  [Parameters] */

// Radius in mm of final shape
radius = 30;

// Height in mm 
height = 20;

// Spacing between rings. Should be at least extrusion width. 
spacing = 0.6; 

// Number of rings to print. Some rings may be lost if their radius is less than the height.
number_of_rings = 5;

/* [Text] */
text = "";

/* [Multiple Extruders] */

// Number of Extruders
extruders = 1; //[1,2]

// Part 
part = "first"; //[first:extruder_1, second:extruder_2, both:extruder_1 and enxtruder_2]

/* [Hidden] */

/// Modules ///
use <write/Write.scad>;

module rotatingRings(radius, height, spacing, rings, ext = 0) {
	spacings = rings - 1;
	//ringWall = (radius - (spacing * spacings))/rings;
	ringWall = (radius/rings-1)-spacing;
	module sphereShell(radius, wallThickness) { 
		difference() {
			sphere(radius);
			sphere(radius-wallThickness);
		}
	}
	module spheres() {
		if (ext == 0) {
			for (i = [height/2 : spacing+ringWall: radius]) {
				sphereShell(i, ringWall);
			}
		} else if (ext == 1) {
			for (i = [height/2 : 2*(spacing+ringWall) : radius]) {
				sphereShell(i, ringWall);
			}
		} else if (ext == 2) {
			for (i = [height/2 + ringWall + spacing : 2*(spacing+ringWall) : radius]) {
				sphereShell(i, ringWall);
			}
		} else if (ext == 3) {
			for (i = [height/2 + ringWall + spacing : 2*(spacing+ringWall) : radius]) {
				translate([-2*radius -1, 0, 0]) sphereShell(i, ringWall);
			}
			for (i = [height/2 : 2*(spacing+ringWall) : radius]) {
				sphereShell(i, ringWall);
			}
		}			
	}
	difference() {
		spheres();
		translate([-radius*3, -radius*3, height/2]) cube([radius*4, radius*4, radius]);
		translate([-radius*3, -radius*3, -height/2 - radius]) cube([radius*4, radius*4, radius]);
	}
}

module text(text) {
	writesphere(text, [0,0,0], radius, rounded="true");
}

module print_part() {
	if (extruders == 1) { 
		rotatingRings(radius, height, spacing, number_of_rings);
		if (text != "") {text(text);} 
	}
	else if (extruders == 2) {
		if (part == "first") {
			rotatingRings(radius, height, spacing, number_of_rings, 1);
			if (text != "") {text(text);}
		 }
		else if (part == "second") {
			rotatingRings(radius, height, spacing, number_of_rings, 2); }
		else if (part == "both") {
			rotatingRings(radius, height, spacing, number_of_rings, 3); 
			if (text != "") {text(text);}
		}
		else {
			rotatingRings(radius, height, spacing, number_of_rings, 3); 
			if (text != "") {text(text);}
		}
	} else {
		rotatingRings(radius, height, spacing, number_of_rings); 
		if (text != "") {text(text);}
		}
	}

/// Generate ///

print_part();