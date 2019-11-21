/*
 * =====================================
 *   This is public Domain Code
 *   Contributed by: Gael Lafond
 *   12 March 2019
 * =====================================
 *
 * String puzzle with a celtic look.
 * Inspired from:
 *     Ring puzzle by Itai Nahshon
 *         https://www.thingiverse.com/thing:3311600
 *
 * Values are in millimetres.
 */

$fn = 50;

ring_width = 80;
ring_dia = 6;
ring_twist = 6; // degree
ring_bottom_cut_zoffset = 1.8;

base_width = 85;
base_thickness = 8;
base_filet_radius = 3;
base_hole_dia = 10;
base_rounded_corner_radius = 13;

bead_dia = 14;
bead_height = 14;
bead_filet_radius = 3.5;
bead_small_hole_dia = 4;
bead_big_hole_dia = 8;
bead_big_hole_depth = 9;


*celtic_ring_cut();
*celtic_ring();

*base();

*bead();


customizable();


module customizable() {
	translate([(base_width + ring_width) / 2 + 5, 0, 0]) {
		celtic_ring_cut();
	}

	base();

	translate([-(base_width + bead_dia) / 2 - 5, 0, 0]) {
		translate([0, bead_dia / 2 + 5, 0]) {
			bead();
		}
		translate([0, -bead_dia / 2 - 5, 0]) {
			bead();
		}
	}
}


module bead() {
	difference() {
		union() {
			// Filet bead
			cylinder(
				h = bead_height,
				d = bead_dia - bead_filet_radius*2,
				center = true
			);
			cylinder(
				h = bead_height - bead_filet_radius*2,
				d = bead_dia,
				center = true
			);
			// Filet
			for (zOffset = [-1, 1]) {
				translate([0, 0, zOffset * (bead_height/2 - bead_filet_radius)]) {
					rotate_extrude() {
						translate([bead_dia/2 - bead_filet_radius, 0]) {
							difference() {
								circle(r = bead_filet_radius);
								translate([-bead_filet_radius/2, 0]) {
									square([bead_filet_radius, bead_filet_radius*2], center = true);
								}
							}
						}
					}
				}
			}
		}

		// Bead hole
		cylinder(d = bead_small_hole_dia, h = bead_height + 0.1, center = true);

		translate([0, 0, bead_height/2 - bead_big_hole_depth]) {
			cylinder(d = bead_big_hole_dia, h = bead_big_hole_depth + 0.1);
		}
	}
}

module celtic_ring_cut() {
	difference() {
		celtic_ring();
		translate([0, 0, -(ring_width/2 + ring_bottom_cut_zoffset)]) {
			cube([ring_width, ring_width, ring_width], center = true);
		}
	}
}

module celtic_ring() {
	ring_curve_dia = (ring_width - ring_dia)/3;

	for (side = [0, 90, 180, 270]) {
		rotate([0, 0, side]) {
			rotate([0, ring_twist, 0]) {
				translate([0, -ring_curve_dia, 0]) {
					rotate_extrude(angle = 180) {
						translate([-ring_curve_dia/2, 0]) {
							circle(d = ring_dia);
						}
					}
				}
			}

			rotate([ring_twist/2, 0, 0]) {
				translate([cos(ring_twist) * ring_curve_dia/2, 0, 0]) {
					rotate([90, 0, 0]) {
						cylinder(d = ring_dia, h = ring_curve_dia*2, center = true);
						// Rounded end for better fit with the half ring
						translate([0, 0, ring_curve_dia]) {
							sphere(d = ring_dia);
						}
						translate([0, 0, -ring_curve_dia]) {
							sphere(d = ring_dia);
						}
					}
				}
			}
		}
	}
}

module ring() {
	ring_curve_dia = (ring_width - ring_dia)/3;

	for (side = [0, 90, 180, 270]) {
		rotate([0, 0, side]) {
			translate([0, -ring_curve_dia, 0]) {
				rotate_extrude(angle = 180) {
					translate([-ring_curve_dia/2, 0]) {
						circle(d = ring_dia);
					}
				}
			}

			translate([ring_curve_dia/2, 0, 0]) {
				rotate([90, 0, 0]) {
					cylinder(d = ring_dia, h = ring_curve_dia*2, center = true);
				}
			}
		}
	}
}

// Ugly workaround to avoid using Minkowski sum (see bellow)
module base() {
	_base_filet_radius = base_filet_radius * 2 > base_thickness ? base_thickness / 2 : base_filet_radius;
	_base_filet_space = base_thickness - 2 * base_filet_radius;
	_base_hole_dia = base_hole_dia + _base_filet_radius * 2;

	difference() {
		// Filet base without hole
		union() {
			// Base without filet
			cube([
				base_width - base_rounded_corner_radius*2,
				base_width - _base_filet_radius*2,
				base_thickness
			], center = true);
			cube([
				base_width - _base_filet_radius*2,
				base_width - base_rounded_corner_radius*2,
				base_thickness
			], center = true);

			// Fill the space between the top and bottom parts
			if (_base_filet_space > 0) {
				cube([
					base_width - base_rounded_corner_radius*2,
					base_width,
					_base_filet_space
				], center = true);
				cube([
					base_width,
					base_width - base_rounded_corner_radius*2,
					_base_filet_space
				], center = true);
				// rounded edges
				for (xOffset = [1, -1], yOffset = [1, -1]) {
					translate([
						xOffset * (base_width/2 - base_rounded_corner_radius),
						yOffset * (base_width/2 - base_rounded_corner_radius),
						0
					]) {
						cylinder(
							r = base_rounded_corner_radius,
							h = _base_filet_space,
							center = true
						);
					}
				}
			}

			// Rounded corner
			for (xOffset = [1, -1], yOffset = [1, -1], zOffset = [1, -1]) {
				translate([
					xOffset * (base_width/2 - base_rounded_corner_radius),
					yOffset * (base_width/2 - base_rounded_corner_radius),
					zOffset * (_base_filet_space/2)
				]) {
					// Torus
					rotate_extrude() {
						translate([base_rounded_corner_radius - _base_filet_radius, 0]) {
							circle(r = _base_filet_radius);
						}
						translate([0, -_base_filet_radius]) {
							square([base_rounded_corner_radius - _base_filet_radius, _base_filet_radius*2]);
						}
					}
				}
			}

			// Rounded edges (along Y)
			for (xOffset = [1, -1], zOffset = [1, -1]) {
				translate([
					xOffset * (base_width/2 - _base_filet_radius),
					0,
					zOffset * (_base_filet_space/2)
				]) {
					rotate([90, 0, 0]) {
						cylinder(
							r = _base_filet_radius,
							h = base_width - base_rounded_corner_radius*2,
							center = true
						);
					}
				}
			}

			// Rounded edges (along X)
			for (yOffset = [1, -1], zOffset = [1, -1]) {
				translate([
					0,
					yOffset * (base_width/2 - _base_filet_radius),
					zOffset * (_base_filet_space/2)
				]) {
					rotate([0, 90, 0]) {
						cylinder(
							r = _base_filet_radius,
							h = base_width - base_rounded_corner_radius*2,
							center = true
						);
					}
				}
			}
		}

		// Holes
		_base_hole_offset = (base_width - _base_filet_radius*2 - _base_hole_dia - 2) / 2;
		for (side = [0, 90, 180, 270]) {
			rotate([0, 0, side]) {
				// corner holes
				translate([_base_hole_offset, _base_hole_offset]) {
					base_hole();
				}
				// center holes
				translate([0, _base_hole_offset]) {
					base_hole();
				}
			}
		}
	}

	module base_hole() {
		difference() {
			cylinder(d = _base_hole_dia, h = base_thickness + 0.1, center = true);

			for (zOffset = [1, -1]) {
				translate([0, 0, zOffset * _base_filet_space/2]) {
					rotate_extrude() {
						translate([_base_hole_dia/2, 0]) {
							circle(r = _base_filet_radius);
						}
					}
				}
			}

			rotate_extrude() {
				translate([_base_hole_dia/2, 0]) {
					square([_base_filet_radius*2, _base_filet_space], center = true);
				}
			}
		}
	}
}


// This is a neat way to create the base but it takes FOREVER to compute.
// Minkowski generate CSG even for preview. That's why it's so slow...
// Damned Minkowski sum...
module base_minkowski() {
	_base_filet_radius = base_filet_radius * 2 >= base_thickness ? base_thickness / 2 - 0.1 : base_filet_radius;
	_base_width = base_width - _base_filet_radius * 2;
	_base_thickness = base_thickness - _base_filet_radius * 2;
	_base_hole_dia = base_hole_dia + _base_filet_radius * 2;

	_base_hole_offset = (_base_width - _base_hole_dia - 2) / 2;

	minkowski() {
		linear_extrude(_base_thickness) {
			difference() {
				square([_base_width, _base_width], center = true);

				for (side = [0, 90, 180, 270]) {
					rotate([0, 0, side]) {
						// corner holes
						translate([_base_hole_offset, _base_hole_offset]) {
							circle(d = _base_hole_dia);
						}
						// center holes
						translate([0, _base_hole_offset]) {
							circle(d = _base_hole_dia);
						}
					}
				}
			}
		}
		sphere(r = _base_filet_radius);
	}
}
