/* Wire Stand-off for Model Railroad.
   Holds bus wires away from benchwork, with slots
   to separate and hold two wires in position.
*/
/***** Display options while rendering *****
 *  disable
 !  show only
 #  highlight / debug
 %  transparent / background
*/
/*  PARAMETERS - values in brackets are suggested starting values)  */
// Width of Bracket
b_width = 42;
// Height of bracket
b_height = 70;
// Width of slot
slot_w = 3;
// Length of slot
slot_l = 12;
// Distance from mounting leg to first slot
offset1 = 20;
// Distance from mounting leg to second slot
offset2 = 50;
// Diameter of holes that wires sit in
hole_diam = 4;
// Width of top flange - with screw holes
flange_d = 30;
// Distance between wires
wire_sep = 20;

// Main Body
module main(){
    difference(){
        linear_extrude(height = b_height){
            square([b_width,5],center=false);
        }
        //first slot
        translate([0,0,offset1]){
            slots();
        }
        //second slot
        translate([0,0,offset2]){
            slots();
        }
        translate([b_width,0,0]){
            #mirror([1,0,0]){
                //third slot
                translate([0,0,offset1]){
                    slots();
                }
                //fourth slot
                translate([0,0,offset2]){
                    slots();
                }
            }
        }
    }
}
//Mounting Flange
module flange(){
    linear_extrude(height = 5){
        square([b_width,flange_d],center=false);
    }
}
module screw_holes(){
    hole_offset = (flange_d)*(.67);
    //first hole
    translate([10,hole_offset,0]){
        cylinder(h=5,d=4,$fn=40,center=false);
        //countersink it
        translate([0,0,3]){
            cylinder(h=2,d1=4,d2=7.35,$fn=40,center=false);
        }
    }
    offset = b_width - 10;
    //second hole
    translate([offset,hole_offset,0]){
        cylinder(h=5, d=4,$fn=40,center=false);
        //countersink it
        translate([0,0,3]){
            cylinder(h=2,d1=4,d2=7.35,$fn=40,center=false);
        }
    }
}
module slots(){
    // some offsets
    a = b_width/2;
    b = (b_width/2) - (wire_sep/2);
    c = b - slot_w;
    d = (b-c)/2;
    e = c+hole_diam/2-((hole_diam-slot_w)/2);
    
    translate([0,0,0]){
        cube([b,5,slot_w],center = false);
    }
    translate([c,0,0]){
        cube([slot_w,5,slot_l],center = false);
    }
    translate([e,0,slot_l]){
        rotate(a=[90,0,0])
        cylinder(h=10,d=hole_diam,$fn=40,center=true);
    }
}
// Now put it all together
    main();
    difference(){
        flange();
        screw_holes();
    }
