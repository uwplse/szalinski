include <utils/build_plate.scad>



//CUSTOMIZER VARIABLES

// Inside Diameter of the ring
Diameter_Inside 		=  100;	 //[0:200] 
// Outside Diameter of the ring
Diameter_Outside		=  110; 	//[0:200]
// Height of the ring
Ring_Height			=  10; 	//[0:200]
// Fragments for the cylinders
fragments_Inside			=  6;	//[3:360]
fragments_Outside		=  12;	//[3:360]

build_plate_selector = 1; //[0:Replicator 2,1: Replicator,2:Thingomatic]

//CUSTOMIZER VARIABLES END


build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
difference() {
	cylinder(r=Diameter_Outside/2,h=Ring_Height,$fn=fragments_Outside);
	translate([0,0,-1])
	cylinder(r=Diameter_Inside/2,h=Ring_Height+2,$fn=fragments_Inside);
	}
