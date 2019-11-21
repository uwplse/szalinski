$fn = 200;

ht = 70;
wall = 5;
id = 81;

od = id + (2 * wall);

module hole(x, y)
{
	translate([x, y, -1])
		cylinder(r = 5, h = wall + 2);
}

difference() {
	union() {
		cylinder(d = od, h = ht);
		rotate([0, -4, 0]) translate([-od/2, -(od - 30)/2, 7]) {
			minkowski() {
				cube ([4 * wall, od - 30, ht + 50]);
				rotate([0, 90, 0])
					cylinder(r=5, h=1);
			}
		}
	}
	translate([0, 0, wall])
		cylinder(d = id, h = ht + 50 + wall + 1);

	// bottom holes
	hole(0, 0);
	hole(0, 17);
	hole(0, 35);
	hole(0, -17);
	hole(0, -35);
	hole(17, 0);
	hole(35, 0);
	hole(-17, 0);
	hole(-35, 0);
	hole(20, 20);
	hole(20, -20);
	hole(-20, 20);
	hole(-20, -20);

	// hanging holes
	translate([-od/2 - 10, 0, ht + 40])
		rotate([0, 90, 0])
			cylinder(r = 3, h = 2 * wall + 20);
	translate([-od/2 - 10, 20, ht + 40])
		rotate([0, 90, 0])
			cylinder(r = 3, h = 2 * wall + 20);
	translate([-od/2 - 10, -20, ht + 40])
		rotate([0, 90, 0])
			cylinder(r = 3, h = 2 * wall + 20);

	// flatten base
	translate([-50, -50, -10])
		cube([100, 100, 10]);
}

