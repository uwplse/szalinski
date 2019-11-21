height = 150;
width = 120;
baseDepth = 20;
topDepth = 7;
wallThickness = 4;
rodDiameter = 8;
rodRadius = (rodDiameter+0.5)/2; // extra .5mm for clearance
cornerRadius = rodDiameter;

module triangle() {
	hull() {
		translate([0, height/2-cornerRadius, 0]) {
			circle(cornerRadius);
		}
		translate([-width/2+cornerRadius, -height/2+cornerRadius, 0]) {
			circle(cornerRadius);
		}
		translate([width/2-cornerRadius, -height/2+cornerRadius, 0]) {
			circle(cornerRadius);
		}
	}
}

difference() {
	union() {
		difference() {
			linear_extrude(baseDepth) {
				triangle();
			}
			translate([0, 0, -1]) {
				linear_extrude(baseDepth+2) {
					offset(-wallThickness) {
						triangle();
					}
				}
			}
		}

		// rod surrounding
		translate([0, height/2-cornerRadius, 0]) {
			cylinder(baseDepth, cornerRadius, cornerRadius);
		}
	}

	// rod hole
	translate([0, height/2-cornerRadius, -1]) {
		cylinder(baseDepth+2, rodRadius, rodRadius);
	}

	translate([-width/2, -height/2, baseDepth]) {
		rotate([-atan((baseDepth-topDepth)/(height-cornerRadius*2)), 0, 0]) {
			cube([width, sqrt(pow(baseDepth-topDepth, 2) + pow(height-cornerRadius*2, 2)), baseDepth]);
		}
	}
	translate([-cornerRadius*2, height/2-cornerRadius*2, topDepth]) {
		cube([cornerRadius*4, cornerRadius*2, baseDepth]);
	}
}
