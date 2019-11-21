// Pet Food Slicer
// Hari Wiguna, 2014

sliceDiameter = 76;
sliceRadius = sliceDiameter/2;
sliceCount = 6;
sliceHeight = 10; //41;
thickness = 1.5;

stemRadius = 5;
stemHeight = 40;
handleRadius = 10;
handleHeight = 4;

$fn = 36;

union() {

	//-- Slicers --
	for (r=[1:sliceCount])
	{
		rotate(360*r/sliceCount,[0,0,1])
			translate([0,-thickness/2,0])
				cube([sliceRadius,thickness,sliceHeight]);
	}

	//-- Stem base --
	cylinder(sliceHeight,stemRadius,0);

	//-- Handle --
	translate([sliceRadius+handleRadius+10,0,0]) 
		Handle();
}


module Handle()
{
	union() {
		cylinder(stemHeight,stemRadius,stemRadius);
		cylinder(h=handleHeight,r=handleRadius, $fn=6);
	}
}