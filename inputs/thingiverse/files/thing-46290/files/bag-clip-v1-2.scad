use <utils/build_plate.scad>
use <write/Write.scad>

// preview[view:north west, tilt:top diagonal]

// Type of part
_1_part = "Outside"; // [Inside, Outside]


// Length of the clip
_2a_length = 80.0; //[30:360]

// Width of the clip
_2b_width = 8.0;

// Curvature of the clip (lower values for a flatter arc, 100 for a semicircle)
_2c_curvature = 80; //[10:100]

// Amount the inner section is longer than the outer part in mm, affects how tightly the clip closes. A decent starting point is 1% of the length of the clip.
_2d_clipExtension = 0.8;


// Optional text on the outside of the clip
_3a_labelText = "";

// Font used to render the label
_3b_labelFont = "write/orbitron.dxf"; // ["write/orbitron.dxf":Orbitron, "write/letters.dxf":Basic, "write/knewave.dxf":KneWave, "write/BlackRose.dxf":BlackRose, "write/braille.dxf":Braille]

// Depth of the label (negative values to cut, positive values to extrude)
_3c_labelThickness = -0.3;

// Height of the label (as a percentage of the clip width)
_3d_labelHeightPercent = 60; // [1:100]

// Label direction
_3e_labelDirection = 1; //[1:Hinge, 0:Clip]

// Space between letters
_3f_labelSpace = 1.1;


// Thickness of the outside part of the clip.
_4a_outsideThickness = 2.0;

// Thickness of the inside part of the clip.
_4b_insideThickness = 1.6;

// Diameter of the hinge
_4c_hingeDiameter = 4.0;


// Controls the radial size of the hinge arc.  Adjust to change how well the pieces hold together.
_5a_hingeAngle = 230; //[180:300]

// Controls the radial size of the tip arc.
_5b_clipAngle = 150; //[90:180]

// Adjust tolerances of the hinges
_5c_hingeGap = 0.1;

////////////////////////////////////////////////////////////////////////


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



// arc from [0 to 360] degrees with rounded ends, runs clockwise from 12 o'clock, rounded tips not included in angle computation
module roundArc(radius0, radius1, angle, depth) {
	thickness = radius1 - radius0;
	cutAngle = 360-angle;
	centerRadius = (radius0 + radius1)/2.0;
	union() {
		if (angle > 180) {
			smallArc(radius0, radius1, 180, depth);
			rotate([0,0,-180]) {
				smallArc(radius0, radius1, angle-180, depth);
			}
		} else {
			smallArc(radius0, radius1, angle, depth);
		}

		// round ends
		for(t = [ [0,centerRadius,0], 
					 [centerRadius * -sin(cutAngle), centerRadius * cos(cutAngle),0] ]) {
			translate(t) {
				cylinder(r=thickness/2, h=depth, center=true);
			}
		}
	}
}

module outerClip(arcRadius, angle, height, outerThickness, innerThickness, hingeRadius, hingeAngle, clipAngle, hingeGap,
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
				roundArc(ir, or, angle, height);
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
					roundArc(ir, or, angle, height);
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
				roundArc(hingeRadius, hingeRadius+outerThickness, hingeAngle, height);
			}
			cylinder(r=ir, h=height/3 + hingeGap, center=true); 
		}

		// clip
		translate([cx, cy, 0])
		rotate([0,0,-angle/2]) {
			roundArc(clipRadius, clipRadius+outerThickness, clipAngle, height);
		}
	}
}

module innerClip(arcRadius, angle, height, outerThickness, innerThickness, hingeRadius, extension, hingeGap) {
	or = arcRadius;
	ir = or - innerThickness;

	hingeHeight = height/3;
	hx = (or-hingeRadius)*sin(angle/2);
	hy = (or-hingeRadius)*cos(angle/2);
	extensionAngle = 2 * asin(extension/(2*or));
	connectorAngle = 2 * asin((hingeRadius*3+outerThickness)/(2*or));
	eps = 0.1;

	//	spine
	union() {
		difference() {
			rotate([0,0,angle/2]) {
				roundArc(ir, or, angle+extensionAngle, height);
			}

			translate([-hx, hy, 0]) {
				difference() {
					cylinder(r=hingeRadius+outerThickness+hingeGap*2, h=height+eps, center=true); 
					cylinder(r=hingeRadius, h=height+2*eps, center=true); 
				}
			}
		}

		// hinge
		translate([-hx, hy, 0]) {
			cylinder(r=hingeRadius, h=height, center=true); 
		}
		// connector
		rotate([0,0,angle/2]) {
			roundArc(ir, or, angle, hingeHeight);
		}
		for(a=[0:6]) {
				assign(frac=a/7) {
				hull() {
					translate([-hx, hy + hingeRadius/2 * frac, 0]) {
						cylinder(r=hingeRadius - hingeRadius*frac, h=hingeHeight, center=true, $fn=30); 
					}
					rotate([0,0,angle/2]) {
						smallArc(ir, or-eps, connectorAngle/2 + frac*connectorAngle/2, hingeHeight);
					}
				}
			}
		}
	}
}

module make($fn = 180) {
	radius = _2a_length / (2 *(_2c_curvature/100));
	angle = 2 * asin(_2a_length/(2*radius));

	translate([0,-radius,_2b_width/2]) {
		if (_1_part == "Inside") {
			innerClip(	radius, 
							angle, 
							_2b_width,
							_4a_outsideThickness, 
							_4b_insideThickness, 
							_4c_hingeDiameter/2, 
							_2d_clipExtension,
							_5c_hingeGap);
		} else {
			outerClip(	radius, 
							angle, 
							_2b_width, 
							_4a_outsideThickness, 
							_4b_insideThickness, 
							_4c_hingeDiameter/2, 
							_5a_hingeAngle, 
							_5b_clipAngle,
							_5c_hingeGap,
							_3a_labelText,
							_3b_labelFont,
							_3c_labelThickness,
							_3d_labelHeightPercent,
							_3e_labelDirection,
							_3f_labelSpace);
		}
	}
}

build_plate(3,140,140);
make();