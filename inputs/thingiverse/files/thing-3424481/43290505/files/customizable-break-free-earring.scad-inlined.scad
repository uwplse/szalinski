

claspType = "pinch"; // [pinch, loop]

// this affects the roundness of the spiral
$fa = 2;

breakFreeEarring(claspType = claspType,
					radius = 25,
					spirals = 6,
					thickness = 2.5);


module breakFreeEarring(claspType = "pinch",
						height = 3,
						radius = 30,
						spirals = 7,
						thickness = 3.5)
{
	union()
	{
		breakFreeEarring_spiral(height, radius, spirals, thickness);

		breakFreeEarring_center(height);

		breakFreeEarring_clasp(claspType = claspType, height = height, radius = radius);
	}
}

// support modules follow

module breakFreeEarring_center(height)
{
	cylinder(r=5, h=height, center=true);
}

module breakFreeEarring_clasp(claspType, height, radius)
{
	if(claspType == "pinch")
	{
		breakFreeEarring_clasp_pinch(height = height,
										radius = radius);
	}
	else
	{
		// the default is the loop to add a user provided clasp
		breakFreeEarring_clasp_loop(height = height,
									spiralRadius = radius);
	}
}

module breakFreeEarring_clasp_loop(height, spiralRadius)
{
	radius = 5;

	translate([spiralRadius + radius, 0, 0])
	difference()
	{
		cylinder(r=radius, h=height, center=true, $fn=30);

		cylinder(r=radius-2, h=height+0.1, center=true, $fn=30);
	}
}

module breakFreeEarring_clasp_pinch(height, radius)
{
	xyLength = 10;

	// this is the slanted pincher part
	zTranslate = 8.5;
	translate([0.5, 0, zTranslate])
	rotate([0, 7.5, 0])
	breakFreeEarring_clasp_pinch_bottom(height = height,
										radius = radius,
										thick = "no",
										xyLength = xyLength);

	// ths is the connector for the pincher parts
	translate([radius, -(xyLength / 2.0), 0])
	cube([4, xyLength, zTranslate / 2.0]);

	breakFreeEarring_clasp_pinch_bottom(height = height,
										radius = radius,
										thick = "yes",
										xyLength = xyLength);
}

module breakFreeEarring_clasp_pinch_bottom(height, radius, thick, xyLength)
{
	xTranslate = radius + (xyLength / 2.0);

	zHeight = thick == "yes" ? height : height - 2;

	translate([xTranslate, 0, 0])
	cube([xyLength, xyLength, zHeight], center = true);

	breakFreeEarring_clasp_pinch_bottomEnd(height, radius, xyLength);
}

module breakFreeEarring_clasp_pinch_bottomEnd(height, radius, xyLength)
{
	xTranslate = radius + xyLength;

	translate([xTranslate, 0, 0])
	rotate([90, 0, 0])
	cylinder(r=height/2.0, h=xyLength, center=true, $fn=30);
}

module breakFreeEarring_spiral(height, radius, spirals, thickness)
{
	zScale = height;

	linear_extrude(height=height, center=true, convexity=10, twist=0)
	scale([1, 1, zScale])
	archimedean_spiral(rmax = radius,
						spirals = spirals,
						thickness = thickness);
}

// spirals   = how many spirals
// thickness = how thick you want the arms to be
// rmax      = maximum radius
module archimedean_spiral(spirals=1, thickness=1, rmax = 100){
s = spirals*360;
t = thickness;
a = sqrt(pow(rmax,2)/(pow(s,2)*(pow(cos(s),2) + pow(sin(s),2))));
points=[
	for(i = [0:$fa:s]) [
		(i*a)*cos(i),
		(i*a)*sin(i)
	]
];
points_inner=[
	for(i = [s:-$fa:0]) [
		(((i*a)+t)*cos(i)),
		(((i*a)+t)*sin(i))
	]
];
polygon(concat(points,points_inner));
} 