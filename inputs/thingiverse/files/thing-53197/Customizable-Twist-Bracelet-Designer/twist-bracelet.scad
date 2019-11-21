$fn=20*1;


//Pick from the list of available bracelet sizes
bracelet_size = 65; //[35:0-6 Mos,39:6-12 Mos,44:12-24 Mos,48:2-5 Yrs,52:6-8 Yrs,57:9-13 Yrs,62:Women's Petite,65:Women's Small,68:Women's Medium,75:Women's Large,80:Women's Plus,86:Women's Ankle,70:Men's Small,73:Men's Medium,78:Men's Large,83:Men's Plus]

//Width of the bracelet surface
width_in_millimeters = 20; // [8:30]

//Spacing between each twist.  The smaller the number the larger the spaces
Spacing = 2; //[0.1:0.1 Spaced,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1:1,1.1,1.5,2:2 Close]

//How thick would you like the lines to be?
Line_thinkness = 2; //[1:1mm Thin,2:2mm Normal,3:3mm Thick]

//How many rotations in each twist
Twist_Rotations = 1*1; //[1:Single,2:Double]

//How wide should each twist be?
Twist_Width = 5; //[0.5,0.75,1,1.5,2,3,4,5]

//How many overlapping twists would you like?
Interlocking_Twists = 1; // [1:Single,2:Double]


bracelet_x = bracelet_size; // x
bracelet_y = bracelet_x * 55 / 65; // y



twist_tall = width_in_millimeters-Line_thinkness*2; // width of the bracelet
twist_wide = Twist_Width; // wide of each spiral
twist_rotations = Twist_Rotations; // number of rotations in each twirl
twist_line_size = Line_thinkness;; // thinkness of each twist line
twist_rotation = 360*twist_rotations;


build();

module build() {
	translate (v=[0, 0,twist_tall/2+twist_line_size]) 
		scale (v=[bracelet_x/bracelet_y,1,1])  {

			twists();
			rings();
		}
}


module twist() {
	translate([-twist_wide/2, 0, 0])
		linear_extrude(height = twist_tall, center = true, convexity = 10, twist = -twist_rotation)
			translate([twist_wide/2, 0, 0])
				circle(r = twist_line_size/2);

	if (Interlocking_Twists==2) {
		translate([-twist_wide/2, 0, 0])
			linear_extrude(height = twist_tall, center = true, convexity = 10, twist = twist_rotation)
				translate([twist_wide/2, 0, 0])
					circle(r = twist_line_size/2);
	}


}

circumferance = bracelet_y*3.1415;

twist_ratio = Spacing; // the ratio of actual twists to the maximum twists just touching each other
twist_count = round((circumferance/(twist_wide+twist_line_size))*twist_ratio); // number of twist segments per bracelet
twist_angle = 360/twist_count;

module twists() {
	for (i = [1:twist_count]) {
			rotate (a=twist_angle*i,v=[0,0,1])
				translate([-bracelet_y/2, 0, 0])
					twist();
	}
}




module rings() {
	translate([0, 0, twist_tall/2])
		rotate_extrude(convexity = 10, $fn = 100)
			translate([bracelet_y/2, 0, 0])
				circle(r = twist_line_size, $fn = 100);

	translate([0, 0, -twist_tall/2])
		rotate_extrude(convexity = 10, $fn = 100)
			translate([bracelet_y/2, 0, 0])
				circle(r = twist_line_size, $fn = 100);

}




