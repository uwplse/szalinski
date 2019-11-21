difference() {
	union() {
		translate([-37,-34,0]) import("rpi2-top_30mm-fan_netfabb.stl");
		translate([0,0,1]) cylinder(r=20,h=2,$fn=96,center=true);
			
	}
	union() {
		translate([0,-2.5,0]) union() {
			translate([16,16,0]) cylinder(r=1.35,h=10,$fn=96,center=true);
			translate([-16,16,0]) cylinder(r=1.35,h=10,$fn=96,center=true);
			translate([16,-16,0]) cylinder(r=1.35,h=10,$fn=96,center=true);
			translate([-16,-16,0]) cylinder(r=1.35,h=10,$fn=96,center=true);
			
			
			translate([0,0,0]) cylinder(r=15,h=6,$fn=96,center=true);
				
		}

		translate([0,30,0]) cylinder(r=1.35,h=6,$fn=96,center=true);
		translate([15,30,0]) cylinder(r=1.35,h=6,$fn=96,center=true);
		translate([-15,30,0]) cylinder(r=1.35,h=6,$fn=96,center=true);
	}
}