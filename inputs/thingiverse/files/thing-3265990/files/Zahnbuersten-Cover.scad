// -----------------------------------------------------
// Zahnbuersten-Cover (fuer die Kulturtasche)
//
//  Detlev Ahlgrimm, 07.12.2018
// -----------------------------------------------------

// Number of connected toothbrush-head-covers
cnt=1;        // [1:6]

d_b=16;       // Durchmesser Buerste + Spiel (15+1)
h_b=17;       // Hoehe Buerste (bis zur Arm-Mittelachse) + Luft (15+2)

d1=8;         // Durchmesser des Arms direkt an der Buerste
d2=9;         // Durchmesser des Arms 20mm von der Buerste entfernt

ws=1.4;       // Wandstaerke

/* [Hidden] */
$fn=100;
d3=d2+2*ws;   // Aussen-Durchmesser Arm-Halterung
hk=d3/5;      // Hoehe, auf der der Arm geklemmt wird

// -----------------------------------------------------
//  d : Aussendurchmesser
//  h : Hoehe / Ringstaerke
// -----------------------------------------------------
module Ring(d, h) {
  rotate_extrude() translate([d/2-h/2, 0, 0]) circle(d=h);
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module HalterMassiv() {
  hull() {    // der Buerstenhalter in abgerundet
    translate([0, 0, h_b+ws-ws/2+hk]) Ring(d_b+2*ws, ws);   // oben
    translate([0, 0, ws/2-0.3]) Ring(d_b+3*ws, ws);         // unten
  }
  hull() {
    translate([20+d_b/2-ws/2, 0, hk]) rotate([0, 90, 0]) Ring(d3, ws);
    translate([0, 0, hk]) rotate([0, 90, 0]) cylinder(d=d3, h=20+d_b/2-ws);  // der Arm-Halter
  }
  translate([0, 0, hk]) rotate([0, 90, 0]) cylinder(d1=d_b+2*ws, d2=d3, h=d_b/2+3*ws);  // der Ansatz zwischen Buersten- und Arm-Halter
}

// -----------------------------------------------------
//
// -----------------------------------------------------
module HalterAusschneider() {
  translate([-d_b-ws, -d3, -d3]) cube([20+2*(d_b+2*ws), 2*d3, d3]);             // Boden plan machen
  translate([0, 0, -0.1]) cylinder(d1=d_b+ws, d2=d_b, h=h_b+0.11);    // Platz fuer die Buerste freischneiden
  translate([0, 0, h_b]) cylinder(d1=d_b, d2=d_b-2*hk, h=hk);         // obere Verengung
  translate([    0, 0, hk]) rotate([0, 90, 0]) rotate([0, 0, 36/2]) cylinder(d=d1, h=d_b/2+0.1, $fn=10);      // inneren Ansatz freischneiden
  translate([d_b/2, 0, hk]) rotate([0, 90, 0]) rotate([0, 0, 36/2]) cylinder(d1=d1, d2=d2, h=20.01, $fn=10);  // Arm freischneiden
}

difference() {
  union() {
    for(i=[0:cnt-1]) {
      translate([0, i*(d_b+2*ws), 0]) HalterMassiv();
    }
    translate([17+d_b/2, 0, 0]) cube([3, (cnt-1)*(d_b+ws), 3]);
  }
  for(i=[0:cnt-1]) {
    translate([0, i*(d_b+2*ws), 0]) HalterAusschneider();
  }
  //translate([-20, -20, -1]) cube([50, 20, 30]);
}
