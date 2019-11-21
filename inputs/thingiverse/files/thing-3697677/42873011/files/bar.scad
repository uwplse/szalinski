
// Number of holes
holes=3; // [2, 3, 4, 5, 6]

/* [Hidden] */

// Bar thickness
thickness=9.7;

// Bar width.
width=37.5;

// Rounded edges.
edge_round=4;

// Hole diameter.
hole_diameter=16;

// Distance between the holes.
hole_distance=40;

$fn=64;

difference() {
	// Create the bar.
	minkowski() {
		linear_extrude(height=thickness-edge_round,center=true)
			hull() {
				circle(d=width-edge_round);
				translate([(holes-1)*hole_distance,0,0])
					circle(d=width-edge_round);
			}
		// Minkowski with sphere gives the nicely rounded edges.
		sphere(d=edge_round,$fn=16);
	}

	// Cut holes.
	for (i=[0:holes-1]) {
		translate([i*hole_distance,0,0])
			cylinder(d=hole_diameter,h=thickness,center=true);
	}
}
