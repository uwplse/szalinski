tongue_length = 65;

rotate(180, v=[1,0,0]) {
	translate([0, -54.2, 20]) {
		difference() {
			translate([-47.7, 30, -20])
			rotate(90, v=[1,0,0])
			color("grey")
			cylinder(d=22, h=tongue_length, center=true, $fn=80);

			translate([-47.7, 30, -13.567])
			color("green")
			cube([24, 135, 24], center=true);
		}
	}
	translate([0, -15.2+(tongue_length/2), 0.6325]) // 0
	difference() {
		translate([-47.7, -7.7, -7.9])
		rotate(90, v=[0,1,0])
		cylinder(h=9.5, d=3.75, center=true, $fn=80);	
		
		translate([-47.7, -7.7, 5.8])
		color("blue")
		cube([26, 5, 24], center=true);
	
	}
}