include <MCAD/shapes.scad>
include <write/Write.scad>

//Derived from
//http://www.thingiverse.com/thing:11647
//http://www.thingiverse.com/thing:4137

//CUSTOMIZER VARIABLES
// preview[view:south east, tilt:top]
//(max 12 characters if using default tool lenght)
message = "10mm    8mm";


Font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]

//Nut size in mm (Left)
Nut_Size=7; 
//Nut size in mm (Right)
Nut_Size2=8;

//Height (thickness) of tool
Tool_Height = 5; 

//Length adjust for tool (Nutsize)
Tool_Length = 10;//[4:20]

//CUSTOMIZER VARIABLES END

kerf = 0.4 + 0; // 
D = Nut_Size + kerf; 	// DIAMETER OF NUT (Left)
D2 = Nut_Size2 + kerf; 	// DIAMETER OF NUT (Right)
M = D/2; 	// MARGIN
M2 = D2/2; 	// MARGIN
H = Tool_Height; 	// HEIGHT (THICKNESS) OF TOOL
Ltot = D * Tool_Length; 	// TOTAL LENGTH OF TOOL
Text_Height = Nut_Size*0.8 ;


// Length from Center of One Side to Center of Other Side
L = Ltot-2*(D/2+M);

rotate([0,0,-45])
difference() {
	union() {
		translate([0,L/2,H/2]) {
			cylinder(r=(D2/2+M2),h=H,center=true);
		}
		translate([0,-L/2,H/2]) {
			cylinder(r =(D/2+M),h=H,center=true);
		}
		translate([-1*((D+D2)/2)/2,-L/2,0]) {
			cube([(D+D2)/2,L,H],center=false);
		}
	}
	translate([0,-L/2-D/4,H/2-0.5]) {
		rotate([0,0,30]) {
			hexagon(D,H+2);
		}	
	}
	translate([0,-L/2-D-D/4,H/2-0.5]) {
		cube([D,2*D,H+2],center=true);
	}
    translate([0,L/2+D2,H/2-0.5]) {
		cube([D2,2*D2,H+2],center=true);
	}
	translate([0,L/2,H/2-0.5]) {
		rotate([0,0,30]) {
			hexagon(D2,H+2);
		}	
	}
    translate([0, 0, H - .1]){
		rotate([0,0,90]) {			
		write(message,t=.5,h=Text_Height,center=true,font=Font);
		}	
	}
}