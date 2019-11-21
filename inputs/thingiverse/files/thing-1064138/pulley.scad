// expects about 0.2 mm of tolerance

bandDiameter   = 3.2; // diameter of band

shaftDiameter  = 5.2; // sized for m5 shaft

pulleyDiameter = 40;
pulleyHeight   = 6;

hubDiameter    = 22;
hubHeight      = 8;

m3_nut_flats = 5.7; // width of m3 nut cave
m3_nut_depth = 2.7; // height of m3 nut for cave
m3_nut_points = (m3_nut_flats / 2) / cos(30); // Nut cave radius

bandPulley();

module bandPulley() {
	
	bandSegments   = 128;
	bandResolution = 24; // 4 produces a sharp inward groove
	
	difference() {
		
		union() {
			// main circumfrence
			difference() {
				cylinder(d = pulleyDiameter, h = pulleyHeight, center = true, $fn = bandSegments);
			
				// band groove
				rotate_extrude(convexity = 10, $fn = 128) {
					translate([pulleyDiameter / 2, 0, 0]) {
						circle(d = bandDiameter, center = true, $fn = bandResolution);
					}
				}
			}
			
			// hub
			translate([0, 0, pulleyHeight / 2 + hubHeight / 2]) {
				cylinder( d = hubDiameter, h = hubHeight, center = true, $fn = 64);
			}
		}
		
		// shaft
		translate([0, 0, hubHeight / 2]) {
			cylinder(d = 5.2, h = pulleyHeight + hubHeight + 1, center = true, $fn = 64);
		}

		for (j = [1:2] ) {
			rotate(360/2 * j, [0,0,1]) {
				rotate(90, [0,1,0]) {
					
					// nut cave
					translate([-(pulleyHeight / 2 + hubHeight / 2), 0, hubDiameter / 2 - m3_nut_depth - 2]) {
						cylinder(r = m3_nut_points, h = m3_nut_depth, center = true, $fn = 6);
					}
					
					// nut entrance
					translate([-(pulleyHeight / 2 + hubHeight), 0, hubDiameter / 2 - m3_nut_depth - 2]) {
						cube(size = [hubHeight, m3_nut_flats, m3_nut_depth], center = true);
					}
					
					// m3 passage
					translate([-(pulleyHeight / 2 + hubHeight / 2), 0, hubDiameter / 4]) {
						cylinder(d = 3.2, h = hubDiameter, center = true, $fn = 24);
					}
					
				} // end: rotate
			} // end: rotate
		} // end: for

	} // end: difference
	
	
	
}
