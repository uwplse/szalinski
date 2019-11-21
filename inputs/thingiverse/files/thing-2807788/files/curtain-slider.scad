narrow_width = 3.25;
narrow_height = 2;
wide_width = 5.25;
wide_height = 2.6;
circle_radius = 3.5;
circle_offset = 1.5;
circle_thickness = 2.2;
$fs = 0.05;

rotate([90, 0, 0]) {
	translate([-narrow_width / 2, -wide_width / 2, narrow_height + circle_radius + circle_offset]) cube([narrow_width, wide_width, wide_height]);
	translate([-narrow_width / 2, -narrow_width / 2, circle_radius + circle_offset]) cube([narrow_width, narrow_width, narrow_height]);
	translate([-wide_width / 2, -wide_width / 2, circle_radius]) cube([wide_width, wide_width, circle_offset]);
	translate([0, -wide_width / 2 + circle_thickness / 2, 0]) rotate([90, 0, 0]) rotate_extrude() translate([circle_radius, 0, 0]) circle(d = circle_thickness);
}
