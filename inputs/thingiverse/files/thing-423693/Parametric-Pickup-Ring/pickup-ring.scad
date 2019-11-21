//Total pickup ring width in millimeters.
total_width = 90;
//Total pickup ring height in millimeters.
total_height = 46;
//Millimeters to shave off the top edge; useful for neck pickups close to the fretboard.
_top_offset = 0;

// Strandberg pickup rings are 20mm wider than PRS

/* [Hidden] */

$fn = 100;

width_offset = total_width - 90;
height_offset = total_height - 46;

top_offset = -_top_offset;

inner_width = 72 + width_offset;
inner_height = 40 + height_offset;
outer_width = 90 + width_offset;
outer_height = 46 + height_offset;

body_screw_head = 4;
body_screw_shaft = 2;
pickup_screw_head = 5.5;
pickup_screw_shaft = 2.5;
countersink = 1;

body_screw_xdist = 82 + width_offset;
body_screw_ydist = 37;
pickup_screw_dist = 79 + width_offset;

thickness = 4;
inner_thickness = 2;
wall_width = 2;

outer_radius = 4;
inner_radius = 2;

hollow = false;

module rounded_rectangle(size, radius) {
	hull() {
		translate([-(size[0] / 2 - radius), -(size[1] / 2 - radius)])
			circle(radius);
		translate([ (size[0] / 2 - radius), -(size[1] / 2 - radius)])
			circle(radius);
		translate([ (size[0] / 2 - radius),  (size[1] / 2 - radius)])
			circle(radius);
		translate([-(size[0] / 2 - radius),  (size[1] / 2 - radius)])
			circle(radius);
	}
}

module base() {
	difference() {
		linear_extrude(thickness) {
			difference() {
				translate([0, top_offset / 2])
					rounded_rectangle([outer_width, outer_height + top_offset], outer_radius);
				rounded_rectangle([inner_width, inner_height], inner_radius);
			}
		}
		if(hollow)
			translate([0, 0, -(thickness - inner_thickness)])
				linear_extrude((thickness - inner_thickness) * 2)
					rounded_rectangle([outer_width - wall_width, outer_height - wall_width], outer_radius);
	}
}

module screw(head, shaft, x, y) {
	translate([x, y, thickness/2])
		cylinder(thickness*2, shaft / 2, shaft / 2, true);
	translate([x, y, thickness])
		cylinder(countersink*2, head / 2, head / 2, true);
}

module screws() {
	screw(body_screw_head, body_screw_shaft, -(body_screw_xdist / 2), -(body_screw_ydist / 2));
	screw(body_screw_head, body_screw_shaft,  (body_screw_xdist / 2), -(body_screw_ydist / 2));
	screw(body_screw_head, body_screw_shaft,  (body_screw_xdist / 2),  (body_screw_ydist / 2));
	screw(body_screw_head, body_screw_shaft, -(body_screw_xdist / 2),  (body_screw_ydist / 2));
	screw(pickup_screw_head, pickup_screw_shaft, -(pickup_screw_dist / 2),  0);
	screw(pickup_screw_head, pickup_screw_shaft,  (pickup_screw_dist / 2),  0);
}

difference() {
	base();
	screws();
}
