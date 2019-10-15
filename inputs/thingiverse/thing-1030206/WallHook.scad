height1 = 25;
width = 10;
thickness = 2;

gap = 10;
height2 = 10;

holeDiameter = 2;
holeFromTop = 5;

difference() {
	union() {
		// Wall
		cube([thickness, width, height1]);

		// Base
		translate([thickness, 0, 0])
			cube([gap, width, thickness]);
		
		// Hook
		translate([gap + thickness, 0, 0])
			cube([thickness, width, height2]);
	}
	rotate([0, 90, 0])
		translate([-(height1 - holeFromTop), width/2, -.1])
		cylinder(thickness + .2, holeDiameter/2.0, holeDiameter/2.0);
}