//-- Oscillating Filament Guide double pivot and arm for P3Steel (3mm) or Prusa i3 frame (6mm)
//-- Parametric: arm lengths can be adjusted as well as thickness of frame and tolerance
//-- Assembly requires 2 x M4 bolts, washers and nyloc nuts, and one small
//-- nylon tie.
//-- AndrewBCN - December 2014
//-- GPLV3
//-- Redesign of Filament Guide for Prusa Mendel by tosjduenfs
//-- Thingiverse #34133


// Parameters

// Long arm length
arm_len=52; // [40:80]

// Short arm length
arm2_len=30; // [28:50]

// Frame thickness not including tolerance
frame_thickness=3; // [3,6]

// Frame thickness tolerance
tolerance=0.1; // [0.0,0.1,0.2,0.3]

/* [Hidden] */
$fn=64;

// Modules

module ofg_arm() {
  difference() {
    union() {
      // pivot cylinder
      cylinder(r=5,h=6, center=true);
      // hollowed out arm
      translate([arm_len/2,0,0]) difference() {
	cube([arm_len,10,6], center=true);
	cube([arm_len-26,6,8], center=true);
	translate([13-arm_len/2,0,0]) cylinder(r=3,h=8, center=true);
	translate([arm_len/2-13,0,0]) cylinder(r=3,h=8, center=true);
      }
      // cleaning sponge holder and filament guide
      translate([arm_len,0,12/2-3]) cylinder(r=6.3,h=12, center=true);
    }
    // hole for M4 bolt
    cylinder(r=2.2,h=8, center=true);
    // hole for cleaning sponge
    translate([arm_len+3,0,14/2-2]) cylinder(r=6,h=20, center=true);
    // chamfer
    translate([arm_len+2,0,14-2]) scale([1,0.9,1.4]) sphere(r=7, center=true);
    // hole for nylon tie
    translate([arm_len-3.8,0,14/2-2]) difference() {
      cylinder(r=4,h=2.2, center=true);
      cylinder(r=2.7,h=2.4, center=true);
    }
    // remove sharp edges
    translate([arm_len+1,0,0]) cube([3,20,40],center=true);
    translate([arm_len,0,10]) cube([20,20,3],center=true);    
  }
}

module ofg_arm2() {
  difference() {
    union() {
      // pivot cylinder
      cylinder(r=5,h=6, center=true);
      // hollowed out arm
      translate([arm2_len/2,0,0]) difference() {
	cube([arm2_len,10,6], center=true);
	cube([arm2_len-26,6,8], center=true);
	translate([13-arm2_len/2,0,0]) cylinder(r=3,h=8, center=true);
	translate([arm2_len/2-13,0,0]) cylinder(r=3,h=8, center=true);
      }
      // 2nd pivot cylinder
      translate([arm2_len,0,0]) cylinder(r=5,h=6, center=true);
    }
    // hole for M4 bolt
    cylinder(r=2.2,h=8, center=true);
    // 2nd hole for M4 bolt
    translate([arm2_len,0,0]) cylinder(r=2.2,h=8, center=true);
  }
}

module ofg_pivot() {
  difference() {
    union() {
      translate([4/2,30/2,30/2]) cube([4,30,30], center=true);
      // 3.2mm = frame thickness + tolerance
      translate([4/2+(frame_thickness+tolerance)+4,30/2,30/2]) cube([4,30,30], center=true);
      // join two pieces
      translate([(frame_thickness+tolerance)/2+4,30/2,4/2]) cube([(frame_thickness+tolerance),30,4], center=true);
      // make nice
      translate([(8+(frame_thickness+tolerance))/2,30/2,30]) difference() {
	rotate([90,0,0]) cylinder(r=(8+(frame_thickness+tolerance))/2, h=30, center=true);
	cube([(frame_thickness+tolerance),32,25], center=true);
      }
    }
  }
  // cylinder for pivot
  translate([(8+(frame_thickness+tolerance))+5/2+4/2,30-10/2,9/2]) difference() {
    hull() {
      translate([1,0,0]) cylinder(r=5,h=9, center=true);
      translate([-8,0,0]) cube([1,10,9], center=true);
    }
    // hole for M4 bolt
    translate([1,0,0]) cylinder(r=2.2,h=50, center=true);
  }  
}

// Print the parts

translate([0,-10,3]) ofg_arm();
translate([0,-25,3]) ofg_arm2();
translate([30,0,0])  rotate([0,0,90]) ofg_pivot();
