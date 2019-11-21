/*
Quadrysteria QR200 Antenna Holder (c) by Jorge Monteiro

Quadrysteria QR200 Antenna Holder is licensed under a
Creative Commons Attribution-ShareAlike 4.0 International.

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.
*/
/* [Basics] */
// Space between tips in mm
// antenna length in mm
antennaLength = 20;
// antenna outer diameter in mm
antennaOuter = 3;
// antenna inner diameter in mm
antennaInner = 1.85;
// base thickness
thickness=1.2;
// gap thickness
gapThickness=1.2;
// screw width
screwWidth=1.75;
// hole diameter
holeWidth=3.2;

/* [Ignore] */
$fn = 40*1;

drawBase();
drawHolders();

// draw the base
module drawBase() {
    translate([0,0,-(thickness+gapThickness)]){
        difference() {
            translate([4,0,gapThickness]) {
                roundedCube(17, 10, thickness, .1);
            }
            translate([7.5,0,gapThickness]) cylinder(thickness, screwWidth, screwWidth);
            cylinder((thickness+gapThickness), holeWidth, holeWidth);
        }
        difference(){
            cylinder((thickness+gapThickness), holeWidth, holeWidth);
            cylinder((thickness+gapThickness), holeWidth-1, holeWidth-1);
        }
    }
};

//draw the antenna holders
module drawHolders() {
    difference() {
        union() {
            // add the antenna holders
            translate([0,-1,1]){
                rotate([45, 0, 0]){
                    cylinder(antennaLength, antennaOuter+1.5, antennaOuter);
                }
            }
            translate([0,1,1]){
                rotate([-45, 0, 0]){
                    cylinder(antennaLength, antennaOuter+1.5, antennaOuter);
                }
            }
            cylinder(4, antennaOuter*1.6, antennaOuter);


        }
        // remove all the bottom stuff, we do not need it
        translate([0,0,-2.5-thickness]) {
            cube([100,100,5], true);
        }
        union() {
            // and all the interior spots
            translate([0,-1,1]){
                rotate([45, 0, 0]){
                    cylinder(antennaLength*1.5, antennaInner, antennaInner);
                }
            }
            translate([0,1,1]){
                rotate([-45, 0, 0]){
                    cylinder(antennaLength*1.5, antennaInner, antennaInner);
                }
            }
            cylinder(2, antennaInner*1.5, antennaInner);
        }
    };
};

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
