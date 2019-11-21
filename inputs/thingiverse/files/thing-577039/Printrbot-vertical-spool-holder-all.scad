$fn = 25;

// Radius of Z-rods (adjust fit here)
R=6.25;

// Path width of single trace of plastic
w1=.4;

// Distance between Z-rods (center to center)
rods = 70;

//fit of 2 pieces
clearance = .5;

hole_x = 15;
hole_y = 25;
base_cap = 16;
arm_length = 90;
arm_height = 40;
arm_offset = 10;
lip_x = 5;
lip_y = 7;
hole_rim = 3;
slant = 3;
floor = 5;
rise = 7;

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

module spool_holder(piece = "all") {

	center_r = R;
	h = base_cap;
	wall = w1 * 4;
	xr = center_r / 4;
	xbc = center_r + wall + xr;
	outer_r = xbc + xr + wall;

	module rodtop(xtz) {
	
		tcyl(center_r, h - 1, tz = -1);

	}

	module span() {
		difference() {
			hull() {
				tcyl(outer_r, h);
				tcyl(outer_r, h, ty = rods);
			}

			rodtop();

			translate([0, rods, 0]) {
				rodtop();
			}
		}
	}

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

	module base() {
		w = 2 * outer_r;
		yy = hole_y + 2 * rise;

		module fillet(ty = 0) {
			translate([0, ty, rise + h]) {
				rotate([0, 90, 0]) {
					cylinder(r = rise, h = w + 2, center = true, $fn = 40);
				}
			}
		}

		difference() {
			union() {
				translate([0, -rods / 2, 0]) {
					span();
				}
				difference() {
					ccube(w, yy + 2 * hole_rim, h - floor + rise, -yy / 2 - hole_rim, floor);
					fillet(yy / 2 + hole_rim);
					fillet(-yy / 2 - hole_rim);
				}
			}
			rotate([0, slant, 0]) {
				ccube(hole_x, hole_y, h + rise + 1, -hole_y / 2, floor);
			}
		}

	}

	if (piece == "all") {
		rotate([0, 0, 90]) {
			base();
		}

		translate([-80, -10, 0]) {
			arm();
		}
	}

	if (piece == "arm") {
		arm();
	}

	if (piece == "base") {
		base();
	}

}

spool_holder();
