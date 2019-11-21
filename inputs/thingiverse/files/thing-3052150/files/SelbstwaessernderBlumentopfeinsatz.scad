// -----------------------------------------------------
// Selbstwaessernder Blumentopfeinsatz
//
//  Detlev Ahlgrimm, 08.2018
// -----------------------------------------------------

// inner diameter of holding container
di=66;    // [40:150]

// thickness of upper collar (+wallthickness)
ct=10;     // [1:20]

// height total
ht=90;    // [30:160]

// height of outer brim
hb=20;     // [0:30]

// wallthickness
wt=0.9;     // [0.5:0.1:3]

// angle at middle area
am=45;      // [45:60]

// include filler tube
it=1;     // [0:false, 1:true]

// diameter of filler tube
td=15;    // [5:20]

// include adhesion helper
ah=0;     // [0:false, 1:true]

// include strenghtener
is=0;     // [0:false, 1:true]

// view profile only
vp=0;     // [0:false, 1:true]

/*hidden*/
$fn=100;
ho=(di/2-10)*tan(am);     // Hoehe des am-Grad-Bereiches
hu=ht-ho-10;              // Hoehe des eigentlichen Blumentopfes

echo(hu, "+", ho, "+ 10 =", hu+ho+10);

// -----------------------------------------------------
//  d : Durchmesser (aussen)
//  h : Hoehe oder auch Ring-Staerke
// -----------------------------------------------------
module Ring(d, h) {
  translate([0, 0, h/2]) rotate_extrude() translate([d/2-h/2, 0, 0]) circle(d=h);
}

// -----------------------------------------------------
//   r : Radius (innen)
//   w : Wandstaerke
//   h : Hoehe
// -----------------------------------------------------
module Rohr(r, w, h) {
  difference() { cylinder(r=r+w, h=h); translate([0, 0, -0.1]) cylinder(r=r, h=h+0.2); }
}

// -----------------------------------------------------
// ein dreieckiger Ring        (-d/2,0) ---/  (-d/2+s,0)      (d/2-s,0) \--- (d/2,0)
//  d : Durchmesser (aussen)            | /                              \ |
//  s : Seitenlaenge                    |/  (-d/2,-s)           (d/2,-s)  \|
// -----------------------------------------------------
module Ansatz(d, s=1) {
  translate([0, 0, -s]) rotate_extrude() translate([d/2, 0, 0]) polygon([[0, 0], [0, s], [-s, s]]);
}
//!Ansatz(di);


// -----------------------------------------------------
// das massive Teil
// -----------------------------------------------------
module body() {
  union() {
    Ring(di+4-2*wt, 2);                                               // innere Rundung
    Ring(di+2*ct+2*wt, 2);                                            // aeussere Rundung
    Rohr((di+4-2*wt)/2-1, ((di+2*ct+2*wt)-(di+4-2*wt))/2, 2);         // den Raum zwischen den zwei Rundungen schliessen
    translate([0, 0, 1]) Rohr(di/2+ct, wt, hb);                       // die Krempe
    translate([0, 0, 1]) cylinder(d=di, h=hu-1);                      // der eigentliche Blumentopf
    translate([0, 0, hu]) cylinder(d1=di, d2=20, h=ho);               // der am-Grad-Teil
    translate([0, 0, hu+ho]) cylinder(d=20, h=9);                     // der im Wasser haengende Teil
    translate([0, 0, hu+ho+8]) Ring(20, 2);                           // obere Rundung
    translate([0, 0, hu+ho+8]) cylinder(d=18, h=2);                   // obere Rundung schliessen
  }
}
//!body();

// -----------------------------------------------------
// das hohle Teil mit Schlitzen
// -----------------------------------------------------
module theThing() {
  d=wt/sin(am);
  difference() {
    body();
    translate([0, 0, -1]) cylinder(d=di-2*wt, h=hu+1.01);                   // den Blumentopf ausschneiden
    translate([0, 0, hu]) cylinder(d1=di-2*d, d2=20-2*d, h=ho+0.01);        // den am-Grad-Teil ausschneiden
    translate([0, 0, hu+ho-2]) cylinder(d=20-2*wt, h=10);                   // den im Wasser haengenden Teil ausschneiden

    for(a=[0:60:359]) {                                                     // die Schlitze schneiden...
      rotate([0, 0, a])
      translate([9, 0, hu+ho-5]) rotate([0, am, 0]) hull() {                // ...im am-Grad-Teil
        translate([0, 0, 0]) cylinder(d=2, h=10);
        translate([6, 0, 0]) cylinder(d=2, h=10);
      }
    }
    for(a=[0:60:359]) {
      rotate([0, 0, a+30])
      translate([0, 0, hu+ho+2]) rotate([0, 90, 0]) hull() {                // ...und in den im Wasser haengenden Teil
          translate([0, 0, 0]) cylinder(d=2, h=11);
          translate([-5, 0, 0]) cylinder(d=2, h=11);
      }
    }
  }
  translate([0, 0, hu+0.01]) Ansatz(di-2*wt, d-wt);    // Ausgleich der unterschiedlichen Wandstaerken auf der Waagerechten
  if(is) {
    l=sqrt((di/2-10)*(di/2-10)+ho*ho);            // Laenge des am-Grad-Bereiches
    for(a=[0:60:359]) {                           // Verstaerkung dranbappen
      rotate([0, 0, 30+a]) translate([-di/2+wt/2, 0, hu]) rotate([0, 90-am, 0]) union() {
        cylinder(r1=0, r2=wt, h=2);
        translate([0, 0, 2]) cylinder(r=wt, h=l-4);
        translate([0, 0, l-2]) cylinder(r1=wt, r2=0, h=2);
      }
    }
  }
}

// -----------------------------------------------------
// das Teil ... ggf. samt Einfuellstutzen und Brim
// -----------------------------------------------------
module allTogether() {
  difference() {
    theThing();
    if(it) {
      translate([0, 0, 0.1]) intersection() {       // die Oeffnung fuer den Einfuellstutzen ausschneiden
        cylinder(d=di, h=200);
        translate([di/2, 0, hu-0.01]) cylinder(d=td, h=hu+20);
      }
    }
  }
  if(it) {
    intersection() {                                // den Einfuellstutzen zufuegen
      union() {
        body();
        cylinder(d=di, h=2);
      }
      translate([di/2, 0, 0]) Rohr(td/2, wt, hu+ho);
    }
  }
  if(ah==1) {
    cylinder(d=min(di-td-2*wt-1, 20), h=0.3);       // Brim zufuegen
    for(a=[45:90:359]) {
      rotate([0, 0, a]) translate([0, -1, 0]) cube([di/2+1, 2, 0.3]);
    }
  }
}

if(hu>0) {        // die Hoehe des eigentlichen Topfes muss positiv sein
  if(vp==1) {
    difference() {
      allTogether();
      translate([-100, -100, -1]) cube([200, 100, 200]);   // DEBUG: das gesamte Teil halbieren
    }
  } else {
    rotate([0, 0, -120]) allTogether();   // bei 120 Grad Drehung erzeugt Cura kuerzere Retraction-Wege
  }
} else {
  text("illegal ration between 'di' and 'ht'!");
}
