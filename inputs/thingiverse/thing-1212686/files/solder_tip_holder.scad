/*
Solder Tip Holder (c) by Jorge Monteiro

Solder Tip Holder is licensed under a
Creative Commons Attribution-ShareAlike 4.0 International.

You should have received a copy of the license along with this
work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.
*/

/* [Basics] */
// Space between tips in mm
tipGap = 3;
// Diameter of tip in mm
tipSize = 9;
// Number of tips you want to store per row
tipsPerRow = 3;
// Number of tips you want to store per column
tipsPerColumn = 3;
// Height of the tip box in mm
height = 18;
// Base of the box in mm
baseHeight = 3;

/* [Ignore] */
$fn=40*1;
tipDim = tipSize/2;
width = tipsPerRow * (tipGap + tipSize) + tipGap;
length = tipsPerColumn * (tipGap + tipSize) + tipGap;
tipHeight = height - baseHeight;

difference() {
    
    translate([length/2-(tipGap+tipDim), width/2-(tipGap+tipDim), -3]) roundedCube(length, width, height, 5);
    drawTipHolders();
};

module drawTipHolders() {
     for(row = [0 : 1 : tipsPerRow-1]) {
         for(column = [0 : 1 : tipsPerColumn-1]) {
            translate([(tipGap+tipDim*2)*column, (tipGap+tipDim*2)*row]) cylinder(tipHeight, tipDim, tipDim);
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

