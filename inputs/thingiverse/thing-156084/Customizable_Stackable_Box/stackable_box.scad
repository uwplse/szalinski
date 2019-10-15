// Display the Cover
display_cover = "yes"; // [yes,no]
// Display the box
display_box = "yes"; // [yes,no]
// Create ears at the corner
with_antiwarp_ears = "yes"; // [yes,no]


// the x length inside the box (the resulting x of the box is inner_x + 2*wall)
inner_x = 45;
// the y length inside the box
inner_y = 80;
// the z height inside the box, until the stacking frame begins
inner_z = 13;

// the z height of the stacking frame
stack_z = 5;
// per side gap between the box-bottom and the stacking frame (box bttom = inner_x + 2*wall; inner stackingframe x = inner_x + 2*wall + 2*stack_gap)
stack_gap = 1;

// wall thickness
wall = 2.5;
// bottom thickness
bottom = 1;

// start-height for overhang suport (should be >stack_z )
support_start_height = 10;

// height of the cover (the stacking part has the "stack_z"-height)
cover_height = 5;

// radius of the antiwarp ear
ear_radius = 10;
// height of the antiwarp ear, should be your layer-height for easy cutoff
ear_height = 0.2;


if(display_cover == "yes"){
	stackable_box_cover(inner_x,inner_y,stack_z,stack_gap,wall,cover_height);
	if(with_antiwarp_ears == "yes"){
		ears(0, 0, inner_x + wall*4 + stack_gap*2, inner_y + wall*4 + stack_gap*2);
	}
}


if(display_box == "yes"){
translate([inner_x + wall*4 + stack_gap*2 + ear_radius*2 + 2,wall + stack_gap,0]){
	stackable_box(inner_x,inner_y,inner_z,stack_z,stack_gap,wall,bottom,support_start_height);
	if(with_antiwarp_ears == "yes"){
		difference() {
			ears(0, 0, inner_x + wall*2, inner_y + wall*2);
			translate([wall,wall, 0]) 
				cube([inner_x, inner_y, inner_z*2]);
		}
	}
}
}


module stackable_box_cover(x, y,stack_z, gap, w,c) {
	cube([x + w*4 + gap*2, y + w*4 + gap*2, c]);
	translate([w+gap, w+gap, 0])
		cube([x + w*2, y + w*2, stack_z+c]);


}


module stackable_box(x, y, z,stack_z, gap, w, b, supheight) {
	box(x, y, z, w, b);
	translate([-wall-gap, -wall-gap, z+b])
		box(x + wall*2 + gap*2, y + wall*2 + gap*2, stack_z, w, 0);

	difference() {
		hull() {
			translate([-wall-gap, -wall-gap, z+b]) 
				box(x + wall*2 + gap*2, y + wall*2 + gap*2, 0.1, w, 0);
			translate([0, 0, supheight]) 
				box(x, y, 0.1, w, b);
		}
		translate([w,w, 0]) 
			cube([x, y, z*2]);
	}


}

module box(x, y, z, w,b) {
	difference() {
		cube([(x + (2 * w)), (y + (2 * w)), (z + b)]);
		translate([w, w, b]) 
			cube([x, y, (z * 2)]);
	}
}

module ears(xmin, ymin, xmax, ymax) {
	translate([xmin, ymin, 0]) cylinder(r = ear_radius, h = ear_height);
	translate([xmin, ymax, 0]) cylinder(r = ear_radius, h = ear_height);
	translate([xmax, ymin, 0]) cylinder(r = ear_radius, h = ear_height);
	translate([xmax, ymax, 0]) cylinder(r = ear_radius, h = ear_height);
}
