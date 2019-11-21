// preview[view:south, tilt:top]

numRings = 8;
// Diameter of ring in mm
wireDiameter = 2;
// Aspect ratio of the ring (Inner diameter/Wire diameter)
// Ring AR range for JPL is 2.7-3.1 Outside this range, the rings will either be fused together or the weave will not stay correctly formed. 
ringAR = 2.8;

// Smoothness factor (larger = smoother, but longer to generate stl)
smoothness = 40;

union()
{
	for (i = [1:numRings])
	{
		rotate([120*(i%3),0,0])
		translate([i*(wireDiameter*ringAR+wireDiameter)/3,0,0])
		rotate([0,-asin(1/(ringAR+1)),0])
		ring(wireDiameter, ringAR);
	}
}

module ring(wd, ar)
{
	rotate_extrude(convexity = 10, $fn=smoothness)
	translate([ar*wd/2+wd/2, 0, 0])
	circle(r = wd/2, $fn=smoothness);
}