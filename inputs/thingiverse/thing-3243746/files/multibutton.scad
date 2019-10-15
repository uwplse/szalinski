$fn = 64*1;

diameter = 30; //[5:50]
height = 2; //[1:25]
number_of_holes = 4; //[1:5]
hole_diameter = 2; //[1:10]
hole_offset = 2; //[0:10]
lip_ratio = 60; //[0:100]
edge_ratio = 90; //[0:100]
number_of_buttons = 4; //[1,2,3,4,6,8,9]
multi_button_spacing = 1; //[2:20]

main();

module main(){
    if (number_of_buttons == 2) {
        oneButton();
        translate(v=[diameter + multi_button_spacing,0,0]) {
            oneButton();
        }
    } else if (number_of_buttons == 3) {
        for (x = [0:2]) {
            translate(v=[(diameter + multi_button_spacing) * x,0,0]) {
                oneButton();
            }
        }
    } else if (number_of_buttons == 4) {
        for (x = [0:1]) {
            for (y = [0:1]) {
                translate(v=[(diameter + multi_button_spacing) * x,(diameter + multi_button_spacing) * y,0]) {
                    oneButton();
                }
            }
        }
    } else if (number_of_buttons == 6) {
        for (x = [0:2]) {
            for (y = [0:1]) {
                translate(v=[(diameter + multi_button_spacing) * x,(diameter + multi_button_spacing) * y,0]) {
                    oneButton();
                }
            }
        }
    } else if (number_of_buttons == 8) {
        for (x = [0:1]) {
            for (y = [0:3]) {
                translate(v=[(diameter + multi_button_spacing) * x,(diameter + multi_button_spacing) * y,0]) {
                    oneButton();
                }
            }
        }
    } else if (number_of_buttons == 9) {
        for (x = [0:2]) {
            for (y = [0:2]) {
                translate(v=[(diameter + multi_button_spacing) * x,(diameter + multi_button_spacing) * y,0]) {
                    oneButton();
                }
            }
        }
    } else {
        oneButton();
    }
}

module oneButton() {
    difference(){
		cylinder(h = height, r = diameter/2); 
		if (number_of_holes == 1) {
			oneHole();
		} else if (number_of_holes == 2) {
			twoHoles();
		} else if (number_of_holes == 3) {
			threeHoles();
		} else if (number_of_holes == 4){
			fourHoles();
		} else {
			fiveHoles();
		}
		translate(v=[0,0,height*lip_ratio*.01])
		cylinder(h = 25, r = diameter/2*edge_ratio*.01);
	}
}

module oneHole() {
	cylinder(h=25, r = hole_diameter/2);
}

module twoHoles() {
	translate(v=[hole_offset, 0, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[-hole_offset, 0, 0])
	cylinder(h = 25, r = hole_diameter/2);	
}

module threeHoles() {
	translate(v=[0, hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[.87*hole_offset, -.5*hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[-.87*hole_offset, -.5*hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);	
}

module fourHoles() {
	translate(v=[hole_offset, hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[-hole_offset, hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);	
	translate(v=[hole_offset, -hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[-hole_offset,-hole_offset,0])
	cylinder(h = 25, r = hole_diameter/2);
}

module fiveHoles() {
	translate(v=[0, hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[hole_offset*.95, hole_offset*.31, 0])
	cylinder(h = 25, r = hole_diameter/2);	
	translate(v=[hole_offset*.59, -hole_offset*.81, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[-hole_offset*.59,-hole_offset*.81,0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[-hole_offset*.95,hole_offset*.31,0])
	cylinder(h = 25, r = hole_diameter/2);
}
