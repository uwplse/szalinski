/*
D4R-II top mount for Naze (c) by Jorge Monteiro

D4R-II top mount for Naze is licensed under a
Creative Commons Attribution-ShareAlike 4.0 International.

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.
*/

$fn = 40;
// Naze
nazeDimension = 36;
nazeBaseThickness = 1.2;
nazeHoleToHoleDistance = 30.5;
nazeHoleSize = 3;
// Side slot size
nazeLeftSideOpenning = 0;
nazeRightSideOpenning = 0;
// frsky antenna
antennaLength = 20;
antennaOuter = 3;
antennaInner = 1.85;
// frsky 
frskyWidth = 25;
frskyLength = 31;
frskyTopWidth = 8;
frskyTopHeight = 10;
frskySideWidth = 1;
frskySideBarHeight = 9;

nazeBaseWithGaps();
frskyBase();

module frskyBase() {    
    difference() {
        union() {
            difference() {
                union() {
                    translate([(nazeDimension-frskyTopWidth)/2,frskyWidth/2-frskySideWidth,0]) rotate([0,0,90]) cube([frskySideWidth,frskyLength,frskySideBarHeight]);
                    translate([(nazeDimension-frskyTopWidth)/2,-frskyWidth/2,0]) rotate([0,0,90]) cube([frskySideWidth,frskyLength,frskySideBarHeight]);
                    translate([-nazeDimension/2,-frskyWidth/2,0]) cube([frskyTopWidth,frskyWidth,frskyTopHeight]);
                };
                // subtract both antenna tubes
                translate([-14,-3,3]) rotate([45, 0, 0]) cylinder(antennaLength, antennaOuter, antennaOuter);
                translate([-14,3,3]) rotate([-45, 0, 0]) cylinder(antennaLength, antennaOuter, antennaOuter);

            };
            // Now draw the antenna tubes
            translate([-14,-3,3]){
                rotate([45, 0, 0]){
                    drawTube(antennaLength, antennaOuter, antennaInner);
                };
            };
            translate([-14,3,3]){
                rotate([-45, 0, 0]){
                    drawTube(antennaLength, antennaOuter, antennaInner);
                };
            };

        };
        translate([-14, -6.3, 6]) rotate([0,90,0]) cylinder(400, antennaInner, antennaInner);
        translate([-14, 6.3, 6]) rotate([0,90,0]) cylinder(400, antennaInner, antennaInner);
    };
};

module nazeBaseWithGaps() {
    gap = nazeDimension - frskyWidth;
    difference() {
        nazeBase();
        if (nazeLeftSideOpenning > 0)
            translate([0, -(frskyWidth+gap)/2, 0]) roundedCube(nazeLeftSideOpenning, gap, nazeBaseThickness, 3);
        if (nazeRightSideOpenning > 0)
            translate([0, (frskyWidth+gap)/2, 0]) roundedCube(nazeRightSideOpenning, gap, nazeBaseThickness, 3);
    };
};

module nazeBase() {
    difference() {
        roundedCube(nazeDimension,nazeDimension,nazeBaseThickness,3);
        union(){
            translate([nazeHoleToHoleDistance/2,nazeHoleToHoleDistance/2,0]) {
                cylinder(nazeBaseThickness, d=nazeHoleSize);
            };
            translate([-nazeHoleToHoleDistance/2,nazeHoleToHoleDistance/2,0]) {
                cylinder(nazeBaseThickness, d=nazeHoleSize);
            };
            translate([-nazeHoleToHoleDistance/2,-nazeHoleToHoleDistance/2,0]) {
                cylinder(nazeBaseThickness, d=nazeHoleSize);
            };
            translate([nazeHoleToHoleDistance/2,-nazeHoleToHoleDistance/2,0]) {
                cylinder(nazeBaseThickness, d=nazeHoleSize);
            };
        };
    };
};

//roundedCube(36,36,1.2,3);
module roundedCube(xdim, ydim, zdim, rdim) {
    translate([-xdim/2,-ydim/2,0]){
        hull(){
            translate([rdim,rdim,0]) cylinder(r=rdim, h=zdim);
            translate([xdim-rdim,rdim,0]) cylinder(r=rdim, h=zdim);

            translate([rdim,ydim-rdim,0]) cylinder(r=rdim, h=zdim);
            translate([xdim-rdim,ydim-rdim,0]) cylinder(r=rdim, h=zdim);

        };
    };
};

module drawTube(distance, outer, inner) {
    difference() {
        cylinder(distance, outer, outer);
        cylinder(distance, inner, inner);
    };
};

module drawTubeWithHole(distance, outer, inner) {
    difference() {
        drawTube(distance, outer, inner);
        translate([0,0,2]) rotate([0, 90, 0]) cylinder(distance, inner, inner);
    };
};

