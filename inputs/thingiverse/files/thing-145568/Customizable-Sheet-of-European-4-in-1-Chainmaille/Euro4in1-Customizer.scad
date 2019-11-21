// preview[view:south, tilt:top]

numRows = 4;
numCols = 4;
// Diameter of ring in mm
wireDiameter = 2;
// Aspect ratio of the ring (Inner diameter/Wire diameter)
// Euro 4:1 has a minimum of 2.9 However, my script starts fusing rings together below 3.3
ringAR = 4;

// Smoothness factor (larger = smoother, but longer to generate stl)
smoothness = 40;

for (i = [1:numRows])
{
	for (j = [1:numCols])
	{
		translate([0,j*(wireDiameter/sin(45)/2+ringAR*wireDiameter/2),0])
		if (abs(i)%2==1)
		{
			rotate([45,0,0])
			translate([(i+1)*(wireDiameter*2+ringAR*wireDiameter)/2, 0, wireDiameter*ringAR/4])
			ring(wireDiameter, ringAR);
		}
		else
		{
			rotate([-45,0,0])
			translate([(i-1)*(wireDiameter*2+ringAR*wireDiameter)/2+(wireDiameter*2+ringAR*wireDiameter), 0, wireDiameter*ringAR/4])
			ring(wireDiameter, ringAR);
		}
	}
}

module ring(wd, ar)
{
	rotate_extrude(convexity = 10, $fn=smoothness)
	translate([ar*wd/2+wd/2, 0, 0])
	circle(r = wd/2, $fn=smoothness);
}