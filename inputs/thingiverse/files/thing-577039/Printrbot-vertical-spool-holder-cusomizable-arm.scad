//Height of the tower below the spindle
arm_height = 40;

//Length of the spindle
arm_length = 90;

module tcube(x, y, z, tx = 0, ty = 0, tz = 0) {
	translate([tx, ty, tz]) {
		cube([x, y, z]);
	}
}

module tcyl(r, h, tx = 0, ty = 0, tz = 0, center = false, $fn = $fn) {
	translate([tx, ty, tz]) {
		cylinder(r = r, h = h, center = center, $fn = $fn);
	}
}

module ccube(x, y, z, ty = 0, tz = 0) {
	tcube(x, y, z, -x / 2, ty, tz);
}

module spool_arm() {
	$fn =25;

	//fit of 2 pieces
	clearance = .5;

	hole_x = 15;
	hole_y = 25;
	arm_offset = 10;
	lip_x = 5;
	lip_y = 7;

	module arm() {
		thickness = hole_y - clearance;
		bar = hole_x - clearance;
		spindle_length = bar + arm_length + arm_offset + lip_x;
		spindle_depth = thickness;
		height = arm_height + spindle_depth;
		brace_r = bar + lip_y;
		t2 = thickness + 2;

		module L() {
			difference() {
				tcube(spindle_length, height, thickness);

				hull() {
					tcube(1, 1, t2, spindle_length, height - spindle_depth - 1, -1);
					tcube(1, 1, t2, spindle_length, -1, -1);
					tcube(1, 1, t2, bar, -1, -1);
					tcyl(brace_r, t2, bar + brace_r, height - spindle_depth - brace_r, -1);
				}

				tcube(bar + 1, bar + 1, t2, spindle_length - bar, height - spindle_depth - 1, -1);
			}
			tcyl(bar, thickness, spindle_length - bar, height - spindle_depth + bar);
		}

		module ring() {
			lip_r = height;
			spindle_r = thickness * .66;
			$fn = 100;
			ty = height - spindle_r - lip_y;

			tcyl(lip_r, bar + arm_offset, $fn = $fn);
			tcyl(spindle_r, spindle_length, ty = ty, $fn = 20);
			ccube(2 * spindle_r, ty, spindle_length );
			tcyl(lip_r, lip_x, tz = spindle_length - lip_x, $fn = $fn);
		}

		intersection() {
	
			translate([0, 0, thickness / 2]) {
				rotate([0, 90, 0]) {
					ring();
				}
			}

			L();
		}

	}

	arm();

}

spool_arm();
