$fs=.5; 
$fa=1;

module clamp() {
	intersection() {	
		difference() {	
			union() {
				translate([0,0,-32]) {
					rotate([45,0,0]) {
						difference() {
							cube([20,40,40],center=true);
							cube([40,36,36],center=true);
						}
					}
				}
				difference() {
					translate([0,0,-12]) {
						cube([20,30,32],center=true);
					}
					translate([0,0,-32]) {
						rotate([45,0,0]) {
							cube([30,37,37],center=true);
						}
					}
				}
			}
			union() {
				sphere(r=7.25);
				cube([8,60,20], center = true);
				translate([7,10,-2]){
					rotate([0,90,0]) {
						cylinder(r=1.25,h=50,center=true);
						cylinder(r=3.2,$fn=6,h=10);
						translate([0,0,-24.5]) {
							cylinder(r=3.5,h=10);
						}
					}
				}
				translate([7,-10,-2]){
					rotate([0,90,0]) {
						cylinder(r=1.25,h=50,center=true);
						cylinder(r=3.2,$fn=6,h=10);
						translate([0,0,-24.5]) {
							cylinder(r=3.5,h=10);
						}
					}
				}
			}
		}
		translate([0,0,20]) {
			rotate([45,0,0]){
				cube([100,100,100],center=true);
			}
		}
	}
}
clamp();