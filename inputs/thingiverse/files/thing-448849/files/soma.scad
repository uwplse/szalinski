/* soma puzzle */

// base component cubes size
size=15;

// size of gap lines between cubes
gap= 0.4;

// depth of gaps
gd = 1.5;

// space between main parts for printing
sp = 3;

module part0() { /* base cube */
	translate([gap / 2, gap / 2, gap / 2])
		cube(size - gap);
}

module part05() { /* cube with a connector on one side */
	part0();
	translate([-gap * 0.5005, gap / 2 + gd, gap / 2 + gd])
		cube([gap * 1.001, size - gap - 2 * gd, size - gap - 2 * gd]);
}

module part1() { /* basic 3 cube part as base for all parts */
	part0();
	translate([size, 0, 0])
		part05();
	translate([size, size, 0])
		rotate([0, 0, 90])
			part05();
}

	/* part r */
	part1();

	/* part y */
	translate([2 * size + sp, 2 * size + sp, 0])
	rotate([0, 0, -90])
	{
		part1();
		rotate([0, 0, -90])
			part05();
	}

	/* part Z */
	translate([3 * size + 2 * sp, size, 0])
	rotate([0, 0, -90])
	{
		part1();
		translate([size, 0, 0])
			rotate([0, 0, -90])
				part05();
	}

	/* part left */
	translate([2 * size + sp, -(3 * size +2 * sp), 0])
	rotate([0, 0, 90])
	{
		part1();
		rotate([0, -90, 0])
			translate([size, 0, -2 * size])
				part05();
	}

	/* part right */
	translate([0, -sp, 0])
	rotate([0, 0, -90])
	{
		part1();
		rotate([0, -90, 0])
			translate([size, size, -size])
				part05();
	}

	/* part Y */
	translate([2 * size + 2 * sp, -(size + sp), 0])
	rotate([0, 0, -90])
	{
		part1();
		rotate([0, -90, 0])
			translate([size, 0, -size])
				part05();
	}

	/* part L */
	translate([5 * size + 3 * sp, -(3 * size + 2 * sp), 0])
	rotate([0, 0, 90])
	{
		part1();
		translate([2 * size, 0, 0])
			part05();
	}

/* eof */
