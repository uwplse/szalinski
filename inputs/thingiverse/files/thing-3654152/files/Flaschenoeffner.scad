// -----------------------------------------------------
// Flaschenoeffner
//
//  Detlev Ahlgrimm, 25.05.2019
// -----------------------------------------------------

include_text=0;  // [0:False, 1:True]

strg1="info@dg-cybersicherheit.de";
size1=7;

strg2="www.cyberscan.io";
size2=7;

$fn=100;

/* [Hidden] */
r=300;
a=24;
hgt=20;
ws=3;

$vpt=[128, 109, -73];
$vpr=[62, 0, 330];
$vpd=446;

xp=r*sin(a);
yp=r*cos(a);
translate([1.5, -r+yp+ws/2, 0]) {
  difference() {
    translate([0, -yp, 0]) difference() {
      cylinder(r=r, h=hgt);
      translate([0, 0, -0.1]) cylinder(r=r-ws, h=hgt+0.2);
    }
    translate([-r-0.1, -r-yp-0.1, -0.1]) cube([r+0.1, 2*r+0.2, hgt+0.2]);
    translate([-0.1, -r-yp-0.1, -0.1]) cube([r+0.2, r+0.1, hgt+0.2]);
    translate([0, -yp, -0.1]) rotate([0, 0, -a]) cube([r+0.1, r+0.1, hgt+0.2]);
  }
  translate([(r-ws/2)*sin(a), (r-ws/2)*cos(a)-yp, 0]) cylinder(d=ws, h=hgt);
  translate([(r-ws/2)*sin(0), (r-ws/2)*cos(0)-yp, 0]) cylinder(d=ws, h=hgt);
}

difference() {
  intersection() {
    translate([25, 0, 0]) scale([1, 0.6, 1]) cylinder(r=25, h=hgt);
    translate([1.5, -yp-r+yp+ws/2, 0]) cylinder(r=r, h=hgt);
  }
  rotate([0, 0, -6]) {
    translate([10, -19, -0.1]) linear_extrude(hgt+0.2) polygon([ [0,0], [0,17], [20,17], [20,10.5], [18,10.5], [18,9.5], [35,0] ]);
    translate([30, -19+17-6.5/2, -0.1]) cylinder(d=6.5, h=hgt+0.2);
  }
  translate([27, -30, hgt/2]) rotate([-90, 0, -2*a]) cylinder(d=hgt-4, h=50);
  translate([13, -8, hgt/2]) rotate([90, 0, 0]) intersection() {
    cylinder(d=32, h=10);
    translate([10, -16, -0.2]) cube([17, 32, 10.2]);
  }
}

if(include_text && len(strg1)>0) render() difference() {
  intersection() {
    translate([60, -23, hgt/2]) rotate([-90, 0, -a/2]) linear_extrude(32) text(strg1, size=size1, halign="center", valign="center");
    translate([1.5, -yp-r+yp+ws/2, 0]) cylinder(r=r+1, h=hgt);
  }
  translate([1.5, -yp-r+yp+ws/2, 0]) cylinder(r=r-1, h=hgt);
}

if(include_text && len(strg2)>0) render() difference() {
  intersection() {
    translate([85, 0, hgt/2]) rotate([90, 0, -a/2]) linear_extrude(25) text(strg2, size=size2, halign="center", valign="center");
    translate([1.5, -yp-r+yp+ws/2, 0]) cylinder(r=r, h=hgt);
  }
  translate([1.5, -yp-r+yp+ws/2, 0]) cylinder(r=r-ws-1, h=hgt);
}
