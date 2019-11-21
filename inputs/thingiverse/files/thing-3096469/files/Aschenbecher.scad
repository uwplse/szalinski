// -----------------------------------------------------
// Aschenbecher - als Aufsatz auf eine Thunfischdose
//
//  Detlev Ahlgrimm, 09.2018
// -----------------------------------------------------

// outer diameter of can
od=88;      // [50:150]

// inner diameter of can
di=75;      // [50:150]

// outer height of can
h=41;       // [1:100]

// wall thickness
wt=0.9;     // [0.5:0.1:5]

// diameter of cigarette-holder
cd=10;      // [5:20]

// number of cigarette-holders
nh=5;       // [1:12]

// length of cigarette-holder
lh=0;       // [0:20]

// make pretty
pretty=1;   // [0:false, 1:true]



/* [Hidden] */
$fn=100;
br=(od/2+wt-2)-(di/2-wt+2);   // Breite vom oberen Rand zwischen den Rundungen
khh=cd/2+cd/4+wt;             // Hoehe des Kippenhalters

//echo("br=", br, "   khh=", khh);

// -----------------------------------------------------
//  r : Radius (mitte)
//  s : Staerke bzw. Breite
// -----------------------------------------------------
module Ring(r, s) {
  rotate_extrude() translate([r, 0, 0]) circle(d=s);
}


// -----------------------------------------------------
//   r : Radius (innen)
//   w : Wandstaerke
//   h : Hoehe
// -----------------------------------------------------
module Rohr(r, w, h) {
  difference() {
    cylinder(r=r+w, h=h);
    translate([0, 0, -0.1]) cylinder(r=r, h=h+0.2);
  }
}


// -----------------------------------------------------
//  statt eines einfachen cylinder() wird es hier
//  unten etwas enger
// -----------------------------------------------------
module Kippe(l=od/2+wt, inner=true) {
  w=inner ? 0 : wt;
  rotate([0, 90, 0]) hull() {
    translate([cd/2, 0, 0]) cylinder(d=cd/2+2*w, h=l);
    translate([0, 0, 0]) cylinder(d=cd+2*w, h=l);
    // khh = cd/2 + (cd/2+2*w)/2 -> = cd/2+cd/4+w
  }
}
//!difference() {  Kippe(od/2+wt, false);  translate([-0.1, 0, 0]) Kippe(od/2+wt+0.2); }


// -----------------------------------------------------
//  ein einzelner Kippenhalter in der eingestellten
//  Laenge
// -----------------------------------------------------
module KippenHalter() {
  difference() {
    intersection() {
      translate([0, 0, h+khh]) Kippe(inner=false);    // der Kippenhalter
      cylinder(d=od+2*wt, h=h+khh);                   // aussen beschneiden
    }
    //translate([0, 0, h+khh]) Kippe(inner=true);       // Platz fuer die Kippe schaffen (brauchts hier aber gar nicht)
    translate([0, 0, h-0.1]) cylinder(r=min(di/2-wt, (od/2+wt)-lh), h=cd+wt);  // innen auf Laenge bringen
  }
}
//!KippenHalter();


// -----------------------------------------------------
//  der Ascher-Aufsatz in Rohform (ohne Rundungen)
// -----------------------------------------------------
module Ascher() {
  difference() {
    union() {
      Rohr(od/2, wt, h+khh);                                    // aessere Ummantelung der Dose
      translate([0, 0, h]) Rohr(di/2-wt, wt, khh);              // innere Ummantelung der Dose
      translate([0, 0, h+khh-wt]) Rohr(di/2-wt, (od/2+wt)-(di/2-wt), wt);    // oberer Abschluss
      for(a=[0:360/nh:359]) {                                   // Zigaretten-Halter erzeugen
        rotate([0, 0, a]) KippenHalter();
      }
    }
    for(a=[0:360/nh:359]) {                                     // Zigaretten-Halter ausschneiden
      rotate([0, 0, a]) translate([0, 0, h+khh]) Kippe(inner=true);
    }
    translate([0, 0, h+khh]) cylinder(d=od+2*wt+1, h=cd);       // oben plan machen
  }
}


// -----------------------------------------------------
//  der massive Ascher mit Rundungen - so dass die
//  Schnittmenge mit Ascher() den finalen Ascher ergibt
// -----------------------------------------------------
module Abrunder() {
  difference() {
    union() {
      cylinder(d=od+2*wt, h=h+khh-2);                       // die Basis
      translate([0, 0, h+khh-2]) Ring(od/2+wt-2, 4);        // oben/aussen rund machen
      translate([0, 0, h+khh-2]) Ring(di/2-wt+2, 4);        // oben/innen rund machen
      translate([0, 0, h+khh-2]) Rohr(di/2-wt+2, (od/2+wt-2)-(di/2-wt+2), 2);   // Zwischenraum fuellen
      if(lh>br) {                          // 
        for(a=[0:360/nh:359]) {                                 // Zigaretten-Halter erzeugen
          rotate([0, 0, a]) translate([0, 0, h+khh]) Kippe(l=di/2+2, inner=false);
        }
      }
    }
    translate([0, 0, h+khh]) cylinder(d=od+2*wt+1, h=cd);   // oben plan machen (hier eigentlich unnoetig)
  }
}
//!Abrunder();


if(br<=0) {
  text("illegal ratio between od, di and wt!");
} else if(pretty==1) {
  translate([0, 0, h+wt+cd/2]) rotate([180, 0, 0])
    intersection() {
    Ascher();
    Abrunder();
  }
} else {
  translate([0, 0, h+wt+cd/2]) rotate([180, 0, 0])
    Ascher();
}
