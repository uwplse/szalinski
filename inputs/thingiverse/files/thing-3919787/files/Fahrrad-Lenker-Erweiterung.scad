// -----------------------------------------------------
// Fahrrad-Lenker-Erweiterung
//   (zwecks Befestigung eines Akku-Frontstrahlers)
//
//  Detlev Ahlgrimm, 13.10.2019
// -----------------------------------------------------

// Durchmesser des Befestigungs-Rohrs
d1=35;

// Durchmesser der Lenker-Erweiterung
d2=26;

// Abstand Befestigungs-Rohr zu Lenker-Erweiterung
lv=30;

// Laenge der Lenker-Erweiterung
lq=50;

// Wandstaerke des Klemm-Elementes
ws=5;

// Breite des Kabelbinders
bk=4.5;

/* [Hidden] */
$fn=100;
h=2*bk+4;

// -----------------------------------------------------
//  wie cube() - nur abgerundet gemaess "r"
// -----------------------------------------------------
module cubeR(v, r=1) {
  assert(r<=v.x/2 && r<=v.y/2 && r<=v.z/2);   // Requires version "nightly build"
  hull() {
    translate([    r,     r,     r]) sphere(r=r);
    translate([v.x-r,     r,     r]) sphere(r=r);
    translate([    r, v.y-r,     r]) sphere(r=r);
    translate([v.x-r, v.y-r,     r]) sphere(r=r);

    translate([    r,     r, v.z-r]) sphere(r=r);
    translate([v.x-r,     r, v.z-r]) sphere(r=r);
    translate([    r, v.y-r, v.z-r]) sphere(r=r);
    translate([v.x-r, v.y-r, v.z-r]) sphere(r=r);
  }
}

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
//  Version 1
// -----------------------------------------------------
module theThingV1() {
  difference() {
    union() {
      cylinder(d1=d1+2*ws-4, d2=d1+2*ws, h=2);                                // 3x Klemm-Element
      translate([0, 0, 2]) cylinder(d=d1+2*ws, h=h-4);
      translate([0, 0, h-2]) cylinder(d2=d1+2*ws-4, d1=d1+2*ws, h=2);

      translate([d1/2-5, -10, 0]) cubeR([lv+5, 20, d2/2*sqrt(3)], 3);         // Abstands-Element
    }
    translate([0, 0, -0.1]) cylinder(d=d1, d2+0.2);                           // Platz fuer das Befestigungs-Rohr schaffen
    translate([d1/3, 0, -0.1]) rotate([0, 0, 90+45]) cube([d1, d1, h+0.2]);   // Klemm-Element oeffnen

    translate([0, 0, h/2-bk/2]) difference() {                                // Fuehrung fuer den Kabelbinder
      cylinder(d=d1+2*ws+4, h=bk+3);
      translate([0, 0, -0.1]) cylinder(d=d1+2*ws-2, h=bk+0.2);
      translate([0, 0, bk]) cylinder(d1=d1+2*ws-2, d2=d1+2*ws+10, h=6.1);
      translate([0, -10, bk]) cube([d1, 20, 6.1]);
    }
  }

  translate([d1/2+lv, 0, d2/2*sqrt(3)/2]) rotate([90, 0, 0]) hull() {         // Lenker-Erweiterung
    scale([1, 1, 0.5]) sphere(d=d2, $fn=6);
    translate([0, 0, lq+10]) scale([1, 1, 0.5]) sphere(d=d2, $fn=6);
  }
}
*mirror([0, 1, 0]) theThingV1();

// -----------------------------------------------------
//  die um d1/2 verlaengerte Lenker-Erweiterung
// -----------------------------------------------------
module LenkerErweiterung() {
  difference() {
    rotate_extrude() translate([d2/2+0.1, 0, 0]) circle(d=d2);
    translate([-d2-0.1, -d2-0.1, -d2/2-0.1]) cube([2*d2+0.2, d2+0.099, d2+0.2]);
    translate([0.01, -0.1, -d2/2-0.1]) cube([d2+0.1, d2+0.2, d2+0.2]);
  }
  translate([0, d2/2+0.1, 0]) rotate([0, 90, 0]) cylinder(d=d2, h=lq);
  translate([lq, d2/2+0.1, 0]) sphere(d=d2);
  translate([-d2/2-0.1, 0, 0]) rotate([90, 0, 0]) cylinder(d=d2, h=lv+d1/2);
}
*translate([d2/2+0.1, lv-0.1, d2/2-1]) LenkerErweiterung();

// -----------------------------------------------------
//  Version 2
// -----------------------------------------------------
module theThingV2() {
  difference() {
    union() {
      cylinder(d1=d1+2*ws-4, d2=d1+2*ws, h=2);                                // 3x Klemm-Element
      translate([0, 0, 2]) cylinder(d=d1+2*ws, h=h-4);
      translate([0, 0, h-2]) cylinder(d2=d1+2*ws-4, d1=d1+2*ws, h=2);

      difference() {
        translate([d2/2+0.1, lv+d1/2-0.1, d2/2-1]) LenkerErweiterung();       // Lenker-Erweiterung
        translate([-10, -0.2, -1.1]) cube([d2+lq+10, d2/2+d1/2+lv+10, 1.1]);  // unten etwas abgeflacht
      }
    }
    translate([0, 0, -0.1]) cylinder(d=d1, d2+0.2);                           // Platz fuer das Befestigungs-Rohr schaffen
  }
  for(m=[0, 1]) mirror([m, 0, 0])
  difference() {
    union() {
      translate([d1/2, -7, 0]) cube([10, 14, h]);
      translate([d1/2+10, -7, h/2]) rotate([-90, 0, 0]) cylinder(d=h, h=14);
    }
    translate([d1/2+10, 7.1, h/2]) rotate([90, 0, 0]) SchraubeM4();
  }
}

difference() {
  theThingV2();
  translate([-d1, -1, -0.1]) cube([2*d1, 2, h+0.2]);
}

*mirror([1, 0, 0]) difference() {
  theThingV2();
  translate([-d1, -1, -0.1]) cube([2*d1, 2, h+0.2]);
}

