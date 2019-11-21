
// part of the container to make (diameter and wall thickness settings need to match for a lid to be compatible with a base)
_1_type = "Base"; // [Base, Lid]

// (this includes the side walls)
_2_outsideDiameter = 36; // [0:300]

// height of the container base (including the bottom, but not the lid)
_3_baseHeight = 14; // [0:300]

// radius of corners (affects both lid and walls)
_4_cornerRadius = 3; // [0:150]

// thickness of the walls (including sides, bottom, and lid)
_5_wallThickness = 0.8;

// gap between the lid and the base, use a smaller value for a tighter fit, larger for looser
_6_lidGap = 0.3;

// height of the lip that holds the lid in place
_7_lipHeight = 0.8;

// resolution used to render curved surfaces (experiment with low resolutions, and render the final results with higher resolution settings)
_8_resolution = 60; // [30:Low (12 degrees), 60:Medium (6 degrees), 120:High (3 degrees)]


////////////////////////////////////////////////////////////

module torus(r1, r2) {
	rotate_extrude(convexity = 4)
	translate([r1, 0, 0])
	circle(r = r2);
}

module roundedCylinder(height, radius, fillet)
{
	if (fillet <= 0) {
		cylinder(h=height, r=radius, center=true);
	} else {
		hull() {
			translate([0, 0, height/2-fillet])
			torus(r1 = radius-fillet, r2 = fillet);
			translate([0, 0, -(height/2-fillet)])
			torus(r1 = radius-fillet, r2 = fillet);
		}
	}
}

module roundTray(diameter, height, rounding, sidewall, bottom)
{
	radius = diameter/2;
	translate([0, 0, height])
	difference() {
		roundedCylinder(height*2, radius, rounding);
		roundedCylinder((height - bottom)*2, radius-sidewall, rounding - sidewall);
		// trim top
		cylinder(h=height+rounding, r=radius+1, center=false);
	}
}

module roundLid(diameter, rounding, sidewall, gap, flatThickness, lipHeight) {
	radius = diameter/2;
	insideRadius = radius - sidewall - gap;
	eps = 0.1;
	union() {
		if (rounding == 0) {
			cylinder(r=radius, h=flatThickness);
		} else {
			difference() {
				hull() {
					torus(radius-rounding, rounding);
				}
				translate([0,0,-rounding-eps]) {
					cylinder(h=rounding+eps, r=radius+eps);
				}
				hull() {
					torus(insideRadius-rounding, rounding-sidewall);
				}
			}
		}
		translate([0,0,-lipHeight]) {
			difference() {
				cylinder(h=lipHeight+eps,r=insideRadius); 
				translate([0,0,-eps]) {
					cylinder(h=lipHeight+3*eps,r=insideRadius - sidewall); 
				}
			}
		}
	}
}

module run($fn = _8_resolution) {
	// additional cusomizeable parameters
	horizontalThickness = _5_wallThickness;

	if (_1_type == "Base") {
		roundTray(_2_outsideDiameter,_3_baseHeight,_4_cornerRadius,_5_wallThickness,horizontalThickness);
	} else {
		roundLid(_2_outsideDiameter,_4_cornerRadius,_5_wallThickness,_6_lidGap,horizontalThickness,_7_lipHeight);
	}
}

run();