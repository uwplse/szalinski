// Copyright 2019 jackw01. 
// https://jackw01.github.io
// Released under the Creative Commons - Attribution license.

// Shaft diameter (mm)
shaftDiameter = 8;
// Outer diameter (mm)
outerDiameter = 20;
// Gap width (mm)
gapWidth = 1.5;
// Thickness (mm)
thickness = 8;
// Screw clearance hole diameter (mm)
screwHoleDiameter = 3.4;
// Screw clearance hole counterbore diameter (mm)
screwHoleCounterboreDiameter = 6.5;
// Thickness of the surfaces that the screw and nut press against (mm)
screwSurfaceThickness = 3;
// Nut pocket width (mm)
nutPocketWidth = 5.75;
// Nut pocket rotation (degrees)
nutPocketRotation = 0;
// Number of segments used to make circular shapes
circleRes = 100;

module regular_polygon(order = 6, r = 1){
    angles = [ for (i = [0:order - 1]) i * (360 / order) ];
    coords = [ for (th = angles) [r * cos(th), r * sin(th)] ];
    polygon(coords);
}

difference() {
    linear_extrude(height=thickness) {
        difference() {
            circle(d=outerDiameter, $fn=circleRes);
            circle(d=shaftDiameter, $fn=circleRes);
            translate([0, -outerDiameter, 0]) square([gapWidth, outerDiameter * 2], center=true);
        }
    }
    translate([0, (-outerDiameter / 2 - shaftDiameter / 2) / 2, thickness / 2]) rotate([0, 90, 180]) union() {
        translate([0, 0, -outerDiameter / 2]) linear_extrude(height=outerDiameter) {
            circle(d=screwHoleDiameter, $fn=circleRes);
        }
        translate([0, 0, screwSurfaceThickness + gapWidth / 2]) linear_extrude(height=screwHoleCounterboreDepth + outerDiameter) {
            circle(d=screwHoleCounterboreDiameter, $fn=circleRes);
        }
        mirror([0, 0, 1]) translate([0, 0, screwSurfaceThickness + gapWidth / 2]) linear_extrude(height=screwHoleCounterboreDepth + outerDiameter) {
            rotate([nutPocketRotation, 0, 0]) regular_polygon(order=6, r=nutPocketWidth / 2);
        }
    }
}
