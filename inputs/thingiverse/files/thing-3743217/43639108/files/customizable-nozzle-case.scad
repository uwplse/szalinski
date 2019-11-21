use <threads-library-by-cuiso-v1.scad>

/*[Nozzle Settings]*/

// Height of the threaded part of the nozzle [mm]
nozzleBaseHeight = 6;

// Height of the tip part of the nozzle [mm]
nozzleTipHeight = 10;

// Diameter of the threaded part of the nozzle [mm]
nozzleBaseDia = 6.6;

// Quantity of nozzles in X-direction
width_number = 6;//[2:10]

// Labeltext - At the moment it is only possible to write words with 5 characters, all longer  words going into the lines. The amount of elements should be equals the length_number.
lblText = [
           "0.2mm",
           "0.3mm",
           "0.4mm",
           "0.5mm",
           "0.6mm",
           "0.8mm",
           "1.0mm", 
           "µSws "
        ];

// Quantity of nozzles in Y-direction (see lblText if changed)
// length_number = 6;//[2:10]
length_number = len(lblText);

// Distance between and at the edges of the nozzleholes in X-direction [mm]
widthDistance = 5;
// Distance between and at the edges of the nozzleholes in Y-direction [mm]
lengthDistance = 5;

// General inaccuracy for the nozzleholes. Reduce to get a tighter fit [mm]
inaccuracy = 0.3;

nozzleBaseDia_ina = nozzleBaseDia + inaccuracy;

/*[Dimensions]*/

// Case interior fillet radius [mm]
interiorFillet = 2.0;

// Width of the hinge [mm]
hingeWidth = width_number * nozzleBaseDia_ina + (width_number+1) * widthDistance - 10;

/*[Walls]*/

// Horizontal wall (top and bottom) thickness [mm]
coverThickness = 1.0; 

// Vertical wall (side) thickness [mm]
sidewallWidth = 1.2; 

// Amount the lid protrudes into the case (larger value allows the case to close more securely) [mm]
lidInsetHeight = 1.2;

// Thickness of the hinge (it should be no more than a few layers thick keep it flexible) [mm]
hingeThickness = 0.4;

// hinge length multiplier (as a function of case height - longer hinges may be needed for less flexible plastics)
hingeLengthScale = 1.1;

// Width of the case in mm (interior dimension)
interiorWidth = width_number * nozzleBaseDia_ina + (width_number+1) * widthDistance + sidewallWidth;

// Length of the case in mm (interior dimension)
interiorLength = length_number * nozzleBaseDia_ina + (length_number+1) * lengthDistance + sidewallWidth;

// Height of the case in mm (interior dimension)
interiorHeight = nozzleBaseHeight + nozzleTipHeight + 0.6;

/*[Details]*/

// Distance the top and bottom surfaces extend beyond the sides of the case (makes the case easier to open) [mm]
rimInset = 0.6; 

// Length of the opening tab on the lid of the case (optional - set to 0 to remove)
tabSize = 1; 

// Fillet radius used for hinge and tab
hingeFillet = 3;

/*[Label Settings]*/ // To change the text you have to open this file in OpenSCAD
// Toggle text, 1 is on
lblToggle = 1; //[1:True, 0:False]

// Size of the labels
lblSize = 3;

// Height of the labels [mm]
lblHeight = 1.0;

/*[Printer Tolerances]*/

// Adjust the tightness of the closed case (larger value makes the case looser, negative value makes it tighter - try adjusting in 0.1mm increments)
lidInsetOffset = 0.15;

/*[hidden]*/

$fn = 20; // resolution

eps = 0.1;




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
				rrectTube(h=nozzleBaseHeight+eps, ow=baseWidth, ol=baseLength, or=baseRadius, t=sidewallWidth);
            
            //lid
                translate([0,0,nozzleBaseHeight])
                rrectTube(h=lidInsetHeight+eps, ow=interiorWidth - lidInsetOffset, ol=interiorLength - lidInsetOffset, or=interiorFillet - lidInsetOffset/2, t=sidewallWidth);

			// nozzlecase
                difference() {
                    rrect(h=nozzleBaseHeight, w=baseWidth, l=baseLength, r=baseRadius);
                    
                    nozzle();
                    
                    if (lblToggle == 1)
                    {
                        maketext();
                    }

                } 
			}
            

			
			translate([0,-centerY,0]) {

             // lid   
                rrectTube(h=nozzleTipHeight+eps, ow=baseWidth, ol=baseLength, or=baseRadius, t=sidewallWidth);
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

	
    module maketext()
    {
        for (n = [0:length_number-1]){
            
            translate([0,(n+1)*lengthDistance+ n*nozzleBaseDia_ina-caseLength/2,nozzleBaseHeight-lblHeight]) {
                // text
                linear_extrude(height = lblHeight) {
                    rotate([0,0,180])
                    text(lblText[n], size = lblSize, valign = "center", halign = "center", spacing = 1.2);
                }
                
                // Lines
                translate([8,0,0])
                    cube([hingeWidth / 2 - widthDistance-1,0.6,lblHeight]);
                translate([hingeWidth / 2 - widthDistance+2+4.4,0, 0])
                    cube([0.6,nozzleBaseDia/2,lblHeight]);

                mirror()
                {
                    translate([8,0,0])
                        cube([hingeWidth / 2 - widthDistance-1,0.6,lblHeight]);
                    translate([hingeWidth / 2 - widthDistance+2+4.4,0, 0])
                        cube([0.6,nozzleBaseDia/2,lblHeight]);
                }
                
            
            }
        }
    }
}


module nozzle(x, y, z)
{
    translate([nozzleBaseDia_ina/2 - (width_number/2)*nozzleBaseDia_ina - ((width_number-1)/2)*widthDistance, nozzleBaseDia_ina/2 - (length_number/2)*nozzleBaseDia_ina - ((length_number-1)/2)*lengthDistance, 0])
    {
    for(n = [0 : width_number - 1])
    {
        for(m = [0 : length_number - 1])
        {
            translate([n * (nozzleBaseDia_ina + widthDistance), m * (nozzleBaseDia_ina + lengthDistance),0])
            {
                //cylinder(d = nozzleBaseDia_ina, h = nozzleBaseHeight);
                thread_for_screw(diameter=nozzleBaseDia_ina, length=nozzleBaseHeight); 
            }
        }    
    }
}
}

case();

// preview[view:north, tilt:top]
