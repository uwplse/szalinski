// configured for customizer

// Height of the test ring (steps on the column will be 1/2 this height)
height = 4;		// [4:10]

// Diameter of the inner hole (the target test size)
holeID = 5;		// [4:10]

// Difference between successive rings on the column (in 1/100 of a mm; 5 = 0.05 mm)
offsetStep = 20;		// [5:100]

// How many steps should there be on the column (beyond the full size ring at the bottom)
steps = 5;


// variables below here will not show up in the customizer

$fn=50 + 0; // How many slices should the circles have (circle accuracy)

radius = holeID / 2;
outerRadius = radius + max(2, radius/2);
halfHeight = height / 2;

difference()
{
	cylinder(r=outerRadius, h=height);
	translate([0,0,-1])
		cylinder(r=radius, h=height+2);
}

//color("red")
translate([0, outerRadius + radius + 2, 0])
{
	for (i = [0:steps])
	{
		translate([0,0,i*halfHeight])
			cylinder(r=radius - (i*(offsetStep/100)), h=halfHeight);
	}
}