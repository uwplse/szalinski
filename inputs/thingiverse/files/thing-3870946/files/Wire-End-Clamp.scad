/* Wire End Clamp for Model Railroad.
   Clamp Bus wire to end of layout, with slots to separate
   and hold two wires in position.
*/
/***** Display options while rendering *****
 *  disable
 !  show only
 #  highlight / debug
 %  transparent / background
*/
/*  PARAMETERS - values in brackets are suggested starting values)  */
/* [Open Parameters:] */
// Width of clamp
b_width = 65;
// Height of clamp
b_height = 30;
// Width of gap
gap_w = 3;
// Depth of gap
gap_d = 2;
// Distance between gaps
gap_sep = 20;

// Main Body
module main(){
    // Main Bracket
    linear_extrude(height = 5){
        square([b_width,b_height],center=false);
    }
}
module gaps(x,y,z){
    //calculate and build the gaps
    // offset from edge of bracket
    offset = (b_width/2)-(gap_sep/2)-(gap_w/2);
    translate([offset,0,0]){
        // first gap
        cube([gap_w,b_height,gap_d]);
        // second gap
        translate([gap_sep,0,0]){
            cube([gap_w,b_height,gap_d]);
        }
    }
}
module screw_holes(){
    //first hole
    translate([10,b_height/2,0]){
        cylinder(h=5,d=4,$fn=40,center=false);
        //countersink it
        translate([0,0,3]){
            cylinder(h=2,d1=4,d2=7.35,$fn=40,center=false);
        }
    }
    offset = b_width - 10;
    //second hole
    translate([offset,b_height/2,0]){
        cylinder(h=5, d=4,$fn=40,center=false);
        //countersink it
        translate([0,0,3]){
            cylinder(h=2,d1=4,d2=7.35,$fn=40,center=false);
        }
    }
}
// Now put it all together
    difference(){
        main();
        gaps();
        screw_holes();
    }
