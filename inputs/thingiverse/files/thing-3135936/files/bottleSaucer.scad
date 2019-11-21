bottleDiameter = 30; // Diameter (in mm) of bottle here
saucerHeight = 20; // Height (in mm) of the saucer here
baseThickness = 1; // Base thickness (in mm) to ensure that you have enough layers that no liquid will pass through
baseRing = 4; // The bottom ring height (in mm) to ensure that you have enough space for your sponge

// Stop editing here

$fn = 120;

difference() {
    union() {
        cylinder(d=bottleDiameter * 1.1, h=saucerHeight * 0.8);
        translate([0, 0, saucerHeight * 0.8]) cylinder(d=bottleDiameter * 1.1 + 5, h=saucerHeight * 0.2);
        translate([0, 0, saucerHeight * 0.7]) cylinder(d1=bottleDiameter * 1.1, d2=bottleDiameter * 1.1 + 5, h=saucerHeight * 0.1);
    }
    translate([0, 0, baseThickness]) cylinder(d=bottleDiameter * 0.9, h=baseRing);
    translate([0, 0, baseThickness + saucerHeight * 0.2]) cylinder(d=bottleDiameter, h=saucerHeight * 0.8);
    translate([0, 0, saucerHeight * 0.9]) cylinder(d=bottleDiameter * 1.1, h=saucerHeight * 0.1);
    translate([bottleDiameter * 0.475, 0, baseThickness]) cylinder(d=bottleDiameter * 0.11, h=saucerHeight);
    translate([-bottleDiameter * 0.475, 0, baseThickness]) cylinder(d=bottleDiameter * 0.11, h=saucerHeight);
    translate([0, bottleDiameter * 0.475, baseThickness]) cylinder(d=bottleDiameter * 0.11, h=saucerHeight);
    translate([0, -bottleDiameter * 0.475, baseThickness]) cylinder(d=bottleDiameter * 0.11, h=saucerHeight);
}