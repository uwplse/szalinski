// -----------------------------------------------------
// Foldback-Klammer-Adapter
//
//  Detlev Ahlgrimm, 04.2018
// -----------------------------------------------------

// length of foldback clip
Length=32;

// width of foldback clip
Width=15;

// thickness of this thing
Thickness=3;      // [2:5]

// switch beween print-view and assembly-view
AssemblyView=1;   // [0:format for printing,1:how to assemble]

$fn=100;

// -----------------------------------------------------
// for Foldback-Clips with
//    Length =   51mm   41mm    32mm   25mm
//    Width  =   22mm   18mm    15mm   12mm
//  https://www.amazon.de/gp/product/B01MU180XF
// -----------------------------------------------------
module FoldbackAdapterA(l, b, t=3, brim=true) {
  w=b-2;
  l2=l+1;
  difference() {
    translate([l2+2*t, 0, 0]) rotate([90, 0, -90]) linear_extrude(l2+2*t) polygon([[0, t], [0, w-t], [-t+0.5, w], [-t, w], [-t, 0], [-t+0.5, 0]]);
    translate([t, w+t-1, w/2]) rotate([0, 90, 0]) cylinder(r=w, h=l2);
  }
  translate([0,   t-0.1, 0]) cube([t, 2*t+0.1, w]);
  translate([l2+t, t-0.1, 0]) cube([t, 2*t+0.1, w]);
  translate([t-0.1,    2*t, 0]) linear_extrude(w) polygon([[0, 0], [t/2+0.1,  0], [ 0.1, t]]);
  translate([l2+t+0.1, 2*t, 0]) linear_extrude(w) polygon([[0, 0], [-t/2-0.1, 0], [-0.1, t]]);

  if(brim) {
    translate([1.5*t+5, t+6, 0]) cylinder(r=4, h=0.3);
    translate([1.5*t+4.5, t, 0]) cube([1, 4, 0.3]);
    
    translate([l2/2+t, t+6, 0]) cylinder(r=4, h=0.3);
    translate([l2/2+t-0.5, t, 0]) cube([1, 4, 0.3]);
    
    translate([l2+t/2-5, t+6, 0]) cylinder(r=4, h=0.3);
    translate([l2+t/2-5.5, t, 0]) cube([1, 4, 0.3]);
  }
}
//!FoldbackAdapterA(51, 22, t=3);
//!FoldbackAdapterA(41, 18);
//!FoldbackAdapterA(32, 15);

// -----------------------------------------------------
//
// -----------------------------------------------------
module FoldbackAdapterB(l, b, t=3) {
  w=b-2;
  l2=l+1;
  difference() {
    translate([0, 1, 0]) cube([l2+2*t, 3*t-0.5, w]);
    translate([-0.1,    -0.1, -0.1]) cube([t+0.3, 2*t+0.2, w+0.2]);
    translate([l2+t-0.2, -0.1, -0.1]) cube([t+0.3, 2*t+0.2, w+0.2]);
    translate([t,    t-0.2, -0.1]) linear_extrude(w+0.2) polygon([[0, 0], [t/2+0.4,  0], [0, t+0.4]]);
    translate([l2+t, t-0.2, -0.1]) linear_extrude(w+0.2) polygon([[0, 0], [-t/2-0.4, 0], [0, t+0.4]]);
  }

  /*translate([2+l/2+t-10, 3*t-10.1, 0]) difference() {
    Arm(42, m=0);
    translate([-2.1, -10, -0.1]) cube([20.2, 19.9, 10]);
  }
  difference() {
    union() {
      translate([2+l/2+t-10, 3*t+1-0.6, 5.9]) rotate([0, -90, 0]) linear_extrude(2) polygon([[0,0], [0,w-6], [w-6,0]]);
      translate([2+l/2+t+8, 3*t+1-0.6, 5.9]) rotate([0, -90, 0]) linear_extrude(2) polygon([[0,0], [0,w-6], [w-6,0]]);
    }
    translate([-0.1, 3*t+1+w-6, w]) rotate([0, 90, 0]) cylinder(r=w-6, h=l+2*t+0.2);
  }*/
}

if(AssemblyView==1) {
  translate([0, -Thickness, 0]) FoldbackAdapterA(Length, Width, Thickness, brim=false);     // Montage
  FoldbackAdapterB(Length, Width, Thickness);
} else {
  translate([0, Width+Thickness, 0]) FoldbackAdapterA(Length, Width, Thickness);            // Druck
  FoldbackAdapterB(Length, Width, Thickness);
}
