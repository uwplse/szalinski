use <utils/build_plate.scad>
use <write/Write.scad>


// preview[view:south, tilt:top diagonal]

// minimum interior diameter of container
_insideDiameter = 18;

// height of the container's interior space
_interiorHeight = 12;

// radius of rounding of edges
_rounding = 8;

// overhang angle for the container (too horizontal of an angle - close to 0 - will require support)
_overhangAngle = 45;

// the thinnest walls of the container will use this value
_minimumWallThickness = 1.0;

// horizontal thickness used for the bottom layer
_bottomThickness = 0.8;

// height of the lip between the parts
_lipHeight = 2.4;

// how far the locking bayonets protrude
_bayonetDepth = 0.6;

// gap between moving parts to adjust how tightly the pieces fit together
_partGap = 0.12;

// text rendered on each side
_labelText = "";

// font used to render the label
_labelFont = "write/orbitron.dxf"; // ["write/orbitron.dxf":Orbitron, "write/letters.dxf":Basic, "write/knewave.dxf":KneWave, "write/BlackRose.dxf":BlackRose, "write/braille.dxf":Braille]

// height of the label in mm
_labelHeight = 8;

// depth of the label (negative values to emboss, positive values to extrude)
_labelDepth = -0.3;

// rotation of the text label
_labelRotation = 0;


////////////////////////////////////////////////////////////////////////

build_plate(0);
make();


module make($fn=90) {
	twistAngle = 60; // amount of twist to close the lid
	bayonetAngle = 30; // angular size of the bayonets
	numberOfSides  = 3; // text is hard coded to work with 3 sides

	// override these to specify exterior dimensions instead of interior dimensions
	outsideDiameter = _insideDiameter + 2*(_minimumWallThickness*2 + _partGap + _bayonetDepth);
	separatorHeight = _interiorHeight + _bottomThickness;

	makePart(outsideDiameter, separatorHeight, numberOfSides, _rounding, _overhangAngle,
						_minimumWallThickness, _bottomThickness, 
						_lipHeight, _bayonetDepth, bayonetAngle, _partGap, 
						twistAngle,
						_labelText, _labelFont, _labelHeight, _labelDepth, _labelRotation);
}



module makePart(diameter, height, sides, rounding, overhang, wall, base, lipHeight, bayonetDepth, bayonetAngle, partGap, twistAngle, label, lfont, lheight, ldepth, lrotation) {
	height = max(height, base+lipHeight);
	radius = diameter/2;
	innerRadius = radius - wall*2 - bayonetDepth - partGap;
	middleRadius = radius - wall - bayonetDepth;
	wallThickness = radius - innerRadius;
	fullHeight = height + lipHeight;
	topBayonetAngle = bayonetAngle+3;
	chamfer = bayonetDepth;
	bayonetHeight = (lipHeight-chamfer)/2;
	angledCutDistance = (innerRadius+wall)*1.5;
	angledCutHeight = angledCutDistance * tan(overhang);
	eps = 0.1;

	difference() {
		union() {
			difference() {
				union() {
					// lip
					cylinder(r=innerRadius+wall, h=fullHeight);

					// body
					translate([0,0,lipHeight]) {
						polyCylinder(sides, radius, height + angledCutHeight, rounding);
					}
				}
				// overhang cut
				rotate_extrude(convexity = 4) {
					polygon(points = [ [innerRadius+wall, lipHeight], 
											 [2*angledCutDistance, lipHeight-eps],
											 [2*angledCutDistance,  lipHeight + angledCutHeight] ], 
											 paths = [[0,1,2]], convexity = 2);
				}
			}

			// bayonet
			rotate([0,0,-45]) {
				thread(innerRadius+wall-eps, innerRadius+wall+bayonetDepth, 
						bayonetAngle, bayonetHeight, bayonetHeight/2, 0, 
						chamfer, innerRadius, innerRadius+wall);
			}

			// extrude label
			if (ldepth > 0) {
				label(label, lfont, lheight, ldepth, -diameter/2, lipHeight + height/2 + (wall + bayonetDepth)*tan(overhang), lrotation);
			}
		}

		// embossed label
		if (ldepth < 0) {
			label(label, lfont, lheight, ldepth, -diameter/2, lipHeight + height/2 + (wall + bayonetDepth)*tan(overhang), lrotation);
		}

		// inner cutout
		translate([0,0,base]) {
			cylinder(r=innerRadius, h=fullHeight + angledCutHeight);
		}
		hull() {
			translate([0,0,lipHeight+max(wall,base)]) {
				cylinder(r=innerRadius, h=fullHeight + angledCutHeight);
			}
			translate([0,0,height]) {
				cylinder(r=middleRadius, h=fullHeight + angledCutHeight);
			}
		}

		// thread cutout
		translate([0,0,fullHeight-lipHeight-partGap]) {
			cylinder(r=middleRadius, h=lipHeight+partGap+eps);
		}

		// top thread
		rotate([0,0,45]) {
			thread(middleRadius-eps, middleRadius+bayonetDepth, 
					topBayonetAngle, lipHeight*2, fullHeight, twistAngle + topBayonetAngle);	

			thread(middleRadius-eps, middleRadius+bayonetDepth, 
					topBayonetAngle+twistAngle, bayonetHeight + eps, 
					fullHeight - lipHeight + bayonetHeight/2 + eps/2, 
					twistAngle + topBayonetAngle, 
					chamfer, middleRadius-eps, middleRadius);
		}

		// angled cut
		rotate_extrude(convexity = 4) {
			polygon(points = [ [innerRadius+wall, fullHeight], 
								 [innerRadius+wall, fullHeight + angledCutHeight + eps],
								 [2*angledCutDistance, fullHeight + angledCutHeight] ], 
							 	paths = [[0,1,2]], convexity = 2);
		}
	}
}


module label(text, font, height, depth, y, z, rotate) {
	eps = 0.1;
	if (text != "") {
		for (r = [0:120:360]) {
			rotate([0,0,r])
			translate([0,depth > 0 ? y - depth/2 + eps/2: y - depth/2 - eps/2,z])
			rotate([90,rotate,0])
			write(str(text), t=abs(depth)+eps, h=height, font=font, space=1.1, center=true);
		}
	}
}

module thread(r1, r2, angle, height, yoffset, rotation, chamfer=0, r3=0, r4=0) {
	for(a=[0,120,240])
	rotate([0,0,a + rotation])
	translate([0,0,yoffset]) {
		hull() {
			smallArc(r1, r2, angle, height);
			if (chamfer != 0) {
				translate([0,0,chamfer]) {
					smallArc(r3, r4, angle, height);
				}
			}
		}
	}
}

////////////// Utility Functions ///////////////////

// only works from [0 to 180] degrees, runs clockwise from 12 o'clock
module smallArc(radius0, radius1, angle, depth) {
	thickness = radius1 - radius0;
	eps = 0.01;

	union() {
		difference() {
			// full arc
			cylinder(r=radius1, h=depth, center=true);
			cylinder(r=radius0, h=depth+2*eps, center=true);

			for(z=[0, 180 - angle]) {
				rotate([0,0,z])
				translate([-radius1,0,0])			
				cube(size = [radius1*2, radius1*2, depth+eps], center=true);
			}
		}
	}
}


module polyCylinder(sides, radius, height, rounding) {
	angle = 360/sides;
	hull() {
		for (a=[0:angle:360])
		rotate([0,0,a])
		translate([0,(radius - rounding)/cos(angle/2),0]) {
			cylinder(r=rounding, h=height);
		}
	}
}
