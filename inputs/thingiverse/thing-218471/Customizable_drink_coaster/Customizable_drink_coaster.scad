// Diameter of drink coaster [mm]
outerDiameter=130;

difference() {
	cylinder(h = 8, r=outerDiameter/2, $fn=50);
	translate([0,0,4])
		cylinder(h = 4, r=(outerDiameter/2)-4, $fn=50);
}