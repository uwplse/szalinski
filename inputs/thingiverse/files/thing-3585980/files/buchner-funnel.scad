inner_diameter = 55;
hole_diameter = 1;
hole_spacing = 1;
plate_thickness = 1;
side_thickness = 1.5;
side_height = 30;
cone_height = 20;
pipe_id = 6;
pipe_od = 8;
pipe_len = 25;

$fs = 0.05;
$fa = 4;

module plate() {
	punched_radius = inner_diameter / 2 - hole_spacing * 2;
	linear_extrude(plate_thickness) difference() {
		circle(d = inner_diameter);
		circle(r = punched_radius);
	}
	difference() {
		cylinder(r = punched_radius, h = plate_thickness);
		hexaholes(punched_radius / sin(60));
	}
}

module hole() {
	cylinder(d = hole_diameter, h = plate_thickness + 1, $fa = 30);
}

module hexaholes(r) {
	if (r > 0) {
		num = floor(r / (hole_diameter + hole_spacing));
		if (num > 1) {
			for (angle = [0, 60, 120]) {
				center_distance = r * sin(60);
				rotate([0, 0, angle]) for (offset = [[-r / 2, center_distance], [-r / 2, -center_distance]]) {
					translate(offset) {
						for (dist = [0 : r / num : r]) {
							translate([dist, 0]) hole();
						}
					}
				}
			}
			hexaholes(r - hole_diameter - hole_spacing);
		}
		if (num == 1) {
			hole();
		}
	}
	
}

plate();
outer_diameter = inner_diameter + 2 * side_thickness;
linear_extrude(side_height) difference() {
	circle(d = outer_diameter);
	circle(d = inner_diameter);
}
rotate([180, 0, 0]) {
	difference() {
		cylinder(d1 = outer_diameter, d2 = pipe_od, h = cone_height);
		cylinder(d1 = inner_diameter, d2 = pipe_id, h = cone_height);
	}
	translate([0, 0, cone_height]) {
		difference() {
			linear_extrude(pipe_len) difference() {
				circle(d = pipe_od);
				circle(d = pipe_id);
			}
			translate([0, 0, pipe_len]) rotate([45, 0, 0]) cube([pipe_len, pipe_len, pipe_od], center = true);
		}
	}
}
