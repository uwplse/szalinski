// Interior width of the parts bin
binWidth = 49;

// Interior length of the parts bin
binDepth = 130;

// Interior height of the parts bin
binHeight = 30;

// How many partitions?
partitions = 4; // [2, 3, 4]

// Height of the mating portion, 0 for none
wedgeHeight = 18;

// Diameter of the 1/2 circle mating portion
wedgeDiameter = 4;

// Should be a whole multiple of extrusion width
wallThickness = 2.1;

// Twice the layer thickness is recommended, 0 for none
anchorThickness = 0.4;

wall (binWidth, wallThickness, binHeight);
translate ([(binWidth) / 2, 0, 0])
	anchor (wedgeDiameter, wedgeHeight);
rotate([0, 0, 180])
	translate ([(binWidth) / 2, 0, 0])
		anchor (wedgeDiameter, wedgeHeight);

offset = wedgeDiameter * .66;
remainingWidth = binWidth - offset;
partialLength =  sqrt (pow ((binDepth/2), 2) + pow (remainingWidth, 2));
partialAngle = asin (binDepth/2/partialLength);

if (partitions > 2)
{
    translate ([offset, binDepth / 4, 0])
        rotate ([0, 0, partialAngle])
            wall (partialLength, wallThickness, binHeight, true, false);

    if (partitions == 4)
    {
        translate ([-offset, -binDepth / 4, 0])
            rotate ([0, 0, partialAngle])
                wall (partialLength, wallThickness, binHeight, false, true);
    }
}

module wall (length, thickness, height, leftAnchor=true, rightAnchor=true)
{
	union ()
	{
		translate([-(length/2 - thickness/2), -thickness/2, 0])
			cube([length - thickness, thickness, height]);

		for (x=[-1,1])
		{
			translate([x*((length - thickness)/2), 0, 0])
				cylinder(r=thickness/2, h=height, $fn=20);	
		}

		// Integral bed anchors
		if (leftAnchor)
			translate([length/2, 0, 0])
				cylinder(r=thickness*3, h=anchorThickness, $fn=20);	
		if (rightAnchor)
			translate([-length/2, 0, 0])
				cylinder(r=thickness*3, h=anchorThickness, $fn=20);		
	}
}

module anchor (width, height)
{
	difference ()
	{
		cylinder(r=(width / 2), h=height, $fn=20);
		translate([0, -width / 2 -1, -1])
			cube([width, width + 2, height + 2]);
	}
}
