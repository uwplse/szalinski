/*
|--------------------------------------------------------------------------
| Hobby Paints Holder Customizer
|--------------------------------------------------------------------------
| This project was mainly for my Vallejo hobby paints,
| but It works with any cylindrical shape, of course
*/

// CUSTOMIZER VARIABLES

// The hole diameter
diameter = 24.5;
// How tall is the holder
height = 10;
// How thick is the holder
thickness = 1; // [1, 2, 3, 4]
rows = 2; // [1, 2, 3, 4, 5]
columns = 4; // [1, 2, 3, 4, 5]
// Cut the holder in angle?
cut = 1; // [0:no, 1:yes]]

// CUSTOMIZER VARIABLES END

// Adds an extra gap to the hole

tolerance = 0.4 * 1;
inner_radius = (diameter + tolerance) / 2;
outer_radius = inner_radius + thickness;
outer_diameter = outer_radius * 2;
holder_offset = outer_diameter - thickness;

module holder() {
	difference() {
		cylinder(h = height, r = outer_radius);
		// hole
		translate([0, 0, 1])
		cylinder(h = height, r = inner_radius);
		// base
		translate([0, 0, -0.5])
		cylinder(h = 2, r = inner_radius - 1);

		if (cut) {
			cube_height = height / 2;
			translate([-outer_radius, -outer_radius , cube_height])
			rotate([atan2(cube_height, outer_diameter), 0, 0])
			cube([outer_diameter, sqrt(pow(cube_height, 2) + pow(outer_diameter, 2)), cube_height]);
		}
	}
}

translate([outer_radius, outer_radius, 0])
for (m = [0:1:rows - 1])
	translate([0, m * holder_offset, 0])
	for (n = [0:1:columns - 1])
		translate([n * holder_offset, 0, 0])
		holder();
