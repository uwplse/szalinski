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

// smoothness Exponent
detail = 6; // [2:10]





/* [Details] */

// length (mm)
length = 100;  // [50:200]

// detail size
circleDiameter = 3;  // [1:16]

// number of twisty pairs (pairs)
tMax = 7;  // [1:16]

// radius before offset (mm)
radius = 5;  // [1:16]

// offset makes shape (mm)
offset = -2;  // [-16:16]

// number of 1/4 turns (turns)
num = 8;  // [1:32]

// number of strand sides
sides = 16;  // [3:32]


/* [Hidden] */
n = num/4;



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
		union()
		{
			for(t=[0:tMax-1], s=[-1:2:1])
			rotate(t*360/tMax, [0, 0, 1])
			translate([offset, 0, 0])
			linear_extrude(height=length, center=false, 
				convexity=10, twist=s*n*360)
			translate([radius, 0, 0])
			circle(r = circleDiameter/2, $fn=sides);
		}

		// build chamber size limiter
		cube(MakerBotSize, center = true);
	}
	// cross-section option
	if (crossSection > 0)
		translate(crossSectionOffset)
			cube(crossSectionSize, center=true);
}



