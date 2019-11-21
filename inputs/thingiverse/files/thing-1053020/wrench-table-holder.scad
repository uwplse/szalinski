/*
Wrench Table Holder (c) by Jorge Monteiro

Wrench Table Holder is licensed under a
Creative Commons Attribution-ShareAlike 4.0 International.

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.
*/
$fn = 40;

topBrace = 90;
bottomBrace = 60;
//base
thickness = 2.5;
baseWidth = 20;
baseHeight = 25;
baseThickness = 1.5;

// braces
braceWidth = 10;
braceThickness = 1.5;

drawBraces();
drawSides(100, 5);

module drawBraces() {
    
    translate([0, braceWidth + baseWidth + 20, 0]) drawBrace(topBrace);
    translate([0, braceWidth + baseWidth + 40, 0]) drawBrace(bottomBrace);
};

module drawBrace(size) {
    union() {
        roundedRect(size, braceWidth, braceThickness, 5);
        translate([0, 0, braceThickness]) socket(size/2-5, baseThickness);
        translate([0, 0, braceThickness]) socket(-size/2+5, baseThickness);
    };
};

module drawSides(length, slots) {
    
    translate([0, baseWidth + 5, 0]) drawLeftBase(length, slots);
    drawRightBase(length, slots);
};

module wrenchSlots(length, slots) {
    difference() {
        // frame
        rotate([90, 0, 0]) cube([length, baseHeight, thickness]);
        // slots per wrench
        for (i = [0 : slots]) {
            translate([i * length/(slots+1),0,baseHeight]) {
                rotate([90, 90, 0]) {
                    hull(){
                        translate([baseHeight/2,0,0]) cylinder(r=2, h=thickness);
                        translate([0,0,0]) cylinder(r=.1, h=thickness);
                        translate([0,10,0]) cylinder(r=.1, h=thickness);
                    };
                };
            };
        };
    };
};

module drawLeftBase(length, slots) {
    difference() {
        translate([0, baseWidth/6, 0]) roundedRect(length, baseWidth, baseThickness, 3);
        socket(length/2-8, baseThickness);
        socket(-length/2+8, baseThickness);
    }
    translate([-length/2, baseWidth/2, 0]) {
        wrenchSlots(length, slots);
    };
};

module drawRightBase(length, slots) {
    difference() {
        translate([0, -baseWidth/6, 0]) roundedRect(length, baseWidth, baseThickness, 3);
        socket(length/2-8, baseThickness);
        socket(-length/2+8, baseThickness);
    }
    translate([-length/2,-baseWidth/2+thickness,0]) {
        wrenchSlots(length, slots);
    };
};


module socket(location, thick) {
    translate([location, 0, 0]) cylinder(h = thick, r = 2);
};

module roundedRect(xdim, ydim, zdim, rdim) {
    translate([-xdim/2,-ydim/2,0]){
        hull(){
            translate([xdim-rdim,rdim,0]) cylinder(r=rdim, h=zdim);
            translate([xdim-rdim,ydim-rdim,0]) cylinder(r=rdim, h=zdim);

            translate([rdim,ydim-rdim,0]) cylinder(r=rdim, h=zdim);
            translate([rdim,rdim,0]) cylinder(r=rdim, h=zdim);
        };
    };
};
