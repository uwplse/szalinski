//  He3D K200 Heated Bed Clamps for securing
//  Glass Plate

$fn = 50;
HB_DIAMETER = 220;
GP_DIAMETER = 199;
GP_HEIGHT = 3;
BOLT_DIAMETER = 3;
CLAMP_WIDTH = 10;
LOWER_DISTANCE = 11;

difference() {
	intersection() {
		union() {
			// Lower Layer
			difference() {
				translate([LOWER_DISTANCE / 2, 0, GP_HEIGHT]) 
					cube([LOWER_DISTANCE, 
						  CLAMP_WIDTH,
						  GP_HEIGHT], 
						  center = true);
				// Glass Plate curve
				translate([HB_DIAMETER / 2, 0, 0]) 
					cylinder(r = GP_DIAMETER / 2, 
							 h = GP_HEIGHT * 2.5);
			}
			
			// Upper Layer
			union() {
				translate([LOWER_DISTANCE / 2, 0, 0]) 
					cube([LOWER_DISTANCE, 
						  CLAMP_WIDTH,
						  GP_HEIGHT], 
						  center = true);
				
				translate([LOWER_DISTANCE, 0, 0]) 
					cylinder(r = CLAMP_WIDTH / 2,
							 h = GP_HEIGHT, 
							 center = true);
			}
		}
	
		// Heated Bed curve
		translate([HB_DIAMETER / 2, 0, -GP_HEIGHT]) 
		cylinder(r = HB_DIAMETER /2, 
				 h = GP_HEIGHT * 3);
	}
	// Bolt Hole
	translate([LOWER_DISTANCE * 0.4, 0, -GP_HEIGHT]) 
	cylinder(r = BOLT_DIAMETER / 2,
			 h = GP_HEIGHT * 3);
}
