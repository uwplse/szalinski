
// diameter of the rod
d=28;
// length of the rod
l=90;

difference() {
	union() {
		cube([50,5,d]);
		cube([10,9,d]);
		translate([0,6,0]) {
			cube([63,3,d]);
		}
	    difference() {
		    union() {
				translate([63,8,d/2]) {
					rotate([-90,0,0]) {
						cylinder(r=d/2, h=l+1+2, $fn=100);
					}
				}
				translate([61,9+l,d/2]) {
					rotate([-90,0,0]) {
						cylinder(r=d/2, h=2);
					}
				}
			}
			translate([63,3,d/2]) {
				rotate([-90,0,0]) {
					cylinder(r=d/2-9, h=l+1+2+10, $fn=100);
				}
			}
		}
	}
	translate([63,7,-1]) {
		cube([d/2,l+9+2+10,d+2]);
	}
}



