// -----------------------------------------------------
// WandHaken (Kueche/Altglasbeutel)
//
//  Detlev Ahlgrimm, 06.2018
// -----------------------------------------------------

$fn=100;

// total height
height_total=60;  // [40:100]

// width
width=20;         // [8:30]

// depth
depth=30;         // [15:1:50]

// height for center@hook
height_hook=20;   // [10:40]

// number of holes
holes=2;          // [1:1:2]

// distance between first and second hole
hole_dist=17;     // [8:0.1:30]

module V2() {
  difference() {
    hull() {   // die Rueckwand
      translate([0, 1.5, 0]) cylinder(d=3, h=width);
      translate([0, height_total-1.5, 0]) cylinder(d=3, h=width);
    }
    translate([-1.6, height_total-8, width/2]) rotate([0, 90, 0]) cylinder(d=4, h=3.2);  // Befestigungsloch
    translate([-0.5, height_total-8, width/2]) rotate([0, 90, 0]) cylinder(d1=4, d2=7, h=2.1); // Loch anphasen fuer Schraubenkopf

    if(holes>1) {
      translate([-1.6, height_total-8-hole_dist, width/2]) rotate([0, 90, 0]) cylinder(d=4, h=3.2);
      translate([-0.5, height_total-8-hole_dist, width/2]) rotate([0, 90, 0]) cylinder(d1=4, d2=7, h=2.1);
    }
  }
  difference() {
    hull() {    // der Ausleger mit Verdickung unten
      difference() {   // der Ausleger
        translate([depth/2, height_hook, 0]) scale([2, 1, 1]) cylinder(d=depth/2, h=width);
        translate([-depth/2, 0, -0.1]) cube([depth/2, height_total, width+0.2]);
      }
      cube([0.5, 10, width]);  // der Ansatz fuer die Verdickung unten
    }
    translate([(depth/2*1.6)/2, height_hook+5, -0.1]) scale([1.6, 1, 1]) cylinder(d=depth/2, h=width+0.2);  // Ausleger zum Haken machen
    translate([depth/2, height_hook+3, -0.1]) cube([depth, 10, width+0.2]);   // die Spitze vom Haken abflachen
  }
}
V2();

//%translate([depth, 0, 0]) cube([1, height_total, width]);
