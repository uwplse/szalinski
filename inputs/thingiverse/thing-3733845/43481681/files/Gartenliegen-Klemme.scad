// -----------------------------------------------------
// Gartenliegen-Klemme
//
//  Detlev Ahlgrimm, 22.06.2019
// -----------------------------------------------------

// diameter
d=27;

// height
h=10;

// wallthickness
ws=3;

/* [Hidden] */
$fn=100;


difference() {
  union() {
    cylinder(d=d+2*ws, h=h);
    translate([0, d, 0]) cylinder(d=d+2*ws, h=h);
  }
  translate([0, 0, -0.1]) cylinder(d=d, h=h+0.2);
  translate([0, d, -0.1]) cylinder(d=d, h=h+0.2);
  translate([d/3.4, -d/2-ws, -0.1]) cube([d, 2*d+2*ws, h+0.2]);
  translate([-d/6, d/2-2*ws, -0.1]) cube([d, 4*ws, h+0.2]);
}
