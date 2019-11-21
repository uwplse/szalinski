include <MCAD/shapes.scad>
include <write/Write.scad>


//(max 12 characters if using default tool lenght)
message = "13mm";

// Typeface
Font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]

//Nut size in mm
Nut_Size = 13; 

//Height (thickness) of tool
Tool_Height = Nut_Size/2; 

//Length adjust for tool (Nutsize)
Tool_Length = 10;//[4:20]

// Choose Extruder2 if you want the text to be filled in with another color
DualExtrusion = "Extruder1";//[Extruder1,Extruder2]
ToolOptions = 2;//[1:Open End Only,2:Both Sides,3:Closed End Only]

// Printer margin (because some printers print a little bit thicker)
kerf = 0.3; // Printing margin 



D = Nut_Size + kerf; 	// DIAMETER OF NUT
M = D/4; 	// MARGIN
H = Tool_Height; 	// HEIGHT (THICKNESS) OF TOOL
Ltot = D * Tool_Length; 	// TOTAL LENGTH OF TOOL
Text_Height = Nut_Size*0.7 ;


// Length from Center of One Side to Center of Other Side
L = Ltot-2*(D/2+M);


rotate([0, 0, -45]){

if (DualExtrusion == "Extruder1"){
difference() {
	union() {
if(ToolOptions > 1){	translate([0,L/2,H/2]) rcylinder(r1 = (D*0.85),r2 = (D*0.85), h = H,center = true,b=Nut_Size*0.1);
		}
		if(ToolOptions < 3){translate([0,-L/2,H/2]) rcylinder(r1 = (D*1.1),r2 = (D*1.1), h = H,center = true,b=Nut_Size*0.1);}
		
		translate([0,0,H/2]) rcube([D*1,L,H],b=Nut_Size*0.1);
	}
	if(ToolOptions < 3){translate([0,-L/2 - D / 4,H/2 - 0.5]) rotate([0,0,30]) hexagon(D, H + 2);}
	
	translate([0,-L/2 - D - D / 4,H/2 - 0.5]) {
		cube([D,2*D,H + 2], center = true);
	}
	if(ToolOptions > 1){ translate([0,L/2,H/2 - 0.5]) rotate([0,0,30]) hexagon(D, H + 2);
		
	}
	translate([0, 0, H - .4]){
		rotate([0,0,90]) WriteText();
	}
}
}
if (DualExtrusion == "Extruder2"){
	translate([0, 0, H - .4]){
		rotate([0,0,90]) WriteText();}
}
}

module WriteText() {minkowski(){cube([0.1,0.1,0.1]);		
		write(message,t=.5,h=Text_Height,center=true,font=Font);}}


// Rounded primitives for openscad
// (c) 2013 Wouter Robers 

// Syntax example for a rounded block
// translate([-15,0,10]) rcube([20,20,20],2);

// Syntax example for a rounded cylinder
// translate([15,0,10]) rcylinder(r1=15,r2=10,h=20,b=2);




module rcube(Size=[20,20,20],b=1)
{hull(){for(x=[-(Size[0]/2-b),(Size[0]/2-b)]){for(y=[-(Size[1]/2-b),(Size[1]/2-b)]){for(z=[-(Size[2]/2-b),(Size[2]/2-b)]){ translate([x,y,z]) sphere(b);}}}}}


module rcylinder(r1=10,r2=10,h=10,b=1)
{translate([0,0,-h/2]) hull(){rotate_extrude() translate([r1-b,b,0]) circle(r = b); rotate_extrude() translate([r2-b, h-b, 0]) circle(r = b);}}
