// Shelf Camera Clip
// Hari Wiguna, 2014

clipWidth = 30;
clipDepth = 20;
clipTopThick = 5;
clipBottomThick = 2;
clipFrontThick = 2;

// Thickness of the shelf where we would clip this onto
shelfThick = 17.66;

// Slit where the angle bracket slides into
slitHeight = 2.56;
slitWidth = 16;

blockHeight = clipTopThick + shelfThick + clipBottomThick;

rotate([90,0,0])
difference()
{
	// ClipBlock
	cube([clipWidth, clipDepth, blockHeight]);

	// Opening for the shelf where we would clip this onto
	translate([0,clipFrontThick,clipBottomThick]) cube([clipWidth, clipDepth, shelfThick]);

	// Slit for the angle bracket
	translate([(clipWidth-slitWidth)/2, 0, clipBottomThick+shelfThick+1]) cube([slitWidth, clipDepth, slitHeight]);
}
