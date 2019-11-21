// parameters
base_len = 70;
base_width = 26;
hook_height = 40;
hook_ledge = 10;
thickness = 6;

$fn = 30;
hull_r = 1;
hull_h = 1;
wall = thickness - (2 * hull_r);
ledge = hook_ledge;

xx = base_len - (2 * hull_r);
yy = hook_height - (2 * hull_r);
zz = base_width - hull_h;

translate([hull_r, hull_r, 0]) {
	minkowski() {
		difference() {
			cube([xx, yy, zz]);
			translate([(xx +  wall)/2, wall, -1])
				cube([(xx - wall)/2, (yy - wall) + 1, zz + 2]);
			translate([wall, wall, - 1])
				cube([xx/2 - (3 * wall)/2, yy - (2 * wall), zz + 2]);
			translate([-1, wall, - 1])
				cube([wall + 2, yy - wall - ledge, zz + 2]);
		}
		cylinder(r = hull_r, h = 1);
	}
}

translate([xx/2 - wall/2 - 1, (1.5 * wall), 0])
	rotate([0, 0, -45])
		cylinder(r = 5, h = zz + hull_h, $fn = 3);

translate([xx/2 + wall + 1, (1.5 * wall), 0])
	rotate([0, 0, -15])
		cylinder(r = 5, h = zz + hull_h, $fn = 3);