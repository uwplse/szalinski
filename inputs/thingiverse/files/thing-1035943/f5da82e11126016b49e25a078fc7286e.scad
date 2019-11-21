/* [Device Size] */

// Device width (mm)
phone_width = 60;

// Device height (mm)
phone_height = 9;

/* [Hidden] */

clip_length = 20;
clip_thickness = 3;
ball_diameter = 25;
arm_length = 7;

module clip() {
    width = phone_width + clip_thickness * 2;
    height = phone_height + clip_thickness * 2;
    
    difference() {
		cube([width, height, clip_length]);
		
		translate([clip_thickness, clip_thickness, -1])
		cube([phone_width, phone_height, clip_length + 2]);
		
		translate([clip_thickness * 2, clip_thickness + phone_height - 1, -1])
		cube([phone_width - (clip_thickness * 2), clip_thickness + 2, clip_length + 2]);
	}
}

module ball() {
	ball_x = 0 - (ball_diameter/2) - arm_length;
	ball_y = clip_thickness + phone_height/2;
	difference() {
		translate([ball_x, ball_y, clip_length/2])
		sphere(d=ball_diameter, $fn=60);
	
		// flatten one side of ball for easy printing
		translate([ball_x, ball_y, -ball_diameter/2])
		cube([ball_diameter, ball_diameter, ball_diameter], center=true);
	}
}

module arm() {
	translate([0, clip_thickness + phone_height/2, clip_length/2])
	rotate([0, -90, 0])
	union() {
		translate([0, 0, arm_length]) cylinder(d=9, h=ball_diameter/2);
		cylinder(d1=min(phone_height + clip_thickness * 2, clip_length), d2=9, h=arm_length);
	}
}

ball();
arm();
clip();