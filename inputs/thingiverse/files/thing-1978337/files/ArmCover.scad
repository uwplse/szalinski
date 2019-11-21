// ****************************************************************************
// Arm cover, can be used to fix the cables in the arm
// resize as required
// Author: Peter Holzwarth
// ****************************************************************************

// length of one arm
len1= 18; // [5:180]

// length of other arm
len2= 20; // [5:180]

rotate([0,-90,0]) cover(len1);
translate([0, 20, 0]) rotate([0,-90,0]) cover(len2);

// an arm cover, 20mm wide
module cover(width) {
    difference() {
        cube([width,14,20+4]);
        // inner part
        translate([-0.1, 2, 2]) cube([width+0.2,10,20]);
        // snapping part
        translate([-0.1, 3, -0.1]) cube([width+.2,8,2.2]);
    }
}
