number_of_points = 5; // [4:50]
// Diameter of the star in mm: 
size = 100; // [10:500]
// How much longer than the body should the points of the star be?
point_to_body_ratio = 2.0; // [1.0:5.0]

module ring(radius, rHeight)
{
	linear_extrude(height = rHeight, center = true)
	{
		difference()
		{
			circle(radius, $fn=50);
			circle(radius-rHeight, $fn=50); 
		}// preview[view:south, tilt:top]
	}
}

module star(bodyRadius, numberOfPoints, pointRadius, height)
{
	for (i = [0:numberOfPoints])
	{
		rotate(i*(360/numberOfPoints))
		{
			polyhedron ( points = [[0, 0, height/2], [0, 0, -height/2], [cos(360/numberOfPoints)*bodyRadius, sin(360/numberOfPoints)*bodyRadius, 0], [cos(360-360/numberOfPoints)*bodyRadius, sin(360-360/numberOfPoints)*bodyRadius, 0], [pointRadius, 0, 0]], triangles = [[3,0,4], [0,2,4], [2,1,4], [1,3,4], [0,3,1], [2,0,1],]);
		}
	}
}

module starWithRing(bodyRadius, numberOfPoints, pointRadius, height, ringRadius)
{
	union()
	{
		star(bodyRadius, numberOfPoints, pointRadius, height);
		translate([pointRadius + ringRadius - 1,0,0])
		{
			ring(ringRadius,1);
		}
	}
}
 
if (size < 30)
{
	star(size/(1.0 + point_to_body_ratio)/2, number_of_points, size/2, size/8);
}
else
{
	starWithRing(size/(1.0 + point_to_body_ratio)/2, number_of_points, size/2, size/8, 5);
}