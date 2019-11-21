// -----------------------------------------------------
// GoPro-Lenkrad-Halterung
//
//  Detlev Ahlgrimm, 04/05.2018
// -----------------------------------------------------

/* [Global] */
part="assembled";   // [assembled:all together (view only),connector_top:upper part,connector_bot:lower part]

/* [connector_top] */
/* [connector_bot] */
/* [assembled] */

// diameter of the bicycle handlebar [mm]
ld=32;  // [10:100]

/* [Hidden] */
$fn=100;

//ld=32;  // Durchmesser des Lenkers
bh=20;  // Breite des Lenker-Verbinders
ws=5;   // Wandstaerke des Lenker-Verbinders


gpc_d=15;   // Durchmesser des GoPro-Connectors
gpc_r=1;    // Rundung am GoPro-Connector
gpc_b=2.8;    // Breite des GoPro-Connectors
gpc_a2=3.4; // Abstand zwischen den Connector-Beinchen beim 2fach-Connector
gpc_a3=3.6; // Abstand zwischen den Connector-Beinchen beim 3fach-Connector


// -----------------------------------------------------
//  lg : Laenge Gewinde
//  lm : Laenge Mutter
// -----------------------------------------------------
module SchraubeM4(lg=20, lm=3.1) {
  union() {
    cylinder(r=4.2, h=lm, $fn=6);
    translate([0, 0, lm-0.1]) cylinder(d=4.5, h=lg+0.1);
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module LenkerVerbinder(gpc=true) {
  difference() {
    union() {
      cylinder(d=ld+2*ws, h=bh);
      if(gpc) {
        translate([-bh/2, ld/2, 0]) cube([bh, ws+10, bh]);
        translate([-ld/2-ws, 0, bh/2]) rotate([-90, 0, 0]) cylinder(d=bh, h=ws+3);
        translate([ ld/2+ws, 0, bh/2]) rotate([-90, 0, 0]) cylinder(d=bh, h=ws+3);
      } else {
        translate([-ld/2-ws, 0, bh/2]) rotate([-90, 0, 0]) cylinder(d=bh, h=ws);
        translate([ ld/2+ws, 0, bh/2]) rotate([-90, 0, 0]) cylinder(d=bh, h=ws);
      }
    }
    translate([0, 0, -0.1]) cylinder(d=ld, h=bh+0.2);
    translate([-ld/2-ws, -ld, -0.1]) cube([ld+2*ws, ld, bh+0.2]);

    translate([-ld/2-ws-4, -0.1, bh/2]) rotate([-90, 0, 0]) cylinder(d=4.5, h=3*ws);
    translate([ ld/2+ws+4, -0.1, bh/2]) rotate([-90, 0, 0]) cylinder(d=4.5, h=3*ws);
    if(gpc) {
      //translate([0, ld/2+ws+5, -0.1]) cylinder(d=4.5, h=bh+0.2);
      translate([-ld/2-ws-4, ws+3.1, bh/2]) rotate([90, 30, 0]) SchraubeM4();
      translate([ ld/2+ws+4, ws+3.1, bh/2]) rotate([90, 30, 0]) SchraubeM4();
    } else {
      //translate([-ld/2-ws-4, -0.1, bh/2]) rotate([-90, 0, 0]) cylinder(d=4.5, h=2*ws);
      //translate([ ld/2+ws+4, -0.1, bh/2]) rotate([-90, 0, 0]) cylinder(d=4.5, h=2*ws);
    }
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
if(part=="assembled") {
  LenkerVerbinder(gpc=true);
  translate([0, -2, bh]) rotate([180, 0, 0]) LenkerVerbinder(gpc=false);
} else if(part=="connector_top") {
  LenkerVerbinder(gpc=true);
} else if(part=="connector_bot") {
  LenkerVerbinder(gpc=false);
}