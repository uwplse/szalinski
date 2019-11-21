inner_diameter = 55;
hole_diameter = 1.5;
hole_spacing = 1.5;
plate_thickness = 1;
side_thickness = 1.5;
side_height = 30;
cone_height = 10;
joint_diameter = 29;
joint_len = 25;
joint_offset = 10;

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
	cylinder(d = hole_diameter, h = plate_thickness + 1, $fn = 6);
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
	od1 = joint_diameter + joint_offset / 10;
	od2 = joint_diameter - joint_len / 10;
	id1 = od1 - side_thickness * 2;
	id2 = od2 - side_thickness * 2;
	difference() {
		cylinder(d1 = outer_diameter, d2 = od1, h = cone_height);
		cylinder(d1 = inner_diameter, d2 = id1, h = cone_height);
	}

	joint_total_len = joint_offset + joint_len;
	translate([0, 0, cone_height]) difference() {
		cylinder(d1 = od1, d2 = od2, h = joint_total_len);
		cylinder(d1 = id1, d2 = id2, h = joint_total_len);
	}
}
