// Hex key sizes (large to small)
sizes = [4, 3, 2.5, 2, 1.5];
// Extra space in hole around hex key
spacing = 0.5;
// Space between hex keys
padding = 7;
// Height of the holder
height = 20;
// Radius of the rounded corners
radius = 4;

function add(v, i = 0, r = 0) = i < len(v) ? add(v, i + 1, r + v[i]) : r;
function addSub(v, count, i = 0, r = 0) = i < count ? addSub(v, count, i + 1, r + v[i]) : r;

module SlopedCube(size, radius = 0) {
	union() {
		cube([size[0], radius, size[3]]);
		translate([radius, radius])
			minkowski() {
				union() {
					cube([size[0] - radius * 2, size[2] - radius * 2, size[3]]);
					translate([0, size[2] - radius * 2])
						Right_Angled_Triangle(size[1] - size[2], size[0] - radius * 2, size[3]);
				}
				cylinder(r = radius, h = 0.01);
			}
	}
}

module Mount() {
	$fn = 50;
	count = len(sizes);
	mountWidth = 45;
	width = (padding + spacing * 2) * count + add(sizes);
	translate([-width / 2, 0, 0])
		rotate([90])
			union() {
				translate([0, 21])
					rotate([90, 0, 0])
						difference() {
							SlopedCube([width, padding + max(sizes), padding + min(sizes), height], radius);
							for(i = [0: len(sizes) - 1]) {
								size = sizes[i];
								union() {
									translate([padding * i + addSub(sizes, i) + padding, padding / 2 + size / 2, -1])
										cylinder(r = size / 2 + spacing, h = 50);
									translate([padding * i + addSub(sizes, i) + padding,  padding + max(sizes) + size * 0.45, 3])
										rotate([90, 0, 0])
											cylinder(r = size / 2 + spacing, h = padding);
									translate([padding * i + addSub(sizes, i) + padding - size / 2 - spacing, padding / 2 + size / 2, -1])
										cube([size + spacing * 2, 20, 4]);
								}
							}
						}
				translate([(width - mountWidth) / 2, 10 - height / 2, 0.5])
					SkadisMount(count = 2, basePlate = false);
			}
}

Mount();

//-------------

function skadisMountWidth(count = 2) = count * 5 + (count - 1) * 35;

module SkadisMount(count = 2, overhang = 10, overhangHeight = 5, height = 1, basePlate = true, grid = true, hookDepth = 6) {
	holeSpacing = 35;
	holeVericalSpacing = 25;
	union() {
		if (basePlate)
			cube(size = [skadisMountWidth(count), overhang + 4 + (holeVericalSpacing * height), overhangHeight]);
		for (i = [0: (grid ? 1 : count - 1) : count - 1]) {
			for (j = [0: (grid ? 1 : height - 1) : height - 1]) {
				translate([i * (holeSpacing + 5), overhang + (holeVericalSpacing + 15) * j, -10])
					SkadisHook(hookDepth);
			}
		}
	}
}

module SkadisHook(hookDepth = 6) {
	rotate([90, 0 ,0])
		translate([0.5, 6 - hookDepth, 0])
			union() {
				translate([0, 0, -4])
					union() {
						RoundBox(size=[4, 10, 4], radius = 1);
						translate([0, hookDepth, 0])
							cube(size=[4,4,4]);
					}
				RoundBox(size=[4,4,5], radius = 1);
			}
}

module RoundBox(size, radius) {
	translate([radius, radius, 0])
		minkowski() {
			cube(size=[size[0] - radius * 2,size[1] - radius * 2, size[2]]);
			cylinder(r=radius, h=0.01);
		}
}

//------------

/*
Triangles.scad
 Author: Tim Koopman
 https://github.com/tkoopman/Delta-Diamond/blob/master/OpenSCAD/Triangles.scad

         angleCA
           /|\
        a / H \ c
         /  |  \
 angleAB ------- angleBC
            b

Standard Parameters
	center: true/false
		If true same as centerXYZ = [true, true, true]

	centerXYZ: Vector of 3 true/false values [CenterX, CenterY, CenterZ]
		center must be left undef

	height: The 3D height of the Triangle. Ignored if heights defined

	heights: Vector of 3 height values heights @ [angleAB, angleBC, angleCA]
		If CenterZ is true each height will be centered individually, this means
		the shape will be different depending on CenterZ. Most times you will want
		CenterZ to be true to get the shape most people want.
*/

/* 
Triangle
	a: Length of side a
	b: Length of side b
	angle: angle at point angleAB
*/
module Triangle(
			a, b, angle, height=1, heights=undef,
			center=undef, centerXYZ=[false,false,false])
{
	// Calculate Heights at each point
	heightAB = ((heights==undef) ? height : heights[0])/2;
	heightBC = ((heights==undef) ? height : heights[1])/2;
	heightCA = ((heights==undef) ? height : heights[2])/2;
	centerZ = (center || (center==undef && centerXYZ[2]))?0:max(heightAB,heightBC,heightCA);

	// Calculate Offsets for centering
	offsetX = (center || (center==undef && centerXYZ[0]))?((cos(angle)*a)+b)/3:0;
	offsetY = (center || (center==undef && centerXYZ[1]))?(sin(angle)*a)/3:0;
	
	pointAB1 = [-offsetX,-offsetY, centerZ-heightAB];
	pointAB2 = [-offsetX,-offsetY, centerZ+heightAB];
	pointBC1 = [b-offsetX,-offsetY, centerZ-heightBC];
	pointBC2 = [b-offsetX,-offsetY, centerZ+heightBC];
	pointCA1 = [(cos(angle)*a)-offsetX,(sin(angle)*a)-offsetY, centerZ-heightCA];
	pointCA2 = [(cos(angle)*a)-offsetX,(sin(angle)*a)-offsetY, centerZ+heightCA];

	polyhedron(
		points=[	pointAB1, pointBC1, pointCA1,
					pointAB2, pointBC2, pointCA2 ],
		triangles=[	
			[0, 1, 2],
			[3, 5, 4],
			[0, 3, 1],
			[1, 3, 4],
			[1, 4, 2],
			[2, 4, 5],
			[2, 5, 0],
			[0, 5, 3] ] );
}

/*
Isosceles Triangle
	Exactly 2 of the following paramaters must be defined.
	If all 3 defined H will be ignored.
	b: length of side b
	angle: angle at points angleAB & angleBC.
*/
module Isosceles_Triangle(
			b, angle, H=undef, height=1, heights=undef,
			center=undef, centerXYZ=[true, false, false])
{
	valid = 	(angle!=undef)?((angle < 90) && (b!=undef||H!=undef)) : (b!=undef&&H!=undef);
	ANGLE = (angle!=undef) ? angle : atan(H / (b/2));
	a = (b==undef)?(H/sin((180-(angle*2))/2)) : 
		 (b / cos(ANGLE))/2;
	B = (b==undef)? (cos(angle)*a)*2:b;
	if (valid)
	{
		Triangle(a=a, b=B, angle=ANGLE, height=height, heights=heights,
					center=center, centerXYZ=centerXYZ);
	} else {
		echo("Invalid Isosceles_Triangle. Must specify any 2 of b, angle and H, and if angle used angle must be less than 90");
	}
}

/*
Right Angled Triangle
	Create a Right Angled Triangle where the hypotenuse will be calculated.

       |\
      a| \
       |  \
       ----
         b
	a: length of side a
	b: length of side b
*/
module Right_Angled_Triangle(
			a, b, height=1, heights=undef,
			center=undef, centerXYZ=[false, false, false])
{
	Triangle(a=a, b=b, angle=90, height=height, heights=heights,
				center=center, centerXYZ=centerXYZ);
}

/*
Wedge
	Is same as Right Angled Triangle with 2 different heights, and rotated.
	Good for creating support structures.
*/
module Wedge(a, b, w1, w2)
{
	rotate([90,0,0])
		Right_Angled_Triangle(a, b, heights=[w1, w2, w1], centerXYZ=[false, false, true]);
}

/*
Equilateral Triangle
	Create a Equilateral Triangle.

	l: Length of all sides (a, b & c)
	H: Triangle size will be based on the this 2D height
		When using H, l is ignored.
*/
module Equilateral_Triangle(
			l=10, H=undef, height=1, heights=undef,
			center=undef, centerXYZ=[true,false,false])
{
	L = (H==undef)?l:H/sin(60);
	Triangle(a=L,b=L,angle=60,height=height, heights=heights,
				center=center, centerXYZ=centerXYZ);
}

/*
Trapezoid
	Create a Basic Trapezoid (Based on Isosceles_Triangle)

            d
          /----\
         /  |   \
     a  /   H    \ c
       /    |     \
 angle ------------ angle
            b

	b: Length of side b
	angle: Angle at points angleAB & angleBC
	H: The 2D height at which the triangle should be cut to create the trapezoid
	heights: If vector of size 3 (Standard for triangles) both cd & da will be the same height, if vector have 4 values [ab,bc,cd,da] than each point can have different heights.
*/
module Trapezoid(
			b, angle=60, H, height=1, heights=undef,
			center=undef, centerXYZ=[true,false,false])
{
	validAngle = (angle < 90);
	adX = H / tan(angle);

	// Calculate Heights at each point
	heightAB = ((heights==undef) ? height : heights[0])/2;
	heightBC = ((heights==undef) ? height : heights[1])/2;
	heightCD = ((heights==undef) ? height : heights[2])/2;
	heightDA = ((heights==undef) ? height : ((len(heights) > 3)?heights[3]:heights[2]))/2;

	// Centers
	centerX = (center || (center==undef && centerXYZ[0]))?0:b/2;
	centerY = (center || (center==undef && centerXYZ[1]))?0:H/2;
	centerZ = (center || (center==undef && centerXYZ[2]))?0:max(heightAB,heightBC,heightCD,heightDA);

	// Points
	y = H/2;
	bx = b/2;
	dx = (b-(adX*2))/2;

	pointAB1 = [centerX-bx, centerY-y, centerZ-heightAB];
	pointAB2 = [centerX-bx, centerY-y, centerZ+heightAB];
	pointBC1 = [centerX+bx, centerY-y, centerZ-heightBC];
	pointBC2 = [centerX+bx, centerY-y, centerZ+heightBC];
	pointCD1 = [centerX+dx, centerY+y, centerZ-heightCD];
	pointCD2 = [centerX+dx, centerY+y, centerZ+heightCD];
	pointDA1 = [centerX-dx, centerY+y, centerZ-heightDA];
	pointDA2 = [centerX-dx, centerY+y, centerZ+heightDA];

	validH = (adX < b/2);

	if (validAngle && validH)
	{
		polyhedron(
			points=[	pointAB1, pointBC1, pointCD1, pointDA1,
						pointAB2, pointBC2, pointCD2, pointDA2 ],
			triangles=[	
				[0, 1, 2],
				[0, 2, 3],
				[4, 6, 5],
				[4, 7, 6],
				[0, 4, 1],
				[1, 4, 5],
				[1, 5, 2],
				[2, 5, 6],
				[2, 6, 3],
				[3, 6, 7],
				[3, 7, 0],
				[0, 7, 4]	] );
	} else {
		if (!validAngle) echo("Trapezoid invalid, angle must be less than 90");
		else echo("Trapezoid invalid, H is larger than triangle");
	}
}
