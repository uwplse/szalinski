//////////////////////////////////////////////////////
// This script generates a nozzle for an aquarium
// pump so that a hose can be connected.
//
// 2017 CC BY-SA by Alexander Fell
//
// version 1
//////////////////////////////////////////////////////


resolution=64;

difference() {
	union() {
		cylinder(h=40, r=7, $fn=resolution);
		stopper(2, 7, 8);
		stopper(9, 7, 8);
		stopper(16, 7, 8);
	}
	translate([0, 0, -0.1]) {
		cylinder(h=41, r=5, $fn=resolution);
	}
}

module stopper(z, ra, rb) {
	translate([0, 0, z]) {
		cylinder(h=10, r1=ra, r2=rb, $fn=resolution);
	}
}

