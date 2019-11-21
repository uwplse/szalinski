// gap between edge and cut based on printer and material
tolerance = 0.3;

// small number to prevent singularities
fudge = 0.01;

// outer diameter of token
diameter = 25;

// height of token
height = 4;

// part to generate
part = "all"; //["all", "light", "dark", "outer", "inner", "outer_plus", "inner_plus", "outer_minus", "inner_minus"]

outerSquare = diameter * 15.5/25;
outerCut = outerSquare + 2 * tolerance;
innerSquare = diameter * 13.5/25;
innerCut = innerSquare + 2 * tolerance;
symbolLength = diameter * 14/25;
symbolLengthCut = symbolLength + 2 * tolerance;
symbolWidth = diameter * 3.5/25;
symbolWidthCut = symbolWidth + 2 * tolerance;

if (part == "all" || part == "outer" || part == "light" || part == "outer_plus") outerPlus();
if (part == "all" || part == "outer" || part == "dark" || part == "outer_minus") outerMinus();
if (part == "all" || part == "inner" || part == "dark" || part == "inner_plus") innerPlus();
if (part == "all" || part == "inner" || part == "light" || part == "inner_minus") innerMinus();

module outerPlus() {
    difference() {
        union() {
            cylinder(r = diameter / 2, h = 2);
            translate([-outerSquare / 2, -outerSquare / 2, 0]) cube([outerSquare, outerSquare, 3/4 * height]);
        }
        translate([-innerCut / 2, -innerCut / 2, 1/4 * height]) cube([innerCut, innerCut, 2.01]);
        translate([0, 0, 1/4 * height - fudge]) rotate([0, 0, 45]) cube([symbolLengthCut, symbolWidthCut, 2/4 * height + 2 * fudge], center = true);
        translate([0, 0, 1/4 * height - fudge]) rotate([0, 0, 135]) cube([symbolLengthCut, symbolWidthCut, 2/4 * height + 2 * fudge], center = true);
    }
}

module outerMinus() {
    translate([diameter * 1.1, 0, 0]) difference() {
        cylinder(r = diameter / 2, h = 2);
        translate([-outerCut / 2, -outerCut / 2, 1]) cube([outerCut, outerCut, 2]);
        translate([0, 0, 1/4 * height - fudge]) rotate([0, 0, 45]) cube([symbolLengthCut, symbolWidthCut, 2/4 * height + 2 * fudge], center = true);
    }
}

module innerPlus() {  
    translate([0, innerSquare * 1.2, 0]) union() {
        cube([innerSquare, innerSquare, 1]);
        translate([symbolLength / 2, symbolLength / 2, 1/4 * height]) rotate([0, 0, 45]) cube([symbolLength, symbolWidth, 2/4 * height], center = true);
        translate([symbolLength / 2, symbolLength / 2, 1/4 * height]) rotate([0, 0, 135]) cube([symbolLength, symbolWidth, 2/4 * height], center = true);
    }
}

module innerMinus() {
    translate([innerSquare * 1.2, innerSquare * 1.2, 0]) union() {
        cube([innerSquare, innerSquare, 1/4 * height]);
        translate([symbolLength / 2, symbolLength / 2, 1/4 * height]) rotate([0, 0, 45]) cube([symbolLength, symbolWidth, 2/4 * height], center = true);
    }
}

