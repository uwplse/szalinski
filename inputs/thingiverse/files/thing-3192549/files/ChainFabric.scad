
/* [Sheet] */

// Maximum width (in mm) of the sheet
width = 210;

// Maximum height (in mm) of the sheet
height = 250;

// Adjusts what peices are connectors
connectorStyle = 1; // [0:None, 1:Two Edges, 2:All Pieces]

/* [Links] */

outerRadius = 7.5;

innerRadius = 6;

// Height of the horizontal bars
thickness = .9;

// Height of vertical beams
connectorHeight = .6;

// Amount to translate each link (relative to the outer radius)
translateMultiplier = 1.1;

// Size of gap for connector pieces (relative to the thickness)
connectorHoleMultiplier = .25;

/* [Hidden] */

$fs = 1;
$fa = 1;

or = outerRadius;
ir = innerRadius;

translateAmount = or * translateMultiplier;


module subpiece()
	linear_extrude(height=thickness, center=true)
		translate([or/2, or/2, 0])
			rotate(-45)
				translate([0, ir/2 - or/2])
					square([sqrt(2) * (or), or - ir], center=true);

module subpieceConnector()
	linear_extrude(height=connectorHeight, center=true)
		translate([or - sqrt(2) * (or - ir)/2, 0, 0])
			rotate(45)
				square(or - ir, center=true);

module piece() {
	for(i = [0 : 90 : 359])
		rotate(i) {
			subpieceConnector();
			translate([0, 0, (i % 180 ? 1 : -1) * (connectorHeight/2 + thickness/2)])
				subpiece();
		}
}

module connector()
	difference(){
		piece();

		rotate(45)
			translate([-or/2, 0, -thickness/2 -connectorHeight/2])
				rotate([30])
					cube([or, thickness * connectorHoleMultiplier, thickness * 2 + connectorHeight * 2], center=true);
	}

translate([or, or])
	for(i = [0 : translateAmount : width - or * translateMultiplier])
		for(j = [0 : translateAmount : height - or * translateMultiplier])
			translate([i, j])
				if(connectorStyle == 0)
					piece();
				else if(connectorStyle == 2)
					connector();
				else if(i == 0 || j == 0)
					connector();
				else
					piece();
