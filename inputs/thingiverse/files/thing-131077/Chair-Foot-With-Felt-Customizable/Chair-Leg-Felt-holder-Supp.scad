//
// Kitchen Chair footpad that holds a 1" diameter felt pad
// Keeps the pad from sliding off by providing a small lip
//

Quality = 100; // [25:Draft,100:Production]

// mm
Leg_Bottom_Diameter = 22.5; // [15:50]

// mm
Leg_Top_Diameter = 24.5; // [15:50]

//degrees
Leg_Angle = 12; // [0:20]

// mm
Leg_Cup_Height = 13; // [10:30]

// mm
Felt_Diameter = 27; // [15:52]

// mm
Felt_Height = 5; // [3:10]

// put thin break-away supports under the felt cup
Include_Supports = 1; // [1:Yes,0:No]

// BELOW HERE VARIABLES THAT ARE NOT CUSTOMIZABLE

$fn = Quality;
wall = 2*1;

// Create the thing

union() {
	difference() {
		hull() {
			rotate([Leg_Angle,0,0]) {
				cylinder(r1=Leg_Bottom_Diameter/2+wall, 
						r2=Leg_Top_Diameter/2+wall, 
						h=Leg_Cup_Height+3*wall,
						center=true);
			}
		
			// felt holder
			translate([0,0,-(Leg_Cup_Height+3*wall)/2]) {
				cylinder(r=Felt_Diameter/2 + wall, 
					h=Felt_Height+wall, 
					center=true);
			}
		
		}
	
		// carve out holes for leg and felt
		difference() {
		   rotate([Leg_Angle,0,0])
				translate([0,0,1.6*wall])
					cylinder(r1=Leg_Bottom_Diameter/2, 
						r2=Leg_Top_Diameter/2, 
						h=Leg_Cup_Height+Felt_Height+2*wall,
						center=true);
			translate([0,0,-(5+Leg_Cup_Height+Felt_Height+0*wall)/2])
				cube([200,200,10],center=true);
		}
	
		translate([0,0,-(0.1+Leg_Cup_Height+Felt_Height+3*wall)/2])
			cylinder(r=Felt_Diameter/2, 
				h=Felt_Height/2+1, 
				center=true);
	
	}

	if (Include_Supports) {
		// add in break-away supports under the felt cup, the bridge is
		// a little too far.
	
		for (rot = [0:90:359])
			rotate([0,0,rot])
				translate([0,Felt_Height+wall,-(Leg_Cup_Height+Felt_Height+3*wall-Felt_Height/2+1)/2])
					cube([0.75, Felt_Diameter/2-wall, Felt_Height/2+1], center=true);
	}

}



