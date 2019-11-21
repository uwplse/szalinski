
// This file was created to make small trays for storing screws and other small objects
// but the parameters can be adjusted to create bowls, cups, trays, etc.
// added comments for the makerbot customizer

// diameter of the tray in mm (including the sides)
trayDiameter = 48; // [0:300]

// height of the tray in mm (including bottom)
trayHeight = 15; // [0:300]

// radius of rounding of the bottom in mm (should be larger than the sidewall thickness)
trayRounding = 4; // [0:150]

// thickness of the vertical walls in mm
traySidewall = 0.8;

// thickness of the bottom in mm
trayBottom = 1.6;

// resolution used to render curved surfaces (experiment with low resolutions, and render the final results with higher resolution settings)
resolution = 60; // [30:Low (12 degrees), 60:Medium (6 degrees), 120:High (3 degrees)]

// ignore
$fn = resolution;

////////////////////////////////////////////////////////////

module torus(r1, r2) {
	rotate_extrude(convexity = 4)
	translate([r1, 0, 0])
	circle(r = r2);
}

module roundedCylinder(height, radius, fillet)
{
	hull() {
		translate([0, 0, height/2-fillet])
		torus(r1 = radius-fillet, r2 = fillet);
		translate([0, 0, -(height/2-fillet)])
		torus(r1 = radius-fillet, r2 = fillet);
	}
}

module roundTray(diameter, height, rounding, sidewall, bottom)
{
	radius = diameter/2;
	translate([0, 0, height])
	difference() {
		roundedCylinder(height*2, radius, rounding);
		roundedCylinder((height - bottom)*2, radius-sidewall, rounding - sidewall);
		cylinder(h=height*2, r=radius+1, center=false);
	}
}

roundTray(trayDiameter,trayHeight,trayRounding,traySidewall,trayBottom);