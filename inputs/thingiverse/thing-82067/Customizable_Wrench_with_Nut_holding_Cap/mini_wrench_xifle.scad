include <MCAD/shapes.scad>
include <write/Write.scad>

// Find this thing on thingiverse:
// http://www.thingiverse.com/thing:82067

//Derived from
//http://www.thingiverse.com/thing:47842

//which in turn derives from
//http://www.thingiverse.com/thing:11647
//http://www.thingiverse.com/thing:4137

// Enhancements:
// - Higher resolution
// - deeper engraving
// - kerf size tightened
// - lowered text height

//CUSTOMIZER VARIABLES
// preview[view:south east, tilt:top]

/* [Geometry] */

//Nut size in mm
Nut_Size = 5.5;

//Height (thickness) of tool
Tool_Height = 2.5; 

//Length adjust for tool (In units of the Nut-diameter)
Tool_Length = 10;//[4:20]

// Has Holding Cap (Insert a nut to bring it to a specific position)
Has_holding_cap = 1; //[0:no,1:yes]

/* [Text] */

//(max 12 characters if using default tool lenght)
message = "My Wrench";

Font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]

//CUSTOMIZER VARIABLES END

$fs=0.1;

kerf = 0.3 + 0; // 
D = Nut_Size + kerf; 	// DIAMETER OF NUT
M = D/2; 	// MARGIN
H = Tool_Height; 	// HEIGHT (THICKNESS) OF TOOL
Ltot = D * Tool_Length; 	// TOTAL LENGTH OF TOOL
Text_Height = Nut_Size*0.7 ;

// Length from Center of One Side to Center of Other Side
L = Ltot-2*(D/2+M);

rotate([0, 0, -45])

difference() {
	union() {
	
		if (Has_holding_cap == 1) {
			translate([0,L/2,0]) {
				cylinder(r=(D/2+M), h= 0.5);
			}
			
		}
	
		difference() {
			union() {
				translate([0,L/2,H/2]) {
					cylinder(r = (D/2+M), h = H,center = true);
				}
				translate([0,-L/2,H/2]) {
					cylinder(r = (D/2+M), h = H,center = true);
				}
				translate([-1*D/2,-L/2,0]) {
					cube([D,L,H], center=false);
				}

				if (Has_holding_cap == 1) {
					translate([0,L/2,H]) {
						cylinder(r=(D/2+M), h= 0.5);
					}
				}
			}
			translate([0,-L/2 - D / 4,H/2 - 1]) {
				rotate([0,0,30]) {
					hexagon(D, H + 4);
				}	
			}
			translate([0,-L/2 - D - D / 4,H/2 - 1]) {
				cube([D,2*D,H + 2], center = true);
			}
			translate([0,L/2,H/2 - 1]) {
				rotate([0,0,30]) {
					hexagon(D, H + 4);
				}	
			}
			translate([0, 0, H - .1]){
				rotate([0,0,90]) {			
				write(message,t=.6,h=Text_Height,center=true,font=Font);
				}	
			}
		}
	}

	if (Has_holding_cap == 1) {
		translate([0,L/2,H/2-1]) {
			cylinder(r=(Nut_Size-2)/2, h= H+2, center=true);
		}
	}
}