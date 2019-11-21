// -----------------------------------------------------
// Sparschwein V2
//
//  Detlev Ahlgrimm, 08.2018
// -----------------------------------------------------

// what to see
part=0; //  [0:all together, 1:main body, 2:cover/butt, 3:profile view]

// diameter
dia=70;   //  [40:120]

// length
len=130;  //  [65:160]

// wallthickness
wt=0.9;   //  [0.5:0.1:5]

// attach coin sign
acs=1;    //  [0:no coin sign, 1:use txt]

// coin sign
txt="50ct";

// fill level visibility
flv=0;    //  [0:no opening, 1:include openings]

// include helper for support-free printing
ish=1;    //  [0:no helper, 1:include helper]

// include adhesion helper
iah=1;    //  [0:no helper, 1:include helper]

/* [Hidden] */
$fn=100;

ihr=0;    // das "hex grid" aus V1 ist hier lahmgelegt

// -----------------------------------------------------
//   r : Radius (innen)
//   w : Wandstaerke
//   h : Hoehe
// -----------------------------------------------------
module RohrIR(r, w, h) {
  difference() { cylinder(r=r+w, h=h); translate([0, 0, -0.1]) cylinder(r=r, h=h+0.2); }
}
module ViertelRohrIR(r, w, h) {
  difference() {
    RohrIR(r, w, h);
    translate([-r-w-0.1, -r-w-0.1, -0.1]) cube([2*(r+w+0.1), r+w+0.11, h+0.2]);    // sueden (west+ost)
    translate([-r-w-0.1, -0.1, -0.1]) cube([r+w+0.11, r+w+0.2, h+0.2]);            // nord-west
  }
}
//!ViertelRohrIR(20, 3, 3);

// -----------------------------------------------------
// der massive Schweine-Basiskoerper
// -----------------------------------------------------
module piggy1() {
  translate([dia/2, 0, dia/2]) hull() {                                                   // Rumpf + ...
    sphere(d=dia);
    translate([len-dia, 0, 0]) sphere(d=dia);
    translate([len-dia, 0, 0]) rotate([0, 90, 0]) cylinder(r=dia/5, h=dia/2);             // Popo flach machen - zwecks Druckbarkeit
    translate([-dia/2-dia/10, 0, -dia/8]) rotate([0, 80, 0]) cylinder(d=dia/3, h=dia/2);  // ... Ruessel
  }
  translate([dia/5, dia/10, dia/2]) rotate([-20, 0, 0]) cylinder(r=dia/8, h=dia/3);       // zwei Ohren
  translate([dia/5, -dia/10, dia/2]) rotate([20, 0, 0]) cylinder(r=dia/8, h=dia/3);

  for(xy=[[dia/2, -dia/5], [dia/2, dia/5], [len-dia/2, -dia/5], [len-dia/2, dia/5]]) {    // vier Stummelbeinchen
    hull() {
      translate([xy[0], xy[1], 0]) cylinder(r=dia/10, h=dia/4);
      translate([xy[0]+dia/4, xy[1], dia/4]) cylinder(r=dia/10, h=dia/4);
    }
  }
  if(acs>0) {
    translate([len/2, -dia/2, dia/2]) rotate([-90, 0, 0]) cylinder(r=12, h=dia/2);
  }
}
//!piggy1();


// -----------------------------------------------------
// ein Stuetzgeruest mit 45-Grad-Winkeln zwecks Druck
// eines halben sphere(d=dia) ohne Support
// -----------------------------------------------------
module SupportHelper() {
  difference() {
    intersection() {
      difference() {
        sphere(d=dia);                                                  // die Kugel
        translate([-dia/2, -dia/2, -dia/2]) cube([dia, dia, dia/2]);    // Kugel halbieren
      }
      for(a=[0:45:359]) {                                               // das Stuetzgeruest ...
        rotate([0, 0, a]) cube([dia/2, 1, dia/2]);
      }
    }
    translate([0, 0, -0.01]) cylinder(d1=dia, d2=0, h=dia/2);           // ...mit 45 Grad aushoehlen
  }
}
//!SupportHelper();


// -----------------------------------------------------
// das fertige Schwein mit saemtlichen Aussparungen
// und Erweiterungen (allerdings ohne den SupportHelper
// im hinteren Teil)
// -----------------------------------------------------
module piggy2() {
  module Langloch(r=1.5, h=10) {
    hull() {
      translate([0, -h/2+r, 0]) cylinder(r=r, h=dia/2+1);
      translate([0, h/2-r, 0]) cylinder(r=r, h=dia/2+1);
    }
  }

  difference() {
    union() {
      difference() {
        piggy1();
        translate([dia/2, 0, dia/2]) hull() {                                             // Rumpf + Ruessel aushoehlen
          sphere(d=dia-2*wt);
          translate([len-dia, 0, 0]) sphere(d=dia-2*wt);
        }
      }
      if(ish==1) {
        translate([dia/2, 0, dia/2]) rotate([0, -90, 0]) SupportHelper();                 // fuer Druck ohne Support
      }
      if(acs>0) {
        if(wt<1.5) {
          translate([len/2, -dia/2+wt+1, dia/2]) rotate([90, 0, 0]) cylinder(r=12, h=wt+1);
        } else {
          translate([len/2, -dia/2+wt, dia/2]) rotate([90, 0, 0]) cylinder(r=12, h=wt);
        }
      }
    }
    translate([-dia/4, dia/10, dia/3*2]) rotate([0, 90, 0]) cylinder(d=dia/10, h=dia/4+wt);   // Augen
    translate([-dia/4, -dia/10, dia/3*2]) rotate([0, 90, 0]) cylinder(d=dia/10, h=dia/4+wt);

    for(y=[dia/20, -dia/20]) {
      translate([-dia/2, y, dia/2-dia/8-3]) hull() {                                      // Nasenloecher
        rotate([0, 90, 0]) cylinder(d=dia/20, h=dia/2-wt);
        translate([0, 0, 6]) rotate([0, 90, 0]) cylinder(d=dia/20, h=dia/2-wt);
      }
      if(acs>0) {
        translate([len/2, -dia/2+wt/2, dia/2]) rotate([90, 0, 0]) linear_extrude(3) 
            text(txt, size=8, halign="center", valign="center");
      }
    }

    if(flv>0) {
      translate([dia/2+7/2, 0, dia/2]) rotate([-90-30, 0, 0]) Langloch();
      translate([dia/2+7/2+5, 0, dia/2]) rotate([-90-10, 0, 0]) Langloch();
      translate([dia/2+7/2+10, 0, dia/2]) rotate([-90+10, 0, 0]) Langloch();
      translate([dia/2+7/2+15, 0, dia/2]) rotate([-90+30, 0, 0]) Langloch();
    }

    if(ihr==1) {
      for(y=[0:8:dia-dia/4-8]) {                                                          // Hexmuster in den Rumpf
        if(y%16==0) {
          for(x=[dia/2:10:len-dia/3-5]) {
            translate([x+7/2, -dia/2-1, dia/4+y]) rotate([-90, 0, 0]) cylinder(d=7, h=dia+2, $fn=6);
          }
        } else {
          for(x=[dia/2+5:10:len-dia/3-5]) {
            translate([x+7/2, -dia/2-1, dia/4+y]) rotate([-90, 0, 0]) cylinder(d=7, h=dia+2, $fn=6);
          }
        }
      }
    }

    translate([len/2-24/2, 0, dia-wt-1]) hull() {                                         // Muenzeinwurfschlitz
      cylinder(r=1.5, h=wt+2);
      translate([24, 0, 0]) cylinder(r=1.5, h=wt+2);
    }
  }
  module Rueckholsperre(p) {
    if(p=="N") {
      translate([0, 0, 0.5]) rotate([-10, 0, 0]) translate([0, 1, -5]) rotate([90, 0, 0]) linear_extrude(1) polygon([[5,0], [10,5], [0,5]]);
    } else {
      translate([0, 0, 0.5]) rotate([ 10, 0, 0]) translate([0, 0, -5]) rotate([90, 0, 0]) linear_extrude(1) polygon([[5,0], [10,5], [0,5]]);
    }
  }
  translate([len/2-24/2+2, 1.7, dia-wt]) Rueckholsperre("N");
  translate([len/2-24/2+12, 1.7, dia-wt]) Rueckholsperre("N");
  translate([len/2-24/2+2, -1.7, dia-wt]) Rueckholsperre("S");
  translate([len/2-24/2+12, -1.7, dia-wt]) Rueckholsperre("S");
}
//!piggy2();


// -----------------------------------------------------
// das endgueltige Schweine-Vorderteil
// -----------------------------------------------------
module SchweinVorn(brim=false) {
  difference() {
    piggy2();
    translate([len-dia/4, -dia/2, 0]) cube([dia/4+0.1, dia, dia]);  // Hinterteil abschneiden
  }
  z=dia/2-sqrt(dia/2*dia/2-dia/4*dia/4);  // sqrt(c*c - a*a)
  translate([len-dia/4-9, 0, dia/2]) rotate([0, 90, 0]) BajonettF(r=dia/2-wt-z-3.5, w=4, h=9);
  intersection() {
    translate([len-dia/4-9, 0, dia/2]) rotate([0, 90, 0]) RohrIR(dia/2-wt-z-3.5+4, z+5, 9);
    piggy1();
  }

  z2=dia/2-(dia/2-wt-z-3.5)-3-3;
  intersection() {                                                  // Stummelschwanz-Befestigungs-Oese
    translate([len-dia/4-9-3, 1.5, z2]) rotate([90, 0, 0]) RohrIR(3, 3, 3);
    piggy1();
  }

  if(brim) {
    translate([len-dia/4, 0, dia/2]) rotate([0, -90, 0]) union() {
      cylinder(d=dia/3, h=0.3);
      for(a=[60,120,-60,-120]) {
        rotate([0, 0, a]) translate([0, -1, 0]) cube([dia/2-z+2, 2, 0.3]);
      }
      RohrIR(dia/2-z+1, 10, 0.3);
    }
  }
}
//!SchweinVorn();


// -----------------------------------------------------
// das endgueltige Schweine-Hinterteil
// -----------------------------------------------------
module SchweinHinten() {
  difference() {
    union() {
      intersection() {
        piggy2();
        translate([len-dia/4, -dia/2, 0]) cube([dia/4, dia, dia]);  // nur Hinterteil verwenden
      }

      z=dia/2-sqrt(dia/2*dia/2-dia/4*dia/4);
      translate([len-dia/4+0.01, 0, dia/2]) rotate([0, -90, 0]) BajonettM(r=dia/2-wt-z-3.5, w=4, h=9, s_xy=0.7, s_z=0.1);
      intersection() {
        translate([len-dia/4, 0, dia/2]) rotate([0, 90, 0]) RohrIR(dia/2-wt-z-3.5-0.7-2, z+5, 10);
        piggy1();
      }
    }
    translate([len-10, 0, dia/2]) rotate([0, 90, 0]) cylinder(r=3, h=15);     // das Loch fuer den Stummelschwanz
  }
}
//!SchweinHinten();


// -----------------------------------------------------
//
// -----------------------------------------------------
module BajonettProfilF(r=20, w=2, h=5) {
  difference() {
    rotate_extrude() translate([r, 0, 0]) polygon([[-0.01,0], [w,h/5*2], [w,h/5*3], [-0.01,h]]);
    translate([0, -r-w-0.1, -0.1]) cube([r+w+0.1, r+w+0.1, h+0.2]);       // sued-ost
    translate([-r-w-0.1, 0, -0.1]) cube([r+w+0.1, r+w+0.1, h+0.2]);       // nord-west
  }
}
//!BajonettProfilF();

// -----------------------------------------------------
//
// -----------------------------------------------------
module BajonettEinlass(r=20, w=2, h=5, h2=7.1) {
  difference() {
    rotate_extrude() translate([r, 0, 0]) polygon([[-0.01,0], [w,h/5*2], [w,h2], [-0.01,h2]]);
    translate([-0.1, 0.01, -0.1]) cube([r+w+0.1, r+w+0.1, h2+0.3]);             // nord-ost
    translate([-r-w-0.1, -r-w-0.11, -0.1]) cube([r+w+0.1, r+w+0.1, h2+0.3]);    // sued-west
    rotate([0, 0, -90-30]) cube([r+w+0.1, r+w+0.1, h2+0.3]);                    // sued-ost
    rotate([0, 0, 90-30]) cube([r+w+0.1, r+w+0.1, h2+0.3]);                     // nord-west
  }
}
//!BajonettEinlass();

// -----------------------------------------------------
//
// -----------------------------------------------------
module BajonettF(r=20, w=4, h=9) {
  difference() {
    RohrIR(r, w, h);
    translate([0, 0, (h-5)/2]) BajonettProfilF(r, w/2, 5);
    translate([0, 0, (h-5)/2]) BajonettEinlass(r, w/2, 5, h);
  }
}
//BajonettF(dia/2);

// -----------------------------------------------------
//
// -----------------------------------------------------
module BajonettProfilM(r=20, w=2, h=5) {
  difference() {
    rotate_extrude() translate([r, 0, 0]) polygon([[-0.01,0], [w,h/5*2], [w,h/5*3], [-0.01,h]]);
    translate([-0.1, 0.01, -0.1]) cube([r+w+0.1, r+w+0.1, h+0.3]);             // nord-ost
    translate([-r-w-0.1, -r-w-0.11, -0.1]) cube([r+w+0.1, r+w+0.1, h+0.3]);    // sued-west
    rotate([0, 0, -90-20]) cube([r+w+0.1, r+w+0.1, h+0.3]);                    // sued-ost
    rotate([0, 0, 90-20]) cube([r+w+0.1, r+w+0.1, h+0.3]);                     // nord-west
  }
}
//!BajonettProfilM();

// -----------------------------------------------------
//  s_xy  : Spiel (bezogen auf den Radius)
// -----------------------------------------------------
module BajonettM(r=20, w=4, h=9, s_xy=0.7, s_z=0.1) {
  RohrIR(r-2-s_xy, 2, h+s_z);
  translate([0, 0, (h+2*s_z-5)/2]) BajonettProfilM(r-s_xy);
}







if(len<dia*1.3) {
  text("illegal ratio between <dia> and <len>!");
} else if(part==0) {
  SchweinVorn();
  //translate([40, 0, 0]) SchweinHinten();
  translate([40, 0, dia/2]) rotate([45, 0, 0]) translate([0, 0, -dia/2]) SchweinHinten();
} else if(part==1) {
  translate([-dia/2, 0, len-dia/4]) rotate([0, 90, 0]) SchweinVorn(iah>0);
} else if(part==2) {
  translate([-dia/2, 0, len]) rotate([0, 90, 0]) SchweinHinten();
} else if(part==3) {
  difference() {
    union() {
      SchweinVorn();
      translate([0, 0, 0]) SchweinHinten();
    }
    translate([-50, -dia/2-10, -20]) cube([50+len+100, dia/2+10, dia+40]);
  }
}

