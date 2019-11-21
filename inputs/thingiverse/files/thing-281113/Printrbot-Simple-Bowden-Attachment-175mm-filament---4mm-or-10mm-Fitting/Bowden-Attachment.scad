bowdenAttachementDiameter = 10; // [4,10]

difference() {

	union() {
		translate([-13.5,-13.5,0]) {
			cube([39,27,10]);
		}
		
		translate([0,0,10]) {
			cylinder(r1 = 13.4, r2 = 8.456835, h = 12, $fn = 80);
		}
	}

	union() {
		color([0.1,0.1,0.5]) {

			// hotend opening	
			translate([0,0,10]) {
				cylinder(r1 = 8.456835, r2 = 1.6, h = 3, $fn = 80);
			}
	
			translate([0,0,-1]) {
				cylinder(d = 2.1, h = 19, $fn = 30);
				cylinder(r = 8.456835, h = 11, $fn = 80);
			}
	
			// Bowden Opening
			translate([0,0,15]) {
				cylinder(d = bowdenAttachementDiameter, h = 12, $fn = 80);
			}
	
			// Secure the Hotend
			rotate(90, [1,0,0]) {
				translate([7.59,5,-15]) {
					cylinder(r = 1.6, h = 30, $fn = 30);
				}
				translate([-7.59,5,-15]) {
					cylinder(r = 1.6, h = 30, $fn = 30);
				}
			}
			
			// M3 Mounting Holes
			translate([-8.5,-8.1,-1]) {
				cylinder(r = 1.6, h = 20, $fn = 30);
			}
			
			translate([-8.5,7.88,-1]) {
				cylinder(r = 1.6, h = 20, $fn = 30);
			}
			
			translate([21.44,-8.1,-1]) {
				cylinder(r = 1.6, h = 15, $fn = 30);
			}
			
			translate([21.44,7.88,-1]) {
				cylinder(r = 1.6, h = 15, $fn = 30);
			}
		}
	}
}