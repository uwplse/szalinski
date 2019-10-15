// MakerBot Thingiverse Customizer template 
// with build chamber limiter, 
// Replicator model selection, 
// and cross section option.  
// 
// by Les Hall
// 
// started 3-19-2014
// All dimensions are in millimeters.  
// This template works in Customizer.  
// 




/* [General] */

// MakerBot Replicator Model
buildVolume = 4; // [0:Replicator 2X, 1:Replicator 2, 2:Replicator Z18, 3:Replicator Mini, 4:Replicator]

// Make whole thing or half thing
crossSection = 0; // [0:whole thing, 1: positive x half, 2:negative x half, 3:positive y half, 4:negative y half, 5:positive z half, 6:negative z half]

// Thickness (mm)
wallThickness = 6; // [1:256]

// smoothness Exponent
detail = 6; // [2:10]





/* [Details] */




// size of build volume in millimeters
buildSize = [
	[246, 152, 155], 
	[285, 153, 155], 
	[305, 305, 457], 
	[100, 100, 125],
	[252, 199, 150], 
];

// select the build volume by model
MakerBotSize = buildSize[buildVolume];

// determine offset and size of cross section eraser
xs = 2*MakerBotSize[0];
ys = 2*MakerBotSize[1];
zs = 2*MakerBotSize[2];
crossSectionOffsets = [
	[ 0,   0,   0], 
	[-xs,  0,   0], 
	[ xs,  0,   0], 
	[ 0,  -ys,  0], 
	[ 0,   ys,  0], 
	[ 0,   0, -zs], 
	[ 0,   0,  zs]
];
crossSectionOffset = crossSectionOffsets[crossSection];
crossSectionSize = 4*MakerBotSize;

// set level of detail for round shapes
$fn = pow(2, detail);


// make it!
difference()
{
	// use intersection to ensure evertything fits in build chamber
	intersection()
	{
		// your thing goes here
		difference()  // or union or intersection
		{
			// example design:  a hollow sphere
			sphere(r = 0.75*MakerBotSize[1]);
			sphere(r = 0.75*MakerBotSize[1] - wallThickness);
		}
		// build chamber size limiter
		cube(MakerBotSize, center = true);
	}
	// cross-section option
	if (crossSection > 0)
		translate(crossSectionOffset)
			cube(crossSectionSize, center = true);
}



