// preview[view:north east, tilt:top diagonal]

//ring size on US scale
size = 9; //[1:.5:20]

//thickness of the ring (mm from inner to outer diameter)
thickness = 3; //[1:.5:5]

//depth of the ring (mm)
ring_depth = 6; //[3:.5:20]

//depth of the symbol (mm)
symbol_depth = 6; //[3:.5:20]

// Which part would you like to see?
part = "both"; // [both:Both,ring:Ring Only,logo:Symbol Only]

rs = size*0.82938 + 11.549;
glod = 2*sqrt(pow((rs+2*thickness)/2,2)-pow(.46*rs,2));

print_part();

module print_part() {
	if (part == "both") {
		both();
	} else if (part == "ring") {
		ring();
	} else if (part == "logo") {
		logo();
	} else {
		both();
	}
}

module ring(){
	difference(){
		cylinder(r = rs/2+thickness, h = ring_depth, $fn=50);
		union(){
			translate([0,0,-.1])cylinder(r = rs/2, h = ring_depth+.2, $fn=50);
			translate([rs*.46,-25,-.1]) cube([50,50,ring_depth+.2]);
			translate([25,0,thickness]) cube([50,.46*glod,ring_depth+.2],center=true);
		}
	}
}

module logo(){
	difference(){
		union(){
			cylinder(r=glod/2,h=symbol_depth, $fn=50);
			translate([-glod/2,-.45*glod-.16*glod,0]){
				cube([glod,.16*glod,symbol_depth]);
			}
			translate([-glod/2,.45*glod,0]){
				cube([glod,.16*glod,symbol_depth]);
			}
		}
		union(){
			translate([0,0,-.1]) cylinder(r=.46*glod/2,h=symbol_depth+.2, $fn=30);
		}
	}
}

module both(){
	translate([rs*.46,0,ring_depth/2]) rotate(a=90,v=[0,1,0]) rotate(a=-90,v=[0,0,1]) logo();
	ring();
}