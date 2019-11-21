use <write/Write.scad>

// preview[view:north west, tilt:top diagonal]


/* [Size] */

// Type of part (customizer will create both parts).
part = "inside"; // [inside:Inside, outside:Outside, both:Both]

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
_labelText = "Hello";

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
module smallArc(radius0, radius1, angle, res) {
    difference() {
	// full arc
	circle(r=radius1, $fn=res);
	circle(r=radius0, $fn=res);
        
	for(z=[0, 180 - angle]) {
	    rotate(z)
	    translate([-radius1,0])			
	    square(radius1*2, center=true);
	}
    }
}



// arc from [0 to 360] degrees with rounded ends, runs clockwise from 12 o'clock, rounded tips not included in angle computation
module roundArc(radius0, radius1, angle, res) {
    thickness = radius1 - radius0;
    cutAngle = 360-angle;
    centerRadius = (radius0 + radius1)/2.0;
    
    if (angle > 180) {
	smallArc(radius0, radius1, 180, res);
	rotate(-180) {
	    smallArc(radius0, radius1, angle-180, res);
	}
    } else {
	smallArc(radius0, radius1, angle, res);
    }
    
    // round ends
    for(t = [ [0,centerRadius], 
	    [centerRadius * -sin(cutAngle), centerRadius * cos(cutAngle)] ]) {
	translate(t) circle(r=thickness/2, $fn=32);
    }
}

module outerClip(arcRadius, angle, height, outerThickness, innerThickness, hingeRadius, hingeAngle, clipAngle, labelText, labelFont, labelThickness, labelHeightPercent, labelDirection, labelSpace) {
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

    module clip() {
        linear_extrude(height=height, center=true) {
            // spine
            rotate(angle/2) roundArc(ir, or, angle, 512);
            
            // hinge
            difference() {
	        translate([-hx, hy])
	        rotate(angle/2+hingeAngle) {
	            roundArc(hingeRadius, hingeRadius + outerThickness, hingeAngle, 64);
	        }
            }
            
            // clip
            translate([cx, cy]) rotate(-angle/2) {
	        roundArc(clipRadius, clipRadius+outerThickness, clipAngle, 64);
            }
        }
    }

    module label(thickness) {
        leps = thickness > 0 ? -eps : eps;
	if (labelThickness != 0 && labelText != "") {
	    rotate([0,labelDirection ? 180 : 0,180]) {
		writecylinder(labelText, [0,0,0], labelRadius+leps,0, t=labelThickness+eps, h=labelHeight, font=labelFont, space=labelSpace);
	    }
	}
    }

    if (labelThickness >= 0) {
        clip();
        label(labelThickness);
    }
    else {
        difference() {
            clip();
            label(labelThickness);
        }
    }
        
}

module innerClip(arcRadius, angle, height, outerThickness, innerThickness, hingeRadius, extension) {
    or = arcRadius;
    ir = or - innerThickness;
    
    hx = (or-hingeRadius)*sin(angle/2);
    hy = (or-hingeRadius)*cos(angle/2);
    extensionAngle = 2 * asin(extension/(2*or));
    connectorAngle = 2 * asin((hingeRadius*2.5+outerThickness)/(2*or));
    eps = 0.1;
    
    //	spine
    linear_extrude(height=height, center=true) {
	rotate(angle/2) roundArc(ir, or, angle+extensionAngle, 512);
        
	// hinge
	translate([-hx, hy]) circle(r=hingeRadius, $fn=64); 
        
	// connector
	rotate(angle/2) roundArc(ir, or, angle, 512);
	for(a=[0:6]) {
            assign(frac=a/7) hull() {
		translate([-hx, hy + hingeRadius/2 * frac, 0]) {
		    circle(r=hingeRadius - hingeRadius*frac, $fn=32); 
		}
		rotate(angle/2) {
		    smallArc(ir, or-eps, connectorAngle/2 + frac*connectorAngle/2, 180);
		}
	    }
	}
    }
}

module make() {
	radius = _length / (2 *(_curvature/100));
	angle = 2 * asin(_length/(2*radius));
        t = (part == "both") ? [0,-20,0] : [0,0,0];

	translate([0,-radius,_width/2]) {
		if (part == "inside" || part == "both") {
			translate(t)
                          innerClip(	radius, 
							angle, 
							_width,
							_outsideThickness, 
							_insideThickness, 
							_hingeDiameter/2, 
							_clipExtension);
		}
                if (part == "outside" || part == "both") {
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
