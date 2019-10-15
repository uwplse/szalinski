/*
CNC End Mills Holder (c) by Jorge Monteiro

CNC End Mills Holder is licensed under a
Creative Commons Attribution-ShareAlike 4.0 International.

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.
*/

/* [Basics] */
// Space between end mills in mm
endMillGap = 5;
// Diameter of end mill in mm
endMillSize = 12;
// Number of end mills you want to store per row
endMillsPerRow = 4;
// Number of end mills you want to store per column
endMillsPerColumn = 4;
// Height of the end mill box in mm
height = 25;
// Base of the box in mm
baseHeight = 3;

/* [Ignore] */
$fn=40*1;
endMillDim = endMillSize/2;
width = endMillsPerRow * (endMillGap + endMillSize) + endMillGap;
length = endMillsPerColumn * (endMillGap + endMillSize) + endMillGap;
endMillHeight = height - baseHeight;

difference() {
    
    translate([length/2-(endMillGap+endMillDim), width/2-(endMillGap+endMillDim), -3]) roundedCube(length, width, height, 5);
    drawEndMillHolders();
};

module drawEndMillHolders() {
     for(row = [0 : 1 : endMillsPerRow-1]) {
         for(column = [0 : 1 : endMillsPerColumn-1]) {
            translate([(endMillGap+endMillSize)*column, (endMillGap+endMillSize)*row, height-endMillHeight/2]) cube([endMillSize, endMillSize, endMillHeight], true);
         }
     }

}

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

