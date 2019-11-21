// -----------------------------------------------------
// WandHaken (Kueche/Altglasbeutel) V2a
//
//  Detlev Ahlgrimm, 06.2018
//
// 13.06.2018   V2a   depth_bp und pos_x zugefuegt
// -----------------------------------------------------

$fn=100;

// total height
height_total=60;  // [40:100]

// total width
width=20;         // [8:30]

// depth backplane
depth_bp=3;       // [3:8]

// depth hook
depth=30;         // [15:1:50]

// height for center@hook
height_hook=20;   // [10:40]

// number of holes
holes=2;          // [1:1, 2:2]

// distance between first and second hole
hole_dist=17;     // [8:0.1:30]

// position for the lower beginning
pos_x=0;          // [0:0.1:2]

module V2() {
  x0=-depth_bp/2+1.5;
  difference() {
    hull() {   // die Rueckwand
      translate([x0, depth_bp/2, 0]) cylinder(d=depth_bp, h=width);
      translate([x0, height_total-depth_bp/2, 0]) cylinder(d=depth_bp, h=width);
    }
    translate([x0-depth_bp/2-0.1, height_total-8, width/2]) rotate([0, 90, 0]) cylinder(d=4, h=depth_bp+0.2);  // Befestigungsloch
    translate([-0.5, height_total-8, width/2]) rotate([0, 90, 0]) cylinder(d1=4, d2=7, h=2.1); // Loch anphasen fuer Schraubenkopf

    if(holes>1) {
      translate([x0-depth_bp/2-0.1, height_total-8-hole_dist, width/2]) rotate([0, 90, 0]) cylinder(d=4, h=depth_bp+0.2);
      translate([-0.5, height_total-8-hole_dist, width/2]) rotate([0, 90, 0]) cylinder(d1=4, d2=7, h=2.1);
    }
  }
  difference() {
    hull() {    // der Ausleger mit Verdickung unten
      difference() {   // der Ausleger
        translate([depth/2, height_hook, 0]) scale([2, 1, 1]) cylinder(d=depth/2, h=width);
        translate([-depth/2, 0, -0.1]) cube([depth/2, height_total, width+0.2]);
      }
      translate([x0+pos_x, 0.1, 0]) cube([0.1, 10, width]);  // der Ansatz fuer die Verdickung unten
    }
    translate([(depth/2*1.6)/2, height_hook+5, -0.1]) scale([1.6, 1, 1]) cylinder(d=depth/2, h=width+0.2);  // Ausleger zum Haken machen
    translate([depth/2, height_hook+3, -0.1]) cube([depth, 10, width+0.2]);   // die Spitze vom Haken abflachen
  }
}
V2();

//%translate([depth, 0, 0]) cube([1, height_total, width]);
