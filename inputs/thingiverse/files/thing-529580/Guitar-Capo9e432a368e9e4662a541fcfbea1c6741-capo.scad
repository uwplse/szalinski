nut_width = 44;
capo_length = 12;
capo_back_thickness = 4;
capo_front_thickness = 4;
neck_shape = 0.5;
fretboard_height = 5;
articulation_radius = 2;
articulation_offset = 2;
clip_height = 7;

// front side
translate([20, 0, 0])
translate([fretboard_height, 0, 0]) {
	rotate([0, -90, 0]) difference() {
		// main thing
		union() {
			cube(size=[capo_length, nut_width, capo_front_thickness], center = true);
			translate([0, 0, 2])
				rotate([90, 0, 0])
					cylinder(h = nut_width, r = 1, $fn = 32, center = true);
		}
		
		// cut outs
		translate([-3, 0, 1])
			cube(size = [4, nut_width - 2, 4], center = true);
		translate([3, 0, 1])
			cube(size = [4, nut_width - 2, 4], center = true);
	}

	// articulation attachment
	translate([0, -nut_width/2 -capo_back_thickness/2, 0]) {
		difference() {
			cube(size = [capo_front_thickness, capo_back_thickness + articulation_offset, capo_length], center = true);
			cube(size = [capo_front_thickness + 2, capo_back_thickness + articulation_offset + 2, capo_length - 2], center = true);
		}
	}

	// articulation front
	translate([0, -nut_width/2 -capo_back_thickness/2 - articulation_offset, 0])
		cylinder(h = capo_length, r = articulation_radius/2, $fn=64, center = true);

	// clip attachment
	translate([capo_front_thickness/2, nut_width/2 + capo_back_thickness/2, 0]) {
		scale([capo_front_thickness*2, capo_back_thickness, clip_height]) {
			union() {
				difference() {
					rotate([0, 0, 45]) cube(size=[sqrt(2)/2,sqrt(2)/2,1], center=true);
					translate([0, 0.5, 0]) cube(size=[1, 1, 2], center=true);
				}
				translate([-0.25, -0.25, 0]) cube(size=[0.5,0.5,1], center=true);
				translate([0.5, 0, 0]) scale([2, 1, 1]) rotate([0, 0, 270]) difference() {
					rotate([0, 0, 45]) cube(size=[sqrt(2)/2,sqrt(2)/2,1], center=true);
					translate([0, 0.5, 0]) cube(size=[1, 1, 2], center=true);
					translate([0.5, 0, 0]) cube(size=[1, 1, 2], center=true);
				}
			}
		}
	}
}

// back side
scale([neck_shape, 1, 1])
difference() {
	// main cylinder
	cylinder(h = capo_length, r = nut_width/2 + capo_back_thickness + articulation_offset, $fn = 128, center = true);
	
	// cut half off
	translate([nut_width/2, 0, 0])
		cube(size=[nut_width, nut_width + 2*capo_back_thickness + articulation_offset + 2, capo_length+1], center = true);
	// inner cylinder
	cylinder(h = capo_length+2, r = nut_width/2 + articulation_offset, $fn = 128, center = true);

	// outer cutout
	difference() {
		cylinder(h = capo_length-2, r = nut_width + capo_back_thickness + articulation_offset, $fn = 128, center = true);
		cylinder(h = capo_length, r = nut_width/2 + capo_back_thickness/2 + articulation_offset, $fn = 128, center = true);
		translate([nut_width/2 - capo_back_thickness, 0, 0])
			cube(size=[nut_width, nut_width + 2*capo_back_thickness + articulation_offset + 2, capo_length+1], center = true);
	}
}

// articulation attachment
translate([fretboard_height/2, -nut_width/2 -capo_back_thickness/2 -articulation_offset, 0]) {
	scale([fretboard_height, capo_back_thickness, capo_length - 2.5]) {
		difference() {
			cube(size=[1, 1, 1], center = true);
			rotate([0, 0, 180+45]) translate([-1, 0, -1]) cube(size=[2, 2, 2]);
		}
	}
	translate([0, capo_back_thickness/4]) cube(size = [fretboard_height - articulation_radius, capo_back_thickness/2 , capo_length - 2.5], center=true);
}

// articulation back
translate([fretboard_height, -nut_width/2 -capo_back_thickness/2 -articulation_offset, 0]) {
	difference() {
		cylinder(h = capo_length - 2.5, r = articulation_radius, $fn=64, center = true);
		translate([-2, -2, 0]) cube(size = [4, 4, capo_length+2], center = true);
		cylinder(h = capo_length+2, r = articulation_radius/2, $fn=64, center = true);
	}
}

// clip
translate([3/4*capo_front_thickness + fretboard_height/2 + 0.5, nut_width/2 + capo_back_thickness/2 + articulation_offset, 0]) {
	difference() {
		cube(size=[3/2*capo_front_thickness + fretboard_height + 1, capo_back_thickness, capo_length], center=true);
		translate([-1, 0, 0])
			cube(size=[3/2*capo_front_thickness + fretboard_height, capo_back_thickness + 1, clip_height+2], center=true);
		translate([-1, capo_back_thickness/2, 0])	
			cube(size=[3/2*capo_front_thickness + fretboard_height, capo_back_thickness + 1, capo_length+2], center=true);
	}
}