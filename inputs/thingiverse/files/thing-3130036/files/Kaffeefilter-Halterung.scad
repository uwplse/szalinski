// -----------------------------------------------------
// Kaffeefilter-Halterung
//
//  Detlev Ahlgrimm, 09.2018
// -----------------------------------------------------

// length bottom
lu=60;            // [10:100]

// length top
lo=170;           // [20:200]

// height
h=73;             // [10:150]

// deepth
t=45;             // [5:100]

// wall thickness
ws=1.4;           // [0.5:0.1:10]

// bottom thickness
bs=0;             // [0:0.1:10]

// diameter opening
ov=100;           // [0:200]

// diameter mounting hole
dl=4;             // [0:0.1:10]

/* [Hidden] */
$fn=100;

// -----------------------------------------------------
//  d : Aussendurchmesser
//  h : Hoehe
// -----------------------------------------------------
module Ring(d, h) {
  rotate_extrude() translate([d/2-h/2, 0, 0]) circle(d=h);
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module Profil(u, o, h) {
  d=(o-u)/2;
  polygon([[-u/2,0], [u/2,0], [u/2+d,h], [-u/2-d,h]]);
}


// -----------------------------------------------------
//
// -----------------------------------------------------
module HalterungRund(u, o, h, t, r) {
  d=(o-u)/2;
  k=sqrt(d*d+h*h)+r;
  w=atan(d/h);
  difference() {
    hull() {
      translate([ u/2-r,   r, 0]) rotate([0,  w, 0]) cylinder(r=r, h=k);
      translate([-u/2+r,   r, 0]) rotate([0, -w, 0]) cylinder(r=r, h=k);
      translate([ u/2-r, t-r, 0]) rotate([0,  w, 0]) cylinder(r=r, h=k);
      translate([-u/2+r, t-r, 0]) rotate([0, -w, 0]) cylinder(r=r, h=k);
    }
    translate([-u, -1, -2*r]) cube([2*u, t+2, 2*r]);
    translate([-o, -1, h]) cube([2*o, t+2, 2*r]);
  }
}
//!translate([0, 0, bs]) HalterungRund(lu+2*ws, lo+2*ws, h, t, 2);


// -----------------------------------------------------
//
// -----------------------------------------------------
module Bodenplatte(u, o, h, t, r) {
  hull() {
    translate([ u/2-r,   r, 0]) cylinder(r=r, h=h);
    translate([-u/2+r,   r, 0]) cylinder(r=r, h=h);
    translate([ u/2-r, t-r, 0]) cylinder(r=r, h=h);
    translate([-u/2+r, t-r, 0]) cylinder(r=r, h=h);
  }
}


difference() {
  union() {
    //translate([0, t+2*ws, bs]) rotate([90, 0, 0]) linear_extrude(t+2*ws) Profil(lu+2*ws, lo+2*ws, h); // Aussenkoerper
    //translate([-lu/2-ws, 0, 0]) cube([lu+2*ws, t+2*ws, bs]); // den Boden extra (kann auch ==0 sein)
    hull() {
      translate([0, 0, bs]) HalterungRund(lu+2*ws, lo+2*ws, h, t+2*ws, 2);
      if(bs>0) Bodenplatte(lu+2*ws, lo+2*ws, bs, t+2*ws, 2);
    }
  }
  //translate([0, t+ws, bs]) rotate([90, 0, 0]) linear_extrude(t) Profil(lu, lo, h+0.01); // Innenkoerper ausschneiden
  translate([0, ws, bs-0.01]) HalterungRund(lu, lo, h+0.02, t, 2);
  translate([0, -0.1, h+bs]) rotate([-90, 0, 0]) cylinder(d=ov, h=2*ws);  // ggf. vordere Oeffnung schneiden
}

if(dl>0) {    // ggf. Befestigungsloch samt Aufbauten dafuer zufuegen
  difference() {
    translate([0, t+ws, h+bs]) rotate([-90, 0, 0]) cylinder(d=lo/4, h=ws);
    translate([0, t+ws-0.1, h+bs+lo/16]) rotate([-90, 0, 0]) cylinder(d=dl, h=2*ws);
  }
}

if(ov>0) {    // bei gewaehlter vorderer Oeffnung etwas Verstaerkung zufuegen
  translate([0, ws/2, h+bs]) rotate([90, 0, 0]) difference() {
    union() {
      Ring(ov+3*ws, 2*ws);
      Ring(ov+8*ws, 2*ws);
    }
    translate([-ov, 0, -ws]) cube([2*ov, ov, 2*ws]);
  }
}

if(bs==0) {   // ohne Boden braucht es etwas Halte-Flaeche
  translate([0, ws+t/2, 0]) cylinder(d=min(t, lu)*0.8, h=0.25);
  translate([-1, 0, 0]) cube([2, t+2*ws, 0.25]);
  translate([-lu/2-ws, t/2+ws-1, 0]) cube([lu+2*ws, 2, 0.25]);
}
