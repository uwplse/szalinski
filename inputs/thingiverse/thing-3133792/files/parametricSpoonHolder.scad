// an assistive device from FabLab Shinagawa
// Parametric Spoon Holder

gR = 25; // Grip radial
gH = 90; // Grip length
bR = 60; // Brim radial
bH = 4; // Brim thickness
sX = 12; // Spoon width
sY = 3; // Spoon thickness
sZ = 24; // Spoon slot

// main geometry
difference() {
    union() {
        translate([0, 0, gH/2]) grip();
        translate([0, 0, bH/2]) brim();
        }
    translate([0, 0, sZ/2]) spoon();
    }

// translate([100, 0, sZ/2]) spoon();
module grip() cylinder(r=gR, h=gH, center=true);
module brim() cylinder(r=bR, h=bH, center=true);
module spoon() cube(size = [sX,sY,sZ], center=true);