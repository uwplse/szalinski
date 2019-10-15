// Half height row(s)
half_row = 1; // 0:25

// Standard height/width row(s)
normal_row = 1; // 0:25

//Double width row(s)
double_row = 1; // 0:25

//Quad width row(s)
quad_row = 1; // 0:25

//Height (mm)
height = 64;

//Top Mounting Clips
topclip = 1; // 0:1

//Bottom Mounting Clips
btmclip = 1; // 0:1

//Left Mounting Clips
//lftclip = 1; // 0:1

//Right Mounting Clips
//rgtclip = 1; // 0:1



grid();


module grid (){

	if (half_row > 0) {
		for (row = [1:half_row]) {
			for (col = [1 : 4]) {
				translate(v = [col*30, 0, row*13.38]) {
						half_box();
				}
			}
		}
	}

	if (normal_row > 0) {
		for (row = [1:normal_row]) {
			for (col = [1 : 4]) {
				translate(v = [col*30, 0, row*27+(half_row*13.5-7)]) {
						box();
				}
			}
		}
	}

	if (double_row > 0) {
		for (row = [1:double_row]) {
			for (col = [1 : 2]) {
				translate(v = [col*60-15 , 0, row*27+(half_row*13.5-7)+(normal_row*27)]) {
						double_box();
				}
			}
		}
	}

	if (quad_row > 0) {
		for (row = [1:quad_row]) {
			translate(v = [75 , 0, row*27+(half_row*13.5-7)+(normal_row*27)+(double_row*27)]) {
					quad_box();
			}
		}
	}
	if (topclip > 0) {
		translate(v = [14.5,-height/2,3.25]) {
			difference() {
				cube(size = [121,height,4]);
				translate( v = [1,0,1]) {
					cube(size = [119,height,2]);
				}
				translate( v = [3,0,0]) {
					cube(size = [115,height,1]);
				}
			}
		}
	}
	if (btmclip > 0) {
		translate(v = [16,-height/2,half_row*13.5+((normal_row+double_row+quad_row)*27)+7]) {
			difference() {
				cube(size = [118,height,2.5]);
				translate( v = [3,0,0]) {
					cube(size = [112,height,2.5]);
				}
				translate( v = [0,0,0]) {
					cube(size = [2,height,1.5]);
				}
				translate( v = [116,0,0]) {
					cube(size = [2,height,1.5]);
				}
			}
		}
	}
}




module half_box(){
	difference() {
		cube(size = [31,height,14.25], center = true);
		cube(size = [29,height,12.25], center = true);
	}

	translate(v = [0,(height / 2)-0.5,0]) {
		cube(size = [31,1,3], center=true);
	}

}

module box(){
	difference() {
		cube(size = [31,height,28], center = true);
		cube(size = [29,height,26], center = true);
	}

	translate(v = [0,(height / 2)-0.5,0]) {
		cube(size = [31,1,6], center=true);
	}
}

module double_box(){
	difference() {
		cube(size = [61,height,28], center = true);
		cube(size = [59,height,26], center = true);
	}

	translate(v = [0,(height / 2)-0.5,0]) {
		cube(size = [61,1,6], center=true);
	}
}

module quad_box(){
	difference() {
		cube(size = [121,height,28], center = true);
		cube(size = [119,height,26], center = true);
	}

	translate(v = [0,(height / 2)-0.5,0]) {
		cube(size = [121,1,6], center=true);
	}
}