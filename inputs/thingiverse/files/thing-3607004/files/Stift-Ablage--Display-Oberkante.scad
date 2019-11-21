// -----------------------------------------------------
// Stift-Ablage @ Display-Oberkante
//
//  Detlev Ahlgrimm, 04.05.2019
// -----------------------------------------------------

// depth arm
tiefe_arm=35;

// height arm
hoehe_arm=15;

// depth holder
tiefe_halter=40;

// width total
breite_gesamt=100;

// height total
hoehe_gesamt=60;

// z-pos arm
zpos_arm=40;

// angle
winkel=15;

// wallthickness
ws=1.1;

// include separators
unterteilung=1;     // [0:False, 1:True]

// include brim
brim=1;             // [0:False, 1:True]

/* [Hidden] */
$fn=100;
xp=breite_gesamt/2-tiefe_halter;

module Halter2D() {
  polygon([ [-breite_gesamt/2,0], [-breite_gesamt/2,tiefe_halter/3], [-xp,tiefe_halter], [xp,tiefe_halter], [breite_gesamt/2,tiefe_halter/3], [breite_gesamt/2,0] ]);
}

module Brim(a=0) {
  rotate([0, 0, a]) {
    translate([15, 0, 0]) cylinder(d=20, h=0.25);
    translate([0, -3, 0]) cube([10, 6, 0.25]);
  }
}

module Halter() {
  rotate([winkel, 0, 0]) translate([0, 0, -zpos_arm]) {
    difference() {
      linear_extrude(hoehe_gesamt) Halter2D();
      translate([0, 0, ws]) linear_extrude(hoehe_gesamt) offset(-ws) Halter2D();
    }
    if(unterteilung) intersection() {
      linear_extrude(hoehe_gesamt) Halter2D();
      rotate([0, 0, 45]) cube([ws*0.75, 2*tiefe_halter, hoehe_gesamt]);
    }
    if(unterteilung) intersection() {
      linear_extrude(hoehe_gesamt) Halter2D();
      rotate([0, 0, -45]) cube([ws*0.75, 2*tiefe_halter, hoehe_gesamt]);
    }
  }
  translate([-breite_gesamt/2, -tiefe_arm-ws, 0]) cube([breite_gesamt, tiefe_arm+ws, ws]);
  translate([-breite_gesamt/2, -tiefe_arm-ws, -hoehe_arm]) cube([breite_gesamt, ws, hoehe_arm+ws]);
}
translate([0, 0, breite_gesamt/2]) rotate([0, 90, 0]) 
Halter();

if(brim) {
  rotate([0, 0, -winkel]) translate([-zpos_arm+10, 0.5, 0]) Brim(-90);
  rotate([0, 0, -winkel]) translate([hoehe_gesamt-zpos_arm, xp/2, 0]) Brim(0);
  translate([0, -tiefe_arm+5, 0]) Brim(0);
  translate([-hoehe_arm/2, -tiefe_arm-ws, 0]) Brim(-90);
}
