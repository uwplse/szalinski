spacerDiameter = 4;
spacerWidth = 32;
spacerThickness = 1;
wallThickness = 2;
wallHeight = 10;


difference() {
	union() {
		translate([0,wallThickness/2,0])
		cube([spacerWidth,wallThickness,wallHeight],center=true);

		SpacerWrapper();
	}
	SpacerHole();
}

module SpacerWrapper() {
	for (xPos = [-spacerWidth/2, spacerWidth/2]) {
		translate([xPos,(spacerDiameter+spacerThickness*2)/2,0])
		cylinder(d=spacerDiameter+spacerThickness*2,h=wallHeight,$fn=64,center=true);
	}
}
module SpacerHole() {
	for (xPos = [-spacerWidth/2, spacerWidth/2]) {
		translate([xPos,(spacerDiameter+spacerThickness*2)/2,0])
		cylinder(d=spacerDiameter,h=wallHeight+2,$fn=64,center=true);
	}
}