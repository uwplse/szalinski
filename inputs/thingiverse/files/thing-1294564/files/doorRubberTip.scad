

/* [Global] */

/* [Body] */
// Rubber tip total height (mm).
total_height = 18; 

// Rubber tip base diameter (mm).
base_diameter 	= 18;

// Rubber tip top diameter (mm).
top_diameter	= 15;

/* [Hole] */

// Rubber tip base thicknes (mm).
base_thicknes = 2; 	// [2:Thin,3:Medium,4:Thick]

// Rubber tip hole  diameter (mm).
hole_diameter  =  7;

/* [Skidproof] */
// Skidproof  thicknes (mm).
rugosity  = 0.5; 	// [0:0.1:1]


/* [Hidden] */
$fn						= 50; 	//Numer of fragments

difference(){
	union() {
		// Rubber tip body
		cylinder(total_height, d1=base_diameter, d2=top_diameter, center=false);
		
		// Skidproof
		for(i=[(base_diameter/2)- rugosity:-1.5:1]) {
			rotate_extrude(convexity=10) translate([i, 0, 0]) circle(r=rugosity);
		}
	}
	// Hole
	translate([0,0,base_thicknes]) cylinder(total_height, d=hole_diameter, center = false);
}
