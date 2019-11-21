// jbox.scad
// Stackable Part Bins
// David O'Connor  david@lizardstation.com
// 24 August 2018

// Copyright Creative Commons Attribution Unported 3.0 (CC-BY-3.0)
//   See https://creativecommons.org/licenses/by/3.0/
//


// Box length
bx = 100; 
// Box width
by = 80;  
// Box or Lid?
box = 1; // [1:Box, 0:Lid]
// number of cells in the length direction
nx = 1; 
// number of cells in the width direction
ny = 1; 
// wall thickness 
wt = 2; 
// cell height
hc = 15;
// box height
hb = 20;
// fillet radius
rf = 2; 
// fit clearance 
fc = 0.20; 

$fa=5 * 1;
$fs=0.5 * 1;

if ((nx == 0) || (ny == 0) || (box == 0)) {    
    union() { 
        translate([0, 0, -wt])
            cube([bx , by, 2*wt]);
        translate([wt+fc, wt+fc, -0.5*fc])
            cube([bx-2*wt-2*fc, by-2*wt-2*fc, wt*2-fc]); 
    }
}
   
else {
        cx = (bx - (nx+1) * wt) / nx;
        cy = (by - (ny+1) * wt) / ny;
    union() {
        difference() {
            difference() {
                cube([nx*cx + (nx+1)*wt, ny*cy+(ny+1)*wt, hb]); 
                union() {
                    for (i = [1:nx]) {
                        for (j = [1:ny]) {
                            translate([(i-1)*(cx+wt)+wt+rf, (j-1)*(cy+wt)+wt+rf, wt+rf]) {
                                minkowski() {
                                    cube([cx-2*rf, cy-2*rf, hb-2*rf]);
                                    sphere(r = rf);
                                }  
                            }
                        }
                    }
                }
            }
            translate([wt, wt, (hc+wt)])
                cube([nx*cx + (nx-1)*wt , ny*cy+(ny-1)*wt, hb]); 
        }
        translate([wt+fc, wt+fc, -wt])
            cube([nx*cx + (nx-1)*wt - 2*fc , ny*cy+(ny-1)*wt - 2*fc, 1.99*wt]);
    }
}


       