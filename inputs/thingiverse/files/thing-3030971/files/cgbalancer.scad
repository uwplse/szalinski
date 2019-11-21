
hole_diameter = 4;
module_scale  = 1;


module leg() {
	translate([34,0,0]) {
		scale([75,10,5]) {
			cube([1,1,1], center=true);
		}
	}
	translate([25,0,0]) {
		translate([0,0,4]) {
			scale([50,8,5]) {
				cube([1,1,1], center=true);
			}
		}
	}
}

module item() {
	difference() {
		scale([ module_scale, module_scale, module_scale ]) {
			union() {
				leg();
				rotate(120) {
					leg();
				}
				rotate(240) {
					leg();
				}
				translate([0,0,10]) {
					translate([0,0,2.5]) {
						cylinder(r1=20,r2=10,h=30, center=true, $fn=100);
					}
				}
			}
		}
		cylinder(r=hole_diameter/2,h=1000, center=true, $fn=50);
	}
}

item();

