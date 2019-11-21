/**
 * Strap button for a child's guitar. 13mm tall, ~15mm wide at the widest.
 */

// Button width.
width = 14.8;

// Button height.
height = 13;

// Screw diameter.
screw_diameter = 4.1;

// Countersink diameter.
countersink_diameter = 6.9;

// Countersink depth.
countersink_depth = 3;

module strap_button() {
	current_height = 0;
	
	bottom_ridge_height = (1.8 / width) * width;
	bottom_ridge_diameter = (5.4 / 7.4) * width;
	
	flare_height = (2.9 / 14.8) * width;
	
	top_height = (3.4 / 14.8) * width;

	center_height = height - bottom_ridge_height - flare_height - top_height;//(5.5 / 13) * height;
	center_diameter = (3.75 / 7.4) * width;
	
	$fa = 1;
	$fs = 1;

	difference() {
		union() {
			// Bottom ridge
			translate([0, 0, current_height]) cylinder(r=bottom_ridge_diameter / 2, h=bottom_ridge_height);
		
			assign(current_height = current_height + bottom_ridge_height) {
				// Thin part.
				translate([0, 0, current_height]) cylinder(r=center_diameter / 2, h=center_height);
				assign(current_height = current_height + center_height) {
					translate([0, 0, current_height]) cylinder(r1=center_diameter / 2, r2=width / 2, h=flare_height);
					assign(current_height = current_height + flare_height) {
						translate([0, 0, current_height]) difference() {
							resize([width, width, top_height]) sphere(r=width / 2);
							translate([0, 0, -width / 2]) cube([width, width, width], true);
						};
					};
					
				};
			};
		}

		cylinder(r=screw_diameter / 2, h=height);
		translate([0, 0, height - countersink_depth]) cylinder(r=countersink_diameter / 2, h=countersink_depth);
	};
}

strap_button();