use <write/Write.scad>


/*[Dimensions]*/

// Width of the case in mm (interior dimension)
interiorWidth = 48;

// Length of the case in mm (interior dimension)
interiorLength = 32;

// Height of the case in mm (interior dimension)
interiorHeight = 8;

// Case interior fillet radius
interiorFillet = 4.0;

// Width of the hinge in mm
hingeWidth = 32;


/*[Dividers]*/

// Number of sections along the width of the case
widthSections = 3; //[1:20]

// Number of sections along the length of the case
lengthSections = 2; //[1:20]


/*[Walls]*/

// Horizontal wall (top and bottom) thickness
coverThickness = 1.0; 

// Vertical wall (side) thickness 
sidewallWidth = 1.0; 

// Amount the lid protrudes into the case (larger value allows the case to close more securely)
lidInsetHeight = 2.4;

// Thickness of the hinge (it should be no more than a few layers thick keep it flexible)
hingeThickness = 0.3;


/*[Details]*/

// Length of the opening tab on the lid of the case (optional - set to 0 to remove)
tabSize = 0; 

// Fillet radius used for the optional tab on the lid
tabFillet = 2;


/*[Fine Tuning]*/

// Adjust the tightness of the closed case (larger value makes the case looser, negative value makes it tighter - try adjusting in 0.1mm increments)
lidInsetOffset = 0;

// Make the hinge longer or shorter
hingeExtension = 0;

// Increase or decrease the flexible portion of the hinge (may be useful for working with different plastics)
hingeBend = 0.6;


/*[Label]*/

// text string embossed into the top of the lid
labelText = "";

// font used to render the label
labelFont = "write/orbitron.dxf"; // ["write/orbitron.dxf":Orbitron, "write/letters.dxf":Basic, "write/knewave.dxf":KneWave, "write/BlackRose.dxf":BlackRose, "write/braille.dxf":Braille]

// depth of the label embossed on the lid
labelDepth = 0.2;

// height of the text in mm
labelHeight = 10;


/*[hidden]*/
eps = 0.1;
$fn = 120; // resolution

module case()
{
	caseLength = interiorLength + sidewallWidth*2;
	caseWidth = interiorWidth + sidewallWidth*2;
	caseRadius = interiorFillet + sidewallWidth;

	lidLength = caseLength + sidewallWidth*2 - lidInsetOffset*2;
	lidWidth = caseWidth + sidewallWidth*2 - lidInsetOffset*2;
	lidRadius = caseRadius + sidewallWidth - lidInsetOffset;

	hingeLength = interiorHeight + coverThickness*2 + hingeExtension;
	centerY = (caseLength + hingeLength)/2;

	hingeWidth = min(hingeWidth, caseWidth - caseRadius*2);
	hingeChamfer = (coverThickness - hingeThickness) * 0.75;

	widthDividerSize = (interiorWidth + sidewallWidth) / widthSections;
	lengthDividerSize = (interiorLength + sidewallWidth) / lengthSections;


	module addLabel(label, zoffset, depth, height, font) {
		if (label != "") {
			translate([0,0,zoffset])
			mirror([0,1,0])
			write(label, t=depth, h=height, font=font, space=1.2, center=true);
		}
	}

	module rrect(h, w, l, r) {
		r = min(r, min(w/2, l/2));
		w = max(w, eps);
		l = max(l, eps);
		h = max(h, eps);
		if (r <= 0) {
			translate([-w/2, -l/2,0]) {
				cube([w,l,h]);
			}
		} else {
			hull() {
				for (y = [-l/2+r, l/2-r]) {
					for (x = [-w/2+r, w/2-r]) {
						translate([x,y,0]) {
							cylinder(h=h, r=r, center=false);
						}
					}
				}
			}
		}
	}

	module rrectTube(h, ow, ol, or, t) {
		difference() {
			rrect(h=h, w=ow, l=ol, r=or);
			translate([0,0,-eps]) {
				rrect(h=h+eps*2, w=ow-t*2, l=ol-t*2, r=or-t);
			}
		}
	}

	union() {
		// lid
		difference() {
			union() {
				translate([0,-centerY - sidewallWidth,0]) {
					rrect(h=coverThickness, w=lidWidth, l=lidLength, r=lidRadius);
					rrectTube(h=lidInsetHeight+coverThickness, ow=lidWidth, ol=lidLength, or=lidRadius, t=sidewallWidth);
				}
			}

			// label			
			translate([0,-centerY - sidewallWidth,0]) {
				addLabel(labelText, (labelDepth+eps)/2 - eps, labelDepth+eps, labelHeight, labelFont);
			}

			// hinge cutout
			translate([-hingeWidth/2 - eps, -hingeLength/2 - sidewallWidth - eps, -eps]) {
				cube([hingeWidth + eps*2, hingeLength/2 + sidewallWidth + eps, coverThickness + lidInsetHeight + eps*2]);
			}
		}

		// base
		translate([0,centerY,0]) {
			rrect(h=coverThickness, w=caseWidth, l=caseLength, r=caseRadius);
		}
		difference() {
			translate([0,centerY,coverThickness-eps]) {
				rrectTube(h=interiorHeight+eps, ow=caseWidth, ol=caseLength, or=caseRadius, t=sidewallWidth);
			}	

			// hinge cutout
//				translate([-hingeWidth/2 - eps, 0, coverThickness-eps]) {
//					#cube([hingeWidth + eps*2, centerY, interiorHeight+eps*2]);
//				}
		}

	}

	// hinge
	union() {
		translate([-hingeWidth/2,-(hingeLength + sidewallWidth*2 + eps*4)/2,0]) {
			cube([hingeWidth, hingeLength + sidewallWidth * 2 + eps*4, hingeThickness]);
		}
		hull() {
			translate([-hingeWidth/2,-hingeLength/2 + hingeBend/2,0]) {
				cube([hingeWidth, hingeLength-sidewallWidth - hingeBend, coverThickness - hingeChamfer]);
			}
			translate([-hingeWidth/2,-hingeLength/2 + hingeBend/2 + hingeChamfer,0]) {
				cube([hingeWidth, hingeLength-sidewallWidth - hingeBend - hingeChamfer*2, coverThickness]);
			}
		}
	}

	// x dividers
	if (widthSections > 1) {
		for (x = [1:widthSections-1]) {
			translate([widthDividerSize * x - interiorWidth/2 - sidewallWidth,centerY - interiorLength/2 - eps,coverThickness-eps]) {
				cube([sidewallWidth, interiorLength + eps*2, interiorHeight+eps]);
			}
		}
	}

	// y dividers
	if (lengthSections > 1) {
		for (y = [1:lengthSections-1]) {
			translate([-interiorWidth/2 - eps, hingeLength/2 + lengthDividerSize * y, coverThickness-eps]) {
				cube([interiorWidth + eps*2, sidewallWidth, interiorHeight+eps]);
			}
		}
	}

	// tab
	if (tabSize > 0) {
		hull() {
			for (x = [tabFillet - hingeWidth/2, hingeWidth/2 - tabFillet]) {
				translate([x,-caseLength - sidewallWidth*2 - hingeLength/2 - tabSize + tabFillet,0]) {
					cylinder(h=coverThickness, r=tabFillet, center=false);
				}
			}
			translate([-hingeWidth/2, -centerY - sidewallWidth * 2 - caseLength/2 + eps,0]) {
				cube([hingeWidth, eps*2, coverThickness]);
			}
		}
	}
	
}

case();

