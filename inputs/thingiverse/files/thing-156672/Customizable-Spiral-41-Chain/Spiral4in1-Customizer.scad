// preview[view:south, tilt:top]

numRings = 8;
// Diameter of ring in mm
wireDiameter = 2;
// Aspect ratio of the ring (Inner diameter/Wire diameter)
// Spiral 4:1 has a minimum of 3.4. However, ring placement is illogical below 4.0 (due to the actual weave bunching up, yet still being possible). Choose something slightly above 4.0 to ensure no fusing errors.
ringAR = 4.05;
angle = 25; // [25:60]

// Smoothness factor (larger = smoother, but longer to generate stl)
smoothness = 20;

union()
{
	for (i = [1:numRings])
	{
		rotate([angle*i,0,0])
		translate([i*(wireDiameter*ringAR+wireDiameter*2+wireDiameter/100)/3,0,0])
		ring(wireDiameter, ringAR);
	}
}

module ring(wd, ar)
{
	rotate_extrude(convexity = 10, $fn=smoothness)
	translate([ar*wd/2+wd/2, 0, 0])
	circle(r = wd/2, $fn=smoothness);
}