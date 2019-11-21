
module effector() {

	// Basic height of Effector
	effectorHeight = 10;

	// Size of Base Effector
	bodyDiameter = 60;             // Central diameter of Effector
	bodyHeight   = effectorHeight; // Height of Effector body, must be taller than Effector's height
	bodyDiaphram = 30;             // Center opening

	// Sizing of Arms
	armLength = 35;              // How far do Arms protrude?
	armWidth  = 40;              // How wide are the Arms?
	armHeight = effectorHeight;  // Set to Effector's height by default
	armNub    = 4;               // How far do the little mounting nubs protrude?

	// Number of M3 Mounting Holes on Effector
	bodyMounts       = 8;        // How many Holes?
	bodyMountsOffset = 20;       // How far from Center?

	// Assemble Base
	difference() {

		// Combine Base and Arms
		union() {
			// Draw Base
			body(bodyDiameter, bodyHeight, bodyDiaphram);

			// Draw 3 arms in 120 degree increments
			for ( i = [0 : 2] ) {
			    rotate( i * 120, [0, 0, 1])
				arm(armLength, armWidth, armHeight, armNub);
			}
		}

		// Diaphram for Hot End	
		translate([0,0,-0.5]) {
			cylinder(d = bodyDiaphram, h = bodyHeight + 1, $fn = 100);
		}
	
		// Add Radial Array M3 mounting Holes
		for ( i = [0 : bodyMounts] ) {
			rotate( (i * (360 / bodyMounts)), [0, 0, 1]) {
				translate([bodyMountsOffset, 0, -0.5]) {
					cylinder(d = 3.1, h = bodyHeight + 1, $fn = 30);
				}
			}
		}
	}

	echo(str("<b>DELTA_EFFECTOR_OFFSET: ", armLength, "mm</b>"));
}

module body(bodyDiameter, bodyHeight, bodyDiaphram) {
	hull() {
		translate([0,0, (bodyHeight * 0.5)]) {
			cylinder(d = bodyDiameter, h = bodyHeight - 1, center = true, $fn = 120);
			cylinder(d = bodyDiameter - 1, h = bodyHeight, center = true, $fn = 120);
		}
	}
}

module arm(armLength, armWidth, armHeight, armNub) {

	nubOffset = (armWidth * 0.5) + (armNub * 0.5);

	union() {

		// Arm
		difference() {
			translate([0, (armLength * 0.5), (armHeight * 0.5)]) {
				hull() {
					cube([armWidth, armLength, armHeight - 1], center=true);
					cube([armWidth - 1, armLength, armHeight], center=true);
				}
			}
			
			// M3 Holes
			translate([0, armLength, (armHeight * 0.5)]) {
				rotate([90,0,90]) {
					cylinder(d = 3.1, h = (armWidth + 1), $fn = 30, center = true);
				}
			}
		}

		// End of Arm
		translate([0, armLength, (armHeight * 0.5)]) {

			difference() {

				union() {
					// Big Cylinder
					rotate([90,0,90]) {
						cylinder(h = armWidth, d = armHeight, $fn = 80, center=true);
					}
					// Arm Nub
					translate([-nubOffset, 0, 0]) {
						rotate([90,0,-90]) {
						cylinder(h = armNub, d1 = armHeight, d2 = (armHeight - 2), $fn = 80, center = true);
						}
					}
					// Arm Nub
					translate([nubOffset, 0, 0]) {
						rotate([90,0,90]) {
						cylinder(h = armNub, d1 = armHeight, d2 = (armHeight - 2), $fn = 80, center = true);
						}
					}
				}
	
				// M3 Holes
				rotate([90,0,90]) {
					cylinder(d = 3.1, h = (armWidth + (armNub * 2) + 1), $fn = 60, center = true);
				}
			}
		}
	}
}


effector();

