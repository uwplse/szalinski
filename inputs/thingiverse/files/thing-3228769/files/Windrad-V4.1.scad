// -----------------------------------------------------
// Windrad V4.1
//
//  Detlev Ahlgrimm, 07.2018
//
// 29.07.2018   V2a   in Achse() den Kugelgelenk-Verbinder leicht vergroessert,
//                    mit einem Ansatz versehen und oben abgerundet
// 06.09.2018   V3    zusaetzliche Ebene 
// 08.09.2018   V3a   Halter_Kugellager_608_2Z() zugefuegt -> eiert immer noch :-(
// 09.09.2018   V4    druckbarer Ersatz fuer das [teure] Kugellager und
//                    Korrektur der Parameter fuer OpenSCAD_v2018 bzw. den Customizer
// 14.09.2018         abgerundete Schaufeln
// 20.11.2018   V4.1  Verstaerkung von Achse() bzw. des Mastes (der alte Mast ist
//                    heute Nacht gebrochen - trotz PLA+)
// -----------------------------------------------------

/* [Global] */
/* [common parameters] */
// What should be rendered
part="assembled_2";   // [wind_catcher_1:Wind Catcher 1, carrier_1:Carrier 1, mast1:Mast1, mast2:Mast2, assembled_1:Assembled - one level, wind_catcher_2:Wind Catcher 2, carrier_2:Carrier 2, assembled_2:Assembled - two level]

// Rounding of Wind Catcher
wcr=0;      // [0:19]

/* [wind_catcher_1] */
/* [carrier_1] */
/* [mast] */
/* [assembled_1] */
/* [parameters for main layer] */

// Length of Arms (from center)
r   =50;    // [30:1:100]

// Number of Wind Catchers
dw  =120;   // [120:3 Arms, 90:4 Arms, 72:5 Arms, 60:6 Arms]

// Radius of Wind Catcher
hsl =30;    // [20:1:100]

// Length of Mast (without the hub for the ball bearing)
al  =100;   // [40:1:180]

/* [wind_catcher_2] */
/* [carrier_2] */
/* [assembled_2] */
/* [parameters for additional layer] */

// Length of Arms (from center)
r2  =70;    // [30:1:100]

// Number of Wind Catchers
dw2 =72;    // [120:3 Arms, 90:4 Arms, 72:5 Arms, 60:6 Arms]

// Radius of Wind Catcher
hsl2=40;    // [20:1:100]

// Length of Mast (without the hub for the ball bearing)
al2 =80;    // [30:1:180]



/* [Hidden] */
$fn=100;
SQRT2=sqrt(2);

// -----------------------------------------------------
//  Kugellager-Ersatz (maennlich)
// -----------------------------------------------------
module KugellagerErsatzM(lng=10) {
  cylinder(r=6, h=lng+23);
  translate([0, 0, lng+23]) cylinder(r1=4, r2=0.5, h=8);
  for(y=[2, 21]) {
    translate([0, 0, lng+y]) rotate_extrude() translate([6, 0, 0]) polygon([[2,0.5], [2,-0.5], [-0.1,-3], [-0.1,1]]);
  }
}


// -----------------------------------------------------
//  Kugellager-Ersatz (weiblich)
// -----------------------------------------------------
module KugellagerErsatzW() {
  difference() {
    union() {
      cylinder(r=10.2, h=23);
      translate([0, 0, 23]) cylinder(r1=10.2, r2=3, h=9);
    }
    translate([0, 0, -0.1]) cylinder(r=8.2, h=23.1);
    translate([0, 0, 23-0.01]) cylinder(r1=8.2, r2=2, h=8);

    for(y=[2, 21]) {
      translate([0, 0, y]) rotate_extrude() translate([8.4-1, 0, 0]) polygon([[0,-2.5], [0,2.5], [1,0.75], [1,-0.75]]);
    }
  }
}


// -----------------------------------------------------
//  r   : halbe Seitenlaenge der Pyramide
// -----------------------------------------------------
module Pyramide(r=15) {
  if(wcr>0) {
    Pyramide2(r);
  } else {
    polyhedron(points=[[r,r,0], [r,-r,0], [-r,-r,0], [-r,r,0], [0,0,r*1.1]],
              faces=[[0,1,4], [1,2,4], [2,3,4], [3,0,4], [1,0,3], [2,1,3]]);
  }
}

module Pyramide2(r=15) {
  r2=wcr;
  hull() {
    translate([r-r2, r-r2, 0]) cylinder(r=r2, h=0.01);
    translate([r-r2, -r+r2, 0]) cylinder(r=r2, h=0.01);
    translate([-r+r2, -r+r2, 0]) cylinder(r=r2, h=0.01);
    translate([-r+r2, r-r2, 0]) cylinder(r=r2, h=0.01);
    translate([0, 0, r*1.1]) cylinder(r=1, h=0.01);
  }
}
//!difference() {  Pyramide2(30);  translate([0, 0, -0.01]) Pyramide2(29);  }

// -----------------------------------------------------
//  r   : halbe Seitenlaenge der Pyramide
//  brim: Brim zufuegen (bei true)
// -----------------------------------------------------
module Schaufel(r, brim=true) {
  wt=0.9;
  difference() {
    union() {
      difference() {
        union() {         // die Pyramide mit Haltesteg und Befestigungsloch
          Pyramide(r);
          translate([0, 0, 12/SQRT2-0.2]) rotate([45, 0, 45]) translate([0, -6, -6]) cube([2*r/SQRT2+10, 12, 12]);
          translate([r+3, r+3, 12/SQRT2]) cylinder(r=3, h=12/SQRT2);
        }
        translate([0, 0, -0.1]) Pyramide(r-wt);    // Pyramide leer machen
        translate([0, 0, 12/SQRT2-0.2]) rotate([45, 0, 45]) translate([0, -4, -4]) cube([2*r/SQRT2+11, 8, 8]);  // Haltesteg leermachen
        translate([r+3, r+3, 12/SQRT2-0.2]) cylinder(r=2, h=12/SQRT2+1);  // Befestigungsloch leermachen
      }
      intersection() {
        union() {       // innere Verstrebungen
          translate([-r, -r, 0]) rotate([0, 0, 45]) translate([0, -0.8, 0]) cube([3*r, 1.6, 2]);
          translate([r, -r, 0]) rotate([0, 0, 180-45]) translate([0, -0.8, 0]) cube([3*r, 1.6, 2]);
          Rohr(r/(SQRT2/2)-5, 5, 2);
        }
        Pyramide(r);    // Verstrebungen auf Pyramide zurechtschneiden
      }
      difference() {    // Haltesteg zumachen
        Pyramide(r);
        translate([0, 0, -0.1]) Pyramide(r-wt);
      }
      // der Arm ist lang: 2*r/SQRT2+10
      // der 1mm starke Anschlag sitzt bei: 2*r/SQRT2-3
      // also ist die Laenge des Haltebereiches: 10+3-1=12
      translate([0, 0, 12/SQRT2-0.2]) rotate([45, 0, 45]) translate([2*r/SQRT2-3, -6, -6]) cube([1, 12, 12]); // definierten Endanschlag zufuegen
      if(brim) {        // auf Wunsch Brim dranbacken
        rotate([0, 0, 45]) translate([2*r/SQRT2+8, -8, 0]) union() {
          cube([2, 16, 0.35]);
          cylinder(r=4, h=0.35);
          translate([0, 16, 0]) cylinder(r=4, h=0.35);
        }
      }
    }
    translate([-2*r, -2*r, -3]) cube([4*r, 4*r, 3]);    // Boden plan machen
    //translate([-2*r, -2*r, 13]) cube([4*r, 4*r, r]);    // nur temporaer zwecks Kontrolle fuer zusammengebaut() !
  }
}


// -----------------------------------------------------
//  r   : Laenge der Arme (ab Zentrum)
//  dw  : Drehwinkel (90 -> 4 Arme, 120 -> 3 Arme)
//  brim: Brim zufuegen (bei true)
// -----------------------------------------------------
module Schaufelhalter(r=50, dw=120, brim=true) {
  as=7.2;
  difference() {
    union() {
      KugellagerErsatzW();
      difference() {
        for(a=[0:dw:359]) {   // vier Arme fuer die Schaufeln
          difference() {
            translate([0, 0, -0.2]) rotate([45, 0, a]) translate([r/2, as/2, as/2]) difference() {
              cube([r, as, as], center=true);
              for(a2=[0:90:359]) {    // Ecken an der Front anschraegen
                rotate([a2, 0, 0]) translate([r/2+0.1, -as/2-0.1, as/4]) rotate([0, -45, 0]) cube([as, as+0.2, as]);
              }
            }
            rotate([0, 0, a]) translate([r-6.3, -0.75, as/SQRT2-0.2]) rotate([90, 0, 0]) cylinder(r=2, h=10); // Loecher bohren
            rotate([0, 0, a]) translate([r-6.3, 0.75, as/SQRT2-0.2]) rotate([-90, 0, 0]) cylinder(r=2, h=10);
            rotate([0, 0, a]) translate([r-12, -as/SQRT2-1, 0]) cube([12, 1.3, as]);    // Ecken des Arms anschraegen
            rotate([0, 0, a]) translate([r-12, as/SQRT2-0.3, 0]) cube([12, 1.2, as]);
            rotate([0, 0, a]) translate([r-12, -1, 2*as/SQRT2-0.2-0.3]) cube([12, 2, 1.2]);
          }
        }
        cylinder(r=10.2, h=17);
      }

      if(brim) {        // auf Wunsch Brim dranbacken
        for(a=[0:dw:359]) {
          rotate([0, 0, a]) union() {
            translate([r-4, -5, 0]) cube([2, 10, 0.35]);
            translate([r-3, -5, 0]) cylinder(r=4, h=0.35);
            translate([r-3, 5, 0]) cylinder(r=4, h=0.35);
          }
        }
      }
    }
    translate([-r, -r, -3]) cube([2*r, 2*r, 3]);    // Boden plan machen
  }
}
//!difference() { cylinder(r=14, h=12); translate([0, 0, -1]) cylinder(r=11.3, h=14); }

// -----------------------------------------------------
//
// -----------------------------------------------------
module Schaufelhalter2(r=50, dw=120, h=80, brim=true) {
  difference() {
    union() {
      Schaufelhalter(r, dw, brim);
      translate([0, 0, 26]) cylinder(r=6, h=h-20);  // die Achse
      translate([0, 0, h]) KugellagerErsatzM(0);
    }
    translate([0, 0, 23-0.01]) cylinder(r1=8.2, r2=2, h=8);

    translate([0, 0, 33]) cylinder(r=2, h=h-33);   // etwas Versteifung zufuegen
    translate([0, 0, h-0.1]) cylinder(r1=2, r2=0.5, h=5);
  }
}
/*!difference() {
  Schaufelhalter2();
  translate([-100, -100, -100]) cube([200, 100, 220]);
}*/


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
//  h   : Laenge der Achse (ohne den Aufsatz fuer das Kugellager)
// -----------------------------------------------------
module Achse(h=80, brim=false) {
  if(brim) {
    translate([0, 0, 6]) rotate([0, -90, 0]) Achse1(h);
    translate([0, -40, 0]) Achse2();
  } else {
    Achse1(h);
    translate([0, 0, h-20]) Achse2();
  }  
}
module Achse1(h=80) {
  rotate([0, 0, 30]) cylinder(r=6*1/0.866025, h=h-10, $fn=6);  // die Achse
  translate([0, 0, h-10]) rotate([0, 0, 30]) cylinder(r1=6*1/0.866025, r2=1, h=6, $fn=6);
  difference() {
    hull() {
      translate([-6, -20, 0]) cube([6, 40, 20]);  // Befestigungsplatte
      translate([0, 0, 30]) rotate([0, 0, 30]) cylinder(r=6*1/0.866025, h=1, $fn=6); //cylinder(r=6, h=1);
    }
    for(y=[-13, 13]) {
      translate([-7, y, 10]) rotate([0, 90, 0]) cylinder(d=4, h=8);           // Loch in Befestigungsplatte
      translate([-3, y, 10]) rotate([0, 90, 0]) cylinder(d1=4, d2=11, h=6.3);   // Vergroesserung fuer Schraubenkopf
    }
  }
}
module Achse2() {
  difference() {
    union() {
      cylinder(r=9, h=15);
      translate([0, 0, 15]) cylinder(r1=9, r2=6, h=5);
      translate([0, 0, 19]) KugellagerErsatzM(0);
    }
    translate([0, 0, -0.1]) rotate([0, 0, 30]) cylinder(r=6*1/0.866025+0.2, h=10.1, $fn=6);
    translate([0, 0, 9.99]) rotate([0, 0, 30]) cylinder(r1=6*1/0.866025+0.2, r2=1, h=6.1, $fn=6);
    //cylinder(r=3, h=35.01);
    //translate([0, 0, 35]) cylinder(r1=3, r2=1, h=5);
  }
}
//!Achse2();
module Achse_alt(h=80, brim=false) {
  difference() {
    union() {
      cylinder(r=6, h=h);                             // die Achse
      translate([0, 0, h-1]) KugellagerErsatzM(0);
      difference() {
        hull() {
          translate([-6, -20, 0]) cube([6, 40, 20]);  // Befestigungsplatte
          translate([0, 0, 30]) cylinder(r=6, h=1);
        }
        for(y=[-13, 13]) {
          translate([-7, y, 10]) rotate([0, 90, 0]) cylinder(d=4, h=8);           // Loch in Befestigungsplatte
          translate([-3, y, 10]) rotate([0, 90, 0]) cylinder(d1=4, d2=11, h=6);   // Vergroesserung fuer Schraubenkopf
        }
      }
    }
    translate([0, 0, 15]) cylinder(r=2, h=h-15-6);   // etwas Versteifung zufuegen
    translate([0, 0, h-6.1]) cylinder(r1=2, r2=0.5, h=5);
  }
  if(brim) {
    translate([9, 12, 0]) cylinder(r=8, h=0.3);
    translate([9, -12, 0]) cylinder(r=8, h=0.3);
    translate([-15, 12, 0]) cylinder(r=8, h=0.3);
    translate([-15, -12, 0]) cylinder(r=8, h=0.3);
    translate([20, 0, 0]) cylinder(r=10, h=0.3);
    translate([-26, 0, 0]) cylinder(r=10, h=0.3);
    
    translate([-15, -14, 0]) cube([23, 4, 0.3]);
    translate([-15, 10, 0]) cube([23, 4, 0.3]);
    translate([-15, -2, 0]) cube([23, 4, 0.3]);
    translate([-17, -12, 0]) cube([4, 24, 0.3]);
    translate([7, -12, 0]) cube([4, 24, 0.3]);
  }
}
//!Schaufel(30);
//!Schaufelhalter(50, 120);
//!difference() { Achse(80); translate([-100, -100, -100]) cube([200, 100, 200]); }
//!difference() { Achse(80); translate([-100, -100, -100]) cube([200, 100, 250]); }




// -----------------------------------------------------
//  r   : Laenge der Arme (ab Zentrum)
//  dw  : Drehwinkel (90 -> 4 Arme, 120 -> 3 Arme)
//  hsl : halbe Seitenlaenge der Pyramide
//  al  : Laenge der Achse (ohne den Aufsatz fuer das Kugellager)
// -----------------------------------------------------
module zusammengebaut(r=40, dw=120, hsl=30, al=80) {
  as=7.2;
  difference() {
    Schaufelhalter(r, dw, brim=false);
    //translate([-20, -20, -1]) cube([40, 20, 30]); // temporaer!
  }

  for(a=[0:dw:359]) {
    rotate([0, 0, a+90])
    translate([0, -r+12, as/SQRT2-0.1]) rotate([0, -90, 0]) translate([0, -2*hsl/SQRT2-10, -12/SQRT2]) rotate([0, 0, 45]) Schaufel(hsl, brim=false);
  }
  translate([0, 0, -al+1]) Achse(al);
}

module zusammengebaut2(r=40, dw=120, hsl=30, al=80, r2=40, dw2=120, hsl2=30, al2=80) {
  as=7.2;
  difference() {
    Schaufelhalter2(r2, dw2, al2, brim=false);
    //translate([-20, -20, -1]) cube([40, 20, 30]); // temporaer!
  }

  difference() {
    translate([0, 0, al2]) Schaufelhalter(r, dw, brim=false);
    //translate([-20, -20, al2-6]) cube([40, 20, 30]); // temporaer!
  }

  for(a=[0:dw2:359]) {
    rotate([0, 0, a+90])
    translate([0, -r2+12, as/SQRT2-0.1]) rotate([0, 90, 0]) translate([0, -2*hsl2/SQRT2-10, -12/SQRT2]) rotate([0, 0, 45]) Schaufel(hsl2, brim=false);
  }

  for(a=[0:dw:359]) {
    rotate([0, 0, a+90])
    translate([0, -r+12, al2+as/SQRT2-0.1]) rotate([0, -90, 0]) translate([0, -2*hsl/SQRT2-10, -12/SQRT2]) rotate([0, 0, 45]) Schaufel(hsl, brim=false);
  }

  translate([0, 0, -al+1]) Achse(al);
}


if(part=="assembled_1") {
  difference() {
    zusammengebaut(r, dw, hsl, al);
    //translate([-200, -200, -100]) cube([400, 200, 200]);
  }
} else if(part=="wind_catcher_1") {
  rotate([0, 0, 180]) Schaufel(hsl);
} else if(part=="carrier_1") {
  Schaufelhalter(r, dw);
} else if(part=="mast1") {
  translate([0, 0, 6]) rotate([0, -90, 0]) Achse1(al);
} else if(part=="mast2") {
  difference() {
    Achse2();
    //cube([10, 10, 100]);
  }
} else if(part=="assembled_2") {
  difference() {
    zusammengebaut2(r, dw, hsl, al, r2, dw2, hsl2, al2);
    //translate([-200, -200, -100]) cube([400, 200, 250]);
  }
} else if(part=="wind_catcher_2") {
  rotate([0, 0, 180]) Schaufel(hsl2);
} else if(part=="carrier_2") {
  Schaufelhalter2(r2, dw2, al2);
}
