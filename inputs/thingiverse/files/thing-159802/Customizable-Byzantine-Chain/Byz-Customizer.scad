// preview[view:south, tilt:top]

numSegments = 4;
numMiddleLinks = 2;
// Diameter of ring in mm
wireDiameter = 2;
// Aspect ratio of the ring (Inner diameter/Wire diameter)
// Ring AR range for Byzantine is greater than 3.2.  For a different number of middle links, larger ARs are needed to fit.
ringAR = 4;

// Smoothness factor (larger = smoother, but longer to generate stl)
smoothness = 20;

for (i=[1:numSegments])
{
	rotate([(i%2)*90, 0, 0])
	translate([i*(ringAR*wireDiameter*cos(25)-wireDiameter+wireDiameter*ringAR),0,0])
	union()
	{
		translate([-wireDiameter/2,0,0])
		angledPair(25);
		rotate([90,180,0])
		angledPair(25);
		translate([ringAR*wireDiameter-wireDiameter,0,0])
		rotate([90,0,0])
		union()
		{
			for (j=[1:numMiddleLinks])
			{
				if (numMiddleLinks%2==1)
				{
					translate([0,0,pow(-1,j)*round((j-1)/2)*wireDiameter])
					ring(wireDiameter,ringAR);
				}
				else
				{
					translate([0,0,pow(-1,j%2)*(round(j/2)*wireDiameter-wireDiameter*49/100)])
					ring(wireDiameter,ringAR);
				}
			}
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