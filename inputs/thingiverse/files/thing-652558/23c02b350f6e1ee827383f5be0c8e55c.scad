use <MCAD/boxes.scad>

/* [Main] */

// Number of vertical "slots" in the case.
lines = 1; // [1,2,3,4,5]

// Number of horizontal "slots" in the case.
columns = 2; // [1,2,3,4,5,6,7,8,9,10]

vertical_dividers = 1; // [0,1,2,3,4,5,6,7,8,9,10]
horizontal_dividers = 1; // [0,1,2,3,4,5,6,7,8,9,10]

case_height = 20; // [41:Shallow, 46.2:Deep]

/* [Optional] */

skirt_size = 0;  // [0:50]

wall_thickness = 1.2;

// Creates 2 separate pieces that can be printed without support but that have to be glued together.
split_base_and_top = "As One"; // [As One, Both, Base, Box]

/* [Hidden] */

$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

split_parts_separation = 10;

single_box_width = 37.1;
single_box_height = 52.25;

double_box_width = 77.1;
double_box_height = 107.4;

round_radius = wall_thickness / 2;

feet_height = 2.8;
feet_size = 6;

feet_subtract = 0;//wall_thickness + 0.5;

// Correction due to Simplify3D bug
simplify_correction = 0.5;

spacing_width = (double_box_width - single_box_width * 2);
spacing_height = (double_box_height - single_box_height * 2);

final_width = (single_box_width * columns) + (spacing_width * (columns - 1));
final_height = (single_box_height * lines) + (spacing_height * (lines - 1));

internal_width = final_width - 2 * wall_thickness;
internal_height = final_height - 2 * wall_thickness;

vertical_spacing = (internal_width - (wall_thickness * vertical_dividers)) / (vertical_dividers + 1);
horizontal_spacing = (internal_height - (wall_thickness * horizontal_dividers)) / (horizontal_dividers + 1);

echo("W=", final_width, " H=", final_height, " vs=", vertical_spacing, " hs=", horizontal_spacing);

if (split_base_and_top == "As One") {
    box();
} else if (split_base_and_top == "Base") {
    split_base();
} else if (split_base_and_top == "Box") {
    split_box();
} else {
    if (final_width > final_height) {
        translate([0, final_height / 2 + split_parts_separation / 2, 0])
        split_box();

        translate([0, -final_height / 2 - split_parts_separation / 2, 0])
        split_base();
    } else {
        translate([0, final_width / 2 + split_parts_separation / 2, 0])
        rotate([0, 0, 90])
        split_box();

        translate([0, -final_width / 2 - split_parts_separation / 2, 0])
        rotate([0, 0, 90])
        split_base();
    }
}

module split_base() {
    rotate([0, 180, 0])
    translate([0, 0, -feet_height - round_radius])
    difference() {
        box();
        translate([0, 0, feet_height + case_height / 2 + 1 + round_radius]) cube([final_width + 2, final_height + 2, case_height + 2], center = true);
    }
}

module split_box() {
    translate([0, 0, - feet_height - round_radius])
    difference() {
        box();
        translate([0, 0, - case_height/2 - 1 + feet_height + round_radius]) cube([final_width + 2, final_height + 2, case_height + 2], center = true);
    }
}

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
module box() {
    translate([0, 0, case_height / 2 + feet_height])
    union() {
        difference() {
            roundedBox([final_width, final_height, case_height], round_radius);
            translate([0,0,wall_thickness]) roundedBox([final_width - 2 * wall_thickness, final_height - 2 * wall_thickness, case_height], round_radius/2);
        }
        
        if (vertical_dividers > 0) {
            translate([-(internal_width - wall_thickness) / 2,0,0])
            for (i = [1:vertical_dividers]) {
                translate([vertical_spacing*i+wall_thickness * (i-1),0,simplify_correction]) cube([wall_thickness, internal_height, case_height-wall_thickness-simplify_correction*2], center = true);
            }
        }
        
        if (horizontal_dividers > 0) {
            translate([0,-(internal_height - wall_thickness) / 2,0])
            for (i = [1:horizontal_dividers]) {
                translate([0,horizontal_spacing*i+wall_thickness * (i-1),simplify_correction]) cube([internal_width, wall_thickness, case_height-wall_thickness-simplify_correction*2], center = true);
            }
        }
        
        for (x=[1, -1]) {
            for (y=[1, -1]) {
                translate([x * (final_width - feet_size) / 2 - x * feet_subtract, y * (final_height - feet_size) / 2 - y * feet_subtract, -case_height / 2]) rotate([0,0, (x==1 && y ==1 ? 90 : (x == -1 && y == 1 ? 180 : (x == -1 && y == -1 ? 270 : 0)))]) feet();
            }
        }	
    }
}
