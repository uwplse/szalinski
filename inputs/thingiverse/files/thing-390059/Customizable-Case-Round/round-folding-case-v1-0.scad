
/*[Dimensions]*/

// Diameter of the case (interior dimension)
interiorDiameter = 50;

// Height of the case (interior dimension)
interiorHeight = 8; 

// Amount the lid protrudes into the case (larger value allows the case to close more securely)
lidInsetHeight = 2.4;

// Width of the hinge
hingeWidth = 16;


/*[Walls]*/

// Horizontal wall thickness
wallHeight = 1.0; 

// Vertical wall thickness
wallWidth = 1.2; 

// Distance the rim extends beyond the edge of the case
rimInset = 0.6;

// Adjust the tightness of the closed case (larger value makes the case looser, negative value makes it tighter)
lidInsetOffset = 0.0; 

// Thickness of the hinge
hingeThickness = 0.4;

// Length of the hinge
hingeLengthScale = 1.5;


/*[Details]*/

// Length of the tab on the lid of the case (optional - set to 0 to remove)
tabSize = 1.5; 

// Fillet radius used for hinge and tab
filletRadius = 6;

// Chamfer used to make the case easier to close
chamfer = 0.4;


/*[hidden]*/
eps = 0.1;
$fn = 120;




module case()
{
	module tube(h, od, id) {
		difference() {
			cylinder(h=h, r=od/2);
			translate([0,0,-eps]) {
				cylinder(h=h+eps*2, r=id/2);
			}
		}
	}

	caseDiameter = interiorDiameter + wallWidth*2 + rimInset*2;
	baseDiameter = caseDiameter - rimInset*2;
	lidDiameter = baseDiameter - wallWidth*2 - lidInsetOffset;
	hingeLength = hingeLengthScale * interiorHeight + wallHeight*2;
	centerY = (caseDiameter + hingeLength)/2;

	filletXOffset = hingeWidth/2 + filletRadius;
	filletAngle = asin((filletXOffset) / (caseDiameter/2+filletRadius));
	filletYOffset = centerY - sqrt(pow(caseDiameter/2+filletRadius, 2) - pow(filletXOffset,2));
	filletHingeExpansion = filletRadius * (1-sin(filletAngle));


	union() {
		// bottom surfaces
		for (y = [-centerY, centerY]) {
			translate([0,y,0]) {
				cylinder(h=wallHeight, r=caseDiameter/2);
			}
		}

		translate([0,0,wallHeight-eps]) {
			// base
			translate([0,centerY,0]) {
				difference() {
					tube(h=interiorHeight+eps, od=baseDiameter, id=interiorDiameter);
					if (chamfer > 0) { // chamfer
						translate([0,0,interiorHeight-chamfer]) {
							cylinder(h=chamfer+eps*2,d1=interiorDiameter-eps, d2=interiorDiameter+chamfer*2,center=false);
						}
					}
				}
			}

			// lid
			translate([0,-centerY,0]) {
				difference() {
					tube(h=lidInsetHeight+eps, od=lidDiameter, id=lidDiameter-wallWidth*2);
					if (chamfer > 0) {
						difference() {
							translate([0,0,lidInsetHeight-chamfer]) {
								cylinder(h=chamfer+eps*2, r=(lidDiameter+eps)/2, center=false);
							}
							translate([0,0,lidInsetHeight-chamfer-eps]) {
								cylinder(h=chamfer+eps*4, d1=lidDiameter, d2=lidDiameter-chamfer*2, center=false);
							}
						}
					}
					//translate([-1, -lidDiameter/2 - eps, -eps]) {
					//	  cube([2, lidDiameter + 2*eps, lidInsetHeight + 2*eps]);
					//}
				}
			}
		}

		// hinge
		difference() {
			translate([-hingeWidth/2 - filletHingeExpansion,-centerY,0]) {
				cube([hingeWidth + filletHingeExpansion*2, centerY*2, hingeThickness]);
			}

			// fillet hinge
			for (x = [-filletXOffset, filletXOffset]) {
				hull() {
					for (y = [-filletYOffset, filletYOffset]) {
						translate([x,y,-eps]) {
							cylinder(h=hingeThickness + eps*2, r=filletRadius, center=false);
						}
					}
				}
			}
		}

		// tab
		if (tabSize > 0) {
			hull() {
				for (x = [filletRadius - hingeWidth/2, hingeWidth/2 - filletRadius]) {
					translate([x,-caseDiameter - hingeLength/2 - tabSize + filletRadius,0]) {
						cylinder(h=wallHeight, r=filletRadius, center=false);
					}
				}
				translate([-hingeWidth/2,-centerY,0]) {
					cube([hingeWidth, eps, wallHeight]);
				}
			}
		}

	}
}

case();

