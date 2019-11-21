baseLength = 150;
baseWidth = 78;
height = 62;
topLength = 158;
thickness = 2;
radius = 2;
$fn = 120;
keysWidth = 60;
keysDepth = 22;
brimRadius = 4;
trifle = 0.000000000000001;

union() { 
	translate([-baseLength/2+thickness/2, -baseWidth/2+thickness/2, -trifle]) minkowski() {
		cube([baseLength-radius, baseWidth-radius, thickness/2]);
		cylinder(r = radius, h = thickness/2);
	}

	translate([0, 0, thickness]) linear_extrude(height = height, scale = topLength/baseLength) union() {
			difference() {
				roundedRect([baseLength, baseWidth], radius);
				roundedRect([baseLength-2*thickness, baseWidth-2*thickness], radius);
			}
			translate([-baseLength/2, -baseWidth/2+keysDepth, 0]) square([baseLength, thickness]);
			translate([-baseLength/2+keysWidth, -baseWidth/2, 0]) square([thickness, keysDepth]);
	}

	translate([-topLength/2-thickness*2.5, (baseWidth*topLength/baseLength)/2, height+thickness+trifle]) rotate([90, 0, 0]) rotate_extrude(angle = 90) translate([brimRadius, 0, 0]) square([thickness, baseWidth*topLength/baseLength-thickness]);

	translate([topLength/2+thickness*2.5, -(baseWidth*topLength/baseLength)/2, height+thickness+trifle]) rotate([90, 0, 180]) rotate_extrude(angle = 90) translate([brimRadius, 0, 0]) square([thickness, baseWidth*topLength/baseLength-thickness]);
}

// size - [x,y]
// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];

	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r = radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r = radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r = radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r = radius);
	}
}
