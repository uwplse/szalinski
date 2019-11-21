// -----------------------------------------------------
// Innendurchmesser-Lehre
//
//  Detlev Ahlgrimm, 09.2018
// -----------------------------------------------------

// Lenght
lng=120;       // [50:150]

// Aperture Angle
ow=0;         // [0:90]

// What to show
show=0;       // [0:assembled, 1:all part together, 2:lower part, 3:upper part, 4:wheel, 5:pusher]

/* [Hidden] */
$fn=100;
wms=atan(10/lng);         // Winkel zur Messpitze
kms=sqrt(lng*lng+100);    // Laenge Kathete zur Messpitze

// -----------------------------------------------------
//  lg : Laenge Gewinde
//  lm : Laenge Mutter
// -----------------------------------------------------
module SchraubeM4(lg=20, lm=3.1, vu=false) {
  union() {
    cylinder(r=4.2, h=lm, $fn=6);
    translate([0, 0, lm-0.1]) cylinder(d=4.5, h=lg+0.1);
  }
  if(vu) {
    translate([0, 0, lm]) cylinder(r1=4.2, r2=4.5/2, h=4.2-4.5/2, $fn=6);
  }
}


// -----------------------------------------------------
//  Innendurchmesser aus Winkel (gem. Kosinussatz)
// -----------------------------------------------------
function Innendurchmesser(winkel) = sqrt(kms*kms - 2*kms * kms * cos(winkel) + kms*kms);
/*echo("min=", Innendurchmesser(0+2*wms));
echo("cur=", Innendurchmesser(ow+2*wms));
echo("max=", Innendurchmesser(90+2*wms));*/


// -----------------------------------------------------
//  ra  : Aussenradius
//  ri  : Innenradius
//  h   : Hoehe
//  a   : Oeffnungswinkel
// -----------------------------------------------------
module RohrTeil(ra, ri, h, a) {
  da=2*ra;
  difference() {
    cylinder(r=ra, h=h);
    translate([0, 0, -0.1]) cylinder(r=ri, h=h+0.2);
    if(a<=90)       translate([0, 0, -0.1]) linear_extrude(h+0.2) polygon([[0,0], [0,da], [da,da],                                [sin(a)*ra, cos(a)*ra]]);
    else if(a<=180) translate([0, 0, -0.1]) linear_extrude(h+0.2) polygon([[0,0], [0,da], [da,da], [da,-da],                      [sin(a)*ra, cos(a)*ra]]);
    else if(a<=270) translate([0, 0, -0.1]) linear_extrude(h+0.2) polygon([[0,0], [0,da], [da,da], [da,-da], [-da,-da],           [sin(a)*ra, cos(a)*ra]]);
    else            translate([0, 0, -0.1]) linear_extrude(h+0.2) polygon([[0,0], [0,da], [da,da], [da,-da], [-da,-da], [-da,da], [sin(a)*ra, cos(a)*ra]]);
  }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Bein1(l=lng) {
  difference() {
    union() {
      cylinder(r=20, h=5);
      translate([15, -5, 0]) cube([l-15-5, 5, 5]);      // das Bein
      hull() {                                          // die Messpitze
        translate([l-5, -5, 0]) linear_extrude(0.25) polygon([[0,0], [4.5,-5], [5,-5], [3,0]]);
        translate([l-5-10, -5, 0]) cube([10, 5, 5]);
      }
      difference() {
        rotate([0, 0, 10]) RohrTeil(42, 19, 5, 200);
        rotate([0, 0, 30]) translate([0, 0, -0.1]) RohrTeil(38, 29, 5.2, 230);
      }
    }
    translate([0, 0, -0.1]) cylinder(r=2.3, h=5.2);     // Mittelloch
    translate([0, 0, 2.5]) cylinder(r=16, h=5);         // Platz fuer Bein2-Zentrum
    translate([-5, 0, 2.5]) cube([21+5, 30, 4]);        // Platz fuer Bein2-Bein
    translate([15, 0-2, 2.5]) rotate([0, 0, 45]) cube([4, 2, 3]);
  }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Bein2(l=lng) {
  difference() {
    cylinder(r=15, h=5);
    translate([0, 0, -0.1]) cylinder(r=2.2, h=5.2);
  }
  translate([10, 0, 0]) cube([l-10-5, 5, 5]);                           // Bein
  hull() {                                                              // Messpitze
    translate([l-5, 5, -2.5]) linear_extrude(0.25) polygon([[0,0], [4.5,5], [5,5], [3,0]]);
    translate([l-5-1, 0, -2.5]) cube([1, 5, 7.5]);
    translate([l-5-10, 0, 0]) cube([1, 5, 5]);
  }
  rotate([0, 0, 45]) translate([0, 10, 2.75]) //cube([3, 30, 5-2.75]);  // Zeiger
    linear_extrude(5-2.75) polygon([[-5,0], [5+3,0], [3,15], [3,30], [0,30], [0,15]]);
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Drehgriff() {
  difference() {
    union() {
      cylinder(r=10, h=5);
      for(a=[0:30:359]) {
        rotate([0, 0, a]) translate([10, 0, 0]) cylinder(r=2.5, h=5);
        //rotate([0, 0, a]) translate([10, 0, 2.5]) sphere(r=3);
      }
    }
    //translate([-20, -20, -10]) cube([40, 40, 10]);
    //translate([-20, -20, 5]) cube([40, 40, 10]);
    translate([0, 0, -0.1]) SchraubeM4(); //cylinder(r=2.2, h=5.2);
  }
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Schieber() {
  difference() {
    union() {
      rotate([0, 0, 90-20/2]) RohrTeil(38-0.5, 29+0.5, 5, 360-20);
      rotate([0, 0, 90-20/2]) translate([0, 0, 4.75]) RohrTeil(40, 27, 4.25, 360-20);
    }
    translate([-33.5, 0, 9.01]) rotate([180, 0, 30]) SchraubeM4(vu=true);
  }
}
//!difference() { Schieber(); translate([-45, -20, -1]) cube([20, 20, 20]); }


if(show==0) {
  translate([0, 0, -2.5]) Bein1();
  rotate([0, 0, ow]) color("red") Bein2();
  rotate([0, 0, 57]) color("blue") translate([-34, 0, -5-2.5]) Drehgriff();
  rotate([0, 0, 57]) translate([0, 0, -2.5]) Schieber();
  txt=str("min=20, cur=", Innendurchmesser(ow+2*wms), ", max=", Innendurchmesser(90+2*wms));
  translate([0, -40, 0]) linear_extrude(1) text(txt, size=6);
} else if(show==1) {
  Bein1();
  translate([lng, -30, 5]) rotate([0, 180, 0]) Bein2();
  translate([35, -45, 5]) rotate([0, 180, 0]) Drehgriff();
  translate([34+10, -40, 9]) rotate([180, 0, 0]) Schieber();
} else if(show==2) {
  Bein1();
} else if(show==3) {
  translate([0, 0, 5]) rotate([180, 0, 0]) Bein2();
} else if(show==4) {
  translate([0, 0, 5]) rotate([0, 180, 0]) Drehgriff();
} else if(show==5) {
  translate([34, 0, 9]) rotate([180, 0, 0]) Schieber();
}
