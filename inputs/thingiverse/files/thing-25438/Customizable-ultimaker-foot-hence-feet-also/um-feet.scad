// The real added height
bottomHeight=14;

// Internal height (snug fit)
internalHeight=12;

// Rounded corner radius
roundness=1;

// How big is the thing in the horizontal plane
cubeSide= 25;

// Wall thickness
outSide= 4;

// Plywood thickness
plyWidth= 6;



// This is rev 2 for thingiverse customizer
// MoonCactus / jeremie.francois@gmail.com / betterprinter.blogspot.com

// The screw data match a standard UM spare
screwDiameter=2.9+0;
screwDistToWalls=0.8+0;
screwHeadDiameter=6+0;
screwHeadDepth=2.2+0;

tol=0.01+0;

translate([-plyWidth-outSide,-plyWidth-outSide,0])
{
	difference()
	{

		minkowski()
		{
			sphere(r=1); // round the main body shape
			difference()
			{

				// Main body
				translate([roundness,roundness,-bottomHeight+roundness])
					cube([cubeSide + plyWidth + outSide -roundness*2, cubeSide + plyWidth + outSide -roundness*2, internalHeight+bottomHeight -roundness*2]);
				// Main cylinder removal
				translate([cubeSide + plyWidth + outSide, cubeSide + plyWidth + outSide,-bottomHeight+roundness-tol])
					cylinder(r=cubeSide-outSide, h=internalHeight+bottomHeight-roundness*2+tol*2);
			}
		}

		// The two grooves (one of them being blind on one side)
		translate([outSide,-tol,0]) cube([plyWidth, cubeSide+plyWidth+outSide+tol*2, internalHeight+tol]);
		translate([-tol+outSide,outSide,0]) cube([cubeSide+plyWidth+tol*2, plyWidth, internalHeight+tol]);

		// Hole for a screw to attach a rubber pad AND to pushes the feet wals against that of the UM for stickier fit
		translate([cubeSide/2+screwDistToWalls, cubeSide/2+screwDistToWalls,-bottomHeight-tol])
		{
			cylinder(r=screwDiameter/2, h=internalHeight+bottomHeight+tol*2, $fn=6);
			cylinder(r=screwDiameter/2, h=screwHeadDepth+2, $fn=20); // 2 easy millimeters to facilitate screwing the screw 
			cylinder(r=screwHeadDiameter/2, h=screwHeadDepth, $fn=20);
		}		


	}
}
