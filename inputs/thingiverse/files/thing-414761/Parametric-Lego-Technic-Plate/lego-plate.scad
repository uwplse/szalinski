// Number of columns of holes
columns = 8; // [2:40]
// Number of rows of holes
rows = 5; // [2:40]
// Stagger rows
_staggered = 0; // [0:No, 1:Yes]

/* [Hidden] */
staggered = _staggered == 1;

$fn = 100;

hole_diameter = 5.4	;
thickness = 1;
spacing = 8 - hole_diameter;
y_spacing = staggered ? sqrt(spacing * spacing / 2) : spacing;

corner_radius = 1.5;
corner_crosses = false;

module rounded_rectangle(size, radius) {
	hull() {
		translate([-(size[0] / 2 - radius), -(size[1] / 2 - radius)])
			circle(radius);
		translate([ (size[0] / 2 - radius), -(size[1] / 2 - radius)])
			circle(radius);
		translate([ (size[0] / 2 - radius),  (size[1] / 2 - radius)])
			circle(radius);
		translate([-(size[0] / 2 - radius),  (size[1] / 2 - radius)])
			circle(radius);
	}
}

module base_plate() {
	soff = staggered ? spacing / 2 : 0;
	size = [spacing + columns * (spacing + hole_diameter) + soff, y_spacing + rows * (y_spacing + hole_diameter)];
	translate([size[0] / 2 - soff / 2, size[1] / 2])
		rounded_rectangle(size, corner_radius);
}

module holes() {
	for(y = [1 : rows])
		translate([staggered ? (y % 2 == 0 ? 1 : -1) * (spacing + hole_diameter) / 4 : 0, (y_spacing + hole_diameter) * y - hole_diameter / 2])
			for(x = [1 : columns])
				translate([(spacing + hole_diameter) * x - hole_diameter / 2, 0])
					circle(d=hole_diameter, false);
}

linear_extrude(thickness)
	difference() {
		base_plate();
		holes();
	}