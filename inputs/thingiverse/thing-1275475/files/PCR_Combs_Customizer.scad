// preview[view:south, tilt:top]

/* [Global] */
// Final height of the comb part
materialHeight = 48;
// Final width of the comb part
materialLength = 195;
// Final thickness of the comb part
materialThick = 2;

/* Comb Dimensions] */
// Center to center distance between combs
combRepeat = 9;
// Separation between combs
combGap = 1;
// Vertical length of the comb
combLength = 14;

/* [Side Spacer] */
// Offset for spacing the wells from the base
wellHeight = 2;
// Minimum extra space on the sides
sideSpacer = 3;

/* [Top Parameters] */
// Top half spacing on the other side
spacingMultiplier = 2;
// Separation between combs on the top
combGapTop = 1;

/* [Hidden] */
numCuts = floor((materialLength-2*sideSpacer)/combRepeat);
spacerWidth = (materialLength-numCuts*combRepeat)/2;

module makePart()
{
	difference()
	{
		cube([materialLength,materialHeight,materialThick],center=false);
		union()
		{
			// First Comb
			makeComb(numCuts,spacerWidth,combRepeat,combGap,combLength);
			// Additional spacer block (to shorten combs)
			translate([spacerWidth,-1,-materialThick/2])
			cube([materialLength-2*spacerWidth,wellHeight+1,materialThick*2],center=false);

			// Second Comb
			translate([materialLength,materialHeight,0])
			rotate([0,0,180])
			makeComb(numCuts*spacingMultiplier,spacerWidth,combRepeat/spacingMultiplier,combGapTop,combLength);
			// Second spacer block
			translate([materialLength,materialHeight,0])
			rotate([0,0,180])
			translate([spacerWidth,-1,-materialThick/2])
			cube([materialLength-2*spacerWidth,wellHeight+1,materialThick*2],center=false);
		}
	}
}

module makeComb(numCombs, xStart, xSpace, xGap, height)
{
	for (i=[1:numCombs+1])
	{
		translate([xStart+(i-1)*xSpace-xGap/2,wellHeight-1-wellHeight,-materialThick/2])
		cube([xGap,height+1+wellHeight,materialThick*2],center=false);
	}
}

//projection()
translate([0,0,-materialThickness/2])
makePart();
