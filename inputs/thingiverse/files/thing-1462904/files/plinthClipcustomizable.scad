// ========================================== 
//Title: plinthClipcustomizable
// Version: 1
// Last Updated: 3 April 2016
// Author: Michael Wakileh
// License: Attribution - Share Alike - Creative Commons
// License URL: http://creativecommons.org/licenses/by-sa/3.0/

//based on the the previous work:
// Title: plinthClip
// Version: 0.1
// Last Updated: 22 June 2011
// Author: Damian Axford
// License: Attribution - Share Alike - Creative Commons
// License URL: http://creativecommons.org/licenses/by-sa/3.0/
// Thingiverse URL: TBC
// ==========================================


// -----------------------------------------------------------------------------------
// Includes
// -----------------------------------------------------------------------------------

// boxes.scad required for roundedBox module 
include <MCAD/boxes.scad>

// -----------------------------------------------------------------------------------
// Global variables
// -----------------------------------------------------------------------------------

variablefnparameter = 360;   // used for $fn parameter when generating curved surfaces
variablelegDia = 26;         // originally 33
variablescrewDia = 3;        //orig 3
variableclipHeighth = 10;    //orig 10
variablewallThickness = 2;   //orig 1.5
variablebaseThickness = 2.5; //orig 2
variablescrewOffset = 0.8;    //originally 2

// ----------------------------------------------------------------------------------- 
// Modules
// -----------------------------------------------------------------------------------

module plinthClip(legDia,screwDia = variablescrewDia) {
	clipHeight = variableclipHeighth;
	wallThickness = variablewallThickness;
	throat = legDia - 6;
	baseThickness = variablebaseThickness;
	screwOffset = variablescrewOffset*screwDia;
	baseDepth=clipHeight + screwDia + 2*screwOffset;
	
	
	difference() {
		union() {
			// base
			translate([0,(baseDepth/2-clipHeight),baseThickness/2])
				roundedBox(size=[legDia,baseDepth,baseThickness], $fn=variablefnparameter,radius=screwDia*2,sidesonly=true);
		
			//clip body
			rotate([90,0,0]) 
				difference() {
			
					union() {		
						// clip
						translate([0,clipHeight/2 + legDia/2,0]) cylinder(h=clipHeight, r=legDia/2 + wallThickness, $fn=variablefnparameter);
			
						// clip reinforcement
						translate([0,legDia/2.1,clipHeight/3]) 
							scale([1,1.3,1])
							cylinder(h=clipHeight/4, r=legDia/2 + 2*wallThickness, $fn=variablefnparameter);
			
						// base
						linear_extrude(height=clipHeight)
							polygon(points= [	[throat/2,clipHeight],
			     							[-throat/2,clipHeight],
										[-legDia/2,0],
			     							[legDia/2,0]]);
		
			
						// guides
						translate([0,legDia*1,clipHeight/2])
							rotate([0,0,45])
							cube(size=[legDia*0.8,legDia*0.8,clipHeight],center=true);
					}	
					// hollow clip
					translate([0,clipHeight/2 + legDia/2,-1]) cylinder(h=clipHeight+2, r=legDia/2, $fn=variablefnparameter);
				
					// open throat
					translate([0,clipHeight/2 + legDia,clipHeight/2]) cube(size=[throat,legDia,clipHeight+2], center=true);
			
					// trim below base
					translate([-legDia,-throat,-1])
						cube(size=[2*legDia,throat,clipHeight+2]);
			
					// trim guides
					translate([wallThickness,legDia*1.17,clipHeight/2])
						rotate([0,0,45])
						cube(size=[legDia*0.8,legDia*0.8,clipHeight+2],center=true);
					translate([-wallThickness,legDia*1.17,clipHeight/2])
						rotate([0,0,45])
						cube(size=[legDia*0.8,legDia*0.8,clipHeight+2],center=true);
				}
		}
		
		// hollow screw slots
		translate([legDia/5,screwOffset + screwDia/2,baseThickness/2])
			cube(size=[legDia/5,screwDia,baseThickness+2],center=true);

		translate([-legDia/5,screwOffset + screwDia/2,baseThickness/2])
			cube(size=[legDia/5,screwDia,baseThickness+2],center=true);

		translate([3*legDia/10,screwOffset + screwDia/2,baseThickness/2])
			cylinder(h=baseThickness+2, r=screwDia/2,center=true,$fn=variablefnparameter);

		translate([1*legDia/10,screwOffset + screwDia/2,baseThickness/2])
			cylinder(h=baseThickness+2, r=screwDia/2,center=true,$fn=variablefnparameter);

		translate([-1*legDia/10,screwOffset + screwDia/2,baseThickness/2])
			cylinder(h=baseThickness+2, r=screwDia/2,center=true,$fn=variablefnparameter);

		translate([-3*legDia/10,screwOffset + screwDia/2,baseThickness/2])
			cylinder(h=baseThickness+2, r=screwDia/2,center=true,$fn=variablefnparameter);
	}
}


// ----------------------------------------------------------------------------------- 
// Example usage
// -----------------------------------------------------------------------------------

plinthClip(legDia=variablelegDia);


