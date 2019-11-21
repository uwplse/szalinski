module servo_arm(body_r = 7.5/2, arm_r1 = 6.5/2, arm_r2 = 3.5/2, arm_len = 14, arm_thickness = 2.5, body_thickness = 7) {
	cylinder(r = body_r, h = body_thickness);
	
	linear_extrude(height = arm_thickness) {
		circle(r = arm_r1);
		translate([0,arm_len,0]) circle(r = arm_r2);
		polygon(points = [ [-arm_r1, 0], [arm_r1, 0], [arm_r2, arm_len], [-arm_r2, arm_len] ]);
	}
}

servo_arm();