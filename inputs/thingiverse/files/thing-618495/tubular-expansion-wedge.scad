
//Diameter of the wedge, make this slightly smaller than the inner diameter of your tube.
outer_diameter = 20; 

//Diameter of the bolt hole, make this slightly larger than the diameter of your bolt.
core_diameter = 10; 

//Diameter of the nut socket, make this slightly larger than the nut measured point to point (not the flats). 
nut_diameter = 17.5;

/* [Hidden] */

flare_angle = 7;
nut_seat = 1.5;

outer_radius = outer_diameter / 2;
core_radius = core_diameter / 2;
nut_radius = nut_diameter / 2;
center_height = outer_radius + nut_diameter / 2;
double_height = center_height * 2;

module wedge(has_nut) {

	module flared_cyl() {
	
		module cyl(height) {
			translate([0, 0, -center_height]) {
				cylinder(r = core_radius, h = height, center = true);
			}
		}

		translate([0, 0, center_height]) {
			hull() {
				cyl(double_height);
				rotate([0, -flare_angle, 0]) {
					cyl(double_height + outer_radius);
				}
			}
		}
	}

	intersection() {
		translate([-double_height, -outer_radius, 0]) {
			cube([2 * double_height, outer_diameter, double_height]);
		}
		rotate([0, 45, 0]) {
			difference() {
				cylinder(r = outer_radius, h = double_height, center = true);
				flared_cyl();

				if (has_nut) {
					translate([0, 0, outer_radius + nut_seat]) {
						nut();
					}
				}

			}
		}
	}
}

module nut() {
	rotate([0, 0, 30]) {
		cylinder(r = nut_radius, h = center_height, $fn = 6, center = false);
	}
}

module main() {
	rotate([0, 0, -90]) {
		translate([0, outer_diameter + 2, 0]) {
			wedge(false);
		}

		wedge(true);
	}
}

if (core_diameter >= outer_diameter) {
	echo("core diameter must be less than outer diameter.");
} else if (nut_diameter >= outer_diameter) {
	echo("nut diameter must be less than outer diameter.");
} else if (core_diameter >= nut_diameter) {
	echo("core diameter must be less than nut diameter.");
} else {
	main();
}

