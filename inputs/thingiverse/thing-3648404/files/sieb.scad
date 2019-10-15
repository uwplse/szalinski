holeSize = 1;
strengthX = 0.2;
strengthY = strengthX;
strengthZ = 2;
diameter = 120;
sieveBorder = 12;
sieveWallHeight = 40;
sieveWallThickness = 2;
steps = round(diameter/(holeSize+strengthX));

intersection() {
    union() {
        for(x = [0:steps]) {
            translate([(holeSize + strengthX)*x, 0, 0])
            cube([strengthX, diameter, strengthZ]);
        }
        for(y = [0:steps]) {
            translate([0, (holeSize + strengthY)*y, 0])
            cube([diameter, strengthY, strengthZ]);
        }
    }
    translate([(diameter/2),(diameter/2),0])
    cylinder(r = diameter/2, h = strengthZ, center = false);
}

translate([(diameter/2),(diameter/2),0])
difference() {
    cylinder(r = diameter/2 + sieveBorder, h = strengthZ, center = false);
    cylinder(r = diameter/2, h = strengthZ, center = false);
}

translate([(diameter/2),(diameter/2),strengthZ])
difference() {
    cylinder(r = diameter/2 + sieveBorder, h = sieveWallHeight, center = false);
    cylinder(r = diameter/2 + sieveBorder - sieveWallThickness, h = sieveWallHeight + 1, center = false);
}