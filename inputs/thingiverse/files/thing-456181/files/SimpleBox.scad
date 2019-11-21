//CUSTOMIZER VARIABLES

//	This section is displays the box options
//	Measurement of box on the X axis
Width = 120;	

//	Measurement of box on the Y axis
Depth = 90;	

//	Measurement of box on the Z axis
Height = 50;	

//	Thickness of box sides
Thick = 2;	//	[1:25]

difference() {
 	cube([Width+2*Thick,Depth+2*Thick,Height+Thick]);
	translate([Thick, Thick, Thick]) {
 		cube([Width,Depth,Height]);
 	}
 }