
holes=3;
diameter=8;
thickness=3;
height=25;

rotate([90, 0, 0]) {
	difference() {
		cube([diameter*(holes*2+1), diameter*thickness, height]);
	
		translate([thickness, 0, thickness]) {
			cube([diameter*(holes*2+1)-2*thickness, diameter*thickness, height-thickness*2]);
		}
	
		for (i = [1 : holes]) {
			translate([diameter/2+diameter*(2*i-1), diameter*1.5, height-thickness]) {
				cylinder(r=diameter/2, h=thickness, $fn=50);
			}
		}
	}
}
