Length = 30; // [1:50]

Width = 10; // [1:50] 

// ignore this variable!
Height = 0.1 * 1;

// Steepness?
Angle = 15; // [1:20]

module shim() {
hull() {
	translate([0, 0, 0])
	rotate([0, -Angle, 0])
	cube([Length, Width, Height]);
	cube([Length, Width, Height]);
	}
}

shim();