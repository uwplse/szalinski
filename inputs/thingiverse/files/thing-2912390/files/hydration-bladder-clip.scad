use <openscad-hook.scad>

$fs = 0.1;
thickness = 2;
strap_width = 25;
strap_thickness = 1;
tube_diameter = 14;
width = 10;

linear_extrude(width) {
	square([strap_width + thickness - strap_thickness, thickness]);
	square([thickness, thickness * 2 + strap_thickness]);
	translate([0, thickness + strap_thickness]) square([strap_width + thickness * 2, thickness]);
	translate([strap_width + thickness, 0]) square([thickness, thickness + strap_thickness]);

	translate([strap_width / 2, 0]) rotate([0, 0, 90]) hook_attached(tube_diameter / 2 + 1, 1, 235);
}
