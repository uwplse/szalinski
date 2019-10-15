/* [Type] */

//Type (3DT needs equal height and width)
type = "T"; //[T,3DT,L,+]

/* [Size] */

//Branch lenth
lenth = 40;

//Branch width
width = 30;

//Branch height
height = 30;

//Thickness
thickness = 3;

if (type == "T") {
	difference(){
		union() {
			branch();
			translate([lenth,0,0]) {
				branch();
			}
		}
		translate([height*-0.5+lenth,thickness,height+thickness]) {
			cube([height,width,thickness]);
		}
	}
		rotate([0,270,0]) {
			translate([height+thickness*2,0,-(height*0.5+thickness+lenth)]) {
				branch();
			}
		}
}

if (type == "L") {
	corner();
	translate([height+thickness*2,0,0]) {
		branch();
	}
	rotate([0,90,0]) {
		translate([-(lenth+height+thickness*2),0,0]) {
			branch();
		}
	}
}

if (type == "+") {
	center();
	translate([height+thickness*2,0,0]) {
		branch();
	}
	rotate([0,90,0]) {
		translate([-(lenth+height+thickness*2),0,0]) {
			branch();
		}
	}
	translate([-lenth,0,0]) {
		branch();
	}
	rotate([0,90,0]) {
		translate([0,0,0]) {
			branch();
		}
	}
}

if (type == "3DT") {
	if (width == height) {
		difference() {
			corner();
			translate([thickness,thickness,thickness]) {
				cube([height,width+thickness,height]);
			}
		}
		translate([height+thickness*2,0,0]) {
			branch();
		}
		rotate([0,90,0]) {
			translate([-(lenth+height+thickness*2),0,0]) {
				branch();
			}
		}
		rotate([0,0,90]) {
			translate([width+thickness*2,-(height+thickness*2),0]) {
				branch();
			}
		}
	}
}

module branch() {
	difference() {
		cube([lenth,width+thickness*2,height+thickness*2]);
		translate([0,thickness,thickness]) {
			cube([lenth,width,height]);
		}
	}
}

module corner() {
	difference() {
		cube([height+thickness*2,width+thickness*2,height+thickness*2]);
		translate([thickness,thickness,thickness]) {
			cube([height+thickness,width,height]);
			cube([height,width,height+thickness]);
		}
	}
}

module center() {
	difference() {
		cube([height+thickness*2,width+thickness*2,height+thickness*2]);
		translate([0,thickness,thickness]) {
			cube([height+thickness*2,width,height]);
		}
		translate([thickness,thickness,0]) {
			cube([height,width,height+thickness*2]);
		}
	}
}