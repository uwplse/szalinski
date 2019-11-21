// -----------------------------------------------------
// Tassen-Umkippschutz (fuer Adrian W. aus S.)
//
//  Detlev Ahlgrimm, 05.09.2019
// -----------------------------------------------------

// diameter cup
d=80;   // [60:0.1:100]
// floor/wall thickness
ws=2;   // [1:0.05:5]

/* [Hidden] */
$fn=100;

difference() {
    cylinder(d1=d*1.5, d2=d+2*ws, h=20);
    translate([0, 0, ws]) cylinder(d1=d+5, d2=d, h=20-2*ws);
    translate([0, 0, 20-ws-0.01]) cylinder(d=d, h=2*ws);
    for(a=[0:60:359]) rotate([0, 0, a]) {
      translate([3, -10, ws]) cube([d, 20, 20]);
      hull() {
        translate([20, 0, -0.1]) cylinder(d=10, h=ws+0.2);
        translate([d*0.75-15, 0, -0.1]) cylinder(d=16, h=ws+0.2);
      }
    }
}
