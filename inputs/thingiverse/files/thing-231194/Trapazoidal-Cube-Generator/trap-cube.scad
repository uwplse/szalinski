//	Height of trapazoid
height = 19;

//	Width of top cube
top_x = 30;
//	Length of top cube
top_y = 34;

//	Width of bottom cube
bottom_x = 45;
//	Length of bottom cube
bottom_y = 65;

wall_thickness = 2;

module trap_cube() {
	difference(){
		hull(){
			translate([0,0,height])
				cube([top_x, top_y, 0.1], center=true);
				cube([bottom_x, bottom_y, 0.1], center=true);
			}

		hull(){
			translate([0,0,height])
				cube([top_x - wall_thickness, top_y - wall_thickness, 0.1], center=true);
				cube([bottom_x - wall_thickness, bottom_y - wall_thickness, 0.1], center=true);
		}
	}
}

trap_cube();