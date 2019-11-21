/* [Module type] */

// Type of the module you want to create
ModuleType="plateWithRectHoles"; // [Fixture, plateForTube, plateWithRectHoles]

/* [Common values for all modules types] */

// Height of the fixture
FixHeight=30; // [10:100]

// Depth of the fixture
FixDepth=12;  // [10:100]

// Tichness of the fixture (dans modules)
FixThickness=3.2; // [2:6]

// space between male and female parts in the fixture (between 0.1 and 0.4)
loose=0.2;

/* [Fixture module parameters] */

// diameter of the hole where you insert the screws
FixAnchorHoles=3.6; // [1:6]

// length of the fixture
FixLength=150;  // [20:300]


/* [plateForTube parameters] */
// Diameter of the container
PlateForTubeDiam=90; // [20:150]

// Depth of the tube 
PlateForTubeDepth=60; // [1:150]

// Tube resolution
PlateForTubeResolution=360; // [3:360]


/* [plateWithRectHole parameters] */
// Hole dim X
PlateWithRectHoleX=25; // [1:100]

// Hole dim Y
PlateWithRectHoleY=5; // [1:100]

// number of holes
PlateWithRectHoleQt=2; // [1:10]

/* [Hidden] */
screwPos1=FixLength * 0.25;
screwPos2=FixLength * 0.75;

base();

module base()
{
	if(ModuleType == "Fixture")
		rotate([0,-90,0]) fixture(length=FixLength, height=FixHeight, width=FixDepth, thickness=FixThickness);

	if(ModuleType == "plateForTube")
		rotate([-90,-90,0]) plateForTube(diam=PlateForTubeDiam + loose*2, depth=PlateForTubeDepth);

	if(ModuleType == "plateWithRectHoles")
		/*rotate([0,-90,0])*/ plateWithRectHoles(holeX=PlateWithRectHoleX, holeY=PlateWithRectHoleY, qtHoles=PlateWithRectHoleQt); 

}


module fixture(length=100, width=10, height=25, thickness=2.4)
{
	screwPos1=FixLength * 0.25;
	screwPos2=FixLength * 0.75;

	// fixture body
	difference()
	{
		cube([length, width,height]);
		union()
		{
			translate([-1,thickness,thickness]) cube([length+2, width - thickness * 2, height - thickness * 2]);
			translate([-1, -1, thickness * 2]) cube([length + 2, thickness * 2, height - thickness * 4]);
		}
	}
	
	// fixture anchors
	union()
	{
		difference()
		{
			translate([screwPos1 - 5, width - thickness, height]) cube([10, thickness, 10]);
			translate([screwPos1, width+1, height+5]) rotate([90,0,0]) cylinder(h=thickness+2, d=FixAnchorHoles, center=false, $fn=PlateForTubeResolution);
		}
		difference()
		{
			translate([screwPos2 - 5, width - thickness, height]) cube([10, thickness, 10]);
			translate([screwPos2, width+1, height+5]) rotate([90,0,0]) cylinder(h=thickness+2, d=FixAnchorHoles, center=false, $fn=PlateForTubeResolution);
		}
	}
}

module plateForTube(diam, depth)
{
	zpos=-(((depth+FixThickness*2) - ((FixHeight/2) - (FixThickness*2)) - FixThickness*1.5) - FixThickness);
	difference()
	{
		union()
		{
			insert(length=diam+FixThickness*2, stripLength=diam+FixThickness*3);
			translate([((diam+FixThickness*2)/2),
				-(((diam+FixThickness*2)/2)+FixThickness*2), 
				-((depth+FixThickness*2) - ((FixHeight/2) - (FixThickness*2)) - FixThickness*1.5)]) 
					cylinder(h=depth+FixThickness*2, d=diam+FixThickness*2, $fn=PlateForTubeResolution);
		}
		translate([diam/2 +FixThickness, -(diam/2 + FixThickness*3), zpos]) 
			cylinder(h=depth+FixThickness*2, d=diam, $fn=PlateForTubeResolution);
		translate([diam +FixThickness, -(diam/2 + FixThickness*3 ), zpos ])
			cylinder(h=depth-FixThickness, d=diam, $fn=PlateForTubeResolution);
		translate([FixThickness, -(diam/2 + FixThickness*3 ), zpos])
			cylinder(h=depth-FixThickness, d=diam, $fn=PlateForTubeResolution);
	}
	
}

module plateWithRectHoles(holeX, holeY, qtHoles=1)  
{
	difference()
	{
		insert(length=holeX + FixThickness * 2, stripLength=(holeY + FixThickness * 2) * qtHoles);
		for(curHole=[1:qtHoles])
			translate([FixThickness, 
					-((holeY+(FixThickness*2)) * curHole), 
					((FixHeight/2) - (FixThickness*2))-1]) 
				cube([holeX, holeY, FixThickness * 2]);
	}
}
module insert(length, stripLength=4)
{
	union()
	{
		color("red") cube([length, (FixDepth - (FixThickness * 2)) , FixHeight - ((FixThickness * 2) - loose)]);
		color("orange") translate([0, -(FixThickness), FixThickness + loose]) cube([length, FixThickness, (FixHeight - (FixThickness * 2)) /2 ]);
		color("yellow") translate([0,-((FixThickness * 2) + (stripLength - FixThickness)), (FixHeight/2) - (FixThickness*2)]) 
			cube([length, stripLength, FixThickness*1.5]);
	}
}