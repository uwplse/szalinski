// Half height row(s)
half_row = 1; // [0:10]

// Standard height/width row(s)
normal_row = 1; // [0:10]

//Double width row(s)
double_row = 1; // [0:10]

//Quad width row(s)
quad_row = 1; // [0:10]



grid();



module grid (){
rotate(a=[270,0,0]){
	if (half_row > 0) {
		for (row = [1:half_row]) {
			for (col = [1 : 4]) {
				translate(v = [col*30, 0, row*13.5]) {
						half_box();
				}
			}
		}
	}

	if (normal_row > 0) {
		for (row = [1:normal_row]) {
			for (col = [1 : 4]) {
				translate(v = [col*30, 0, row*27+(half_row*13.5-6.75)]) {
						box();
				}
			}
		}
	}

	if (double_row > 0) {
		for (row = [1:double_row]) {
			for (col = [1 : 2]) {
				translate(v = [col*60-15 , 0, row*27+(half_row*13.5-6.75)+(normal_row*27)]) {
						double_box();
				}
			}
		}
	}

	if (quad_row > 0) {
		for (row = [1:quad_row]) {
			translate(v = [75 , 0, row*27+(half_row*13.5-6.75)+(normal_row*27)+(double_row*27)]) {
					quad_box();
			}
		}
	}
}
}




module half_box(){
	difference() {
		cube(size = [31,68,14.5], center = true);
		cube(size = [29,70,12.5], center = true);
	}

	translate(v = [0,33.5,0]) {
		cube(size = [31,1,3], center=true);
	}

}

module box(){
	difference() {
		cube(size = [31,68,28], center = true);
		cube(size = [29,70,26], center = true);
	}

	translate(v = [0,33.5,0]) {
		cube(size = [31,1,6], center=true);
	}
}

module double_box(){
	difference() {
		cube(size = [61,68,28], center = true);
		cube(size = [59,70,26], center = true);
	}

	translate(v = [0,33.5,0]) {
		cube(size = [61,1,6], center=true);
	}
}

module quad_box(){
	difference() {
		cube(size = [121,68,28], center = true);
		cube(size = [119,70,26], center = true);
	}

	translate(v = [0,33.5,0]) {
		cube(size = [121,1,6], center=true);
	}
}