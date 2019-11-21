use <MCAD/boxes.scad>

/* [Main] */

// Number of vertical "slots" in the case.
lines = 2; // [1,2,3,4,5]

// Number of horizontal "slots" in the case.
columns = 2; // [1,2,3,4,5,6,7,8,9,10]

vertical_dividers = 3; // [0,1,2,3,4,5,6,7,8,9,10]
horizontal_dividers = 3; // [0,1,2,3,4,5,6,7,8,9,10]

case_height = 47; // [47:Shallow, 46.2:Deep]

/* [Optional] */

skirt_size = 0;  // [0:50]

wall_thickness = 1.1;

/* [Hidden] */

$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

single_box_width = 37.1;
single_box_height = 52.25;

double_box_width = 77.1;
double_box_height = 107.4;

round_radius = wall_thickness;

feet_height = 2.8;
feet_size = 6;

spacing_width = (double_box_width - single_box_width * 2);
spacing_height = (double_box_height - single_box_height * 2);

final_width = (single_box_width * columns) + (spacing_width * (columns - 1));
final_height = (single_box_height * lines) + (spacing_height * (lines - 1));

internal_width = final_width - 2 * wall_thickness;
internal_height = final_height - 2 * wall_thickness;

module feet() {
	translate([0,0,-(feet_height-round_radius)/2])
	difference() {
		union() {
			difference() {
				roundedBox([feet_size, feet_size, feet_height + round_radius], round_radius, sidesonly = true);
				rotate([0,0,45]) translate([-feet_size, 0, -feet_height]) cube([feet_size*2, feet_size, feet_height + 4]);
			}
		
			if (skirt_size > 0) {
				translate([0,0,-(feet_height + round_radius)/2]) cylinder(r = skirt_size, h = 0.3, center = false);
			}
		}
		if (skirt_size > 0) {
			translate([-skirt_size-1,0,-(feet_height + round_radius)/2-0.5]) cube([skirt_size+1, skirt_size+1, 1]);
		}
	}
}

difference() {
	roundedBox([final_width, final_height, case_height], round_radius);
	translate([0,0,wall_thickness+1]) roundedBox([final_width - 2 * wall_thickness, final_height - 2 * wall_thickness, case_height+2], round_radius/2);
}

vertical_spacing = (internal_width - (wall_thickness * vertical_dividers)) / (vertical_dividers + 1);
if (vertical_dividers > 0) {
	translate([-(internal_width - wall_thickness) / 2,0,0])
	for (i = [1:vertical_dividers]) {
		translate([vertical_spacing*i+wall_thickness * (i-1),0,0]) cube([wall_thickness, internal_height, case_height - wall_thickness], center = true);
	}
}

horizontal_spacing = (internal_height - (wall_thickness * horizontal_dividers)) / (horizontal_dividers + 1);
if (horizontal_dividers > 0) {
	translate([0,-(internal_height - wall_thickness) / 2,0])
	for (i = [1:horizontal_dividers]) {
		translate([0,horizontal_spacing*i+wall_thickness * (i-1),0]) cube([internal_width, wall_thickness, case_height - wall_thickness], center = true);
	}
}

for (x=[1, -1]) {
	for (y=[1, -1]) {
		translate([x * (final_width - feet_size) / 2, y * (final_height - feet_size) / 2, -case_height / 2]) rotate([0,0, (x==1 && y ==1 ? 90 : (x == -1 && y == 1 ? 180 : (x == -1 && y == -1 ? 270 : 0)))]) feet();
	}
}

