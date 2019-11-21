// -----------------------------------------------------
// GoPro-Lenkrad-Halterung
//
//  Detlev Ahlgrimm, 04/05.2018
// -----------------------------------------------------

/* [Global] */
part="assembled";   // [assembled:all together (view only),connector_top:upper part,connector_bot:lower part,connector_gopro:GoPro connector,extension:GoPro extension,screw_handle:handle for the screw]

/* [connector_top] */
/* [connector_bot] */
/* [extension] */
/* [screw_handle] */
/* [assembled] */

// diameter of the bicycle handlebar [mm]
ld=32;  // [10:100]

// length of extension [mm]
ext_len=50; // [20:100]



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
//  lg : Laenge Gewinde
//  lm : Laenge Mutter
// -----------------------------------------------------
module SchraubeM5(lg=20, lm=4) {
  union() {
    cylinder(r=5, h=lm, $fn=6);
    translate([0, 0, lm-0.1]) cylinder(r=2.8, h=lg+0.1);
  }
}
//!SchraubeM5();

// -----------------------------------------------------
//  Liefert einen Ring mit dem Aussendurchmesser gpc_d
//  und der Hoehe gpc_r.
// -----------------------------------------------------
module ConnectorRundung() {
  translate([0, 0, gpc_r/2]) rotate_extrude() translate([gpc_d/2-gpc_r/2, 0, 0]) circle(d=gpc_r);
}
//ConnectorRundung();


// -----------------------------------------------------
//  Liefert ein einzelnes Connector-Beinchen.
//  "h" meint die Hoehe zwischen Loch-Mittelpunkt und
//  Boden.
// -----------------------------------------------------
module ConnectorEinzeln(h=10) {
  difference() {
    hull() {
      ConnectorRundung();
      translate([0, 0, gpc_b-gpc_r]) ConnectorRundung();
      translate([0, -gpc_d/2+gpc_r/2, gpc_r/2])       rotate([0, 90, 0]) cylinder(d=gpc_r, h=h);
      translate([0, -gpc_d/2+gpc_r/2, gpc_b-gpc_r/2]) rotate([0, 90, 0]) cylinder(d=gpc_r, h=h);
      translate([0,  gpc_d/2-gpc_r/2, gpc_r/2])       rotate([0, 90, 0]) cylinder(d=gpc_r, h=h);
      translate([0,  gpc_d/2-gpc_r/2, gpc_b-gpc_r/2]) rotate([0, 90, 0]) cylinder(d=gpc_r, h=h);
    }
    //translate([0, 0, -0.1]) cylinder(d=5.3, h=gpc_b+0.2);
  }
}
//ConnectorEinzeln();

// -----------------------------------------------------
//  Liefert einen dreibeinigen Connector.
//  "h1" : Loch-Mittelpunkt bis Ende der Einzel-Beinchen
//  "h2" : Loch-Mittelpunkt bis Ende des Connectors
//  Das Stueck h2-h1 ist somit der massive Verbinder fuer
//  die Beinchen.
// -----------------------------------------------------
module ConnectorDreifach(h1=8, h2=10, retraction_free_print=0) {
  if(h1<8)  echo("WARNUNG in ConnectorDreifach(): h1 zu klein");
  difference() {
    union() {
      ConnectorEinzeln(h1);
      translate([0, 0,     gpc_b+gpc_a3]) ConnectorEinzeln(h1);
      translate([0, 0, 2*(gpc_b+gpc_a3)]) ConnectorEinzeln(h1);
      translate([0, 0, 3*gpc_b+2*gpc_a3]) cylinder(r1=7, r2=5, h=3);
    }
    translate([0, 0, 3*gpc_b+2*gpc_a3+4]) rotate([180, 0, 30]) SchraubeM5(lg=20, lm=4);
  }
  if(retraction_free_print>0) {
    st=retraction_free_print;
    translate([-gpc_d/2, -h1, gpc_b/2])                   cube([h2+gpc_d/2, h1*2, st]);
    translate([-gpc_d/2, -h1, gpc_b/2+gpc_b+gpc_a3])      cube([h2+gpc_d/2, h1*2, st]);
    translate([-gpc_d/2, -h1, gpc_b/2+2*(gpc_b+gpc_a3)])  cube([h2+gpc_d/2, h1*2, st]);
    translate([-gpc_d/2, h1, gpc_b/2])  cube([h2+gpc_d/2, st, 2*(gpc_b+gpc_a3)+st]);
    translate([-gpc_d/2, -h1, gpc_b/2]) cube([h2+gpc_d/2, st, 2*(gpc_b+gpc_a3)+st]);
  }
  if(h2>h1) {
    hull() {
      translate([h1-0.01, -gpc_d/2+gpc_r/2, gpc_r/2])                         rotate([0, 90, 0]) cylinder(d=gpc_r, h=h2-h1);
      translate([h1-0.01, -gpc_d/2+gpc_r/2, gpc_b-gpc_r/2+2*(gpc_b+gpc_a3)])  rotate([0, 90, 0]) cylinder(d=gpc_r, h=h2-h1);
      translate([h1-0.01,  gpc_d/2-gpc_r/2, gpc_r/2])                         rotate([0, 90, 0]) cylinder(d=gpc_r, h=h2-h1);
      translate([h1-0.01,  gpc_d/2-gpc_r/2, gpc_b-gpc_r/2+2*(gpc_b+gpc_a3)])  rotate([0, 90, 0]) cylinder(d=gpc_r, h=h2-h1);
    }
  }
}
module ConnectorZweifach(h1=8, h2=10) {
  if(h1<8)  echo("WARNUNG in ConnectorDreifach(): h1 zu klein");
  difference() {
    union() {
      ConnectorEinzeln(h1);
      translate([0, 0,     gpc_b+gpc_a2]) ConnectorEinzeln(h1);
    }
    translate([0, 0, 3*gpc_b+gpc_a2+4]) rotate([180, 0, 30]) SchraubeM5(lg=20, lm=4);
  }
  if(h2>h1) {
    hull() {
      translate([h1-0.01, -gpc_d/2+gpc_r/2, gpc_r/2])                         rotate([0, 90, 0]) cylinder(d=gpc_r, h=h2-h1);
      translate([h1-0.01, -gpc_d/2+gpc_r/2, gpc_b-gpc_r/2+(gpc_b+gpc_a2)])  rotate([0, 90, 0]) cylinder(d=gpc_r, h=h2-h1);
      translate([h1-0.01,  gpc_d/2-gpc_r/2, gpc_r/2])                         rotate([0, 90, 0]) cylinder(d=gpc_r, h=h2-h1);
      translate([h1-0.01,  gpc_d/2-gpc_r/2, gpc_b-gpc_r/2+(gpc_b+gpc_a2)])  rotate([0, 90, 0]) cylinder(d=gpc_r, h=h2-h1);
    }
  }
}
//!ConnectorZweifach();
//!ConnectorDreifach();

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
      translate([0, ld/2+ws+5, -0.1]) cylinder(d=4.5, h=bh+0.2);
      translate([-ld/2-ws-4, ws+3.1, bh/2]) rotate([90, 30, 0]) SchraubeM4();
      translate([ ld/2+ws+4, ws+3.1, bh/2]) rotate([90, 30, 0]) SchraubeM4();
    } else {
      translate([-ld/2-ws-4, -0.1, bh/2]) rotate([-90, 0, 0]) cylinder(d=4.5, h=2*ws);
      translate([ ld/2+ws+4, -0.1, bh/2]) rotate([-90, 0, 0]) cylinder(d=4.5, h=2*ws);
    }
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module GoProAufsatz() {
  translate([(3*gpc_b+2*gpc_a3)/2, 12, gpc_d/2]) rotate([90, 0, -90]) ConnectorDreifach(h1=8, h2=12);
  difference() {
    translate([-(bh+6+0.4)/2, -10, 0]) cube([bh+6+0.4, 13, bh]);
    translate([-(bh+0.2)/2, -10.1, -0.1]) cube([bh+0.4, 10.1, bh+0.2]);
    translate([-(bh+6+0.6)/2, -5, bh/2]) rotate([0, 90, 0]) cylinder(d=4.5, h=bh+7);
  }
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module Arm(x, y, z, d=2) {
  cube([d+0.01, y, z]);
  translate([0, 0, z]) scale([1, y/4, z/4]) rotate([0, 90, 0]) linear_extrude(x-d)
    polygon([[0,0], [1,0], [2,1], [3,0], [4,0], [4,1], [3,2], [4,3], [4,4],
             [3,4], [2,3], [1,4], [0,4], [0,3], [1,2], [0,1]]);
  translate([x-d-0.01, 0, 0]) cube([d+0.01, y, z]);
}
//!Arm(34, 15.6, 15);

// -----------------------------------------------------
//
// -----------------------------------------------------
module GoProArm(l=50) {
  h1=8;
  h2=10;
  translate([0, gpc_b, 0]) rotate([-90, 0, 0]) ConnectorZweifach(h1, h2);
  translate([l, 0, 0]) rotate([90, 0, 180]) ConnectorDreifach(h1, h2);
  difference() {
    //translate([h1, 0, -gpc_d/2]) cube([l-2*h1, 3*gpc_b+2*gpc_a3, gpc_d]);
    translate([h1, 0, -gpc_d/2]) Arm(l-2*h1, 3*gpc_b+2*gpc_a3, gpc_d);
    //translate([h2, (3*gpc_b+2*gpc_a3)/2, gpc_d/2]) rotate([0, 90, 0]) cylinder(r=5, h=l-2*h2);
  }
  
}
//GoProArm(50);


// -----------------------------------------------------
//  fuer Schraube M5x50 (DIN 933)
// -----------------------------------------------------
module SchraubenGriff() {
  difference() {
    union() {
      cylinder(r1=7, r2=5, h=54-19);   // Schraube soll 19mm rausstehen
      for(a=[0:120:360]) {
        rotate([0, 0, a]) translate([5, 0, 3]) sphere(r=4);
        rotate([0, 0, a]) translate([5, 0, 3]) cylinder(r1=4, r2=0.1, h=20);
      }
    }
    translate([0, 0, -0.1]) SchraubeM5(lg=35, lm=15.1);
    translate([-10, -10, -10]) cube([20, 20, 10]);
  }
}
//!SchraubenGriff();



// -----------------------------------------------------
//
// -----------------------------------------------------
if(part=="assembled") {
  LenkerVerbinder(gpc=true);
  translate([0, -2, bh]) rotate([180, 0, 0]) LenkerVerbinder(gpc=false);
  translate([-10, ld/2+ws+10, bh/2]) rotate([0, 90, 0]) GoProAufsatz();
  translate([-10+gpc_d/2, ld/2+10+ws+2+10, gpc_b]) rotate([90, 0, 40]) GoProArm(ext_len);
  translate([ld, ld/2+10+ws+2+10, gpc_b]) SchraubenGriff();
} else if(part=="connector_top") {
  LenkerVerbinder(gpc=true);
} else if(part=="connector_bot") {
  LenkerVerbinder(gpc=false);
} else if(part=="connector_gopro") {
  GoProAufsatz();
} else if(part=="extension") {
  GoProArm(ext_len);
} else if(part=="screw_handle") {
  SchraubenGriff();
}

// -----------------------------------------------------
// Druck-Ansicht
// -----------------------------------------------------
//LenkerVerbinder(gpc=true);
//translate([0, -5, 0]) rotate([0, 0, 180]) LenkerVerbinder(gpc=false);
//translate([ld/2+ws+bh, 30, 0]) GoProAufsatz();
//translate([ld/2+ws+bh, 0, gpc_d/2]) GoProArm(50);
