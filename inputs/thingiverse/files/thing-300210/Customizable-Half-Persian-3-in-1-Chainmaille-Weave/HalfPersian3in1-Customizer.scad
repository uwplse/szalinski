// preview[view:south, tilt:top]

numSegments = 4;
// Diameter of ring in mm
wireDiameter = 2;
// Aspect ratio of the ring (Inner diameter/Wire diameter)
// Fusing begins at about AR=4.0
ringAR = 4.2;

// Smoothness factor (larger = smoother, but longer to generate stl)
smoothness = 30;

for (i=[1:numSegments])
{
	translate([i*(ringAR*wireDiameter*cos(32.5)-wireDiameter*0.4),0,0])
	union()
	{
		translate([0,wireDiameter/6,(wireDiameter+wireDiameter*ringAR)*sin(0)/2+wireDiameter/2])
		rotate([0,20,0])
		ring(wireDiameter, ringAR);
		translate([wireDiameter*0.67,0,0])
		rotate([90,180,0])
		translate([0,wireDiameter/6,(wireDiameter+wireDiameter*ringAR)*sin(0)/2+wireDiameter/2])
		rotate([0,20,0])
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