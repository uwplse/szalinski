//Get a rule and discover your finger width in milimeters! If it is 40, you chose another kind of finger...
FINGER_DIAMETER = 18; // [8:40]

$fn=100;

difference() {
	// Solid finger + nail
	union() {
		// Nail
		translate([0, -FINGER_DIAMETER/4, 2*FINGER_DIAMETER/3]) {
			rotate([90,0,0]) {
				difference() {
					translate([0,0,0]) {
						scale([0.9,1.4,1]) {
							sphere(r=FINGER_DIAMETER*0.8);
						}
					}
					translate([0,0,FINGER_DIAMETER/2.5]) {
						scale([0.9,1.4,1]) {
							sphere(r=FINGER_DIAMETER);
						}
					}
					translate([
						-FINGER_DIAMETER*(1-1/6),
						-FINGER_DIAMETER*(1-1/6)*2,
						-FINGER_DIAMETER/2
					]) {
						cube([100,100,100]);
					}
				}
			}
		}

		// Finger (cylinder)
		cylinder(r=FINGER_DIAMETER/2+1.5, h=FINGER_DIAMETER*0.7, center=true);

		// Round tip of the finger (sphere)
		translate([0, 0, FINGER_DIAMETER*0.7/2]) {
			sphere (r=FINGER_DIAMETER/2+1.5);
		}
	}

	// Making the finger hollow

	// Finger (inner cylinder)
	// (with small 0.02 clearance for OpenSCAD floating point issue with difference)
	translate(0, 0, -0.01) {
		cylinder(r=FINGER_DIAMETER/2, h=FINGER_DIAMETER*0.7 + 0.02, center=true);
	}

	// Round tip of the finger (inner sphere)
	translate([0, 0, FINGER_DIAMETER*0.7/2]) {
		sphere (r=FINGER_DIAMETER/2);
	}
}
