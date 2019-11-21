$fn = 100;
base_radius = 5;
base_height = 10;
slant_height = 4;
mouth_opening_radius = 3;
mouth_piece_height = 5;
handle_height = base_height-2;
module baseflask(){
	difference(){
		cylinder(h = base_height, r = base_radius);
		translate([0,0,1])
		cylinder(h = base_height+2, r = base_radius - 0.5);
	}
}

module slantflask(){
	translate([0,0,base_height])
	difference(){
		cylinder(h = slant_height, r1 = base_radius, r2 = mouth_opening_radius);
		translate([0,0,-1])
		cylinder(h = slant_height+2, r1 = base_radius-0.5, r2 = mouth_opening_radius - 0.5);
	}
}

module mouthpiece(){
	translate([0,0,base_height + slant_height])
	difference(){
		cylinder(h = mouth_piece_height, r = mouth_opening_radius);
		translate([0,0,-1])
		cylinder(h = mouth_piece_height+2, r = mouth_opening_radius - 0.5);
	}
}

module handle(){
	translate([0,base_radius,5])
	rotate([0,90,0])
	difference(){
		rotate_extrude(height = handle_height, twist = 180)
			translate([4,0,0])
			circle(0.5);
		rotate([90,0,0])
		translate([-3,0,0])
			cylinder(h=11 ,r=8);
	}
}
module draw_objects(){
	baseflask();
	slantflask();
	mouthpiece();
	handle();
}
draw_objects();