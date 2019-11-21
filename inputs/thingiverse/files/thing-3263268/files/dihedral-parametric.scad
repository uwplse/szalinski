// Diameter of the hole for the kite's spine
spine_hole_diameter = 9;
// Length of the "horizontal" section through which the spine goes
spine_length = 15;
// Diameter of the holes in the "arms"
arm_hole_diameter = 8.8;
// Minimum wall thickness (hole to outer edge)
wall_thickness = 2;
// Length of the "arms"
arm_length = 25.5;
// Depth of webbing between the arms (measured outwards from the "horizontal" section)
webbing_depth = 6;
// Thickness of the webbing
webbing_thickness = 2.5;

height = arm_hole_diameter + (wall_thickness * 2);
depth = max(arm_hole_diameter, spine_hole_diameter) + (wall_thickness * 2);
arm_offset_w = (((arm_length * sin(75)) - (depth * sin(15))) + spine_length) / 2;
arm_depth_extra = (((depth * sin(15)) / sin(75)) * sin(15)) / 2;
arm_offset_d = ((arm_length * sin(15)) - arm_depth_extra) / 2;
webbing_offset = (webbing_depth + depth) / 2;
webbing_flat_offset = webbing_offset + (webbing_depth / 2) - 0.25;
webbing_inseam = (arm_length * sin(75)) - (depth * sin(15));
webbing_length = webbing_inseam * 2 + spine_length;

echo(webbing_length);

// middle section
difference() {
	cube([spine_length, depth, height], center=true);
	cylinder(d=spine_hole_diameter, h=height, $fn=128, center=true);
}

// arms - 15deg angle
translate([arm_offset_w, arm_offset_d, 0]) rotate([0, 0, 15]) arm();
translate([-arm_offset_w, arm_offset_d, 0]) rotate([0, 180, -15]) arm();

// webbing
difference() {
	translate([0, webbing_offset, 0]) cube([webbing_length, webbing_depth, webbing_thickness], center=true);
	translate([arm_offset_w, arm_offset_d, 0]) rotate([0, 0, 15]) cube([arm_length, depth, 10], center=true);
	translate([-arm_offset_w, arm_offset_d, 0]) rotate([0, 180, -15]) cube([arm_length, depth, 10], center=true);
}
translate([0, webbing_flat_offset, 0]) cube([webbing_length, 0.5, height], center=true);

module arm() {
	difference() {
		cube([arm_length, depth, height], center=true);
		rotate([90, 0, 90]) cylinder(d=7.8, h=arm_length + 0.1, $fn=128, center=true);
	}
}
