use <write/Write.scad>

// preview[view:north west, tilt:top diagonal]


/* [Size] */

// Type of part (customizer will create both parts).
part = "Inside"; // [inside:Inside, outside:Outside]

// Length of the clip.
_length = 120.0; //[30:360]

// Width of the clip.
_width = 9.0;

// Thickness of the outside part of the clip.
_outsideThickness = 2.0;

// Thickness of the inside part of the clip.
_insideThickness = 1.6;

// Gap between the parts at the hinge, use this to adjust how tighly the hinge fits together (smaller/negative values will result in a tighter fit.
_hingeGap = 0.05;


/* [Label] */

// Optional text on the outside of the clip
_labelText = "";

// Font used to render the label
_labelFont = "write/orbitron.dxf"; // ["write/orbitron.dxf":Orbitron, "write/letters.dxf":Basic, "write/knewave.dxf":KneWave, "write/BlackRose.dxf":BlackRose, "write/braille.dxf":Braille]

// Depth of the label (negative values to emboss, positive values to extrude)
_labelThickness = -0.2;

// Height of the label (as a percentage of the clip width)
_labelHeightPercent = 60; // [1:100]

// Label direction
_labelDirection = 1; //[1:Start at Hinge, 0:Start at Clip]

// Spacing between letters
_labelSpace = 1.1;


/* [Advanced] */

// Curvature of the clip (lower values for a flatter arc, 100 for a semicircle)
_curvature = 80; //[10:100]

// Diameter of the hinge
_hingeDiameter = 5.0;

// Controls the radial size of the hinge arc.  Adjust to change how well the pieces hold together.
_hingeAngle = 220; //[180:300]

// Controls the radial size of the tip arc.
_clipAngle = 145; //[90:180]

// Amount the inner section is longer than the outer part in mm, affects how tightly the clip closes. A decent starting point is 1% of the length of the clip.
_clipExtension = 0.5;


////////////////////////////////////////////////////////////////////////


// only works from [0 to 180] degrees, runs clockwise from 12 o'clock
module smallArc(radius0, radius1, angle, depth, res) {
	thickness = radius1 - radius0;
	eps = 0.1;

	union() {
		difference() {
			// full arc
			cylinder(r=radius1, h=depth, center=true, $fn=res);
			cylinder(r=radius0, h=depth+2*eps, center=true, $fn=res);

			for(z=[0, 180 - angle]) {
				rotate([0,0,z])
				translate([-radius1,0,0])			
				cube(size = [radius1*2, radius1*2, depth+eps], center=true);
			}
		}
	}
}



// arc from [0 to 360] degrees with rounded ends, runs clockwise from 12 o'clock, rounded tips not included in angle computation
module roundArc(radius0, radius1, angle, depth, res) {
	thickness = radius1 - radius0;
	cutAngle = 360-angle;
	centerRadius = (radius0 + radius1)/2.0;
	union() {
		if (angle > 180) {
			smallArc(radius0, radius1, 180, depth, res);
			rotate([0,0,-180]) {
				smallArc(radius0, radius1, angle-180, depth, res);
			}
		} else {
			smallArc(radius0, radius1, angle, depth, res);
		}

		// round ends
		for(t = [ [0,centerRadius,0], 
					 [centerRadius * -sin(cutAngle), centerRadius * cos(cutAngle),0] ]) {
			translate(t) {
				cylinder(r=thickness/2, h=depth, center=true, $fn=32);
			}
		}
	}
}

module outerClip(arcRadius, angle, height, outerThickness, innerThickness, hingeRadius, hingeAngle, clipAngle,
labelText, labelFont, labelThickness, labelHeightPercent, labelDirection, labelSpace) {
	ir = arcRadius;
	or = ir + outerThickness;
	clipRadius = innerThickness/2 + 0.1;
	hx = (ir-hingeRadius)*sin(angle/2);
	hy = (ir-hingeRadius)*cos(angle/2);
	cx = (ir-clipRadius)*sin(angle/2);
	cy = (ir-clipRadius)*cos(angle/2);

	// label
	eps = 0.1;
	labelHeight = height * (labelHeightPercent/100);
	labelRadius = or+labelThickness/2;

	union() {

		if (labelThickness >= 0) {
			//	spine
			rotate([0,0,angle/2]) {
				roundArc(ir, or, angle, height, 512);
			}
			
			if (labelThickness != 0 && labelText != "") {
				rotate([0,labelDirection ? 180 : 0,180]) {
					writecylinder(labelText, [0,0,0], labelRadius-eps,0, t=labelThickness+eps, h=labelHeight, font=labelFont, space=labelSpace);
				}
			}
		} else {
			difference() {
				//	spine
				rotate([0,0,angle/2]) {
					roundArc(ir, or, angle, height, 512);
				}
				if (labelThickness != 0 && labelText != "") {
					rotate([0,labelDirection ? 180 : 0,180]) {
						writecylinder(labelText, [0,0,0], labelRadius+eps,0, t=labelThickness+eps, h=labelHeight, font=labelFont, space=labelSpace);
					}
				}
			}
		}

		// hinge
		difference() {
			translate([-hx, hy, 0])
			rotate([0,0,angle/2+hingeAngle]) {
				roundArc(hingeRadius, hingeRadius + outerThickness, hingeAngle, height, 64);
			}
		}

		// clip
		translate([cx, cy, 0])
		rotate([0,0,-angle/2]) {
			roundArc(clipRadius, clipRadius+outerThickness, clipAngle, height, 64);
		}
	}
}

module innerClip(arcRadius, angle, height, outerThickness, innerThickness, hingeRadius, extension) {
	or = arcRadius;
	ir = or - innerThickness;

	hingeHeight = height;
	hx = (or-hingeRadius)*sin(angle/2);
	hy = (or-hingeRadius)*cos(angle/2);
	extensionAngle = 2 * asin(extension/(2*or));
	connectorAngle = 2 * asin((hingeRadius*2.5+outerThickness)/(2*or));
	eps = 0.1;

	//	spine
	union() {
		rotate([0,0,angle/2]) {
			roundArc(ir, or, angle+extensionAngle, height, 512);
		}


		// hinge
		translate([-hx, hy, 0]) {
			cylinder(r=hingeRadius, h=height, center=true, $fn=64); 
		}
		// connector
		rotate([0,0,angle/2]) {
			roundArc(ir, or, angle, hingeHeight, 512);
		}
		for(a=[0:6]) {
				assign(frac=a/7) {
				hull() {
					translate([-hx, hy + hingeRadius/2 * frac, 0]) {
						cylinder(r=hingeRadius - hingeRadius*frac, h=hingeHeight, center=true, $fn=32); 
					}
					rotate([0,0,angle/2]) {
						smallArc(ir, or-eps, connectorAngle/2 + frac*connectorAngle/2, hingeHeight, 180);
					}
				}
			}
		}
	}
}

module make() {
	radius = _length / (2 *(_curvature/100));
	angle = 2 * asin(_length/(2*radius));

	translate([0,-radius,_width/2]) {
		if (part == "Inside") {
			innerClip(	radius, 
							angle, 
							_width,
							_outsideThickness, 
							_insideThickness, 
							_hingeDiameter/2, 
							_clipExtension);
		} else {
			outerClip(	radius, 
							angle, 
							_width, 
							_outsideThickness, 
							_insideThickness, 
							_hingeDiameter/2 + _hingeGap, 
							_hingeAngle, 
							_clipAngle,
							_labelText,
							_labelFont,
							_labelThickness,
							_labelHeightPercent,
							_labelDirection,
							_labelSpace);
		}
	}
}

make();