pipe_diameter=50; // [30, 40, 50, 60, 70]
rotated_mount=1; // [0, 1]

module mounting_holes() {
	dist = 61.5;

	// d=4 is too large, need something to hold or nuts
	translate([dist/2, 0, 0]) children();
	translate([0, dist/2, 0]) children();
	translate([-dist/2, 0, 0]) children();

	translate([0, -dist/2, 0]) children();
}

module wall_plate(pipe_diameter, do_rotate=1) {
	$fn=97;
	dist = 75;
	plate = 5;
	difference () {
		intersection() {
			cylinder(d1=dist, d2=dist-50, h=50, $fn=97);
		union() {
			cylinder(d=dist, h=plate, $fn=97);

			difference() {
				translate([0, 0, plate + 5])
				cube([40, 75, 10], center=true);
				translate([0, 0, 7 + pipe_diameter/2])
				rotate([90, 0, 0])
				cylinder(d=pipe_diameter, h=90, center=true);
			}
		}
		}

		translate([0, 0, plate + pipe_diameter/2])
		rotate([90,0,0])
		difference () {
			cylinder(d=pipe_diameter + 12, h=10, center=true);
			cylinder(d=pipe_diameter + 7, h=10, center=true);
		}

		rotate([0,0,45 * do_rotate])
		translate([0,0,-.1])
		mounting_holes() {
			cylinder(d=4.5, h=8, $fn=17);
			translate([0,0,plate-1])
			cylinder(d=8, h=5, $fn=6);
		}
	}

}


wall_plate(pipe_diameter, rotated_mount);

