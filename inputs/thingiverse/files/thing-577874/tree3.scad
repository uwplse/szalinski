// Christmas tree
// Created by SimonSnowman, December 2014
// http://www.thingiverse.com/SimonSnowman
// License: Creative Commons Attribution-ShareAlike CC BY-SA 

/*[Trunk]*/

// Height of the trunk
trunkHeight=80; // [50:100]

// Radius of the trunk
trunkRadius=3.5; // [3:5]

/*[Base]*/

// Height of the circular foot
baseHeight=2; // [1:4]

// Radius of the circular foot
baseRadius=20; // [10:30]

// Height of the slopey bit around the bottom of the trunk
skirtHeight=10; // [5:15]

/*[Branches]*/

// Total number of branches
branchCount=50; // [30:100]

// Generally make smaller than trunk
branchRadius=2; // [1,1.5,2,2.5,3,3.5,4]

// Angle between trunk and branches
branchAngle=45; // [30:45]

// Percentage of the trunk (from the top) covered by branches
trunkCoveragePercent=85; // [75:95]

// Length of the spike on the top of the tree
spikeLength=12; // [10:20]

// Angle of tree edge from trunk
topAngle=25; // [20:30]

/*[Hidden]*/
branchMinZ=trunkHeight-((min(100,trunkCoveragePercent)/100)*trunkHeight); // (relative to bottom of trunk)
branchMaxZ=trunkHeight;
$fn=16;

//base
module base()
{
	cylinder(h=baseHeight, r=baseRadius);
}

//trunk - sits on the base
module trunk()
{
	translate([0,0,baseHeight])
		cylinder(h=trunkHeight, r=trunkRadius);
}

// spike - sits on top the trunk
module spike()
{
	translate([0,0,baseHeight+trunkHeight])
		cylinder(h=spikeLength, r=branchRadius);
}

// skirt - slopey bit around the bottom of the trunk
module skirt()
{
	translate([0,0,baseHeight])
		cylinder(h=skirtHeight,r1=baseRadius-(0.75*(baseRadius-trunkRadius)),r2=0);
	translate([0,0,baseHeight])
		cylinder(h=skirtHeight*0.5,r1=baseRadius-(0.5*(baseRadius-trunkRadius)),r2=0);
	translate([0,0,baseHeight])
		cylinder(h=skirtHeight*0.25,r1=baseRadius-(0.25*(baseRadius-trunkRadius)),r2=0);
}

// Tree is divided into 5 72 degree sectors
// numbered 0,3,1,4,2 from the origin.
// Branch index is modded by 5 to give a value 0..4
// The rotation is then a random angle within that sector.
// The effect is that each set of 5 branches is distributed
// fairly around the tree and reduces the change of two
// branches being very close together.
function rotationAngle(branchIndex) =
	// mid-point of the sector
	(36+(144*(branchIndex % 5)))%360
	// +/- 36 degrees
	+rands(-36,36,1)[0];
	
// Evenly spaces branches in the range branchMinZ..branchMaxZ
function branchHeightLinear(branchIndex) =
	baseHeight + branchMinZ + ((branchIndex/(branchCount-1)) * (branchMaxZ - branchMinZ));

// Use sin wave to make branches progressively further apart as we get higher up the tree
function branchHeightSin(branchIndex) =
	baseHeight + branchMinZ + ( (1-sin((branchIndex / (branchCount-1))*90)) * (branchMaxZ - branchMinZ));

function branchLength(branchIndex) =
	20;

module branch_stack()
{
	for (i=[0:branchCount-1])
	{
		assign(bHeight=branchHeightSin(i),zSpin=rotationAngle(i),bLength=branchLength(i))
		{
			echo(i, bHeight, zSpin, bLength);

			translate([0,0,bHeight])
				rotate(a=[0,branchAngle,zSpin])
					cylinder(h=((baseHeight+trunkHeight+spikeLength)-bHeight)*sin(topAngle)/sin(180-topAngle-branchAngle), r=branchRadius);
		}
	}
}

base();
trunk();
spike();
branch_stack();
skirt();

