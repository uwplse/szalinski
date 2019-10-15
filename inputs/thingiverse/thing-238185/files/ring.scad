// Radius of the ring, in mm
gRadius=2;

// Height of the ring
gHeight=1;

// Thickness of the ring
gThickness=0.75;

// Number of chunky segments
gSegments=25;

// Quality of the ring in the middle
gQuality=500;

function rand1(lower, upper) = rands(lower, upper, 1)[0];

module ring(radius, height, thickness, segments)
{
	function sphereRotation(sphereI) = 360*sphereI/segments;
	difference()
	{
		for(sphereI = [0 : segments])
		{
			rotate([0,0,sphereRotation(sphereI)])
			translate([radius,0,0])
			rotate([rand1(0,360), rand1(0,360), rand1(0, 360)])
			sphere(center=true, r=thickness*rand1(0.6,1.25), $fn=5);
		}
		cylinder(h=height*5.25, center=true, r=radius-thickness/2, $fn=gQuality);
	}
}

ring(radius=gRadius, height=gHeight, thickness=gThickness, segments=gSegments);

