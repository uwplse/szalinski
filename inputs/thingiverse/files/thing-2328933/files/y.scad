fine = 40;						// circles fineness, turn down to 10 while designing for 3d performance reasons

debug = false;                  // enable to produce test part
horizontalCut = false;          // enable to see insides

radIn = 1.3;					// fillament guide radius, 1.2 for 1.75 filament
radPtfe = 2.5;					// ptfe radius, set to radIn if you don't have fittings that let ptfe tube to go straight through
radThread = 5.4/2;				// cylinder radius for M6 screw
radOut = 4.5;					// outter radius

radBig = 110;					// cuvature radius, affects overall part length
angle = acos(1 - 5/radBig);		// 5*2 is the distance betwen 2 inlets to fit both ptfe fittings

module arcTube(radius, angle)
{
	// i'm on OpenSCAD 2015 so no angle in rotate_extrude for me =(

	translate([0, -radBig, 0])
	difference()
	{
		rotate_extrude(angle = 360, $fn = fine*6, convexity = 10)
		{
			translate([radBig, 0, 0])
			circle(r = radius, $fn = fine*2);
		}

		translate([0, -radBig*2, -10])
		cube([radBig*2, radBig*4, radOut + 20]);

		rotate([0, 0,  180 + angle])
		translate([0, -radBig*2, -10])
		cube([radBig*2, radBig*4, radOut + 20]);
	}
}

difference()
{
	// main body
	union()
	{
		arcTube(radOut, angle);
		mirror([0,1,0])
		arcTube(radOut, angle);
		
		rotate([0, 90, 0])
		cylinder(r = radOut, h = 10, $fn = fine*2);
	}

	// fillament channel
	arcTube(radIn, angle);
	mirror([0,1,0])
	arcTube(radIn, angle);

	rotate([0, 90, 0])
	translate([0, 0, -1])
	cylinder(r = radIn, h = 12, $fn = fine);

	// outlet thread
	translate([10, 0, 0])
	rotate([0, -90, 0])
	union()
	{
		translate([0, 0, -1])
		cylinder(r = radThread, h = 4.5 + 1, $fn = fine);
		cylinder(r = radPtfe, h = 7, $fn = fine);
	}

	// inlet thread 1
	translate([0, -radBig, 0])
	rotate([0, 0, angle - 3.5])
	translate([0, radBig, 0])
	translate([-7, 0, 0])
	rotate([0, 90, 0])
	union()
	{
		cylinder(r = radThread, h = 4.5, $fn = fine);
		translate([0, 0, 4.5])
		cylinder(r1 = radThread, r2 = radIn-0.4, h = 7-4.5 + 2, $fn = fine);
	}

	// inlet thread 2
	mirror([0, 1, 0])
	translate([0, -radBig, 0])
	rotate([0, 0, angle - 3.5])
	translate([0, radBig, 0])
	translate([-7, 0, 0])
	rotate([0, 90, 0])
	union()
	{
		cylinder(r = radThread, h = 4.5, $fn = fine);
		translate([0, 0, 4.5])
		cylinder(r1 = radThread, r2 = radIn-0.4, h = 7-4.5 + 2, $fn = fine);
	}

	// cut the bottom of the tube for better printability
	translate([0, 0, -30 - radOut + 0.6])
	translate([-250, -250, 0])
	cube([500, 500, 30]);

    cutOffset = horizontalCut?0:radOut - 0.6;
	translate([0, 0, cutOffset])
	translate([-250, -250, 0])
	cube([500, 500, 30]);

    if(debug)
    {
        translate([-100, -50, -50])
        cube([100, 100, 100]);
    }
}
