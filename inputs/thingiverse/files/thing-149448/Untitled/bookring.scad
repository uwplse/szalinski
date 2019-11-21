use <write/Write.scad>



thumb_radius = 11.5; 			//11.5
thumb_move = 0;	 			//0
wall = 2;					//2
height = 14;					//14
winglength = 43;				//43
angle = 10;					//10
text_left = "eine kleine";		
textdepth = 0.5;				//0.5
move_textleft_x = 3;			//5
move_textleft_z = 5;			//5
size_textleft = 5;			//5
text_right = "Leseratte";
move_textright_x = 5;			//5
move_textright_z = 5;			//5
size_textright = 5;			//5


$fn = 50+0;					//50

bookring(thumb_radius, wall, height);




module bookring(thumb_radius, wall, height) {
	difference() {
		union() {
			translate([0, (thumb_radius + (wall / 2)) +thumb_move, 0])
				cylinder(r = (thumb_radius + wall), h = height);
			rotate([0, 0, angle])
				difference() {
					union() {
						wing();
						additionalStructur((thumb_radius * 2), ((thumb_radius * 2) + wall));
						additionalStructur((winglength - wall), (winglength * 2));
					}
					translate([+move_textright_x, -wall + textdepth, move_textright_z])
						rotate([90, 0, 0])
							write(text_right, t = textdepth*2, h = size_textright, center = false);
				}
			rotate([0, 0, (-angle)])
				difference() {
					mirror([1, 0, 0]) {
						wing();
						additionalStructur((thumb_radius * 2), ((thumb_radius * 2) + wall));
						additionalStructur((winglength - wall), (winglength * 2));
					}
					translate([(-winglength)+move_textleft_x, -wall + textdepth, move_textleft_z])
						rotate([90, 0, 0])
							write(text_left, t = textdepth*2, h = size_textleft, center = false);
				}
		}
		translate([0, (thumb_radius + (wall / 2)) +thumb_move, 0])
			cylinder(r = thumb_radius, h = height);
	}
}








module wing() {
	difference() {
		hull() {
			cylinder(r = wall, h = height);
			translate([winglength, 0, 0])
				cylinder(r = wall, h = height);
			translate([0, (thumb_radius * 1.5), 0])
				cylinder(r = wall, h = height);
		}
		hull() {
			cylinder(r = 0.1, h = height);
			translate([winglength, 0, 0])
				cylinder(r = 0.1, h = height);
			translate([0, (thumb_radius * 1.5), 0])
				cylinder(r = 0.1, h = height);
		}
	}
}



module additionalStructur(innerradius, outerradius) {
	intersection() {
		hull() {
			cylinder(r = wall, h = height);
			translate([winglength, 0, 0])
				cylinder(r = wall, h = height);
			translate([0, (thumb_radius * 1.5), 0])
				cylinder(r = wall, h = height);
		}
		difference() {
			translate([0, thumb_radius, 0])
				cylinder(r = outerradius, h = height);
			translate([0, thumb_radius, 0])
				cylinder(r = innerradius, h = height);
		}
	}
}

