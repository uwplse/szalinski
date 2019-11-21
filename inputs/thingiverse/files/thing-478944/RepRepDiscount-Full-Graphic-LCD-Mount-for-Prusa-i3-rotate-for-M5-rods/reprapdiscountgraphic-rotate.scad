// This script creates a bracket for mounting the RepRapDiscount graphic LCD
// panel on top of the left side Z axis mount.
//
// Parts required:
//
// (1) 110 mm M5 rod
// (1) M5 locking nut
// (1) M5 hand twist nut
// (2) M5 washer
// (4) 3mm x 15mm bolts for arms
// (2) 3mm x 20mm bolts for base
// (1) 3mm x 25mm bolts for rotating parts
// (7) 3mm nuts
// (2) 3mm washers (optional)
// 
// Instructions: (old, for non rotation version)
//
// 1) print out all parts
// 2) remove the (2) bolts holding your top left Z axis bracket
// 3) place base of mount on top of frame and thread the 20mm bolts
//    through the top Z-axis bracket and the base (see photo on
//    Thingiverse) then add 3mm washers and nuts and tighten
// 4) mount arms to the LCD panel with the spacer side pointing 
//    toward the center
// 5) thread the 5/16" bolt through the arms and base 
// 6) adjust and tighten the 5/16" bolt
// 7) connect LCD panel ribbon cables
// 
// Created by: drcharlesbell@gmail.com
//
// Enjoy!

module bracket() {
  difference() {
    union() {
      rotate([0,0,45]) translate([0,-1,0]) cube([42,42,8]);
      translate([-30,29.75,0]) cylinder(37.5,6.5,6.5);
      translate([-1,-6.5,0]) cube([5,9,8]);
      translate([-1,55.5,0]) cube([5,9.5,8]);
    }
    rotate([0,0,45]) translate([5,-1,0]) cube([37,37,8]);
    translate([-30,29.75,0]) cylinder(38.5,2.9,2.9); //for M5 rods
    rotate([0,90,0]) translate([-4,-3,-1]) cylinder(10,1.75,1.75,$fn=32);
    rotate([0,90,0]) translate([-4,61.5,-1]) cylinder(10,1.75,1.75,$fn=32);
    translate([3.75,-7,0]) cube([3,100,10]);
  }
  translate([-27.1,24,0]) cube([8,11,8]);
}

module top_clamp_center() {
  difference() {
    union() {
      translate([0,-15,0]) cube([55,20,20]);
      translate([48,20,0]) cylinder(20,8,8);
      translate([40,-15,0]) cube([16,35,20]);
    }
    // cutout for frame
    translate([5,-11,0]) cube([40,7,20]);
    translate([10,-21,0]) cube([30,10,20]);
    // bolt for clamp and nut trap
    translate([-1,0,5]) rotate([0,90,0]) cylinder(25,1.75,1.75,$fn=32);
    translate([17,0,5]) rotate([0,90,0]) cylinder(3,3.3,3.3,$fn=6);
    // nut trap
    translate([17,-9,2.15]) cube([3,10,5.7]);
    // bolt for clamp and nut trap
    translate([-1,0,15]) rotate([0,90,0]) cylinder(25,1.75,1.75,$fn=32);
    translate([17,0,15]) rotate([0,90,0]) cylinder(3,3.3,3.3,$fn=6);
    // nut trap
    translate([17,-9,12.15]) cube([3,10,5.7]);
    // slice
    translate([11,-10,0]) cube([0.75,40,20]);
    // rod
    translate([48,20,0]) cylinder(22,4.25,4.25);
  }
}

module top_clamp_side() {
rHex = 7/2;
  difference() {
    union() {
      translate([0,-20,0]) cube([16,35,20]);
      translate([-8,-20,0]) cube([24,24,28]);
    }
    // cutout for frame
    translate([-8,-20,0]) cube([4,14,28]);
    translate([-8,-20,0]) cube([4,18,12]);
    translate([-4,-20,0]) cube([4,18,28]);
    translate([-4,-20,0]) cube([16,18,28]);
   // rod
    translate([10,-12,4]) rotate([0,90,0]) cylinder(10,1.75,1.75,$fn=32);
    translate([10,-12,24]) rotate([0,90,0]) cylinder(10,1.75,1.75,$fn=32);
    translate([8,1,10])rotate([90,90,0]) cylinder(5,3.5,3.5,$fn=32);
    translate([8,5,10]){
		rotate([90,0,0,]) linear_extrude(10,center = false,2,twist = 0,slices = 20)
			polygon(points=[[sin(360*1/6)*rHex, cos(360*1/6)*rHex],[sin(360*2/6)*rHex, cos(360*2/6)*rHex],[sin(360*3/6)*rHex, cos(360*3/6)*rHex],[sin(360*4/6)*rHex, cos(360*4/6)*rHex],[sin(360*5/6)*rHex, cos(360*5/6)*rHex],[sin(360*6/6)*rHex, cos(360*6/6)*rHex]]);}
	

	// m3 screw
   translate([8,16,10])rotate([90,90,0]) cylinder(20,1.75,1.75,$fn=32);
  }
   translate([-8,-1.75,7.75]) rotate([45,0,0]) cube([4,6,6]);


}
module rotating_head() {
  difference() {
    union() {
      translate([8,40,0]) cylinder(20,8,8);
      translate([0,20,0]) cube([16,20,20]);
     }
    // rod
    translate([8,40,0]) cylinder(22,2.9,2.9); //for M5 rods

	// m3 screw
#   translate([8,39,10])rotate([90,90,0]) cylinder(20,1.75,1.75,$fn=32);
   translate([8,80,10])rotate([90,90,0]) cylinder(50,3.5,3.5,$fn=32);
  }
  
}



translate([-60,0,0]) top_clamp_side();
rotate([0,0,180]) translate([-10,-59,0]) bracket();
bracket();
translate([-60,0,0])rotating_head();