$fn = 32 * 1;

// width in mm
boom = 10.2;

boom_shape = 0;	// [0:square, 1:circular]

thickness = 3 * 1;
motor_r = 27.6 / 2;
motor_hole_r = 3 / 2;	// M3
motor_hole_dist_1 = 19 * 1;	// 3/4"?
motor_hole_dist_2 = 15.9 * 1;		// 5/8"?

rotate([ 0, 180, 0 ])
motor_mount_old();

module motor_mount_old()
{
	side = boom + 2 * thickness;

	// Motor mounting plate
	difference()
	{
		hull()
		{
			cylinder(r = motor_r, h = thickness);

			translate([-side / 2, motor_r, -thickness])
			cube([side, 5, thickness * 2]);
		}

		rotate([90, 0, 0])
		motor_mount_holes();
	}

	difference()
	{
		hull()
		{
			translate([-side / 2, motor_r + 5, -side + thickness])
			cube([side, 20, side]);
	
			translate([-side / 2, motor_r, -thickness])
			cube([side, 5, thickness * 2]);
		}

		// Hole for boom
		if (boom_shape == 0)
		{
			translate([-boom / 2, motor_r + 5, thickness - (side - boom) / 2 - boom])
			cube([boom, 25, boom]);
		}
		else
		{
			translate([0, motor_r + 5, thickness - (side - boom) / 2 - boom / 2])
			rotate([-90, 0, 0 ])
			cylinder(h = 25, r = boom / 2);
		}

		// Hole for arm screw
		translate([-side / 2 - 0.01, motor_r + 20, -boom / 2])
		rotate([90, 0, 90])
		cylinder(h = side + 0.02, r = 3.1 / 2);
	}
}

module motor_mount_holes()
{
	screw_cap_r = 4.75 / 2;
	spacer_r = 8 / 2;

	// Left
	translate([-motor_hole_dist_1 / 2, thickness + 0.01, 0])
	rotate([90, 0, 0])
	cylinder(h = thickness + 0.02, r = motor_hole_r * 1.1);

	translate([-motor_hole_dist_1 / 2, 1.01, 0])
	rotate([90, 0, 0])
	cylinder(h = 1.02, r1 = motor_hole_r * 1.1, r2 = screw_cap_r * 1.1);

	translate([-motor_hole_dist_1 / 2, 0, 0])
	rotate([90, 0, 0])
	cylinder(h = 5, r = screw_cap_r * 1.2);

	// Right
	translate([motor_hole_dist_1 / 2, thickness + 0.01, 0])
	rotate([90, 0, 0])
	cylinder(h = thickness + 0.02, r = motor_hole_r * 1.1);

	translate([motor_hole_dist_1 / 2, 1.01, 0])
	rotate([90, 0, 0])
	cylinder(h = 1.02, r1 = motor_hole_r * 1.1, r2 = screw_cap_r * 1.1);

	translate([motor_hole_dist_1 / 2, 0, 0])
	rotate([90, 0, 0])
	cylinder(h = 5, r = screw_cap_r * 1.2);

	// Bottom
	translate([0, thickness + 0.01, -motor_hole_dist_2 / 2])
	rotate([90, 0, 0])
	cylinder(h = thickness + 0.02, r = motor_hole_r * 1.1);

	translate([0, 1.01, -motor_hole_dist_2 / 2])
	rotate([90, 0, 0])
	cylinder(h = 1.02, r1 = motor_hole_r * 1.1, r2 = screw_cap_r * 1.1);

	translate([0, 0, -motor_hole_dist_2 / 2])
	rotate([90, 0, 0])
	cylinder(h = 5, r = screw_cap_r * 1.2);

	// Top
	translate([0, thickness + 0.01, motor_hole_dist_2 / 2])
	rotate([90, 0, 0])
	cylinder(h = thickness + 0.02, r = motor_hole_r * 1.1);

	translate([0, 1.01, motor_hole_dist_2 / 2])
	rotate([90, 0, 0])
	cylinder(h = 1.02, r1 = motor_hole_r * 1.1, r2 = screw_cap_r * 1.1);

	translate([0, 0, motor_hole_dist_2 / 2])
	rotate([90, 0, 0])
	cylinder(h = 5, r = screw_cap_r * 1.2);

	// Hole for shaft
	translate([0, thickness + 0.01, 0])
	rotate([90, 0, 0])
	cylinder(h = thickness * 2, r = spacer_r);
}
