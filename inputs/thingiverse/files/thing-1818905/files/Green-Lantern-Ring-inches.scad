// preview[view:north east, tilt:top diagonal]

//ring size on US scale
size = 9; //[1:.5:20]

//thickness of the ring (inches from inner to outer diameter)
thickness = .125; //[.0625:.0005:.1875]

//depth of the ring (inches)
ring_depth = .25; //[.125:.0625:1]

//depth of the symbol (inches)
symbol_depth = .25; //[.125:.0625:1]

// Which part would you like to see?
part = "both"; // [both:Both,ring:Ring Only,logo:Symbol Only]

rs = size*.0326 + .455;
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
			translate([rs*.46,-10,-.1]) cube([5,20,ring_depth+.2]);
			translate([1,0,thickness]) cube([2,.46*glod,ring_depth+.2],center=true);
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
	translate([(size*.0326 + .455)*.46,0,ring_depth/2]) rotate(a=90,v=[0,1,0]) rotate(a=-90,v=[0,0,1]) logo();
	ring();
}