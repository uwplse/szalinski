// twisted cage

// overall height of basket
height=70; // [10:400]

// radius of basket
radius=40;  // [10:200]

// thickness of base and spokes
th=2;

// amount of twist from bottom to top of basket
an1=120;  // [0:180]

// number of clockwise spokes
nsp=13; // [0:50]

// number of counterclockwise spokes
csp=21; // [0:50]

module spoke(an1) {
		hull() {
//union() {
			translate([radius, -th / 2, 0])
				cube(th);
			rotate([0, 0, an1])
				translate([radius, -th / 2, height])
					cube(th);
		}
}

$fs = 0.5;
$fa = 3;

for (i=[1:nsp]) {
	rotate([0, 0, i * (360 / nsp)])
		spoke(-an1);
}

for (i=[1:csp]) {
	rotate([0, 0, i * (360 / csp)])
		spoke(an1);
}

/* base */
cylinder(h = th, r = radius + th);

/* top ring */
translate([0, 0, height])
	difference() {
		cylinder(h = th, r = radius + th);
		translate([0, 0, -0.0001])
			cylinder(h = th + 0.0002, r = radius);
	}

// eof
