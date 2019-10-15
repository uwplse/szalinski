/*
 * Tatara A8 v1.10 Customizable Rods Blocker 
 * https://www.thingiverse.com/thing:2746024
 * 
 * by TataraTeam - https://www.thingiverse.com/TataraTeam/about
 * created 2018-01-05
 * version v0.02
 *
 * Changelog
 * --------------
 * v0.02:
 *      - Add extra hole 
 *
 * v0.01:
 *      - First version
 * --------------
 *
 * This work is licensed under the Creative Commons - Attribution - NonCommercial - ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */

//preview[view:north, tilt:top]

// Height of whole part
h=4; //[4:0.04:8]
// Extra Depth for rod hole
depth=0.2; //[-1:0.04:2]
// extra hole diameter (0 no hole) for set screw
eh_diam=0;//[0:0.05:7]

   
if (eh_diam != 0) {
    difference() {
        flange_extra_space_hole(h,depth);
        cylinder(h*3, d = eh_diam, center = true, $fn=128);
        }
    }    
else {
    flange_extra_space_hole(h,depth);
    }    

echo("done");


// modules
module flange_extra_space_hole(h,depth){
    if (depth > 0) {
        difference() {  
            basicshape(h);
            translate([0,0,h-depth]) 
                cylinder(h, d = 8.2, center = false, $fn=128);
        }
    }
    if (depth <= 0) {
        union (){
            basicshape(h);
            translate([0,0,h]) 
                cylinder(-depth, d = 8.2, center = false, $fn=128);
            }
    }    
}  
    
    
module basicshape(h){
    difference() {  
        hull(){ // this is the main shape
        // make first clinder 
         cylinder(h, d = 14, center = false, $fn=128);
        // second cylinder and translate
        translate([-3,-10,0]) 
            cylinder(h, d = 8, center = false, $fn=128);
        //third cilinder and translate
        translate([10,3,0]) 
            cylinder(h, d = 8, center = false, $fn=128);
        }
        // round inner border
        translate([18.13333,-18.13333,0]) 
            cylinder(h*3, r = 18.64435, center=true, $fn=256);
        // make first hole and translate
        translate([-3,-10,0]) 
            cylinder(h*3, d = 3.2, center = true, $fn=128);
        // make second hole and translate
        translate([10,3,0]) 
            cylinder(h*3, d = 3.2, center = true, $fn=128);
        // the wole depth
        }
    }