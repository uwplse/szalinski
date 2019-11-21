// meissner object
// based on tetrahedron

// size of object in ALL directions
size = 40;

m = 2 * sqrt(2);

$fn = 50;

scale(size / m)
	translate([0, 0, m / 2])
		intersection() {
			translate([1, 1, 1]) sphere(m);
			translate([1, -1, -1]) sphere(m);
			translate([-1, 1, -1]) sphere(m);
			translate([-1, -1, 1]) sphere(m);
		}

// eof
