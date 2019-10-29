// diameter of the rod
d=28;
// length of the rod
l=90;
// height of the rod
height=120; // [35:350]

difference() {
	union() {
		cube([35,6,d]);
		cube([4,13,d]);
		translate([0,10,0]) {
			cube([height,3,d]);
		}
		difference() {
			union() {
				translate([height,12,d/2]) {
					rotate([-90,0,0]) {
						cylinder(r=d/2, h=l+1+2, $fn=50);
					}
				}
				translate([height-3,12+1+l,d/2]) {
					rotate([-90,0,0]) {
						cylinder(r=d/2, h=2, $fn=50);
					}
				}
			}
			translate([height,10+l/4,d/2]) {
				rotate([-90,0,0]) {
					cylinder(r=d/2-9, h=l+1+2+10, $fn=50);
				}
			}
		}
	}
	translate([height,0,-1]) {
		cube([d/2+1,l+12+1+2+1,d+2]);
	}
}





