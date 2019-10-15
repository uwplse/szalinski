//Box type 
box_type = 1; //[0:Half Height, 1:Standard, 2:Double, 3:Quad]

//Rack depth (no more than your max Z height!)
depth = 64;

//With divider slots?
divider = 1; //[0:No, 1:Yes]

//Render drawer or divider panel?
panel = 0; // [0:Box, 1:Panel]




//finger pull
if (panel == 0) {
	difference() {
		cylinder(h=5, r=5);
		translate(v=[-5,0,0]) {
			cube(size=[10,10,10], center=true);
		}
	}
}


if (box_type == 0) {
	if (panel == 0) {
		translate(v=[-depth/2+0.5,0,11.5/2]) {
			difference() {
				cube(size=[depth-1,27,11.5], center=true);
				translate(v=[0,0,0.5]){
					cube(size=[depth-3,25,10.5], center=true);
				}
			}
		}
	translate(v=[0.5,0,5.75]) {
			difference() {
				cube(size=[3,27,11.5], center=true);
				cube(size=[1,25,11.5], center=true);
				cube(size=[3,20,11.5], center=true);
			}
		}
	}

	if (divider == 1) {
		if (panel == 0) {
			difference() {
				union() {
					translate(v=[-depth/2,-27/2+2,11.5/2]) {
						cube(size=[5,2,11.5], center = true);
					}
					translate(v=[-depth/2,27/2-2,11.5/2]) {
						cube(size=[5,2,11.5], center = true);
					}
				}
				translate(v=[-depth/2,0,11.5/2]) {
						cube(size=[2.5,25,11.5], center = true);
				}
			}
		}
		if (panel == 1) {
				cube(size=[24,10,2], center=true);
		}
	}
}






if (box_type == 1) {
	if (panel == 0) {
		translate(v=[-depth/2+0.5,0,24/2]) {
			difference() {
				cube(size=[depth-1,27,24], center=true);
				translate(v=[0,0,0.5]){
					cube(size=[depth-3,25,23], center=true);
				}
			}
		}
		translate(v=[0.5,0,12]) {
			difference() {
				cube(size=[3,27,24], center=true);
				cube(size=[1,25,24], center=true);
				cube(size=[3,20,24], center=true);
			}
		}
	}

	if (divider == 1) {
		if (panel == 0) {
			difference() {
				union() {
					translate(v=[-depth/2,-27/2+2,12]) {
						cube(size=[5,2,24], center = true);
					}
					translate(v=[-depth/2,27/2-2,12]) {
						cube(size=[5,2,24], center = true);
					}
				}
				translate(v=[-depth/2,0,12]) {
					cube(size=[2.5,25,24], center = true);
				}
			}
		}
		if (panel == 1) {
			cube(size=[24,23,2], center=true);
		}
	}
}







if (box_type == 2) {
	if (panel == 0) {
		translate(v=[-depth/2+0.5,0,24/2]) {
			difference() {
				cube(size=[depth-1,57,24], center=true);
				translate(v=[0,0,0.5]){
					cube(size=[depth-3,55,23], center=true);
				}
			}
		}
		translate(v=[0.5,0,12]) {
			difference() {
				cube(size=[3,57,24], center=true);
				cube(size=[1,55,24], center=true);
				cube(size=[3,50,24], center=true);
			}
		}
	}

	if (divider == 1) {
		if (panel == 0) {
			difference() {
				union() {
					translate(v=[-depth/2,-57/2+2,12]) {
						cube(size=[5,2,24], center = true);
					}
					translate(v=[-depth/2,57/2-2,12]) {
						cube(size=[5,2,24], center = true);
					}
				}
				translate(v=[-depth/2,0,12]) {
					cube(size=[2.5,55,24], center = true);
				}
			}
		}
		if (panel == 1) {
			cube(size=[24,54,2], center=true);
		}
	}
}





if (box_type == 3 ) {
	if (panel == 0) {
		translate(v=[-depth/2+0.5,0,24/2]) {
			difference() {
				cube(size=[depth-1,115,24], center=true);
				translate(v=[0,0,0.5]){
					cube(size=[depth-3,113,23], center=true);
				}
			}
		}
		translate(v=[0.5,0,12]) {
			difference() {
				cube(size=[3,57,24], center=true);
				cube(size=[1,55,24], center=true);
				cube(size=[3,50,24], center=true);
			}
		}
	}

	if (divider == 1) {
		if (panel == 0) {
			difference() {
				union() {
					translate(v=[-depth/2,-115/2+2,12]) {
						cube(size=[5,2,24], center = true);
					}
					translate(v=[-depth/2,115/2-2,12]) {
						cube(size=[5,2,24], center = true);
					}
				}
				translate(v=[-depth/2,0,12]) {
					cube(size=[2.5,113,24], center = true);
				}
			}
		}
		if (panel == 1) {
			cube(size=[24,112,2], center=true);
		}
	}
}