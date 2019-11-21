// The length off the hanger
hangerLength = 170;

// Space between the holes
hangerHoleSpacing = 10;

// Radius of the holes
holeRadius = 2;

/* [HIDDEN] */
hangerHeight = 10;
hangerWidth = 3;

standWall = 5;

hangerConnectorHeight = 5;

$fn = 360;

for(i = [0:0]) {
	translate([0, (hangerHeight + 5) * i, 0])
		hanger();
}

module stand() {
	linear_extrude(height = standWall, center = true, convexity = 10)
   	import(file = "stand.dxf");
}

module hanger() {
	difference() {
		cube([hangerLength, hangerHeight, hangerWidth]);

		for(a = [1 : hangerLength / hangerHoleSpacing - 1]) {
			translate([hangerHoleSpacing * a, hangerHeight / 2, -1])	
				cylinder(h = hangerWidth + 2, r = holeRadius, $fn=360);
		}
	}

	translate([-standWall, (hangerHeight - hangerConnectorHeight) / 2, 0])
		cube([standWall, hangerConnectorHeight, hangerWidth]);

	translate([hangerLength, (hangerHeight - hangerConnectorHeight) / 2, 0])
		cube([standWall, hangerConnectorHeight, hangerWidth]);
}