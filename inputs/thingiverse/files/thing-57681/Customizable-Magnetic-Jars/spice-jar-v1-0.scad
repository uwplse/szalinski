use <utils/build_plate.scad>
use <write/Write.scad>


// preview[view:north west, tilt:top diagonal]

// type of the part to produce
_part = "jar"; // [jar,lid]

// width of the container exterior
_containerSize = 24; // [10:300]

// height of the container (before tilting, not including the lid)
_height = 24; // [10:300]

// tilt of the container
_tilt = 20; // [0:60]

// dimension used for the thinnest walls of the container
_minimumWallThickness = 1.0;

// thickness used for the top of the lid or bottom of the base.  When printing the lid with clear plastic, setting this thickness to print one or two layers will result in a clearer lid.
_horizontalWallThickness = 1.0;

// radius of rounding of the vertical lines, a large radius will produce a cylinder
_rounding = 7;

// height of the lip between lid and base
_lipHeight = 3.0;

// how far the locking bayonets protrude
_bayonetDepth = 0.5;

// gap in mm between the lid and the jar, use this to adjust how tightly it closes
_partGap = 0.1;


// diameter of magnets used in base (optional - set to 0 for none)
_magnetDiameter = 0;

// height of the magnet used in the base
_magnetHeight = 3.1;

// location of the magnets, larger values move it towards the edge, smaller values towards the center.  Make sure this value is not too large, or the cutout for the magnets will protrude beyond the shell of the jar.
_magnetPlacement = 0.75;


// diameter of the holes in the lid
_lidHoleDiameter = 2;

// number of holes in the lid (set to 0 for a solid lid)
_numberOfLidHoles = 0;


// rendered vertically along the spine of the jar or across the lid
_labelText = "";

// font used to render the label
_labelFont = "write/orbitron.dxf"; // ["write/orbitron.dxf":Orbitron, "write/letters.dxf":Basic, "write/knewave.dxf":KneWave, "write/BlackRose.dxf":BlackRose, "write/braille.dxf":Braille]

// depth of the label (negative values to emboss, positive values to extrude)
_labelDepth = -0.3;

// height of the label in mm
_labelHeight = 5;


////////////////////////////////////////////////////////////////////////


build_plate(0);
make();


module make($fn=120) {
	bayonetAngle = 30;
	lidHeight = _lipHeight + _horizontalWallThickness + 0.3;

	if (_part == "jar") {
		makeBase( _tilt, _containerSize, _height,
					_minimumWallThickness, _horizontalWallThickness, 
					_lipHeight, _bayonetDepth, bayonetAngle, _partGap, _rounding,
					_magnetDiameter, _magnetHeight, _magnetPlacement,
					_labelText, _labelFont, _labelHeight, _labelDepth);
	} else if (_part == "lid") {
		makeLid(	_containerSize, lidHeight,
					_minimumWallThickness, _horizontalWallThickness, 
					_lipHeight, _bayonetDepth, bayonetAngle, 
					_rounding, _numberOfLidHoles, _lidHoleDiameter,
					_labelText, _labelFont, _labelHeight, _labelDepth);
	}
}


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


module thread(r1, r2, angle, height, yoffset, rotation, chamfer=0, r3=0, r4=0) {
		for(a=[0:90:360])
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

module makeBase(rotation, diameter, height, wall, base, lipHeight, bayonetDepth, bayonetAngle, partGap, rounding, mdiameter, mheight, mplacement, labelText, labelFont, labelHeight, labelDepth) {
	height = max(max(height, base+lipHeight), diameter*tan(rotation)); // make sure height remains valid
	rounding = min(rounding, diameter/2);
	radius = diameter/2;
	innerRadius = radius - wall*2 - bayonetDepth - partGap;
	fullHeight = height + lipHeight;
	chamfer = bayonetDepth;
	bayonetHeight = (lipHeight-chamfer)/2;
	eps = 0.05;
	mradius=mdiameter/2;

	difference() {
		union() {
			difference() {
				rotate([rotation,0,0])
				translate([0,0,-radius * tan(rotation)]) {
					difference() {
						union() {
							difference() {
								rotate([0,0,45])
								union() {
									// body
									polyCylinder(4, radius, height, rounding);
					
									// lip
									translate([0,0,rounding+eps]) {
										cylinder(r=innerRadius+wall, h=fullHeight-rounding-eps);
									}
				
									// bayonet
									rotate([0,0,15])
									thread(innerRadius+wall-eps, innerRadius+wall+bayonetDepth, 
											bayonetAngle, bayonetHeight, fullHeight - bayonetHeight/2, 0, 
											-chamfer, innerRadius, innerRadius+wall);
								}
			
								// inner cutout
								translate([0,0,-eps]) {
									cylinder(r=innerRadius, h=fullHeight*2);
								}
							}
							
							if (labelDepth > 0) 
								label(labelText, labelFont, labelHeight, labelDepth, radius, height);
						}
							
						if (labelDepth < 0) 
							label(labelText, labelFont, labelHeight, labelDepth, radius, height);
					}

				}
			
				// cut base
				translate([0,0,-diameter/cos(rotation)]) {
					cube(size=diameter/cos(rotation)*2, center=true);
				}
			}
			
			// bottom plate
			hull() {
				translate([0,0,eps/2]) {
					roundRect(2*innerRadius+eps, 2*innerRadius/cos(rotation), eps, rounding);
				}
				translate([0,-base*tan(rotation),base-eps/2]) {
					roundRect(2*innerRadius+eps, 2*innerRadius/cos(rotation), eps, rounding);
				}
			}
			if (mradius > 0 && mheight > 0) {
				magnetCylinders(innerRadius, rotation, mradius+wall, mheight+wall, mplacement);
			}
		}

		// magnets
		if (mradius > 0 && mheight > 0) {
			magnetCylinders(innerRadius, rotation, mradius, mheight, mplacement, eps);
		}
	}
}

module roundRect(width, depth, height, round) {
	round = min(round, width/2);
	hull() {
		for (w=[-1,1])
		for (d=[-1,1])
		translate([w * (width/2 - round),d * (depth/2 - round),0]) {
			cylinder(r=round, h=height, center=true);
		}
	}
}

module label(labelText, labelFont, labelHeight, labelDepth, offset, height) {
	eps = 0.1;
	depthy = offset + labelDepth/2;
	if (labelDepth != 0 && labelText != "") {
		translate([0,labelDepth > 0 ?  depthy - eps : depthy + eps, height/2])

		rotate([90,90,180]) {
			write(labelText, t=abs(labelDepth)+eps, h=labelHeight, font=labelFont, space=1.1, center=true);
		}
	}
}


module magnetCylinders(radius, rotation, mradius, mheight, distance, offset = 0) {
	if (mradius > 0 && mheight > 0) {
		for (x=[-1,1])
		for (y=[-1,1])
		translate([x * radius * distance, y * radius/cos(rotation) * distance, -offset]) {
			cylinder(r=mradius, h=mheight + offset);
		}	
	}
}


module makeLid(diameter, height, wall, base, lipHeight, bayonetDepth, bayonetAngle, rounding, numHoles, holeDiameter, labelText, labelFont, labelHeight, labelDepth) {
	style = "round";
	height = max(height, base+lipHeight);
	bayonetAngle = bayonetAngle+3;
	radius = diameter/2;
	innerRadius = radius - wall - bayonetDepth;
	chamfer = bayonetDepth;
	bayonetHeight = (lipHeight-chamfer)/2;
	twistAngle = 45;
	evenHoles = numHoles - numHoles%2;
	eps = 0.1;

	rotate([0,0,45])
	union() {
		difference() {
			// body (round, hex, knurled)
			polyCylinder(4, radius, height, rounding);
	
			// inner cutout
			translate([0,0,base]) {
				cylinder(r=innerRadius, h=height+eps);
			}
	
			// bayonet
			rotate([0,0,-15]) {
				thread(innerRadius-eps, innerRadius+bayonetDepth, 
						bayonetAngle, lipHeight + eps, height - lipHeight/2 + eps/2, twistAngle + bayonetAngle);
		
				// bayonet
				thread(innerRadius-eps, innerRadius+bayonetDepth, 
						bayonetAngle+twistAngle, bayonetHeight + eps, height - (lipHeight - bayonetHeight/2) + eps/2,	 
						twistAngle + bayonetAngle, 
						chamfer, innerRadius-eps, innerRadius);
			}		
	
			// embossed label		
			if (labelDepth < 0) {
				translate([0,0,-eps])
				rotate([0,0,-45])
				mirror([1,0,0])
				write(labelText, t=abs(labelDepth)+eps, h=labelHeight, font=labelFont, space=1.1, center=true);
			}	
	
			// holes
			translate([0,0,-eps]) {
				if (numHoles % 2 == 1) {
					cylinder(r=holeDiameter/2,h=base+2*eps);
				}
				
				for (n = [0:evenHoles - 1]) {
					rotate([0,0,n * (360/evenHoles)]) 
					translate([innerRadius*0.6,0,0]) {
						cylinder(r=holeDiameter/2,h=base+2*eps);
					}
				}
			}
		}
	
		// extruded label		
		if (labelDepth > 0) {
			translate([0,0,-labelDepth])
			rotate([0,0,-45])
			mirror([1,0,0])
			write(labelText, t=labelDepth+eps, h=labelHeight, font=labelFont, space=1.1, center=true);
		}	
	}
}

