

/*[Dimensions]*/

// Width of the case in mm (interior dimension)
interiorWidth = 24.5;

// Length of the case in mm (interior dimension)
interiorLength = 32.5;

// Height of the case in mm (interior dimension)
interiorHeight = 10;

// Case interior fillet radius
interiorFillet = 2.0;

// Width of the hinge in mm
hingeWidth = 12;


/*[Walls]*/

// Horizontal wall (top and bottom) thickness
coverThickness = 1.0; 

// Vertical wall (side) thickness 
sidewallWidth = 1.1; 

// Amount the lid protrudes into the case (larger value allows the case to close more securely)
lidInsetHeight = 1.2;

// Thickness of the hinge (it should be no more than a few layers thick keep it flexible)
hingeThickness = 0.3;

// hinge length multiplier (as a function of case height - longer hinges may be needed for less flexible plastics)
hingeLengthScale = 1.1;


/*[Details]*/

// Distance the top and bottom surfaces extend beyond the sides of the case (makes the case easier to open)
rimInset = 0.6; 

// Length of the opening tab on the lid of the case (optional - set to 0 to remove)
tabSize = 1; 

// Fillet radius used for hinge and tab
hingeFillet = 3;


/*[Printer Tolerances]*/

// Adjust the tightness of the closed case (larger value makes the case looser, negative value makes it tighter - try adjusting in 0.1mm increments)
lidInsetOffset = 0.0;



/*[hidden]*/
eps = 0.1;
$fn = 120; // resolution

module case()
{
	// minimal error checking
	hingeWidth = min(hingeWidth, interiorWidth);
	hingeThickness = min(hingeThickness, coverThickness);
	lidInsetHeight = min(lidInsetHeight, interiorHeight);

	baseLength = interiorLength + sidewallWidth*2;
	baseWidth = interiorWidth + sidewallWidth*2;
	baseRadius = interiorFillet + sidewallWidth;

	caseLength = baseLength + rimInset*2;
	caseWidth = baseWidth + rimInset*2;
	caseRadius = baseRadius + rimInset;

	hingeLength = hingeLengthScale * interiorHeight + coverThickness*2;
	centerY = (caseLength + hingeLength)/2;

	filletXOffset = hingeWidth/2 + hingeFillet;
	filletYOffset = hingeLength/2 - hingeFillet;


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
		// bottom surfaces
		for (i = [-centerY, centerY]) {
			translate([0,i,0]) {
				rrect(h=coverThickness, w=caseWidth, l=caseLength, r=caseRadius);
			}
		}

		translate([0,0,coverThickness-eps]) {

			// base
			translate([0,centerY,0]) {
				rrectTube(h=interiorHeight+eps, ow=baseWidth, ol=baseLength, or=baseRadius, t=sidewallWidth);
			}

			// lid
			translate([0,-centerY,0]) {
				rrectTube(h=lidInsetHeight+eps, ow=interiorWidth - lidInsetOffset, ol=interiorLength - lidInsetOffset, or=interiorFillet - lidInsetOffset/2, t=sidewallWidth);
			}
		}

		// hinge
		if (hingeWidth > caseWidth - caseRadius*2) {
			translate([-hingeWidth/2,-centerY,0]) {
				cube([hingeWidth, centerY*2, hingeThickness]);
			}
		} else {
			difference() {
				translate([-hingeWidth/2 - hingeFillet,-centerY,0]) {
					cube([hingeWidth + hingeFillet*2, centerY*2, hingeThickness]);
				}
	
				// fillet hinge
				for (x = [-filletXOffset, filletXOffset]) {
					hull() {
						for (y = [-filletYOffset, filletYOffset]) {
							translate([x,y,-eps]) {
								cylinder(h=hingeThickness + eps*2, r=hingeFillet, center=false);
							}
						}
					}
				}
			}
		}

		// tab
		if (tabSize > 0) {
			hull() {
				for (x = [hingeFillet - hingeWidth/2, hingeWidth/2 - hingeFillet]) {
					translate([x,-caseLength - hingeLength/2 - tabSize + hingeFillet,0]) {
						cylinder(h=coverThickness, r=hingeFillet, center=false);
					}
				}
				translate([-hingeWidth/2,-centerY,0]) {
					cube([hingeWidth, eps, coverThickness]);
				}
			}
		}
	}	


}

case();

