// -----------------------------------------------------
// Beutel-Rollen-Halter
//
//  Detlev Ahlgrimm, 17.12.2018
//
// Diesmal mit Nutzung des offset-Kommandos. Siehe:
//    https://www.thingiverse.com/thing:3280926/comments/#comment-2218732
// Vielen Dank an "Bikecyclist": https://www.thingiverse.com/Bikecyclist/about
// -----------------------------------------------------

// what to render
part=0;   // [0:assembled, 1:base for printing, 2:hooks for printing, 3:undermost hooks for printing]

/* [Base] */

// horizontal distance between hooks
hdh=100.0;  // [61:180]

// width of hook
wdth=10;    // [8:30]

// wall thickness
ws=3.0;   // [3:0.1:10]

/* [Hook] */

// vertical distance to next higher hook
vdh=50.0;   // [30:100]

// inner diameter of hook
idh=56.0;   // [35:100]


/* [Hidden] */
$fn=100;


// -----------------------------------------------------
//
// -----------------------------------------------------
module Base(y=20) {
  difference() {
    union() {
      translate([-10, 0, 0]) cylinder(d=y, h=ws+1);
      translate([hdh+10, 0, 0]) cylinder(d=y, h=ws+1);
      translate([-10, -y/2, 0]) cube([hdh+20, y, ws+1]);
    }
    translate([-10, 0, -0.1]) cylinder(d=4, h=ws+1.2);
    translate([-10, 0, ws-2]) cylinder(d1=4, d2=9, h=3.1);
    translate([hdh+10, 0, -0.1]) cylinder(d=4, h=ws+1.2);
    translate([hdh+10, 0, ws-2]) cylinder(d1=4, d2=9, h=3.1);

    translate([wdth, -7, -0.1]) linear_extrude(ws+0.2) offset(delta=0.3) Connector();
    translate([-0.3, -10.1, -0.1]) cube([wdth+0.6, 3.3, ws+0.2]);

    translate([hdh-wdth, -7, -0.1]) linear_extrude(ws+0.2) mirror([1, 0, 0]) offset(delta=0.3) Connector();
    translate([hdh-wdth-0.3, -10.1, -0.1]) cube([wdth+0.6, 3.3, ws+0.2]);
  }
  translate([-0.3, 7.5, ws/2]) rotate([0, 90, 0]) cylinder(d=2, h=hdh+0.6);
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Connector() {
  polygon([ [0,0], [0,14], [-wdth,14], [-wdth,3], [-3,7], [-3,0] ]);
}
//!Connector();


// -----------------------------------------------------
//
// -----------------------------------------------------
module Hook(hdh=hdh, vdh=vdh, idh=idh, wdth=wdth, ws=ws, umh=0) {
  difference() {
    union() {
      cube([ws, vdh, wdth]);
      translate([0, -idh/2-ws, 0]) cube([idh/2+ws, idh/2+ws, wdth]);
      difference() {  // eigener difference(), damit er Connector() nicht stoert
        translate([idh/2+ws, 0, 0]) cylinder(d=idh+2*ws, h=wdth);
        translate([-0.1, 0, -0.1]) cube([idh+2*ws+0.2, idh/2+ws+0.1, wdth+0.2]);
      }
    }
    translate([idh/2+ws, 0, -0.1]) cylinder(d=idh, h=wdth+0.2);
    if(umh==0) translate([ws, -idh/2-ws, wdth]) rotate([0, -90, 0]) linear_extrude(ws+0.2) offset(delta=0.3) Connector();
  }
  if(umh==0) translate([ws/2, -idh/2-ws+14.5, 0]) cylinder(d=2, h=wdth);
  difference() {
    translate([0, vdh, 0]) rotate([0, 90, 0]) linear_extrude(ws) Connector();
    translate([ws/2, vdh+14, -0.1]) cylinder(d=2, h=wdth+0.2);
  }
  translate([idh+ws*1.5, 0, 0]) cylinder(d=ws, h=wdth);
  if(umh==1) {
    difference() {
      union() {
        translate([0, -idh/2-ws-10, 0]) cube([ws+1, 10, wdth]);
        translate([0, -idh/2-ws-10, wdth/2]) rotate([0, 90, 0]) cylinder(d=wdth, h=ws+1);
      }
      translate([-0.1, -idh/2-ws-10, wdth/2]) rotate([0, 90, 0]) cylinder(d=4, h=ws+0.2);
      translate([ws+1-2, -idh/2-ws-10, wdth/2]) rotate([0, 90, 0]) cylinder(d1=4, d2=9, h=3.1);
    }
  }
}



if(part==0) {
  Base();
  translate([wdth, -5-7, 0]) rotate([0, -90, 0]) Hook(vdh=5);
  translate([hdh-wdth, -5-7, 0]) rotate([0, 90, 0]) mirror([1, 0, 0]) Hook(vdh=5);

  translate([hdh, -5-7-(vdh+idh/2+ws), 0]) rotate([0, -90, 0]) Hook();
  translate([0, -5-7-(vdh+idh/2+ws), 0]) rotate([0, 90, 0]) mirror([1, 0, 0]) Hook();

  translate([wdth, -5-7-2*(vdh+idh/2+ws), 0]) rotate([0, -90, 0]) Hook(umh=1);
  translate([hdh-wdth, -5-7-2*(vdh+idh/2+ws), 0]) rotate([0, 90, 0]) mirror([1, 0, 0]) Hook(umh=1);
} else if(part==1) {
  translate([0, 0, ws+1]) rotate([180, 0, 0]) Base();
  translate([idh, idh/2+ws+10+3, 0]) {
    Hook(vdh=5);
    translate([-3, 0, 0]) mirror([1, 0, 0]) Hook(vdh=5);
  }
} else if(part==2) {
  Hook();
  translate([-3, 0, 0]) mirror([1, 0, 0]) Hook();
} else if(part==3) {
  Hook(umh=1);
  translate([-3, 0, 0]) mirror([1, 0, 0]) Hook(umh=1);
}
