// preview[view:south, tilt:top]

numSegments = 4;
// Diameter of ring in mm
wireDiameter = 2;
// Aspect ratio of the ring (Inner diameter/Wire diameter)
// Ring AR range for Power Line is greater than 5.2 realistically. However, this does not translate mathematically due to an orbital connection. Fusing begins in the script around an AR of 6.0.
ringAR = 6.2;

// Smoothness factor (larger = smoother, but longer to generate stl)
smoothness = 20;

for (i=[1:numSegments])
{
	translate([i*(ringAR*wireDiameter*2-wireDiameter*2),0,0])
	rotate([0,0,35])
	union()
	{
		ring(wireDiameter, ringAR);
		rotate([0,90,0])
		separatedPair(sqrt(pow(3*wireDiameter+ringAR*wireDiameter,2)/4+pow(ringAR*wireDiameter,2)/4)+wireDiameter/2,wireDiameter,ringAR);
		rotate([90+35,90,0])
		translate([0,wireDiameter*ringAR-wireDiameter*3/4,-ringAR*wireDiameter/4-wireDiameter/3.8])
		ring(wireDiameter, ringAR);
		rotate([-(90+35),-90,0])
		translate([0,-(wireDiameter*ringAR-wireDiameter*3/4),-ringAR*wireDiameter/4-wireDiameter/3.8])
		ring(wireDiameter, ringAR);
	}
}

module separatedPair(dist, wd, ar)
{
	union()
	{
		translate([0,0,dist/2])
		ring(wd,ar);
		translate([0,0,-dist/2])
		ring(wd,ar);
	}
}

module angledPair(angle, wd, ar)
{
	union()
	{
		translate([0,0,(wd+wd*ar)*sin(angle)/2+wd/2])
		rotate([0,angle,0])
		ring(wd,ar);

		translate([0,0,-(wd+wd*ar)*sin(angle)/2-wd/2])
		rotate([0,-angle,0])
		ring(wd,ar);
	}
}

module ring(wd, ar)
{
	rotate_extrude(convexity = 10, $fn=smoothness)
	translate([ar*wd/2+wd/2, 0, 0])
	circle(r = wd/2, $fn=smoothness);
}