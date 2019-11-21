//CUSTOMIZER VARIABLES

height = 100; // [50:200]
depth = 50; // [25:75]
dslot = 40; // [20:80]
fslot = 60; // [20:80]

//CUSTOMIZER VARIABLES END

$fn = 200;

width = height * 2;
radius = width / 2;

difference() {
	rotate(a = 90, v = [1, 0, 0])
		linear_extrude(depth)
			intersection() {
				square([width, height], true);
				translate([0, radius / 2])
					circle(radius);
			}
	translate([-width, -depth / 2, height / 2])
		rotate(a = 90, v = [0, 1, 0])
			linear_extrude(width * 4)
					circle(dslot / 2);
	rotate(a = 90, v = [1, 0, 0])
		translate([0, 0, -depth / 2])
			linear_extrude(depth * 2)
				translate([0, height / 2])
					circle(fslot / 2);
}
