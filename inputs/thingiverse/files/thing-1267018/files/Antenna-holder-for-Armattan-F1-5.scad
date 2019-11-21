/*
Antenna holder for Armattan F1-5 (c) by Jorge Monteiro

Antenna holder for Armattan F1-5 is licensed under a
Creative Commons Attribution-ShareAlike 4.0 International.

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.
*/


$fn = 40*1;
/* [Basics] */
// Length of the antena tube
antennaLength = 20;
// Outer diameter of the antena tube
antennaOuter = 3;
// Inner diameter of the antena tube
antennaInner = 1.8;
// Thickness of the base
baseThickness = 1.2;
// Width of the base
width=16;

difference() {
    union() {
        roundedCube(width, 32, baseThickness, 3);

        translate([0, 0, -5]) 
            union() {
                // Now draw the antenna tubes
                translate([0,-8,3]){
                    rotate([45, 0, 0]){
                        cylinder(antennaLength, antennaOuter+2, antennaOuter);
                    };
                };
                translate([0,8,3]){
                    rotate([-45, 0, 0]){
                        cylinder(antennaLength, antennaOuter+2, antennaOuter);
                    };
                };
            };
        };
        translate([0, 0, -5]) cube([100,100,10], true);
        cylinder(2, 3.5, 3.2);
        translate([0,8,-2])
            rotate([-45, 0, 0])
                cylinder(antennaLength*2, antennaInner, antennaInner);
        translate([0,-8,-2])
            rotate([45, 0, 0])
                cylinder(antennaLength*2, antennaInner, antennaInner);
        
        
    };

module drawTube(distance, outer, inner) {
    difference() {
        cylinder(distance, outer, outer);
        cylinder(distance, inner, inner);
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
