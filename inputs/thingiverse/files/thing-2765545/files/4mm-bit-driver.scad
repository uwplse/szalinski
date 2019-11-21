/* ============================================================
	Configuration
============================================================ */

// bit size in mm
bit_size = 4; // [2:1:10]

// Magnet Diameter
magnet_diameter = 4; // [2:1:10]

// Magnet Height
magnet_height = 2; // [2:1:8]

/* ============================================================
	Code
============================================================ */

hex_diameter = bit_size * 1.154701 + 0.2;

// handle
difference () {
	
	translate () {
		// handle top
		translate([0,0,100]) sphere(d=20, $fn=48);

		// handle body
		translate([0,0,30]) cylinder(d=20, h=70, $fn=48);
		translate([0,0,15]) cylinder(d1=hex_diameter * 1.7, d2=20, h=15, $fn=48);
	}
	
	// grip slots
	for (i = [0 : 1 : 8]) {
		rotate( i * 360 / 8, [0, 0, 1]) {
			translate ([11,0,-20]) {
				translate([0,0,30]) cylinder(d=5, h=100, $fn=48);
			}
		}
	}
}

// shaft for the bit including hole for magnet
difference () {
	cylinder (h=15, d=hex_diameter * 1.7, $fn=48);
	translate([0,0,10]) cylinder(d=magnet_diameter+0.1, h=magnet_height, $fn=32);
	cylinder(d=hex_diameter, h=10, $fn=6);
}
