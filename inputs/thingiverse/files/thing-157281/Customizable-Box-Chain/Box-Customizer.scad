// preview[view:south, tilt:top]

numSegments = 4;
// Diameter of ring in mm
wireDiameter = 2;
// Aspect ratio of the ring (Inner diameter/Wire diameter)
// Ring AR range for Box is greater than 3.8. However, it does not maintain a square cross section below an AR of 4.8. Fusing from script begins around an AR of 4.0.
ringAR = 4.8;

// Smoothness factor (larger = smoother, but longer to generate stl)
smoothness = 40;

for (i=[1:numSegments])
{
	if (ringAR>=4.8)
	{
		translate([i*(ringAR*wireDiameter*cos(32.5)-wireDiameter*0.5),0,0])
		union()
		{
			angledPair(32.5);
			rotate([90,180,0])
			angledPair(32.5);
		}
	}
	// Make the rings asymmetrically angled
	else
	{
		translate([i*(ringAR*wireDiameter*cos(32.5)-wireDiameter*0.65),0,0])
		union()
		{
			angledPair(32.5-10);
			rotate([90,180,0])
			translate([-wireDiameter/4,0,0])
			angledPair(32.5+10);
		}
	}
}

module angledPair(angle)
{
	union()
	{
		translate([0,0,(wireDiameter+wireDiameter*ringAR)*sin(angle)/2+wireDiameter/2])
		rotate([0,angle,0])
		ring(wireDiameter,ringAR);

		translate([0,0,-(wireDiameter+wireDiameter*ringAR)*sin(angle)/2-wireDiameter/2])
		rotate([0,-angle,0])
		ring(wireDiameter,ringAR);
	}
}

module ring(wd, ar)
{
	rotate_extrude(convexity = 10, $fn=smoothness)
	translate([ar*wd/2+wd/2, 0, 0])
	circle(r = wd/2, $fn=smoothness);
}