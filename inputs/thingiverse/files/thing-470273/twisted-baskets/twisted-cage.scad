// twisted cage

// overall height of basket
height=70; // [10:200]

// radius of basket
radius=40;  // [10:100]

// thickness of base and spokes (tenths)
th=20;  // [1:50]

// amount of twist from top to bottom of basket
an1=120;  // [0:180]

// number of spokes
nsp=20; // [1:50]

// just twist clockwise or overlap twists both ways
twist = "clockwise"; // [clockwise, counterclockwise, both]

thickness = th / 10;

module spoke(ang, h, r) {
	x=r - cos(ang) * r;
	y=sin(ang) * r;
	h1=sqrt(x*x+y*y);
	h2=sqrt(x * x + y * y + h * h);
	a1=atan2(h1, h);
	a2=atan2(x, y);
	translate([r, 0, 0]) {
		if (twist == "clockwise") {
			rotate([0, 0, a2])
				rotate([-a1, 0, 0])
					cylinder(d=thickness, h=h2);
		}
		if (twist == "counterclockwise") {
			rotate([0, 0, -a2])
				rotate([a1, 0, 0])
					cylinder(d=thickness, h=h2);
		}
		if (twist == "both") {
			rotate([0, 0, a2])
				rotate([-a1, 0, 0])
					cylinder(d=thickness, h=h2);
			rotate([0, 0, -a2])
				rotate([a1, 0, 0])
					cylinder(d=thickness, h=h2);
		}
	}
}

for (i=[0:nsp-1]) {
	rotate([0, 0, i * (360/nsp)])
		spoke(an1, height, radius);
}

/* base */
translate([0, 0, -thickness/2])
	cylinder(h=thickness, r=radius + thickness);

/* top ring */
translate([0, 0, height - thickness / 2])
	difference() {
		cylinder(h=thickness, r=radius + thickness);
		translate([0, 0, -0.0001])
		cylinder(h=thickness + 0.0002, r=radius - thickness);
	}

// eof
